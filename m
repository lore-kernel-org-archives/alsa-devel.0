From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] ASoC: amd: acp-da7219-max98357: Make
	symbol da7219_dai_clk static
Date: Thu, 29 Mar 2018 02:14:03 +0000
Message-ID: <1522289643-61304-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from huawei.com (unknown [45.249.212.32])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C4A4267063
 for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2018 04:08:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Akshu
 Agrawal <akshu.agrawal@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Dylan Reid <dgreid@chromium.org>
Cc: kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, Wei Yongjun <weiyongjun1@huawei.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fixes the following sparse warning:

sound/soc/amd/acp-da7219-max98357a.c:46:12: warning:
 symbol 'da7219_dai_clk' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index b205c78..f41560e 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -43,7 +43,7 @@
 #define DUAL_CHANNEL		2
 
 static struct snd_soc_jack cz_jack;
-struct clk *da7219_dai_clk;
+static struct clk *da7219_dai_clk;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
