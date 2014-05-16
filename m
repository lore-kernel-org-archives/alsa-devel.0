From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/7] ASoC: max98090: Fix digital sidetone gain
	TLV
Date: Fri, 16 May 2014 16:55:19 +0300
Message-ID: <1400248525-21900-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1400248525-21900-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id BFBAF26089A
 for <alsa-devel@alsa-project.org>; Fri, 16 May 2014 15:55:35 +0200 (CEST)
In-Reply-To: <1400248525-21900-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

TLV for digital sidetone volume is wrong, this fix matches it to the
datasheet.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/codecs/max98090.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index f3dd9791e736..9e08c4768bc0 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -390,6 +390,7 @@ static const DECLARE_TLV_DB_SCALE(max98090_alc_tlv, -1500, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_alcmakeup_tlv, 0, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_alccomp_tlv, -3100, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_drcexp_tlv, -6600, 100, 0);
+static const DECLARE_TLV_DB_SCALE(max98090_sdg_tlv, 50, 200, 0);
 
 static const unsigned int max98090_mixout_tlv[] = {
 	TLV_DB_RANGE_HEAD(2),
@@ -666,7 +667,7 @@ static const struct snd_kcontrol_new max98090_snd_controls[] = {
 	SOC_SINGLE_EXT_TLV("Digital Sidetone Volume",
 		M98090_REG_ADC_SIDETONE, M98090_DVST_SHIFT,
 		M98090_DVST_NUM - 1, 1, max98090_get_enab_tlv,
-		max98090_put_enab_tlv, max98090_micboost_tlv),
+		max98090_put_enab_tlv, max98090_sdg_tlv),
 	SOC_SINGLE_TLV("Digital Coarse Volume", M98090_REG_DAI_PLAYBACK_LEVEL,
 		M98090_DVG_SHIFT, M98090_DVG_NUM - 1, 0,
 		max98090_dvg_tlv),
-- 
2.0.0.rc0
