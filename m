From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 3/5] ALSA: usb-audio: add MIDI port names for
	the Yamaha MOTIF	XF
Date: Sun, 07 Sep 2014 21:44:29 +0200
Message-ID: <540CB59D.2040505@ladisch.de>
References: <540CB520.50909@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 9B1102610A6
 for <alsa-devel@alsa-project.org>; Sun,  7 Sep 2014 21:43:40 +0200 (CEST)
In-Reply-To: <540CB520.50909@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/midi.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 7b166c2..69e93a9 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1506,6 +1506,12 @@ static struct port_info {
 	PORT_INFO(vendor, product, num, name, 0, \
 		  SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC | \
 		  SNDRV_SEQ_PORT_TYPE_HARDWARE)
+#define GM_SYNTH_PORT(vendor, product, num, name, voices) \
+	PORT_INFO(vendor, product, num, name, voices, \
+		  SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC | \
+		  SNDRV_SEQ_PORT_TYPE_MIDI_GM | \
+		  SNDRV_SEQ_PORT_TYPE_HARDWARE | \
+		  SNDRV_SEQ_PORT_TYPE_SYNTHESIZER)
 #define ROLAND_SYNTH_PORT(vendor, product, num, name, voices) \
 	PORT_INFO(vendor, product, num, name, voices, \
 		  SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC | \
@@ -1525,6 +1531,11 @@ static struct port_info {
 		  SNDRV_SEQ_PORT_TYPE_MIDI_MT32 | \
 		  SNDRV_SEQ_PORT_TYPE_HARDWARE | \
 		  SNDRV_SEQ_PORT_TYPE_SYNTHESIZER)
+	/* Yamaha MOTIF XF */
+	GM_SYNTH_PORT(0x0499, 0x105c, 0, "%s Tone Generator", 128),
+	CONTROL_PORT(0x0499, 0x105c, 1, "%s Remote Control"),
+	EXTERNAL_PORT(0x0499, 0x105c, 2, "%s Thru"),
+	CONTROL_PORT(0x0499, 0x105c, 3, "%s Editor"),
 	/* Roland UA-100 */
 	CONTROL_PORT(0x0582, 0x0000, 2, "%s Control"),
 	/* Roland SC-8850 */
