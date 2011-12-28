From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/3] ASoC: Convert kirkwood-t5325 to table
	based DAPM init
Date: Wed, 28 Dec 2011 19:03:23 +0800
Message-ID: <1325070203.2497.4.camel@phoenix>
References: <1325069897.2497.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 85429244A8
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 12:03:30 +0100 (CET)
Received: by obcwm4 with SMTP id wm4so8222137obc.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 03:03:29 -0800 (PST)
In-Reply-To: <1325069897.2497.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/kirkwood/kirkwood-t5325.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index 6e99230..b47cc4e 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -59,11 +59,6 @@ static int t5325_dai_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	snd_soc_dapm_new_controls(dapm, t5325_dapm_widgets,
-				ARRAY_SIZE(t5325_dapm_widgets));
-
-	snd_soc_dapm_add_routes(dapm, t5325_route, ARRAY_SIZE(t5325_route));
-
 	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	snd_soc_dapm_enable_pin(dapm, "Speaker");
@@ -91,6 +86,11 @@ static struct snd_soc_card t5325 = {
 	.owner = THIS_MODULE,
 	.dai_link = t5325_dai,
 	.num_links = ARRAY_SIZE(t5325_dai),
+
+	.dapm_widgets = t5325_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(t5325_dapm_widgets),
+	.dapm_routes = t5325_route,
+	.num_dapm_routes = ARRAY_SIZE(t5325_route),
 };
 
 static struct platform_device *t5325_snd_device;
-- 
1.7.5.4
