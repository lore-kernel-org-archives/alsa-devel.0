From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: firewire-lib/dice: add arrangements
	of PCM pointer and interrupts for Dice quirk
Date: Fri, 29 Aug 2014 13:40:45 +0900
Message-ID: <1409287245-15184-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1409287245-15184-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 25699266706
 for <alsa-devel@alsa-project.org>; Fri, 29 Aug 2014 06:40:59 +0200 (CEST)
In-Reply-To: <1409287245-15184-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: drobbins@funtoo.org, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In IEC 61883-6, one data block transfers one event. In ALSA, the event equals one PCM frame,
hence one data block transfers one PCM frame. But Dice has a quirk at higher sampling rate
(176.4/192.0 kHz) that one data block transfers two PCM frames.

Commit 10550bea44a8 ("ALSA: dice/firewire-lib: Keep dualwire mode but obsolete
CIP_HI_DUALWIRE") moved some codes related to this quirk into Dice driver. But the commit
forgot to add arrangements for PCM period interrupts and DMA pointer updates. As a result, Dice
driver cannot work correctly at higher sampling rate.

This commit adds 'double_pcm_frames' parameter to amdtp structure for this quirk. When this
parameter is set, PCM period interrupts and DMA pointer updates occur at double speed than in
IEC 61883-6.

Reported-by: Daniel Robbins <drobbins@funtoo.org>
Fixes: 10550bea44a8 ("ALSA: dice/firewire-lib: Keep dualwire mode but obsolete CIP_HI_DUALWIRE")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 11 ++++++++++-
 sound/firewire/amdtp.h |  1 +
 sound/firewire/dice.c  | 15 +++++++++++----
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index f96bf4c..95fc2eaf 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -507,7 +507,16 @@ static void amdtp_pull_midi(struct amdtp_stream *s,
 static void update_pcm_pointers(struct amdtp_stream *s,
 				struct snd_pcm_substream *pcm,
 				unsigned int frames)
-{	unsigned int ptr;
+{
+	unsigned int ptr;
+
+	/*
+	 * In IEC 61883-6, one data block represents one event. In ALSA, one
+	 * event equals to one PCM frame. But Dice has a quirk to transfer
+	 * two PCM frames in one data block.
+	 */
+	if (s->double_pcm_frames)
+		frames *= 2;
 
 	ptr = s->pcm_buffer_pointer + frames;
 	if (ptr >= pcm->runtime->buffer_size)
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index d8ee7b0..4823c08 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -125,6 +125,7 @@ struct amdtp_stream {
 	unsigned int pcm_buffer_pointer;
 	unsigned int pcm_period_pointer;
 	bool pointer_flush;
+	bool double_pcm_frames;
 
 	struct snd_rawmidi_substream *midi[AMDTP_MAX_CHANNELS_FOR_MIDI * 8];
 
diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 4cf8eb7..e3a04d6 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -567,10 +567,14 @@ static int dice_hw_params(struct snd_pcm_substream *substream,
 		return err;
 
 	/*
-	 * At rates above 96 kHz, pretend that the stream runs at half the
-	 * actual sample rate with twice the number of channels; two samples
-	 * of a channel are stored consecutively in the packet. Requires
-	 * blocking mode and PCM buffer size should be aligned to SYT_INTERVAL.
+	 * At 176.4/192.0 kHz, Dice has a quirk to transfer two PCM frames in
+	 * one data block of AMDTP packet. Thus sampling transfer frequency is
+	 * a half of PCM sampling frequency, i.e. PCM frames at 192.0 kHz are
+	 * transferred on AMDTP packets at 96 kHz. Two successive samples of a
+	 * channel are stored consecutively in the packet. This quirk is called
+	 * as 'Dual Wire'.
+	 * For this quirk, blocking mode is required and PCM buffer size should
+	 * be aligned to SYT_INTERVAL.
 	 */
 	channels = params_channels(hw_params);
 	if (rate_index > 4) {
@@ -581,6 +585,9 @@ static int dice_hw_params(struct snd_pcm_substream *substream,
 
 		rate /= 2;
 		channels *= 2;
+		dice->stream.double_pcm_frames = true;
+	} else {
+		dice->stream.double_pcm_frames = false;
 	}
 
 	mode = rate_index_to_mode(rate_index);
-- 
1.9.1
