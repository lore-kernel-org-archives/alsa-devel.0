From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] ALSA: firewire-tascam: add support for
	FW-1804
Date: Fri,  5 Feb 2016 09:56:06 +0900
Message-ID: <1454633768-17729-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1454633768-17729-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DD552605C6
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 01:56:13 +0100 (CET)
In-Reply-To: <1454633768-17729-1-git-send-email-o-takashi@sakamocchi.jp>
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

This model supports:
 * maximum 12 PCM channels for PCM playback
 * maximum 18 PCM channels for PCM capture
 * 4 ports for MIDI playback
 * 4 ports for MIDI capture
 * control and status messages in tx isochronous packets
 * up to 96.0 kHz

This commit adds support for the model. As the other supported models,
all of available PCM channels are always enabled.

As I described in commit c0949b278515da94, Ilya Zimnovich had investigated
TASCAM FireWire series in 2011 with his FW-1804. In his report, this model
has internal multiplexer and any software implementation can control it.
Following to the design of ALSA firewire stack, this commit won't
implement it. It should be in userspace via Linux fw character device.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index ee0bc18..dcb11c2 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -33,7 +33,16 @@ static struct snd_tscm_spec model_specs[] = {
 		.midi_playback_ports = 2,
 		.is_controller = true,
 	},
-	/* FW-1804 may be supported. */
+	{
+		.name = "FW-1804",
+		.has_adat = true,
+		.has_spdif = true,
+		.pcm_capture_analog_channels = 8,
+		.pcm_playback_analog_channels = 2,
+		.midi_capture_ports = 2,
+		.midi_playback_ports = 4,
+		.is_controller = false,
+	},
 };
 
 static int identify_model(struct snd_tscm *tscm)
-- 
2.5.0
