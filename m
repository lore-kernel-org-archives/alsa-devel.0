From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 5/5] ASoC: tegra: Staticize some functions in
	tegra30_i2s.c
Date: Mon, 21 Jan 2013 14:59:26 +0530
Message-ID: <1358760566-3803-6-git-send-email-sachin.kamat@linaro.org>
References: <1358760566-3803-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f43.google.com (mail-pb0-f43.google.com
 [209.85.160.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AAAF2625E2
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 10:38:28 +0100 (CET)
Received: by mail-pb0-f43.google.com with SMTP id jt11so1855752pbb.30
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 01:38:27 -0800 (PST)
In-Reply-To: <1358760566-3803-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: sachin.kamat@linaro.org, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, swarren@nvidia.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

'tegra30_i2s_startup' and 'tegra30_i2s_shutdown' are used only in this file and
hence made static. Fixes the following sparse warnings:
sound/soc/tegra/tegra30_i2s.c:74:5: warning:
symbol 'tegra30_i2s_startup' was not declared. Should it be static?
sound/soc/tegra/tegra30_i2s.c:101:6: warning:
symbol 'tegra30_i2s_shutdown' was not declared. Should it be static?

Cc: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/tegra/tegra30_i2s.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
index 27e91dd..f4e1ce8 100644
--- a/sound/soc/tegra/tegra30_i2s.c
+++ b/sound/soc/tegra/tegra30_i2s.c
@@ -71,7 +71,7 @@ static int tegra30_i2s_runtime_resume(struct device *dev)
 	return 0;
 }
 
-int tegra30_i2s_startup(struct snd_pcm_substream *substream,
+static int tegra30_i2s_startup(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
 	struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
@@ -98,7 +98,7 @@ int tegra30_i2s_startup(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-void tegra30_i2s_shutdown(struct snd_pcm_substream *substream,
+static void tegra30_i2s_shutdown(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
 	struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-- 
1.7.4.1
