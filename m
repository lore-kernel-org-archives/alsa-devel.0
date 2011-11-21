From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove WM5100 DSP memory windows from
	register default data
Date: Mon, 21 Nov 2011 18:09:52 +0000
Message-ID: <1321898992-6538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 522F5244AC
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 19:10:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Gidwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

They're all volatile so shouldn't have defaults and as we've got pages
into the DSP memory the registers themselves aren't that useful - a
further patch adding support for the DSPs will provide direct diagnostic
access to the DSP memories.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100-tables.c |  168 --------------------------------------
 1 files changed, 0 insertions(+), 168 deletions(-)

diff --git a/sound/soc/codecs/wm5100-tables.c b/sound/soc/codecs/wm5100-tables.c
index 3e90dea..9a18fae 100644
--- a/sound/soc/codecs/wm5100-tables.c
+++ b/sound/soc/codecs/wm5100-tables.c
@@ -697,90 +697,6 @@ bool wm5100_readable_register(struct device *dev, unsigned int reg)
 	case WM5100_HPLPF3_2:
 	case WM5100_HPLPF4_1:
 	case WM5100_HPLPF4_2:
-	case WM5100_DSP1_DM_0:
-	case WM5100_DSP1_DM_1:
-	case WM5100_DSP1_DM_2:
-	case WM5100_DSP1_DM_3:
-	case WM5100_DSP1_DM_508:
-	case WM5100_DSP1_DM_509:
-	case WM5100_DSP1_DM_510:
-	case WM5100_DSP1_DM_511:
-	case WM5100_DSP1_PM_0:
-	case WM5100_DSP1_PM_1:
-	case WM5100_DSP1_PM_2:
-	case WM5100_DSP1_PM_3:
-	case WM5100_DSP1_PM_4:
-	case WM5100_DSP1_PM_5:
-	case WM5100_DSP1_PM_1530:
-	case WM5100_DSP1_PM_1531:
-	case WM5100_DSP1_PM_1532:
-	case WM5100_DSP1_PM_1533:
-	case WM5100_DSP1_PM_1534:
-	case WM5100_DSP1_PM_1535:
-	case WM5100_DSP1_ZM_0:
-	case WM5100_DSP1_ZM_1:
-	case WM5100_DSP1_ZM_2:
-	case WM5100_DSP1_ZM_3:
-	case WM5100_DSP1_ZM_2044:
-	case WM5100_DSP1_ZM_2045:
-	case WM5100_DSP1_ZM_2046:
-	case WM5100_DSP1_ZM_2047:
-	case WM5100_DSP2_DM_0:
-	case WM5100_DSP2_DM_1:
-	case WM5100_DSP2_DM_2:
-	case WM5100_DSP2_DM_3:
-	case WM5100_DSP2_DM_508:
-	case WM5100_DSP2_DM_509:
-	case WM5100_DSP2_DM_510:
-	case WM5100_DSP2_DM_511:
-	case WM5100_DSP2_PM_0:
-	case WM5100_DSP2_PM_1:
-	case WM5100_DSP2_PM_2:
-	case WM5100_DSP2_PM_3:
-	case WM5100_DSP2_PM_4:
-	case WM5100_DSP2_PM_5:
-	case WM5100_DSP2_PM_1530:
-	case WM5100_DSP2_PM_1531:
-	case WM5100_DSP2_PM_1532:
-	case WM5100_DSP2_PM_1533:
-	case WM5100_DSP2_PM_1534:
-	case WM5100_DSP2_PM_1535:
-	case WM5100_DSP2_ZM_0:
-	case WM5100_DSP2_ZM_1:
-	case WM5100_DSP2_ZM_2:
-	case WM5100_DSP2_ZM_3:
-	case WM5100_DSP2_ZM_2044:
-	case WM5100_DSP2_ZM_2045:
-	case WM5100_DSP2_ZM_2046:
-	case WM5100_DSP2_ZM_2047:
-	case WM5100_DSP3_DM_0:
-	case WM5100_DSP3_DM_1:
-	case WM5100_DSP3_DM_2:
-	case WM5100_DSP3_DM_3:
-	case WM5100_DSP3_DM_508:
-	case WM5100_DSP3_DM_509:
-	case WM5100_DSP3_DM_510:
-	case WM5100_DSP3_DM_511:
-	case WM5100_DSP3_PM_0:
-	case WM5100_DSP3_PM_1:
-	case WM5100_DSP3_PM_2:
-	case WM5100_DSP3_PM_3:
-	case WM5100_DSP3_PM_4:
-	case WM5100_DSP3_PM_5:
-	case WM5100_DSP3_PM_1530:
-	case WM5100_DSP3_PM_1531:
-	case WM5100_DSP3_PM_1532:
-	case WM5100_DSP3_PM_1533:
-	case WM5100_DSP3_PM_1534:
-	case WM5100_DSP3_PM_1535:
-	case WM5100_DSP3_ZM_0:
-	case WM5100_DSP3_ZM_1:
-	case WM5100_DSP3_ZM_2:
-	case WM5100_DSP3_ZM_3:
-	case WM5100_DSP3_ZM_2044:
-	case WM5100_DSP3_ZM_2045:
-	case WM5100_DSP3_ZM_2046:
-	case WM5100_DSP3_ZM_2047:
 		return 1;
 	default:
 		return 0;
