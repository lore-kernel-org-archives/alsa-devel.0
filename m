From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 1/31] HDA patch_via.c: Remove
	IS_VT17xx_VENDORID macro
Date: Thu, 8 Oct 2009 13:27:49 +0800
Message-ID: <16685ee0910072227v76bb2e38kc75c91565c45f633@mail.gmail.com>
References: <16685ee0910050628r328962bbt1af7e429264868d3@mail.gmail.com>
	<s5hd4516g5t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id ABF3210391B
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:27:49 +0200 (CEST)
Received: by fxm8 with SMTP id 8so5182613fxm.45
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:27:49 -0700 (PDT)
In-Reply-To: <s5hd4516g5t.wl%tiwai@suse.de>
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
Cc: LoganLi@viatech.com.cn, alsa-devel@alsa-project.org, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Remove unused IS_VT17xx_VENDORID macro

IS_VT17*_VENDORID macros are used nowhere, so clean them up.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |    8 --------
 1 file changed, 8 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
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
