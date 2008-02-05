From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] duplicate strcasecmp test for "rj-master" in
	mpc8610_hpcd_probe()
Date: Tue,  5 Feb 2008 10:19:43 +0000
Message-ID: <1202206783-22390-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <47A79D09.6090806@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 378A724542
	for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2008 11:19:45 +0100 (CET)
In-Reply-To: <47A79D09.6090806@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Roel Kluin <12o3l@tiscali.nl>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Roel Kluin <12o3l@tiscali.nl>

In linus' git tree I found this problem. Is it also in the alsa tree?
please confirm it's the right fix. The patch was not yet tested.

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
Acked-by: Timur Tabi <timur@freescale.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
Applied to the ASoC tree too.

 sound/soc/fsl/mpc8610_hpcd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index f26c4b2..a00aac7 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -315,7 +315,7 @@ static int mpc8610_hpcd_probe(struct of_device *ofdev,
 		machine_data->dai_format = SND_SOC_DAIFMT_LEFT_J;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
-	} else if (strcasecmp(sprop, "rj-master") == 0) {
+	} else if (strcasecmp(sprop, "rj-slave") == 0) {
 		machine_data->dai_format = SND_SOC_DAIFMT_RIGHT_J;
 		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
 		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
-- 
1.5.4