@@ -1445,88 +1361,4 @@ struct reg_default wm5100_reg_defaults[WM5100_REGISTER_COUNT] = {
 	{ 0x0EC9, 0x0000 },  /* R3785  - HPLPF3_2 */
 	{ 0x0ECC, 0x0000 },  /* R3788  - HPLPF4_1 */
 	{ 0x0ECD, 0x0000 },  /* R3789  - HPLPF4_2 */
-	{ 0x4000, 0x0000 },  /* R16384 - DSP1 DM 0 */
-	{ 0x4001, 0x0000 },  /* R16385 - DSP1 DM 1 */
-	{ 0x4002, 0x0000 },  /* R16386 - DSP1 DM 2 */
-	{ 0x4003, 0x0000 },  /* R16387 - DSP1 DM 3 */
-	{ 0x41FC, 0x0000 },  /* R16892 - DSP1 DM 508 */
-	{ 0x41FD, 0x0000 },  /* R16893 - DSP1 DM 509 */
-	{ 0x41FE, 0x0000 },  /* R16894 - DSP1 DM 510 */
-	{ 0x41FF, 0x0000 },  /* R16895 - DSP1 DM 511 */
-	{ 0x4800, 0x0000 },  /* R18432 - DSP1 PM 0 */
-	{ 0x4801, 0x0000 },  /* R18433 - DSP1 PM 1 */
-	{ 0x4802, 0x0000 },  /* R18434 - DSP1 PM 2 */
-	{ 0x4803, 0x0000 },  /* R18435 - DSP1 PM 3 */
-	{ 0x4804, 0x0000 },  /* R18436 - DSP1 PM 4 */
-	{ 0x4805, 0x0000 },  /* R18437 - DSP1 PM 5 */
-	{ 0x4DFA, 0x0000 },  /* R19962 - DSP1 PM 1530 */
-	{ 0x4DFB, 0x0000 },  /* R19963 - DSP1 PM 1531 */
-	{ 0x4DFC, 0x0000 },  /* R19964 - DSP1 PM 1532 */
-	{ 0x4DFD, 0x0000 },  /* R19965 - DSP1 PM 1533 */
-	{ 0x4DFE, 0x0000 },  /* R19966 - DSP1 PM 1534 */
-	{ 0x4DFF, 0x0000 },  /* R19967 - DSP1 PM 1535 */
-	{ 0x5000, 0x0000 },  /* R20480 - DSP1 ZM 0 */
-	{ 0x5001, 0x0000 },  /* R20481 - DSP1 ZM 1 */
-	{ 0x5002, 0x0000 },  /* R20482 - DSP1 ZM 2 */
-	{ 0x5003, 0x0000 },  /* R20483 - DSP1 ZM 3 */
-	{ 0x57FC, 0x0000 },  /* R22524 - DSP1 ZM 2044 */
-	{ 0x57FD, 0x0000 },  /* R22525 - DSP1 ZM 2045 */
-	{ 0x57FE, 0x0000 },  /* R22526 - DSP1 ZM 2046 */
-	{ 0x57FF, 0x0000 },  /* R22527 - DSP1 ZM 2047 */
-	{ 0x6000, 0x0000 },  /* R24576 - DSP2 DM 0 */
-	{ 0x6001, 0x0000 },  /* R24577 - DSP2 DM 1 */
-	{ 0x6002, 0x0000 },  /* R24578 - DSP2 DM 2 */
-	{ 0x6003, 0x0000 },  /* R24579 - DSP2 DM 3 */
-	{ 0x61FC, 0x0000 },  /* R25084 - DSP2 DM 508 */
-	{ 0x61FD, 0x0000 },  /* R25085 - DSP2 DM 509 */
-	{ 0x61FE, 0x0000 },  /* R25086 - DSP2 DM 510 */
-	{ 0x61FF, 0x0000 },  /* R25087 - DSP2 DM 511 */
-	{ 0x6800, 0x0000 },  /* R26624 - DSP2 PM 0 */
-	{ 0x6801, 0x0000 },  /* R26625 - DSP2 PM 1 */
-	{ 0x6802, 0x0000 },  /* R26626 - DSP2 PM 2 */
-	{ 0x6803, 0x0000 },  /* R26627 - DSP2 PM 3 */
-	{ 0x6804, 0x0000 },  /* R26628 - DSP2 PM 4 */
-	{ 0x6805, 0x0000 },  /* R26629 - DSP2 PM 5 */
-	{ 0x6DFA, 0x0000 },  /* R28154 - DSP2 PM 1530 */
-	{ 0x6DFB, 0x0000 },  /* R28155 - DSP2 PM 1531 */
-	{ 0x6DFC, 0x0000 },  /* R28156 - DSP2 PM 1532 */
-	{ 0x6DFD, 0x0000 },  /* R28157 - DSP2 PM 1533 */
-	{ 0x6DFE, 0x0000 },  /* R28158 - DSP2 PM 1534 */
-	{ 0x6DFF, 0x0000 },  /* R28159 - DSP2 PM 1535 */
-	{ 0x7000, 0x0000 },  /* R28672 - DSP2 ZM 0 */
-	{ 0x7001, 0x0000 },  /* R28673 - DSP2 ZM 1 */
-	{ 0x7002, 0x0000 },  /* R28674 - DSP2 ZM 2 */
-	{ 0x7003, 0x0000 },  /* R28675 - DSP2 ZM 3 */
-	{ 0x77FC, 0x0000 },  /* R30716 - DSP2 ZM 2044 */
-	{ 0x77FD, 0x0000 },  /* R30717 - DSP2 ZM 2045 */
-	{ 0x77FE, 0x0000 },  /* R30718 - DSP2 ZM 2046 */
-	{ 0x77FF, 0x0000 },  /* R30719 - DSP2 ZM 2047 */
-	{ 0x8000, 0x0000 },  /* R32768 - DSP3 DM 0 */
-	{ 0x8001, 0x0000 },  /* R32769 - DSP3 DM 1 */
-	{ 0x8002, 0x0000 },  /* R32770 - DSP3 DM 2 */
-	{ 0x8003, 0x0000 },  /* R32771 - DSP3 DM 3 */
-	{ 0x81FC, 0x0000 },  /* R33276 - DSP3 DM 508 */
-	{ 0x81FD, 0x0000 },  /* R33277 - DSP3 DM 509 */
-	{ 0x81FE, 0x0000 },  /* R33278 - DSP3 DM 510 */
-	{ 0x81FF, 0x0000 },  /* R33279 - DSP3 DM 511 */
-	{ 0x8800, 0x0000 },  /* R34816 - DSP3 PM 0 */
-	{ 0x8801, 0x0000 },  /* R34817 - DSP3 PM 1 */
-	{ 0x8802, 0x0000 },  /* R34818 - DSP3 PM 2 */
-	{ 0x8803, 0x0000 },  /* R34819 - DSP3 PM 3 */
-	{ 0x8804, 0x0000 },  /* R34820 - DSP3 PM 4 */
-	{ 0x8805, 0x0000 },  /* R34821 - DSP3 PM 5 */
-	{ 0x8DFA, 0x0000 },  /* R36346 - DSP3 PM 1530 */
-	{ 0x8DFB, 0x0000 },  /* R36347 - DSP3 PM 1531 */
-	{ 0x8DFC, 0x0000 },  /* R36348 - DSP3 PM 1532 */
-	{ 0x8DFD, 0x0000 },  /* R36349 - DSP3 PM 1533 */
-	{ 0x8DFE, 0x0000 },  /* R36350 - DSP3 PM 1534 */
-	{ 0x8DFF, 0x0000 },  /* R36351 - DSP3 PM 1535 */
-	{ 0x9000, 0x0000 },  /* R36864 - DSP3 ZM 0 */
-	{ 0x9001, 0x0000 },  /* R36865 - DSP3 ZM 1 */
-	{ 0x9002, 0x0000 },  /* R36866 - DSP3 ZM 2 */
-	{ 0x9003, 0x0000 },  /* R36867 - DSP3 ZM 3 */
-	{ 0x97FC, 0x0000 },  /* R38908 - DSP3 ZM 2044 */
-	{ 0x97FD, 0x0000 },  /* R38909 - DSP3 ZM 2045 */
-	{ 0x97FE, 0x0000 },  /* R38910 - DSP3 ZM 2046 */
-	{ 0x97FF, 0x0000 },  /* R38911 - DSP3 ZM 2047 */
 };
-- 
1.7.7.3
