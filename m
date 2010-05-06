From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: tlv320dac33: Use codec defaults for
	LOM/LOP and DAC power
Date: Thu,  6 May 2010 12:04:25 +0300
Message-ID: <1273136665-3340-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AF5B24621
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 11:04:58 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Do not change the codec defaults for the following registers:
0x40, 0x41: Line output gains, do not use amplification
0x42: LOM/LOP Voltage hold, and selection
0x44: LOM inversion control

It has been found, that the values configured to these registers
can cause amplification, which can make the output of DAC33
distorted.

The codec reset values are considered safe in all environmnts.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---

If there is a need for user control over these, than additional
kcontrols can be invented for the settings.
But sorting out the meaning, and naming of such controls could take
considerable time.
At the moment, it is safer to use the codec defaults for these instead
of the original values.

 sound/soc/codecs/tlv320dac33.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 68b7ccb..ad5e263 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -303,21 +303,10 @@ static void dac33_init_chip(struct snd_soc_codec *codec)
 	/* C : (defaults) */
 	dac33_write(codec, DAC33_DAC_CTRL_C, 0x00);
 
-	/* 64-65 : L&R DAC power control
-	 Line In -> OUT 1V/V Gain, DAC -> OUT 4V/V Gain*/
-	dac33_write(codec, DAC33_LDAC_PWR_CTRL, DAC33_LROUT_GAIN(2));
-	dac33_write(codec, DAC33_RDAC_PWR_CTRL, DAC33_LROUT_GAIN(2));
-
 	/* 73 : volume soft stepping control,
 	 clock source = internal osc (?) */
 	dac33_write(codec, DAC33_ANA_VOL_SOFT_STEP_CTRL, DAC33_VOLCLKEN);
 
-	/* 66 : LOP/LOM Modes */
-	dac33_write(codec, DAC33_OUT_AMP_CM_CTRL, 0xff);
-
-	/* 68 : LOM inverted from LOP */
-	dac33_write(codec, DAC33_OUT_AMP_CTRL, (3<<2));
-
 	dac33_write(codec, DAC33_PWR_CTRL, DAC33_PDNALLB);
 
 	/* Restore only selected registers (gains mostly) */
-- 
1.7.1
