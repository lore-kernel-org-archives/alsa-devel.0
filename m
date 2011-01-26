From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 3/4] ASoC: Add optional pointer to codec
	interconnects to snd_soc_codec_driver
Date: Wed, 26 Jan 2011 13:58:16 +0200
Message-ID: <1296043097-11720-3-git-send-email-jhnikula@gmail.com>
References: <1296043097-11720-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E95C71039FF
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 12:57:10 +0100 (CET)
Received: by mail-fx0-f51.google.com with SMTP id 5so871208fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 03:57:10 -0800 (PST)
In-Reply-To: <1296043097-11720-1-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This is aimed to as an alternative to snd_soc_dapm_add_routes call in codec
drivers that have only single interconnect map. By doing this in soc-core
saves from doing error checking in codec drivers.

This idea came from Mark Brown <broonie@opensource.wolfsonmicro.com>.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 include/sound/soc.h  |    8 ++++++++
 sound/soc/soc-core.c |   22 +++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index fec03ae..38597c0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -551,6 +551,14 @@ struct snd_soc_codec_driver {
 
 	void (*seq_notifier)(struct snd_soc_dapm_context *,
 			     enum snd_soc_dapm_type);
+
+	/*
+	 * optional map of codec audio path interconnects. Can be used as
+	 * an alternative for snd_soc_dapm_add_routes call in codec drivers
+	 * that have only single interconnect map
+	 */
+	const struct snd_soc_dapm_route *route;
+	int num_routes;
 };
 
 /* SoC platform interface */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 17484b1..2dbb91e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1402,7 +1402,7 @@ static void soc_set_name_prefix(struct snd_soc_card *card,
 static int soc_probe_codec(struct snd_soc_card *card,
 			   struct snd_soc_codec *codec)
 {
-	int ret = 0;
+	int ret = 0, err;
 
 	codec->card = card;
 	codec->dapm.card = card;
@@ -1421,6 +1421,18 @@ static int soc_probe_codec(struct snd_soc_card *card,
 		}
 	}
 
+	if (codec->driver->route) {
+		ret = snd_soc_dapm_add_routes(&codec->dapm,
+					      codec->driver->route,
+					      codec->driver->num_routes);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"asoc: failed to add interconnects: %d\n",
+				ret);
+			goto err_routes;
+		}
+	}
+
 	soc_init_codec_debugfs(codec);
 
 	/* mark codec as probed and add to card codec list */
@@ -1430,6 +1442,14 @@ static int soc_probe_codec(struct snd_soc_card *card,
 
 	return 0;
 
+err_routes:
+	if (codec->driver->remove) {
+		err = codec->driver->remove(codec);
+		if (err < 0)
+			dev_err(codec->dev,
+				"asoc: failed to remove %s: %d\n",
+				codec->name, err);
+	}
 err_probe:
 	module_put(codec->dev->driver->owner);
 
-- 
1.7.2.3
