From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] ALSA: firewire-tascam: remove a flag for
	controller
Date: Fri,  5 Feb 2016 09:56:07 +0900
Message-ID: <1454633768-17729-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1454633768-17729-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CBE02605C1
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

Currently, 'struct snd_tscm_spec' has a member named as 'is_controller' to
identify MIDI controller. This member was originally added to skip
parse control and status messages in isochronous packets for non-controller
model.

As long as I investigate, FW-1804 (non-controller) also transfers the
control and status message, thus it becomes meaningless.

This commit removes it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam.c | 3 ---
 sound/firewire/tascam/tascam.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index dcb11c2..e281c33 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -21,7 +21,6 @@ static struct snd_tscm_spec model_specs[] = {
 		.pcm_playback_analog_channels = 8,
 		.midi_capture_ports = 4,
 		.midi_playback_ports = 4,
-		.is_controller = true,
 	},
 	{
 		.name = "FW-1082",
@@ -31,7 +30,6 @@ static struct snd_tscm_spec model_specs[] = {
 		.pcm_playback_analog_channels = 2,
 		.midi_capture_ports = 2,
 		.midi_playback_ports = 2,
-		.is_controller = true,
 	},
 	{
 		.name = "FW-1804",
@@ -41,7 +39,6 @@ static struct snd_tscm_spec model_specs[] = {
 		.pcm_playback_analog_channels = 2,
 		.midi_capture_ports = 2,
 		.midi_playback_ports = 4,
-		.is_controller = false,
 	},
 };
 
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index 2d028d2..6626860 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -39,7 +39,6 @@ struct snd_tscm_spec {
 	unsigned int pcm_playback_analog_channels;
 	unsigned int midi_capture_ports;
 	unsigned int midi_playback_ports;
-	bool is_controller;
 };
 
 #define TSCM_MIDI_IN_PORT_MAX	4
-- 
2.5.0
