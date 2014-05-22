From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [RFT v3 3/3] ASoC: core: Add support for DAI
	multicodec
Date: Thu, 22 May 2014 09:01:26 +0200
Message-ID: <537DA0C6.7080502@baylibre.com>
References: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
 <1398340906-5017-4-git-send-email-bcousson@baylibre.com>
 <535BABCF.6080001@metafoo.de> <5374D6BF.4060500@baylibre.com>
 <5375EC1C.9020909@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f171.google.com (mail-we0-f171.google.com
 [74.125.82.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D88026558D
 for <alsa-devel@alsa-project.org>; Thu, 22 May 2014 09:01:29 +0200 (CEST)
Received: by mail-we0-f171.google.com with SMTP id w62so3032926wes.16
 for <alsa-devel@alsa-project.org>; Thu, 22 May 2014 00:01:29 -0700 (PDT)
In-Reply-To: <5375EC1C.9020909@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Fabien Parent <fparent@baylibre.com>, misael.lopez@ti.com, broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Lars,

On 16/05/2014 12:44, Lars-Peter Clausen wrote:
> On 05/15/2014 05:01 PM, Benoit Cousson wrote:

[...]

>>>> @@ -1586,16 +1626,21 @@ static int soc_probe_link_dais(struct
>>>> snd_soc_card *card, int num, int order)
>>>>                            codec2codec_close_delayed_work);
>>>>
>>>>                /* link the DAI widgets */
>>>> -            ret =3D soc_link_dai_widgets(card, dai_link,
>>>> -                    cpu_dai, codec_dai);
>>>> -            if (ret)
>>>> -                return ret;
>>>> +            for (i =3D 0; i < rtd->num_codecs; i++) {
>>>> +                ret =3D soc_link_dai_widgets(card, dai_link,
>>>> +                        cpu_dai, rtd->codec_dais[i]);
>>>
>>> This will create a DAI link widget for each CODEC DAI. The DAI link
>>> widget will configure the CPU and the CODEC DAI that are connected to
>>> it. If there is one DAI link widget per CODEC DAI this means that the
>>> CPU DAI will be connected to multiple DAI link widgets, which means it
>>> will be configured once for each CODEC DAI (with possible conflicting
>>> configurations).
>>
>> I've got that point, but now I'm wondering what struct should be per =

>> codec_dai. Should we consider one source and several sinks to =

>> represent the multiple codecs?
> =

> The soc_link_dai_widgets function should take the rtd as a parameter =

> instead of the CODEC and CPU DAIs. Same goes for snd_soc_dapm_new_pcm() =

> then you create one dai_link widget per stream (i.e. one for capture of =

> there is capture support, one for playback if there is playback =

> support). And then create the paths between the dai_link widgets and the =

> DAI widgets accordingly.

I'm still not 100% sure how it should work so here is a tentative patch to =
try to handle that part. Please note that in my setup none of that code is =
ever called :-( I'm not sure why!

Please ignore the extra DEBUG code I added and there is probably some way t=
o factorize some code, but I'd like to be sure that this is the proper way =
to handle the routes in the multicodec case before re-sending that series.


Thanks,
Benoit

---
>From 565bfa3f31abbe2b677238ed423eb9fa99609086 Mon Sep 17 00:00:00 2001
From: Benoit Cousson <bcousson@baylibre.com>
Date: Thu, 22 May 2014 08:54:54 +0200
Subject: [PATCH] ASoC: Temp: Tentative multicodec adaptation for dapm routes

Not-Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 include/sound/soc-dapm.h |   3 +-
 sound/soc/soc-core.c     |  31 +----------
 sound/soc/soc-dapm.c     | 132 +++++++++++++++++++++++++++++++++++++++----=
----
 3 files changed, 113 insertions(+), 53 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index b041fc6..41336be 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -381,8 +381,7 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *=
card);
 void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card);
 int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 			 const struct snd_soc_pcm_stream *params,
-			 struct snd_soc_dapm_widget *source,
-			 struct snd_soc_dapm_widget *sink);
+			 struct snd_soc_pcm_runtime *rtd);
 =

 /* dapm path setup */
 int snd_soc_dapm_new_widgets(struct snd_soc_card *card);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 077f51a..208df5d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1483,37 +1483,8 @@ static int soc_link_dai_widgets(struct snd_soc_card =
*card,
 				struct snd_soc_dai_link *dai_link,
 				struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
-	struct snd_soc_dapm_widget *play_w, *capture_w;
-	int ret;
-
 	/* link the DAI widgets */
-	play_w =3D codec_dai->playback_widget;
-	capture_w =3D cpu_dai->capture_widget;
-	if (play_w && capture_w) {
-		ret =3D snd_soc_dapm_new_pcm(card, dai_link->params,
-					   capture_w, play_w);
-		if (ret !=3D 0) {
-			dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
-				play_w->name, capture_w->name, ret);
-			return ret;
-		}
-	}
-
-	play_w =3D cpu_dai->playback_widget;
-	capture_w =3D codec_dai->capture_widget;
-	if (play_w && capture_w) {
-		ret =3D snd_soc_dapm_new_pcm(card, dai_link->params,
-					   capture_w, play_w);
-		if (ret !=3D 0) {
-			dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
-				play_w->name, capture_w->name, ret);
-			return ret;
-		}
-	}
-
-	return 0;
+	return snd_soc_dapm_new_pcm(card, dai_link->params,rtd);
 }
 =

 static int soc_probe_link_dais(struct snd_soc_card *card, int num, int ord=
er)
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f457225..4f21429 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -22,7 +22,7 @@
  *      device reopen.
  *
  */
-
+#define DEBUG
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -3248,22 +3248,12 @@ out:
 	return ret;
 }
 =

