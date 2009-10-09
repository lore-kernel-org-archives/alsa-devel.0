From: <LoganLi@viatech.com.cn>
Subject: [PATCH 1/30] ALSA: HDA VIA: Remove unused
	IS_VT17xx_VENDORID macro
Date: Fri, 9 Oct 2009 18:40:00 +0800
Message-ID: <5B2BE0DB92BC8F4694F815C2F34E0D5F123C2E@exchbj03.viatech.com.bj>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 926DC1037FE
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 12:39:58 +0200 (CEST)
Content-class: urn:content-classes:message
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: Remove unused IS_VT17xx_VENDORID macro

IS_VT17*_VENDORID macros are used nowhere, so clean them up.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 pci/hda/patch_via.c |    8 --------
 1 file changed, 8 deletions(-)

--- a/pci/hda/patch_via.c
+++ b/pci/hda/patch_via.c
@@ -76,14 +76,6 @@
 #define VT1702_HP_NID		0x17
 #define VT1702_DIGOUT_NID	0x11
 
-#define IS_VT1708_VENDORID(x)		((x) >= 0x11061708 && (x) <=
0x1106170b)
-#define IS_VT1709_10CH_VENDORID(x)	((x) >= 0x1106e710 && (x) <=
0x1106e713)
-#define IS_VT1709_6CH_VENDORID(x)	((x) >= 0x1106e714 && (x) <=
0x1106e717)
-#define IS_VT1708B_8CH_VENDORID(x)	((x) >= 0x1106e720 && (x) <=
0x1106e723)
-#define IS_VT1708B_4CH_VENDORID(x)	((x) >= 0x1106e724 && (x) <=
0x1106e727)
-#define IS_VT1708S_VENDORID(x)		((x) >= 0x11060397 && (x) <=
0x11067397)
-#define IS_VT1702_VENDORID(x)		((x) >= 0x11060398 && (x) <=
0x11067398)
-
 enum VIA_HDA_CODEC {
 	UNKNOWN = -1,
 	VT1708,
