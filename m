From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/8] ASoC: pxa: e750_wm9705: Convert to table
	based DAPM setup
Date: Sat,  1 Mar 2014 15:48:15 +0100
Message-ID: <1393685300-5307-3-git-send-email-lars@metafoo.de>
References: <1393685300-5307-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-192.synserver.de
 [212.40.185.192])
 by alsa0.perex.cz (Postfix) with ESMTP id 74481265278
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 15:47:54 +0100 (CET)
In-Reply-To: <1393685300-5307-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org

Use table based setup to register the DAPM widgets and routes. This on one hand
makes the code a bit cleaner and on the other hand the board level DAPM elements
get registered in the card's DAPM context rather than in the CODEC's DAPM
context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/e750_wm9705.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index c34e447..ee36aba 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -85,11 +85,6 @@ static int e750_ac97_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "PCBEEP");
 	snd_soc_dapm_nc_pin(dapm, "MIC2");
 
-	snd_soc_dapm_new_controls(dapm, e750_dapm_widgets,
-					ARRAY_SIZE(e750_dapm_widgets));
-
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
 	return 0;
 }
 
@@ -119,6 +114,11 @@ static struct snd_soc_card e750 = {
 	.owner = THIS_MODULE,
 	.dai_link = e750_dai,
 	.num_links = ARRAY_SIZE(e750_dai),
+
+	.dapm_widgets = e750_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(e750_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static struct gpio e750_audio_gpios[] = {
-- 
1.8.0
