From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 3/3] ALSA: firewire-motu: constify
	snd_rawmidi_ops structures
Date: Tue, 15 Aug 2017 10:09:54 +0200
Message-ID: <1502784594-14670-3-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 27B2E2673FF
 for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2017 10:35:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, bhumirks@gmail.com
List-Id: alsa-devel@alsa-project.org

These snd_rawmidi_ops structures are only passed as the third
argument of snd_rawmidi_set_ops.  This argument is const, so the
snd_rawmidi_ops structures can be const too.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/firewire/motu/motu-midi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/motu/motu-midi.c b/sound/firewire/motu/motu-midi.c
index e3acfcc..e55cab6 100644
--- a/sound/firewire/motu/motu-midi.c
+++ b/sound/firewire/motu/motu-midi.c
@@ -128,12 +128,12 @@ static void set_midi_substream_names(struct snd_motu *motu,
 
 int snd_motu_create_midi_devices(struct snd_motu *motu)
 {
-	static struct snd_rawmidi_ops capture_ops = {
+	static const struct snd_rawmidi_ops capture_ops = {
 		.open		= midi_capture_open,
 		.close		= midi_capture_close,
 		.trigger	= midi_capture_trigger,
 	};
-	static struct snd_rawmidi_ops playback_ops = {
+	static const struct snd_rawmidi_ops playback_ops = {
 		.open		= midi_playback_open,
 		.close		= midi_playback_close,
 		.trigger	= midi_playback_trigger,
