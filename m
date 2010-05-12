From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 2/5] hda - allow up to 10 Azalia codecs
Date: Wed, 12 May 2010 09:30:17 +0800
Message-ID: <20100512015713.872250021@intel.com>
References: <20100512013015.752623810@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C21E1037F7
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 03:58:31 +0200 (CEST)
Content-Disposition: inline; filename=alsa-max-codecs.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

Currently AZX_MAX_CODECS is defined to 8. Increase it to 10 in order to
support the HDMI device indices {3, 7, 8, 9}.

The HD audio spec allows up to 14 codecs. So we are still within the
hardware capacity.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_intel.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_intel.c	2010-05-10 09:40:20.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_intel.c	2010-05-11 13:02:51.000000000 +0800
@@ -267,7 +267,7 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO
 #define RIRB_INT_MASK		0x05
 
 /* STATESTS int mask: S3,SD2,SD1,SD0 */
-#define AZX_MAX_CODECS		8
+#define AZX_MAX_CODECS		10
 #define AZX_DEFAULT_CODECS	4
 #define STATESTS_INT_MASK	((1 << AZX_MAX_CODECS) - 1)
 
@@ -866,7 +866,7 @@ static int azx_reset(struct azx *chip, i
 		goto __skip;
 
 	/* clear STATESTS */
-	azx_writeb(chip, STATESTS, STATESTS_INT_MASK);
+	azx_writew(chip, STATESTS, STATESTS_INT_MASK);
 
 	/* reset controller */
 	azx_writel(chip, GCTL, azx_readl(chip, GCTL) & ~ICH6_GCTL_RESET);
@@ -956,7 +956,7 @@ static void azx_int_clear(struct azx *ch
 	}
 
 	/* clear STATESTS */
-	azx_writeb(chip, STATESTS, STATESTS_INT_MASK);
+	azx_writew(chip, STATESTS, STATESTS_INT_MASK);
 
 	/* clear rirb status */
 	azx_writeb(chip, RIRBSTS, RIRB_INT_MASK);
