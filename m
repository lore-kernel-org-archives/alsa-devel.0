From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH 1/2] ASoC: tegra+alc5632: Added digital
	microphone DAPM widget.
Date: Mon, 13 Feb 2012 21:27:36 +0200
Message-ID: <1329161256-10157-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 158CD243E2
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 20:27:50 +0100 (CET)
Received: by eekd49 with SMTP id d49so1835166eek.38
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 11:27:49 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@ti.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

ALC5632 codec supports digital microphone. This patch adds DAPM widget.

Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/tegra/tegra_alc5632.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
index c000f51..2a27725 100644
--- a/sound/soc/tegra/tegra_alc5632.c
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -102,6 +102,7 @@ static const struct snd_soc_dapm_widget tegra_alc5632_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Int Spk", NULL),
 	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Digital Mic", NULL),
 };
 
 static const struct snd_kcontrol_new tegra_alc5632_controls[] = {
-- 
1.7.3.4
