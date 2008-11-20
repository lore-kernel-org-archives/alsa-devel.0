From: "naveen krishna ch" <naveenkrishna.ch@gmail.com>
Subject: ASoC, TWL4030 Register defaults
Date: Thu, 20 Nov 2008 16:49:33 +0530
Message-ID: <ef0d8a250811200319kd1afdf8r74d09d54e37b830c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B9AF24432
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 12:19:35 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so288456yxh.2
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 03:19:34 -0800 (PST)
Content-Disposition: inline
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
Cc: Mark Brown <broonie@sirena.org.uk>, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

Hi alsa devels,

Thanks for your suggestions.

Here is the patch for the register default values.
The defaults are chosen for minimal gain settings of the input and output
devices of the CODEC.

If asked for i can send the details of each register.
I will format and send the other patches soon.

The patch is as follows:

[PATCH] Register default values for gain, path selection for various input
and output devices
From:
chnaveenkrishna <chnaveen@chnaveen.mistral.in>
  To:
Date:
Today 04:49:50 pm

---
 sound/soc/codecs/twl4030.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index ee2f0d3..3bc42b3 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -45,8 +45,8 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
        0xc3, /* REG_OPTION             (0x2)   */
        0x00, /* REG_UNKNOWN            (0x3)   */
        0x00, /* REG_MICBIAS_CTL        (0x4)   */
-       0x24, /* REG_ANAMICL            (0x5)   */
-       0x04, /* REG_ANAMICR            (0x6)   */
+       0xb0, /* REG_ANAMICL            (0x5)   */
+       0x10, /* REG_ANAMICR            (0x6)   */
        0x0a, /* REG_AVADC_CTL          (0x7)   */
        0x00, /* REG_ADCMICSEL          (0x8)   */
        0x00, /* REG_DIGMIXING          (0x9)   */
@@ -67,22 +67,22 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
        0x00, /* REG_ARX2VTXPGA         (0x18)  */
        0x00, /* REG_ARXL1_APGA_CTL     (0x19)  */
        0x00, /* REG_ARXR1_APGA_CTL     (0x1A)  */
-       0x4b, /* REG_ARXL2_APGA_CTL     (0x1B)  */
-       0x4b, /* REG_ARXR2_APGA_CTL     (0x1C)  */
+       0x2b, /* REG_ARXL2_APGA_CTL     (0x1B)  */
+       0x2b, /* REG_ARXR2_APGA_CTL     (0x1C)  */
        0x00, /* REG_ATX2ARXPGA         (0x1D)  */
        0x00, /* REG_BT_IF              (0x1E)  */
        0x00, /* REG_BTPGA              (0x1F)  */
        0x00, /* REG_BTSTPGA            (0x20)  */
-       0x00, /* REG_EAR_CTL            (0x21)  */
-       0x24, /* REG_HS_SEL             (0x22)  */
-       0x0a, /* REG_HS_GAIN_SET        (0x23)  */
+       0x20, /* REG_EAR_CTL            (0x21)  */
+       0x00, /* REG_HS_SEL             (0x22)  */
+       0x05, /* REG_HS_GAIN_SET        (0x23)  */
        0x00, /* REG_HS_POPN_SET        (0x24)  */
-       0x00, /* REG_PREDL_CTL          (0x25)  */
-       0x00, /* REG_PREDR_CTL          (0x26)  */
-       0x00, /* REG_PRECKL_CTL         (0x27)  */
-       0x00, /* REG_PRECKR_CTL         (0x28)  */
-       0x00, /* REG_HFL_CTL            (0x29)  */
-       0x00, /* REG_HFR_CTL            (0x2A)  */
+       0x20, /* REG_PREDL_CTL          (0x25)  */
+       0x20, /* REG_PREDR_CTL          (0x26)  */
+       0x20, /* REG_PRECKL_CTL         (0x27)  */
+       0x20, /* REG_PRECKR_CTL         (0x28)  */
+       0x1f, /* REG_HFL_CTL            (0x29)  */
+       0x1f, /* REG_HFR_CTL            (0x2A)  */
        0x00, /* REG_ALC_CTL            (0x2B)  */
        0x00, /* REG_ALC_SET1           (0x2C)  */
        0x00, /* REG_ALC_SET2           (0x2D)  */
@@ -112,7 +112,7 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
        0x00, /* REG_VIBRA_CTL          (0x45)  */
        0x00, /* REG_VIBRA_SET          (0x46)  */
        0x00, /* REG_VIBRA_PWM_SET      (0x47)  */
-       0x00, /* REG_ANAMIC_GAIN        (0x48)  */
+       0x24, /* REG_ANAMIC_GAIN        (0x48)  */
        0x00, /* REG_MISC_SET_2         (0x49)  */
 };

-- 
1.5.3.4

-- 
Thanks,

(: Naveen Krishna Ch :)
