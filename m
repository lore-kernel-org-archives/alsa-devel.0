From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: samsung: make tm2_dapm_widgets and
	tm2_pm_ops static
Date: Sun, 13 Aug 2017 16:37:15 +0100
Message-ID: <20170813153715.18058-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A15F266884
 for <alsa-devel@alsa-project.org>; Sun, 13 Aug 2017 17:37:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

tm2_dapm_widgets and tm2_pm_ops are local to the source and do not need
to be in global scope, so make them static.

Cleans up sparse warnings:
symbol 'tm2_dapm_widgets' was not declared. Should it be static?
symbol 'tm2_pm_ops' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/samsung/tm2_wm5110.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
index 24cc9d63ce87..68698f3d72f9 100644
--- a/sound/soc/samsung/tm2_wm5110.c
+++ b/sound/soc/samsung/tm2_wm5110.c
@@ -318,7 +318,7 @@ static const struct snd_kcontrol_new tm2_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 };
 
-const struct snd_soc_dapm_widget tm2_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget tm2_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("HP", NULL),
 	SND_SOC_DAPM_SPK("SPK", NULL),
 	SND_SOC_DAPM_SPK("RCV", NULL),
@@ -521,7 +521,7 @@ static void tm2_pm_complete(struct device *dev)
 	tm2_start_sysclk(card);
 }
 
-const struct dev_pm_ops tm2_pm_ops = {
+static const struct dev_pm_ops tm2_pm_ops = {
 	.prepare	= tm2_pm_prepare,
 	.suspend	= snd_soc_suspend,
 	.resume		= snd_soc_resume,
-- 
2.11.0
