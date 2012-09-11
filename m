From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm8900: Fix typo of name to wm9700
Date: Tue, 11 Sep 2012 09:27:13 +0800
Message-ID: <1347326833-2019-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1347326833-2019-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3E0D7264F09
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 03:27:21 +0200 (CEST)
In-Reply-To: <1347326833-2019-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8900.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 5bc877b..e781f86 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -493,10 +493,10 @@ SOC_DAPM_SINGLE("RINPUT2 Switch", WM8900_REG_INCTL, 1, 1, 0),
 SOC_DAPM_SINGLE("RINPUT3 Switch", WM8900_REG_INCTL, 0, 1, 0),
 };
 
-static const char *wm9700_lp_mux[] = { "Disabled", "Enabled" };
+static const char *wm8900_lp_mux[] = { "Disabled", "Enabled" };
 
 static const struct soc_enum wm8900_lineout2_lp_mux =
-SOC_ENUM_SINGLE(WM8900_REG_LOUTMIXCTL1, 1, 2, wm9700_lp_mux);
+SOC_ENUM_SINGLE(WM8900_REG_LOUTMIXCTL1, 1, 2, wm8900_lp_mux);
 
 static const struct snd_kcontrol_new wm8900_lineout2_lp =
 SOC_DAPM_ENUM("Route", wm8900_lineout2_lp_mux);
-- 
1.7.10.4
