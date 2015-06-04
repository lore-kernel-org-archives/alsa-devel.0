From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 15/22] ASoC: tas2552: Correct the Speaker
	Driver Playback Volume (PGA_GAIN)
Date: Thu, 4 Jun 2015 15:22:39 +0300
Message-ID: <1433420571-5421-16-git-send-email-peter.ujfalusi@ti.com>
References: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 38F4C26644E
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 14:23:31 +0200 (CEST)
In-Reply-To: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The last parameter for DECLARE_TLV_DB_SCALE() is to tell if the gain will
be muted or not when it is set to raw 0. IN this case it is not muted.
The PGA_GAIN is in 0-4 bits in the register. Fix the offset in the
SOC_SINGLE_TLV() for this.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 264df631b130..fe2e4d384a00 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -406,11 +406,11 @@ static struct snd_soc_dai_driver tas2552_dai[] = {
 /*
  * DAC digital volumes. From -7 to 24 dB in 1 dB steps
  */
-static DECLARE_TLV_DB_SCALE(dac_tlv, -7, 100, 24);
+static DECLARE_TLV_DB_SCALE(dac_tlv, -7, 100, 0);
 
 static const struct snd_kcontrol_new tas2552_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Driver Playback Volume",
-			 TAS2552_PGA_GAIN, 0, 0x1f, 1, dac_tlv),
+			 TAS2552_PGA_GAIN, 0, 0x1f, 0, dac_tlv),
 };
 
 static const struct reg_default tas2552_init_regs[] = {
-- 
2.4.2
