From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: [PATCH 1/3] ASoC: dapm: use clk_prepare_enable and clk_disable_unprepare
Date: Tue, 30 Apr 2013 16:09:52 +0200
Message-ID: <1367330994-7259-2-git-send-email-fabio.baltieri@linaro.org>
References: <1367330994-7259-1-git-send-email-fabio.baltieri@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1367330994-7259-1-git-send-email-fabio.baltieri@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>, Fabio Baltieri <fabio.baltieri@linaro.org>
List-Id: alsa-devel@alsa-project.org

Update dapm_clock_event to use clk_prepare_enable and
clk_disable_unprepare.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 21779a6..a80c883 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1095,9 +1095,9 @@ int dapm_clock_event(struct snd_soc_dapm_widget *w,
 
 #ifdef CONFIG_HAVE_CLK
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		return clk_enable(w->clk);
+		return clk_prepare_enable(w->clk);
 	} else {
-		clk_disable(w->clk);
+		clk_disable_unprepare(w->clk);
 		return 0;
 	}
 #endif
-- 
1.8.2
