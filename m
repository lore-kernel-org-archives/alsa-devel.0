From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/6] ASoC: odrodix2_max98090: Make non exported
	symbols static
Date: Sun, 17 Aug 2014 16:18:18 +0200
Message-ID: <1408285102-24538-3-git-send-email-lars@metafoo.de>
References: <1408285102-24538-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-166.synserver.de (smtp-out-166.synserver.de
 [212.40.185.166])
 by alsa0.perex.cz (Postfix) with ESMTP id E7A762650E7
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 16:18:27 +0200 (CEST)
In-Reply-To: <1408285102-24538-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sangbeom Kim <sbkim73@samsung.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

odroidx2_drvdata and odroidu3_drvdata are not used outside this module so make
them static (and also const while we are at it).

Fixes the following warnings from sparse:
    sound/soc/samsung/odroidx2_max98090.c:69:26: warning: symbol
     'odroidx2_drvdata' was not declared. Should it be static?
    sound/soc/samsung/odroidx2_max98090.c:74:26: warning: symbol
     'odroidu3_drvdata' was not declared. Should it be static?

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/samsung/odroidx2_max98090.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/odroidx2_max98090.c b/sound/soc/samsung/odroidx2_max98090.c
index 278edf9..3c8f604 100644
--- a/sound/soc/samsung/odroidx2_max98090.c
+++ b/sound/soc/samsung/odroidx2_max98090.c
@@ -66,12 +66,12 @@ static struct snd_soc_card odroidx2 = {
 	.late_probe		= odroidx2_late_probe,
 };
 
-struct odroidx2_drv_data odroidx2_drvdata = {
+static const struct odroidx2_drv_data odroidx2_drvdata = {
 	.dapm_widgets		= odroidx2_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(odroidx2_dapm_widgets),
 };
 
-struct odroidx2_drv_data odroidu3_drvdata = {
+static const struct odroidx2_drv_data odroidu3_drvdata = {
 	.dapm_widgets		= odroidu3_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(odroidu3_dapm_widgets),
 };
-- 
1.8.0
