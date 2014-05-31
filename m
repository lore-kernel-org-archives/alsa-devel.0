From: asd <asd@marian1000.go.ro>
Subject: Realtek Alc 883 not have eapd
Date: Sat, 31 May 2014 23:58:03 +0300
Message-ID: <1619929.VNVWo8L5J4@marian1000.go.ro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart4510010.3ZOYrlORXn"
Content-Transfer-Encoding: 7Bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from marian1000.go.ro (5-14-230-222.residential.rdsnet.ro
 [5.14.230.222]) by alsa0.perex.cz (Postfix) with ESMTP id 9780126513B
 for <Alsa-devel@alsa-project.org>; Sat, 31 May 2014 22:58:04 +0200 (CEST)
Received: from localhost ([127.0.0.1] helo=marian1000.go.ro)
 by marian1000.go.ro with esmtp (Exim 4.82)
 (envelope-from <asd@marian1000.go.ro>) id 1WqqLr-0000tt-K7
 for Alsa-devel@alsa-project.org; Sat, 31 May 2014 23:58:03 +0300
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--nextPart4510010.3ZOYrlORXn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Below is patch wich disable eapd.
--nextPart4510010.3ZOYrlORXn
Content-Disposition: attachment; filename="patch_realtek_eapd.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="patch_realtek_eapd.patch"

Index: hda/patch_realtek.c
===================================================================
--- hda.orig/patch_realtek.c	2014-05-13 14:33:14.000000000 +0300
+++ hda/patch_realtek.c	2014-05-31 23:09:08.668996601 +0300
@@ -293,8 +293,14 @@
 static void alc_auto_init_amp(struct hda_codec *codec, int type)
 {
 	unsigned int tmp;
+	
+	if (codec->vendor_id == 0x10ec0883) {
 
-	alc_auto_setup_eapd(codec, true);
+		alc_auto_setup_eapd(codec, false);
+	} else {
+		alc_auto_setup_eapd(codec, true);
+		}
+			
 	switch (type) {
 	case ALC_INIT_GPIO1:
 		snd_hda_sequence_write(codec, alc_gpio1_init_verbs);

--nextPart4510010.3ZOYrlORXn
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--nextPart4510010.3ZOYrlORXn--
