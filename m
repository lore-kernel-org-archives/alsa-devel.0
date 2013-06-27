From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 4/7] ALSA: usb-audio: add MIDI port names for
 some Roland devices
Date: Thu, 27 Jun 2013 22:19:25 +0200
Message-ID: <51CC9E4D.4050006@ladisch.de>
References: <51CC9D8B.7060601@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id DC31E265679
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 22:18:32 +0200 (CEST)
In-Reply-To: <51CC9D8B.7060601@ladisch.de>
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
 sound/usb/midi.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 63dd054..b901f46 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1575,8 +1575,41 @@ static struct port_info {
 	EXTERNAL_PORT(0x0582, 0x004d, 0, "%s MIDI"),
 	EXTERNAL_PORT(0x0582, 0x004d, 1, "%s 1"),
 	EXTERNAL_PORT(0x0582, 0x004d, 2, "%s 2"),
+	/* BOSS GT-PRO */
+	CONTROL_PORT(0x0582, 0x0089, 0, "%s Control"),
 	/* Edirol UM-3EX */
 	CONTROL_PORT(0x0582, 0x009a, 3, "%s Control"),
+	/* Roland VG-99 */
+	CONTROL_PORT(0x0582, 0x00b2, 0, "%s Control"),
+	EXTERNAL_PORT(0x0582, 0x00b2, 1, "%s MIDI"),
+	/* Cakewalk Sonar V-Studio 100 */
+	EXTERNAL_PORT(0x0582, 0x00eb, 0, "%s MIDI"),
+	CONTROL_PORT(0x0582, 0x00eb, 1, "%s Control"),
+	/* Roland VB-99 */
+	CONTROL_PORT(0x0582, 0x0102, 0, "%s Control"),
+	EXTERNAL_PORT(0x0582, 0x0102, 1, "%s MIDI"),
+	/* Roland A-PRO */
+	EXTERNAL_PORT(0x0582, 0x010f, 0, "%s MIDI"),
+	CONTROL_PORT(0x0582, 0x010f, 1, "%s 1"),
+	CONTROL_PORT(0x0582, 0x010f, 2, "%s 2"),
+	/* Roland SD-50 */
+	ROLAND_SYNTH_PORT(0x0582, 0x0114, 0, "%s Synth", 128),
+	EXTERNAL_PORT(0x0582, 0x0114, 1, "%s MIDI"),
+	CONTROL_PORT(0x0582, 0x0114, 2, "%s Control"),
+	/* Roland OCTA-CAPTURE */
+	EXTERNAL_PORT(0x0582, 0x0120, 0, "%s MIDI"),
+	CONTROL_PORT(0x0582, 0x0120, 1, "%s Control"),
+	EXTERNAL_PORT(0x0582, 0x0121, 0, "%s MIDI"),
+	CONTROL_PORT(0x0582, 0x0121, 1, "%s Control"),
+	/* Roland SPD-SX */
+	CONTROL_PORT(0x0582, 0x0145, 0, "%s Control"),
+	EXTERNAL_PORT(0x0582, 0x0145, 1, "%s MIDI"),
+	/* Roland A-Series */
+	CONTROL_PORT(0x0582, 0x0156, 0, "%s Keyboard"),
+	EXTERNAL_PORT(0x0582, 0x0156, 1, "%s MIDI"),
+	/* Roland INTEGRA-7 */
+	ROLAND_SYNTH_PORT(0x0582, 0x015b, 0, "%s Synth", 128),
+	CONTROL_PORT(0x0582, 0x015b, 1, "%s Control"),
 	/* M-Audio MidiSport 8x8 */
 	CONTROL_PORT(0x0763, 0x1031, 8, "%s Control"),
 	CONTROL_PORT(0x0763, 0x1033, 8, "%s Control"),