-int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
+int snd_soc_dapm_new_link(struct snd_soc_card *card,
 			 const struct snd_soc_pcm_stream *params,
-			 struct snd_soc_dapm_widget *source,
-			 struct snd_soc_dapm_widget *sink)
+			 char *link_name)
 {
-	struct snd_soc_dapm_route routes[2];
 	struct snd_soc_dapm_widget template;
 	struct snd_soc_dapm_widget *w;
-	size_t len;
-	char *link_name;
-
-	len =3D strlen(source->name) + strlen(sink->name) + 2;
-	link_name =3D devm_kzalloc(card->dev, len, GFP_KERNEL);
-	if (!link_name)
-		return -ENOMEM;
-	snprintf(link_name, len, "%s-%s", source->name, sink->name);
 =

 	memset(&template, 0, sizeof(template));
 	template.reg =3D SND_SOC_NOPM;
@@ -3271,7 +3261,7 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 	template.name =3D link_name;
 	template.event =3D snd_soc_dai_link_event;
 	template.event_flags =3D SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-		SND_SOC_DAPM_PRE_PMD;
+			       SND_SOC_DAPM_PRE_PMD;
 =

 	dev_dbg(card->dev, "ASoC: adding %s widget\n", link_name);
 =

@@ -3284,15 +3274,115 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 =

 	w->params =3D params;
 =

-	memset(&routes, 0, sizeof(routes));
+	return 0;
+}
+
+int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
+			 const struct snd_soc_pcm_stream *params,
+			 struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dapm_route route;
+	struct snd_soc_dapm_widget *source, *sink;
+	size_t len;
+	char *link_name;
+	const char *codecs_link_name =3D "multiple";
+	unsigned int num_widgets =3D 0;
+	int i;
+
+	/* cpu_dai->capture_widget -> codec_dai->playback_widget */
+	for (i =3D 0; i < rtd->num_codecs; i++)
+		if (rtd->codec_dais[i]->playback_widget)
+			num_widgets++;
+
+	if (!rtd->cpu_dai->capture_widget || !num_widgets)
+		return 0;
+
+
+	source =3D rtd->cpu_dai->capture_widget;
+
+	if (num_widgets > 1) {
+		len =3D strlen(source->name) + strlen(codecs_link_name) + 2;
+	} else {
+		sink =3D rtd->codec_dais[0]->playback_widget;
+		len =3D strlen(source->name) + strlen(sink->name) + 2;
+	}
+
+	link_name =3D devm_kzalloc(card->dev, len, GFP_KERNEL);
+	if (!link_name)
+		return -ENOMEM;
+
+	if (num_widgets > 1)
+		snprintf(link_name, len, "%s-%s", source->name, codecs_link_name);
+	else
+		snprintf(link_name, len, "%s-%s", source->name, sink->name);
+
+	pr_info("%s(), link_name #1 %s", __func__,link_name);
+	snd_soc_dapm_new_link(card, params, link_name);
 =

-	routes[0].source =3D source->name;
-	routes[0].sink =3D link_name;
-	routes[1].source =3D link_name;
-	routes[1].sink =3D sink->name;
 =

-	return snd_soc_dapm_add_routes(&card->dapm, routes,
-				       ARRAY_SIZE(routes));
+	memset(&route, 0, sizeof(route));
+	route.source =3D source->name;
+	route.sink =3D link_name;
+	snd_soc_dapm_add_route(&card->dapm, &route, false);
+
+	route.source =3D link_name;
+	for (i =3D 0; i < rtd->num_codecs; i++) {
+		if (!rtd->codec_dais[i]->playback_widget)
+			continue;
+
+		route.sink =3D rtd->codec_dais[i]->playback_widget->name;
+		snd_soc_dapm_add_route(&card->dapm, &route, false);
+	}
+
+
+	num_widgets =3D 0;
+
+	/* codec_dai->capture_widget -> cpu_dai->playback_widget */
+	for (i =3D 0; i < rtd->num_codecs; i++)
+		if (rtd->codec_dais[i]->capture_widget)
+			num_widgets++;
+
+	if (!rtd->cpu_dai->playback_widget || !num_widgets)
+		return 0;
+
+
+	sink =3D rtd->cpu_dai->playback_widget;
+
+	if (num_widgets > 1) {
+		len =3D strlen(sink->name) + strlen(codecs_link_name) + 2;
+	} else {
+		source =3D rtd->codec_dais[0]->playback_widget;
+		len =3D strlen(source->name) + strlen(sink->name) + 2;
+	}
+
+	link_name =3D devm_kzalloc(card->dev, len, GFP_KERNEL);
+	if (!link_name)
+		return -ENOMEM;
+
+	if (num_widgets > 1)
+		snprintf(link_name, len, "%s-%s", codecs_link_name, sink->name);
+	else
+		snprintf(link_name, len, "%s-%s", source->name, sink->name);
+
+	pr_info("%s(), link_name #2 %s", __func__,link_name);
+	snd_soc_dapm_new_link(card, params, link_name);
+
+
+	memset(&route, 0, sizeof(route));
+	route.sink =3D link_name;
+	for (i =3D 0; i < rtd->num_codecs; i++) {
+		if (!rtd->codec_dais[i]->capture_widget)
+			continue;
+
+		route.source =3D rtd->codec_dais[i]->capture_widget->name;
+		snd_soc_dapm_add_route(&card->dapm, &route, false);
+	}
+
+	route.source =3D link_name;
+	route.sink =3D sink->name;
+	snd_soc_dapm_add_route(&card->dapm, &route, false);
+
+	return 0;
 }
 =

 int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
-- =

1.8.3.2



-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
