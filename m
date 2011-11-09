From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix duplicate const warnings in da7210.c
Date: Wed,  9 Nov 2011 23:16:49 +0000
Message-ID: <1320880609-32110-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6D27F10384A
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 00:16:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/da7210.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index b545b7d..8b5848a 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -240,7 +240,7 @@ static const DECLARE_TLV_DB_SCALE(adc_eq_master_gain_tlv, -1800, 600, 1);
 static const DECLARE_TLV_DB_SCALE(dac_gain_tlv, -7725, 75, 0);
 
 /* ADC and DAC high pass filter f0 value */
-static const char const *da7210_hpf_cutoff_txt[] = {
+static const char * const da7210_hpf_cutoff_txt[] = {
 	"Fs/8192*pi", "Fs/4096*pi", "Fs/2048*pi", "Fs/1024*pi"
 };
 
@@ -251,7 +251,7 @@ static const struct soc_enum da7210_adc_hpf_cutoff =
 	SOC_ENUM_SINGLE(DA7210_ADC_HPF, 0, 4, da7210_hpf_cutoff_txt);
 
 /* ADC and DAC voice (8kHz) high pass cutoff value */
-static const char const *da7210_vf_cutoff_txt[] = {
+static const char * const da7210_vf_cutoff_txt[] = {
 	"2.5Hz", "25Hz", "50Hz", "100Hz", "150Hz", "200Hz", "300Hz", "400Hz"
 };
 
-- 
1.7.7.2
