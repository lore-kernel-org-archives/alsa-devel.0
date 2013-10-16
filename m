From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: rt5640: Don't go to standby on resume
Date: Wed, 16 Oct 2013 17:33:35 +0100
Message-ID: <1381941215-29031-2-git-send-email-broonie@kernel.org>
References: <1381941215-29031-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DA91261A64
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 18:35:03 +0200 (CEST)
In-Reply-To: <1381941215-29031-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

There is no need for the CODEC to go to standby on resume since the core will
power it up as needed and in any case it is an idle_bias_off CODEC so would
normally sit with bias off while idle.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/rt5640.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index b0cde92..4d041d3 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1993,7 +1993,6 @@ static int rt5640_resume(struct snd_soc_codec *codec)
 		gpio_set_value_cansleep(rt5640->pdata.ldo1_en, 1);
 		msleep(400);
 	}
-	rt5640_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
 }
-- 
1.8.4.rc3
