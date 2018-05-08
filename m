From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 09/10] ASoC: AMD: Add const to snd_soc_ops instances
Date: Tue, 8 May 2018 10:17:52 +0530
Message-ID: <1525754888-14124-9-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Akshu Agrawal <akshu.agrawal@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Kurtz <djkurtz@chromium.org>, Alex Deucher <alexander.deucher@amd.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Wei Yongjun <weiyongjun1@huawei.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

Marking snd_soc_ops instances const

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index fa5ad5b..133139d 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -171,17 +171,17 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 	da7219_clk_disable();
 }
 
-static struct snd_soc_ops cz_da7219_cap_ops = {
+static const struct snd_soc_ops cz_da7219_cap_ops = {
 	.startup = cz_da7219_startup,
 	.shutdown = cz_da7219_shutdown,
 };
 
-static struct snd_soc_ops cz_max_play_ops = {
+static const struct snd_soc_ops cz_max_play_ops = {
 	.startup = cz_max_startup,
 	.shutdown = cz_max_shutdown,
 };
 
-static struct snd_soc_ops cz_dmic_cap_ops = {
+static const struct snd_soc_ops cz_dmic_cap_ops = {
 	.startup = cz_dmic_startup,
 	.shutdown = cz_dmic_shutdown,
 };
-- 
2.7.4
