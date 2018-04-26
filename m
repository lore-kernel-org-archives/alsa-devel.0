From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 10/11] ASoC: AMD: Add const to snd_soc_ops
	instances
Date: Thu, 26 Apr 2018 16:45:56 +0530
Message-ID: <1524741374-13523-10-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0079.outbound.protection.outlook.com [104.47.36.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D52E26781E
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 13:18:04 +0200 (CEST)
In-Reply-To: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

Marking snd_soc_ops instances const

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
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
