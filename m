From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] ALSA: oxfw: support more MIDI ports
Date: Sun, 18 Oct 2015 17:09:39 +0900
Message-ID: <1445155780-7600-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1445155780-7600-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id AB247261552
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 10:09:44 +0200 (CEST)
In-Reply-To: <1445155780-7600-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In IEC 61883-6, sequence multiplexing is applied to MIDI conformant data
channel. As a result, eight MIDI data streams are included in the channel.
Although ALSA AM824 data block processing layer implements this
multiplexing, current OXFW driver doesn't utilize it due to wrong
calculation of MIDI ports.

This commit fixes this bug to add proper calculation. Although this commit
allows to use 8 MIDI data streams, the number of available MIDI ports is
limited by the number of ALSA MIDI ports added by the driver.

Fixes: df075feefbd3('ALSA: firewire-lib: complete AM824 data block processing layer')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 4879808..7cb5743 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -148,7 +148,7 @@ static int start_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream,
 	}
 
 	pcm_channels = formation.pcm;
-	midi_ports = DIV_ROUND_UP(formation.midi, 8);
+	midi_ports = formation.midi * 8;
 
 	/* The stream should have one pcm channels at least */
 	if (pcm_channels == 0) {
-- 
2.1.4
