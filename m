From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Enable internal speaker on Dell
	M101z
Date: Thu, 16 Sep 2010 10:16:10 +0200
Message-ID: <4C91D24A.4070005@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000100000009090600000802"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id C9C3A24341
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Sep 2010 10:16:15 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1Ow9dc-00081q-0c
	for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2010 09:16:12 +0100
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.103]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1Ow9db-0001t1-KN
	for alsa-devel@alsa-project.org; Thu, 16 Sep 2010 09:16:11 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000100000009090600000802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

BugLink: http://launchpad.net/bugs/640254

In some cases a magic processing coefficient is needed to enable
the internal speaker on Dell M101z. According to Realtek, this
processing coefficient is only present on ALC269vb.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------000100000009090600000802
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Enable-internal-speaker-on-Dell-M101z.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Enable-internal-speaker-on-Dell-M101z.patch"

>From 363739d6b5eefb44a0cbbf44c390f8fcd01a6e58 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Thu, 16 Sep 2010 10:07:53 +0200
Subject: [PATCH] ALSA: HDA: Enable internal speaker on Dell M101z

BugLink: http://launchpad.net/bugs/640254

In some cases a magic processing coefficient is needed to enable
the internal speaker on Dell M101z. According to Realtek, this
processing coefficient is only present on ALC269vb.

Cc: stable@kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ab2947d..2063d0f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -14671,6 +14671,7 @@ static int alc269_resume(struct hda_codec *codec)
 
 enum {
 	ALC269_FIXUP_SONY_VAIO,
+	ALC269_FIXUP_DELL_M101Z,
 };
 
 static const struct alc_fixup alc269_fixups[] = {
@@ -14680,11 +14681,20 @@ static const struct alc_fixup alc269_fixups[] = {
 			{}
 		}
 	},
+	[ALC269_FIXUP_DELL_M101Z] = {
+		.verbs = (const struct hda_verb[]) {
+			/* Enables internal speaker */
+			{0x20, AC_VERB_SET_COEF_INDEX, 13},
+			{0x20, AC_VERB_SET_PROC_COEF, 0x4040},
+			{}
+		}
+	},
 };
 
 static struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x104d, 0x9071, "Sony VAIO", ALC269_FIXUP_SONY_VAIO),
 	SND_PCI_QUIRK(0x104d, 0x9077, "Sony VAIO", ALC269_FIXUP_SONY_VAIO),
+	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	{}
 };
 
-- 
1.7.1


--------------000100000009090600000802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000100000009090600000802--
