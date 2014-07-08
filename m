From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH] USB-Audio: Add second S/PDIF device on Phiree
	U2
Date: Tue,  8 Jul 2014 11:19:20 +0300
Message-ID: <1404807560-17139-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail.tpnet.fi (webmail.tpnet.fi [62.106.63.33])
 by alsa0.perex.cz (Postfix) with ESMTP id CAA4E2602AD
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 10:19:23 +0200 (CEST)
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

Phiree U2 has an unusual configuration. It only has S/PDIF output, but
there are still two devices presented:
- device 0: PCM audio, subject to volume control
- device 1: non-PCM data (passthrough), not subject to volume control

It looks like the AES bits are set according to the selected device,
since outputting PCM data via device 1 will not work (silence).

Currently only the device 0 is shown via the "iec958" alias, and the
second device is not accessible via hinted aliases.

Simply provide access to both of these devices via the "iec958" alias.

Reported-by: touc @ XBMC forum
Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---

This isn't really the optimal solution, but is probably one of the
simplest (except maybe just using device 1 as the only iec958 device).

I guess the kernel driver (or even config rules with sufficient @func
support) could select the appropriate device according to AES0, but
not sure if that is worth the effort?

Also, I'm not 100% sure if this is actually uncommon or if we just
hide it in on other such devices.


 src/conf/cards/USB-Audio.conf | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
index ce3ae01..77a48b9 100644
--- a/src/conf/cards/USB-Audio.conf
+++ b/src/conf/cards/USB-Audio.conf
@@ -52,6 +52,11 @@ USB-Audio.pcm.iec958_device {
 	"USB Device 0x46d:0x992" 999
 }
 
+# Second iec958 device number, if any.
+USB-Audio.pcm.iec958_2_device {
+	"PHIREE U2" 1  # 0 = PCM S/PDIF, 1 = non-PCM S/PDIF
+}
+
 
 # If a device requires non-standard definitions for front, surround40,
 # surround51, surround71 or iec958, they can be defined here.
@@ -422,4 +427,39 @@ USB-Audio.pcm.iec958.0 {
 	}
 }
 
+USB-Audio.pcm.iec958.1 {
+	@args [ CARD AES0 AES1 AES2 AES3 ]
+	@args.CARD { type string }
+	@args.AES0 { type integer }
+	@args.AES1 { type integer }
+	@args.AES2 { type integer }
+	@args.AES3 { type integer }
+	@func refer
+	name {
+		@func concat
+		strings [
+			"cards.USB-Audio."
+			{ @func card_name card $CARD }
+			".pcm.iec958_2:CARD=" $CARD
+			",AES0=" $AES0 ",AES1=" $AES1 ",AES2=" $AES2 ",AES3=" $AES3
+		]
+	}
+	default {
+		# FIXME: we cannot set the AES parameters
+		type hw
+		card $CARD
+		device {
+			@func refer
+			name {
+				@func concat
+				strings [
+					"cards.USB-Audio.pcm.iec958_2_device."
+					{ @func card_name card $CARD }
+				]
+			}
+			default 999
+		}
+	}
+}
+
 # vim: ft=alsaconf
-- 
1.8.4.5
