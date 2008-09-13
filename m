From: robbat2@gentoo.org
Subject: [PATCH] ALSA: HDA: hda_local: Less magic numbers.
Date: Sat, 13 Sep 2008 16:54:59 -0700
Message-ID: <1221350101-11772-3-git-send-email-robbat2@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.isohunt.com (b01.ext.isohunt.com [208.71.112.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EF9F245E1
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Sep 2008 01:55:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, "Robin H. Johnson" <robbat2@gentoo.org>
List-Id: alsa-devel@alsa-project.org

From: Robin H. Johnson <robbat2@gentoo.org>

Explain some of the magic numbers I saw while trying to fix the AD1989 SPDIF
issue. Maybe should just use the expanded form directly in the verbs?

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>

diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index d688f50..7957fef 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -368,12 +368,15 @@ int snd_hda_parse_pin_def_config(struct hda_codec *codec,
 #define AMP_OUT_UNMUTE	0xb000
 #define AMP_OUT_ZERO	0xb000
 /* pinctl values */
-#define PIN_IN		0x20
-#define PIN_VREF80	0x24
-#define PIN_VREF50	0x21
-#define PIN_OUT		0x40
-#define PIN_HP		0xc0
-#define PIN_HP_AMP	0x80
+#define PIN_IN			(AC_PINCTL_IN_EN)
+#define PIN_VREFHIZ	(AC_PINCTL_IN_EN | AC_PINCTL_VREF_HIZ)
+#define PIN_VREF50		(AC_PINCTL_IN_EN | AC_PINCTL_VREF_50)
+#define PIN_VREFGRD	(AC_PINCTL_IN_EN | AC_PINCTL_VREF_GRD)
+#define PIN_VREF80		(AC_PINCTL_IN_EN | AC_PINCTL_VREF_80)
+#define PIN_VREF100	(AC_PINCTL_IN_EN | AC_PINCTL_VREF_100)
+#define PIN_OUT		(AC_PINCTL_OUT_EN)
+#define PIN_HP			(AC_PINCTL_OUT_EN | AC_PINCTL_HP_EN)
+#define PIN_HP_AMP		(AC_PINCTL_HP_EN)
 
 /*
  * get widget capabilities
-- 
1.6.0.1
