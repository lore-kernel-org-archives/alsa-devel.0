From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/4] ASoC: Add optional pointer to machine
	audio routes to snd_soc_card
Date: Wed, 26 Jan 2011 13:58:15 +0200
Message-ID: <1296043097-11720-2-git-send-email-jhnikula@gmail.com>
References: <1296043097-11720-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F273E1039F4
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 12:57:06 +0100 (CET)
Received: by mail-fx0-f51.google.com with SMTP id 5so871208fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 03:57:06 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This is targeted mostly to cross-device setups where single audio map
defining routes around and between the codecs looks cleaner than defining
and registering maps to each codec separately from machine init callbacks.

This could be also used to reduce simple machine init callbacks where only
snd_soc_dapm_add_routes and snd_soc_dapm_sync are called. However, this does
work only if the widgets names are unique in the system.

Idea of common audio map came from Peter Ujfalusi <peter.ujfalusi@nokia.com>.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 include/sound/soc.h  |    8 ++++++++
 sound/soc/soc-core.c |   21 +++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1355ef0..fec03ae 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -686,6 +686,14 @@ struct snd_soc_card {
 	struct snd_soc_pcm_runtime *rtd_aux;
 	int num_aux_rtd;
 
+	/*
+	 * optional machine audio map. Can be used as an alternative for
+	 * snd_soc_dapm_add_routes call in machine init in single codec setup
+	 * or as a common audio map in cross-device setup
+	 */
+	const struct snd_soc_dapm_route *route;
+	int num_routes;
+
 	struct work_struct deferred_resume_work;
 
 	/* lists of probed devices belonging to this card */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4da185f..17484b1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1727,6 +1727,7 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	struct snd_soc_codec *codec;
 	struct snd_soc_codec_conf *codec_conf;
 	enum snd_soc_compress_type compress_type;
+	const char *temp;
 	int ret, i;
 
 	mutex_lock(&card->mutex);
@@ -1810,6 +1811,26 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		}
 	}
 
+	if (card->route) {
+		/*
+		 * use the last codec and dapm context of it when setting up
+		 * the common audio map
+		 */
+		codec = list_first_entry(&card->codec_dev_list,
+					 struct snd_soc_codec, card_list);
+		temp = codec->name_prefix;
+		codec->name_prefix = NULL;
+		ret = snd_soc_dapm_add_routes(&codec->dapm,
+					      card->route, card->num_routes);
+		if (ret < 0) {
+			pr_err("asoc: failed to add routes %s: %d\n",
+			       card->name, ret);
+			goto probe_aux_dev_err;
+		}
+		codec->name_prefix = temp;
+		snd_soc_dapm_sync(&codec->dapm);
+	}
+
 	snprintf(card->snd_card->shortname, sizeof(card->snd_card->shortname),
 		 "%s",  card->name);
 	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
-- 
1.7.2.3
