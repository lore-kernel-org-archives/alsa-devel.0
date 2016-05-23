From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8985: add register definitions for
	WM8758" to the asoc tree
Date: Mon, 23 May 2016 18:50:20 +0100
Message-ID: <E1b4tzg-0006aQ-JC@debutante>
References: <1463068477-18421-2-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 52359261527
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 19:50:32 +0200 (CEST)
In-Reply-To: <1463068477-18421-2-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>
Cc: plamen@barix.com, ckeepax@opensource.wolfsonmicro.com, broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8985: add register definitions for WM8758

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6c9ae721dc5024bc67617f46f0faede6445c4b78 Mon Sep 17 00:00:00 2001
From: Petr Kulhavy <petr@barix.com>
Date: Mon, 23 May 2016 16:11:24 +0200
Subject: [PATCH] ASoC: wm8985: add register definitions for WM8758

The WM8758 chip is almost identical to WM8985 with the difference that it
doesn't feature the AUX input. This patch adds the register definitions
for WM8758 specific bit fields to the header file.

Signed-off-by: Petr Kulhavy <petr@barix.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8985.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/sound/soc/codecs/wm8985.h b/sound/soc/codecs/wm8985.h
index 2e71ff507638..41b1048e3c97 100644
--- a/sound/soc/codecs/wm8985.h
+++ b/sound/soc/codecs/wm8985.h
@@ -290,6 +290,9 @@
 #define WM8985_GPIO1GPD_MASK                    0x0040  /* GPIO1GPD */
 #define WM8985_GPIO1GPD_SHIFT                        6  /* GPIO1GPD */
 #define WM8985_GPIO1GPD_WIDTH                        1  /* GPIO1GPD */
+#define WM8758_OPCLKDIV_MASK                    0x0030  /* OPCLKDIV - [1:0] */
+#define WM8758_OPCLKDIV_SHIFT                        4  /* OPCLKDIV - [1:0] */
+#define WM8758_OPCLKDIV_WIDTH                        2  /* OPCLKDIV - [1:0] */
 #define WM8985_GPIO1POL                         0x0008  /* GPIO1POL */
 #define WM8985_GPIO1POL_MASK                    0x0008  /* GPIO1POL */
 #define WM8985_GPIO1POL_SHIFT                        3  /* GPIO1POL */
@@ -301,6 +304,12 @@
 /*
  * R9 (0x09) - Jack Detect Control 1
  */
+#define WM8758_JD_VMID1_MASK                    0x0100  /* JD_VMID1 */
+#define WM8758_JD_VMID1_SHIFT                        8  /* JD_VMID1 */
+#define WM8758_JD_VMID1_WIDTH                        1  /* JD_VMID1 */
+#define WM8758_JD_VMID0_MASK                    0x0080  /* JD_VMID0 */
+#define WM8758_JD_VMID0_SHIFT                        7  /* JD_VMID0 */
+#define WM8758_JD_VMID0_WIDTH                        1  /* JD_VMID0 */
 #define WM8985_JD_EN                            0x0040  /* JD_EN */
 #define WM8985_JD_EN_MASK                       0x0040  /* JD_EN */
 #define WM8985_JD_EN_SHIFT                           6  /* JD_EN */
@@ -649,6 +658,12 @@
 #define WM8985_OUT4_2LNR_MASK                   0x0020  /* OUT4_2LNR */
 #define WM8985_OUT4_2LNR_SHIFT                       5  /* OUT4_2LNR */
 #define WM8985_OUT4_2LNR_WIDTH                       1  /* OUT4_2LNR */
+#define WM8758_VMIDTOG_MASK                     0x0010  /* VMIDTOG */
+#define WM8758_VMIDTOG_SHIFT                         4  /* VMIDTOG */
+#define WM8758_VMIDTOG_WIDTH                         1  /* VMIDTOG */
+#define WM8758_OUT2DEL_MASK                     0x0008  /* OUT2DEL */
+#define WM8758_OUT2DEL_SHIFT                         3  /* OUT2DEL */
+#define WM8758_OUT2DEL_WIDTH                         1  /* OUT2DEL */
 #define WM8985_POBCTRL                          0x0004  /* POBCTRL */
 #define WM8985_POBCTRL_MASK                     0x0004  /* POBCTRL */
 #define WM8985_POBCTRL_SHIFT                         2  /* POBCTRL */
