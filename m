From: Li Bo <liboat@gmail.com>
Subject: [PATCH 1/31] HDA patch_via.c: Remove
	IS_VT17xx_VENDORID macro
Date: Mon, 5 Oct 2009 21:28:00 +0800
Message-ID: <16685ee0910050628r328962bbt1af7e429264868d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id E3ADC244C2
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 15:28:01 +0200 (CEST)
Received: by bwz25 with SMTP id 25so9937800bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 06:28:00 -0700 (PDT)
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
Cc: tiwai@suse.de, LoganLi@viatech.com.cn, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Remove IS_VT17xx_VENDORID macro

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-09-29 18:01:12.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-09-29 18:01:16.000000000 +0800
@@ -76,14 +76,6 @@
 #define VT1702_HP_NID		0x17
 #define VT1702_DIGOUT_NID	0x11

-#define IS_VT1708_VENDORID(x)		((x) >= 0x11061708 && (x) <= 0x1106170b)
-#define IS_VT1709_10CH_VENDORID(x)	((x) >= 0x1106e710 && (x) <= 0x1106e713)
-#define IS_VT1709_6CH_VENDORID(x)	((x) >= 0x1106e714 && (x) <= 0x1106e717)
-#define IS_VT1708B_8CH_VENDORID(x)	((x) >= 0x1106e720 && (x) <= 0x1106e723)
-#define IS_VT1708B_4CH_VENDORID(x)	((x) >= 0x1106e724 && (x) <= 0x1106e727)
-#define IS_VT1708S_VENDORID(x)		((x) >= 0x11060397 && (x) <= 0x11067397)
-#define IS_VT1702_VENDORID(x)		((x) >= 0x11060398 && (x) <= 0x11067398)
-
 enum VIA_HDA_CODEC {
 	UNKNOWN = -1,
 	VT1708,
