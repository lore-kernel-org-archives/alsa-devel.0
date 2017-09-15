From: anish kumar <yesanishhere@gmail.com>
Subject: [PATCH 3/4] ASoC: dapm: Avoid creating kcontrol for
	params
Date: Thu, 14 Sep 2017 22:03:01 -0700
Message-ID: <CABCoZhDkhsLHz4+6JzpM-nVx0cDmOfExPcHN3F+1D+t+FuRoDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f193.google.com (mail-ua0-f193.google.com
 [209.85.217.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 174DB26727C
 for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2017 07:03:02 +0200 (CEST)
Received: by mail-ua0-f193.google.com with SMTP id g47so384216uad.2
 for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2017 22:03:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "broonie@kernel.org" <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, perex@perex.cz, tiwai@suse.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: anish kumar <yesanishhere@gmail.com>

Currently in codec to codec dai link if there are multiple
params defined then dapm can use created kcontrol to
decide which param to apply at runtime.

However, in case there is only single param configuration
then there is no point in creating the kcontrol and also there
is no point in allocating memory for kcontrol.

In the snd_soc_dapm_new_pcm function, there is memory
allocation happening for kcontrol which is later used
or not used based on num_param. It is better to not
allocate memory when there is only a single configuration.
This change is to remedy that anomaly.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 sound/soc/soc-dapm.c | 114 +++++++++++++++++++++++++++++----------------------
 1 file changed, 66 insertions(+), 48 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d55cac6..3c493b3 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3778,18 +3778,12 @@ static int snd_soc_dapm_dai_link_put(struct
snd_kcontrol *kcontrol,
        return 0;
 }

-int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
-                        const struct snd_soc_pcm_stream *params,
-                        unsigned int num_params,
-                        struct snd_soc_dapm_widget *source,
-                        struct snd_soc_dapm_widget *sink)
+static struct snd_kcontrol_new *
+snd_soc_dapm_alloc_kcontrol(struct snd_soc_card *card,
+                       char *link_name,
+                       const struct snd_soc_pcm_stream *params,
+                       int num_params)
 {
-       struct snd_soc_dapm_widget template;
-       struct snd_soc_dapm_widget *w;
-       char *link_name;
-       int ret, count;
-       unsigned long private_value;
-       const char **w_param_text;
        struct soc_enum w_param_enum[] = {
                SOC_ENUM_SINGLE(0, 0, 0, NULL),
        };
@@ -3798,19 +3792,16 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
                             snd_soc_dapm_dai_link_get,
                             snd_soc_dapm_dai_link_put),
        };
+       struct snd_kcontrol_new *kcontrol_news;
        const struct snd_soc_pcm_stream *config = params;
+       const char **w_param_text;
+       unsigned long private_value;
+       int count;

        w_param_text = devm_kcalloc(card->dev, num_params,
-                                       sizeof(char *), GFP_KERNEL);
+                               sizeof(char *), GFP_KERNEL);
        if (!w_param_text)
-               return -ENOMEM;
-
-       link_name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-%s",
-                                  source->name, sink->name);
-       if (!link_name) {
-               ret = -ENOMEM;
-               goto outfree_w_param;
-       }
+               return NULL;

        for (count = 0 ; count < num_params; count++) {
                if (!config->stream_name) {
@@ -3827,24 +3818,14 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
                                                strlen(config->stream_name) + 1,
                                                GFP_KERNEL);
                }
-               if (!w_param_text[count]) {
-                       ret = -ENOMEM;
-                       goto outfree_link_name;
-               }
+               if (!w_param_text[count])
+                       goto outfree_w_param;
                config++;
        }
+
        w_param_enum[0].items = num_params;
        w_param_enum[0].texts = w_param_text;

-       memset(&template, 0, sizeof(template));
-       template.reg = SND_SOC_NOPM;
-       template.id = snd_soc_dapm_dai_link;
-       template.name = link_name;
-       template.event = snd_soc_dai_link_event;
-       template.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-               SND_SOC_DAPM_PRE_PMD;
-       template.num_kcontrols = 1;
-       /* duplicate w_param_enum on heap so that memory persists */
        private_value =
                (unsigned long) devm_kmemdup(card->dev,
                        (void *)(kcontrol_dai_link[0].private_value),
@@ -3852,22 +3833,66 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
        if (!private_value) {
                dev_err(card->dev, "ASoC: Failed to create control for
%s widget\n",
                        link_name);
-               ret = -ENOMEM;
-               goto outfree_link_name;
+               goto outfree_w_param;
        }
        kcontrol_dai_link[0].private_value = private_value;
        /* duplicate kcontrol_dai_link on heap so that memory persists */
-       template.kcontrol_news =
-                               devm_kmemdup(card->dev, &kcontrol_dai_link[0],
-                                       sizeof(struct snd_kcontrol_new),
-                                       GFP_KERNEL);
-       if (!template.kcontrol_news) {
+       kcontrol_news =
+                       devm_kmemdup(card->dev, &kcontrol_dai_link[0],
+                               sizeof(struct snd_kcontrol_new),
+                               GFP_KERNEL);
+       if (!kcontrol_news) {
                dev_err(card->dev, "ASoC: Failed to create control for
%s widget\n",
                        link_name);
-               ret = -ENOMEM;
                goto outfree_private_value;
        }
+       return kcontrol_news;
+
+outfree_private_value:
+       devm_kfree(card->dev, (void *)private_value);
+outfree_w_param:
+       for (count = 0 ; count < num_params; count++)
+               devm_kfree(card->dev, (void *)w_param_text[count]);
+       devm_kfree(card->dev, w_param_text);
+       return NULL;
+}
+
+int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
+                        const struct snd_soc_pcm_stream *params,
+                        unsigned int num_params,
+                        struct snd_soc_dapm_widget *source,
+                        struct snd_soc_dapm_widget *sink)
+{
+       struct snd_soc_dapm_widget template;
+       struct snd_soc_dapm_widget *w;
+       char *link_name;
+       int ret;
+
+       link_name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-%s",
+                                  source->name, sink->name);
+       if (!link_name)
+               return -ENOMEM;

+       memset(&template, 0, sizeof(template));
+       template.reg = SND_SOC_NOPM;
+       template.id = snd_soc_dapm_dai_link;
+       template.name = link_name;
+       template.event = snd_soc_dai_link_event;
+       template.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+               SND_SOC_DAPM_PRE_PMD;
+       template.kcontrol_news = NULL;
+
+       /* allocate memory for control, only in case of multiple configs */
+       if (num_params > 1) {
+               template.num_kcontrols = 1;
+               template.kcontrol_news =
+                                       snd_soc_dapm_alloc_kcontrol(card,
+                                               link_name, params, num_params);
+               if (!template.kcontrol_news) {
+                       ret = -ENOMEM;
+                       goto outfree_link_name;
+               }
+       }
        dev_dbg(card->dev, "ASoC: adding %s widget\n", link_name);

        w = snd_soc_dapm_new_control_unlocked(&card->dapm, &template);
@@ -3899,15 +3924,8 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
        devm_kfree(card->dev, w);
 outfree_kcontrol_news:
        devm_kfree(card->dev, (void *)template.kcontrol_news);
-outfree_private_value:
-       devm_kfree(card->dev, (void *)private_value);
 outfree_link_name:
        devm_kfree(card->dev, link_name);
-       for (count = 0 ; count < num_params; count++)
-               devm_kfree(card->dev, (void *)w_param_text[count]);
-outfree_w_param:
-       devm_kfree(card->dev, w_param_text);
-
        return ret;
 }

--
2.5.4 (Apple Git-61)