@@ -684,6 +699,9 @@
 #define WM8985_BEEPVOL_MASK                     0x000E  /* BEEPVOL - [3:1] */
 #define WM8985_BEEPVOL_SHIFT                         1  /* BEEPVOL - [3:1] */
 #define WM8985_BEEPVOL_WIDTH                         3  /* BEEPVOL - [3:1] */
+#define WM8758_DELEN2_MASK                      0x0004  /* DELEN2 */
+#define WM8758_DELEN2_SHIFT                          2  /* DELEN2 */
+#define WM8758_DELEN2_WIDTH                          1  /* DELEN2 */
 #define WM8985_BEEPEN                           0x0001  /* BEEPEN */
 #define WM8985_BEEPEN_MASK                      0x0001  /* BEEPEN */
 #define WM8985_BEEPEN_SHIFT                          0  /* BEEPEN */
@@ -790,6 +808,14 @@
 /*
  * R49 (0x31) - Output ctrl
  */
+#define WM8758_HP_COM                           0x0100  /* HP_COM */
+#define WM8758_HP_COM_MASK                      0x0100  /* HP_COM */
+#define WM8758_HP_COM_SHIFT                          8  /* HP_COM */
+#define WM8758_HP_COM_WIDTH                          1  /* HP_COM */
+#define WM8758_LINE_COM                         0x0080  /* LINE_COM */
+#define WM8758_LINE_COM_MASK                    0x0080  /* LINE_COM */
+#define WM8758_LINE_COM_SHIFT                        7  /* LINE_COM */
+#define WM8758_LINE_COM_WIDTH                        1  /* LINE_COM */
 #define WM8985_DACL2RMIX                        0x0040  /* DACL2RMIX */
 #define WM8985_DACL2RMIX_MASK                   0x0040  /* DACL2RMIX */
 #define WM8985_DACL2RMIX_SHIFT                       6  /* DACL2RMIX */
@@ -806,6 +832,14 @@
 #define WM8985_OUT3BOOST_MASK                   0x0008  /* OUT3BOOST */
 #define WM8985_OUT3BOOST_SHIFT                       3  /* OUT3BOOST */
 #define WM8985_OUT3BOOST_WIDTH                       1  /* OUT3BOOST */
+#define WM8758_OUT4ENDEL                        0x0010  /* OUT4ENDEL */
+#define WM8758_OUT4ENDEL_MASK                   0x0010  /* OUT4ENDEL */
+#define WM8758_OUT4ENDEL_SHIFT                       4  /* OUT4ENDEL */
+#define WM8758_OUT4ENDEL_WIDTH                       1  /* OUT4ENDEL */
+#define WM8758_OUT3ENDEL                        0x0008  /* OUT3ENDEL */
+#define WM8758_OUT3ENDEL_MASK                   0x0008  /* OUT3ENDEL */
+#define WM8758_OUT3ENDEL_SHIFT                       3  /* OUT3ENDEL */
+#define WM8758_OUT3ENDEL_WIDTH                       1  /* OUT3ENDEL */
 #define WM8985_TSOPCTRL                         0x0004  /* TSOPCTRL */
 #define WM8985_TSOPCTRL_MASK                    0x0004  /* TSOPCTRL */
 #define WM8985_TSOPCTRL_SHIFT                        2  /* TSOPCTRL */
@@ -1021,6 +1055,10 @@
 #define WM8985_HALFIPBIAS_MASK                  0x0080  /* HALFIPBIAS */
 #define WM8985_HALFIPBIAS_SHIFT                      7  /* HALFIPBIAS */
 #define WM8985_HALFIPBIAS_WIDTH                      1  /* HALFIPBIAS */
+#define WM8758_HALFIPBIAS                       0x0040  /* HALFI_IPGA */
+#define WM8758_HALFI_IPGA_MASK                  0x0040  /* HALFI_IPGA */
+#define WM8758_HALFI_IPGA_SHIFT                      6  /* HALFI_IPGA */
+#define WM8758_HALFI_IPGA_WIDTH                      1  /* HALFI_IPGA */
 #define WM8985_VBBIASTST_MASK                   0x0060  /* VBBIASTST - [6:5] */
 #define WM8985_VBBIASTST_SHIFT                       5  /* VBBIASTST - [6:5] */
 #define WM8985_VBBIASTST_WIDTH                       2  /* VBBIASTST - [6:5] */
-- 
2.8.1
