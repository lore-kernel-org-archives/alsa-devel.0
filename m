From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: sst-bxt-da7219_max98357a: fix obsoleted initializer for array
Date: Mon, 17 Oct 2016 23:02:56 +0100
Message-ID: <20161017220256.32008-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Vinod Koul <vinod.koul@intel.com>, Yong Zhi <yong.zhi@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Smatch reports below warnings:

    bxt_da7219_max98357a.c:352:9: warning: obsolete array initializer,
    use C99 syntax

An earlier commit cleaned up similar warnings, however, a recent
commit 43c02ede76a60de ("ASoC: Intel: Add DMIC channel constraint for
bxt machine") re-introduced the older initializer style. So fix
this warning to make the code consistent.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 865a21e..bff80b4 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -348,7 +348,7 @@ static struct snd_soc_dai_link broxton_dais[] = {
 		.dynamic = 1,
 		.ops = &broxton_refcap_ops,
 	},
-	[BXT_DPCM_AUDIO_DMIC_CP]
+	[BXT_DPCM_AUDIO_DMIC_CP] =
 	{
 		.name = "Bxt Audio DMIC cap",
 		.stream_name = "dmiccap",
-- 
2.9.3
