From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/5] ASoC: JZ4740: Convert qi_lb60 codec to
	table based DAPM setup
Date: Tue, 12 Apr 2011 19:31:03 +0200
Message-ID: <1302629465-21315-3-git-send-email-lars@metafoo.de>
References: <1302629465-21315-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-049.synserver.de (smtp-out-051.synserver.de
	[212.40.185.51]) by alsa0.perex.cz (Postfix) with SMTP id 4A901103831
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Apr 2011 19:30:41 +0200 (CEST)
In-Reply-To: <1302629465-21315-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Use the newly introduced dapm_widgets, dpam_routes and fields of the
snd_soc_card struct to setup DAPM.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/jz4740/qi_lb60.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
index 49723e3..875abc9 100644
--- a/sound/soc/jz4740/qi_lb60.c
+++ b/sound/soc/jz4740/qi_lb60.c
@@ -70,12 +70,6 @@ static int qi_lb60_codec_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	snd_soc_dapm_new_controls(dapm, qi_lb60_widgets,
-				  ARRAY_SIZE(qi_lb60_widgets));
-	snd_soc_dapm_add_routes(dapm, qi_lb60_routes,
-				ARRAY_SIZE(qi_lb60_routes));
-	snd_soc_dapm_sync(dapm);
-
 	return 0;
 }
 
@@ -93,6 +87,11 @@ static struct snd_soc_card qi_lb60 = {
 	.name = "QI LB60",
 	.dai_link = &qi_lb60_dai,
 	.num_links = 1,
+
+	.dapm_widgets = qi_lb60_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(qi_lb60_widgets),
+	.dapm_routes = qi_lb60_routes,
+	.num_dapm_routes = ARRAY_SIZE(qi_lb60_routes),
 };
 
 static struct platform_device *qi_lb60_snd_device;
-- 
1.7.2.5
