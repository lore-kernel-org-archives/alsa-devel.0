From: Vishal Thanki <vishalthanki@gmail.com>
Subject: [PATCH] ASoC: ak4104: Limit the supported sample rates
Date: Mon, 26 Sep 2016 15:34:19 +0200
Message-ID: <1474896859-31069-1-git-send-email-vishalthanki@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 655AF261560
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 15:34:23 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id b184so14178365wma.3
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 06:34:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, jic23@kernel.org, afd@ti.com, kuninori.morimoto.gx@renesas.com
Cc: Vishal Thanki <vishalthanki@gmail.com>
List-Id: alsa-devel@alsa-project.org

Currently the driver exposes range of sample rates between 8KHz to
192KHz as a part of dai_driver. This does not hold true as the limited
number sample rates are allowed in hw_params DAI callback. This patch
limits the sample rates exposed via dai_driver.

Signed-off-by: Vishal Thanki <vishalthanki@gmail.com>
---
 sound/soc/codecs/ak4104.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index bdca879..1a9d233 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -163,7 +163,10 @@ static struct snd_soc_dai_driver ak4104_dai = {
 		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000,
+		.rates = SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
+			 SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+			 SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+			 SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE  |
 			   SNDRV_PCM_FMTBIT_S24_3LE |
 			   SNDRV_PCM_FMTBIT_S24_LE
-- 
2.4.11
