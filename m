From: Petr Kulhavy <petr@barix.com>
Subject: [PATCH v2 1/2] ASoC: wm8985: add register definitions
	for WM8758
Date: Tue, 17 May 2016 14:48:53 +0200
Message-ID: <1463489334-17549-2-git-send-email-petr@barix.com>
References: <1463489334-17549-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id CCC8D26148F
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 14:49:07 +0200 (CEST)
Received: by mail-wm0-f52.google.com with SMTP id e201so138486690wme.0
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 05:49:07 -0700 (PDT)
In-Reply-To: <1463489334-17549-1-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com
Cc: Petr Kulhavy <petr@barix.com>, alsa-devel@alsa-project.org, plamen@barix.com
List-Id: alsa-devel@alsa-project.org

The WM8758 chip is almost identical to WM8985 with the difference that it
doesn't feature the AUX input. This patch adds the register definitions
for WM8758 specific bit fields to the header file.

Signed-off-by: Petr Kulhavy <petr@barix.com>
---
v1: initial
v2: no change

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
1.9.1
