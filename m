From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH 3/4] ASoC: wm8960: fix "RINPUT3" audio route
	error
Date: Tue, 12 May 2015 14:58:36 +0800
Message-ID: <d92199aca689cbb075bb3d0a4a9d8f54e5e61909.1431413323.git.zidan.wang@freescale.com>
References: <c36ecb00aeb3115e208518c5e256f35f7b1308db.1431413323.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0138.outbound.protection.outlook.com [65.55.169.138])
 by alsa0.perex.cz (Postfix) with ESMTP id C89AD265453
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2015 08:57:02 +0200 (CEST)
In-Reply-To: <c36ecb00aeb3115e208518c5e256f35f7b1308db.1431413323.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Zidan Wang <zidan.wang@freescale.com>, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

It should be "RINPUT3" instead of "LINPUT3" route to "Right Input
Mixer".

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/codecs/wm8960.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 2559e31..4ab1607 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -397,7 +397,7 @@ static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "Right Input Mixer", "Boost Switch", "Right Boost Mixer", },
 	{ "Right Input Mixer", NULL, "RINPUT1", },  /* Really Boost Switch */
 	{ "Right Input Mixer", NULL, "RINPUT2" },
-	{ "Right Input Mixer", NULL, "LINPUT3" },
+	{ "Right Input Mixer", NULL, "RINPUT3" },
 
 	{ "Left ADC", NULL, "Left Input Mixer" },
 	{ "Right ADC", NULL, "Right Input Mixer" },
-- 
1.9.1
