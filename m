From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: cs42l51: Clear
 CS42L51_MIC_POWER_CTL_AUTO bit for MODE_SLAVE and MODE_MASTER
Date: Wed, 23 Nov 2011 12:44:45 +0800
Message-ID: <1322023485.6782.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AF9F8103BE7
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 05:44:56 +0100 (CET)
Received: by ggnq2 with SMTP id q2so1057514ggn.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 20:44:56 -0800 (PST)
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

According to the datasheet:

MIC Power Control & Speed Control (Address 03h)
BIT[7] : Auto-Detect Speed Mode (AUTO)
        Default: 1
        0 - Disable
        1 - Enable

Function:
Enables the auto-detect circuitry for detecting the speed mode
of the CODEC when operating as a slave.
When AUTO is enabled, the MCLK/LRCK ratio must be implemented
according to Table 3 on page 39. The
SPEED[1:0] bits are ignored when this bit is enabled.
Speed is determined by the MCLK/LRCK ratio.

SPEED[1:0] bits are ignored when this bit is enabled.
Thus we need to clear this bit for MODE_SLAVE and MODE_MASTER
because the default of this bit is 1 (Enable).

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/cs42l51.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 00718b5..35c5ac3 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -400,7 +400,8 @@ static int cs42l51_hw_params(struct snd_pcm_substream *substream,
 
 	intf_ctl &= ~(CS42L51_INTF_CTL_MASTER | CS42L51_INTF_CTL_ADC_I2S
 			| CS42L51_INTF_CTL_DAC_FORMAT(7));
-	power_ctl &= ~(CS42L51_MIC_POWER_CTL_SPEED(3)
+	power_ctl &= ~(CS42L51_MIC_POWER_CTL_AUTO
+			| CS42L51_MIC_POWER_CTL_SPEED(3)
 			| CS42L51_MIC_POWER_CTL_MCLK_DIV2);
 
 	switch (cs42l51->func) {
-- 
1.7.5.4
