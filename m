From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 1/3] ALSA: usb-audio: add packet size quirk for
	the Medeli	DD305
Date: Sun, 15 Nov 2015 22:37:44 +0100
Message-ID: <5648FB28.8030702@ladisch.de>
References: <5648FAED.8020300@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 670492608EA
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 22:38:41 +0100 (CET)
In-Reply-To: <5648FAED.8020300@ladisch.de>
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
 sound/usb/midi.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 7661616..68e9f9a 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1341,6 +1341,7 @@ static int snd_usbmidi_out_endpoint_create(struct snd_usb_midi *umidi,
 		 * Various chips declare a packet size larger than 4 bytes, but
 		 * do not actually work with larger packets:
 		 */
+	case USB_ID(0x0a67, 0x5011): /* Medeli DD305 */
 	case USB_ID(0x0a92, 0x1020): /* ESI M4U */
 	case USB_ID(0x1430, 0x474b): /* RedOctane GH MIDI INTERFACE */
 	case USB_ID(0x15ca, 0x0101): /* Textech USB Midi Cable */
