From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFT v3 3/3] ASoC: core: Add support for DAI
	multicodec
Date: Fri, 16 May 2014 12:44:44 +0200
Message-ID: <5375EC1C.9020909@metafoo.de>
References: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
 <1398340906-5017-4-git-send-email-bcousson@baylibre.com>
 <535BABCF.6080001@metafoo.de> <5374D6BF.4060500@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000908080101000104000700"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-123.synserver.de (smtp-out-194.synserver.de
 [212.40.185.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 98993261718
 for <alsa-devel@alsa-project.org>; Fri, 16 May 2014 12:44:46 +0200 (CEST)
In-Reply-To: <5374D6BF.4060500@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Fabien Parent <fparent@baylibre.com>, misael.lopez@ti.com, broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000908080101000104000700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 05/15/2014 05:01 PM, Benoit Cousson wrote:
> Hi Lars,
>
> I'm struggling a little bit to understand one of your comment :-)
>
> On 26/04/2014 14:51, Lars-Peter Clausen wrote:
>> On 04/24/2014 02:01 PM, Benoit Cousson wrote:
>>> @@ -870,6 +876,10 @@ struct snd_soc_dai_link {
>>>        const struct device_node *codec_of_node;
>>>        /* You MUST specify the DAI name within the codec */
>>>        const char *codec_dai_name;
>>> +
>>> +    struct snd_soc_dai_link_component *codecs;
>>
>> Should probably be const
>
> In fact, I don't think this is not possible, since this struct will be initialized at runtime in the legacy case when the regular codec struct is the one used by the driver.

That shouldn't be a problem. The const applies to the data the pointer 
points to, not the pointer itself.

>
> [...]
>
>>> @@ -1586,16 +1626,21 @@ static int soc_probe_link_dais(struct
>>> snd_soc_card *card, int num, int order)
>>>                            codec2codec_close_delayed_work);
>>>
>>>                /* link the DAI widgets */
>>> -            ret = soc_link_dai_widgets(card, dai_link,
>>> -                    cpu_dai, codec_dai);
>>> -            if (ret)
>>> -                return ret;
>>> +            for (i = 0; i < rtd->num_codecs; i++) {
>>> +                ret = soc_link_dai_widgets(card, dai_link,
>>> +                        cpu_dai, rtd->codec_dais[i]);
>>
>> This will create a DAI link widget for each CODEC DAI. The DAI link
>> widget will configure the CPU and the CODEC DAI that are connected to
>> it. If there is one DAI link widget per CODEC DAI this means that the
>> CPU DAI will be connected to multiple DAI link widgets, which means it
>> will be configured once for each CODEC DAI (with possible conflicting
>> configurations).
>
> I've got that point, but now I'm wondering what struct should be per codec_dai. Should we consider one source and several sinks to represent the multiple codecs?

The soc_link_dai_widgets function should take the rtd as a parameter instead 
of the CODEC and CPU DAIs. Same goes for snd_soc_dapm_new_pcm() then you 
create one dai_link widget per stream (i.e. one for capture of there is 
capture support, one for playback if there is playback support). And then 
create the paths between the dai_link widgets and the DAI widgets accordingly.

>
>> So there should only be one DAI link widget per DAI link, with the CPU
>> DAI on one side and the CODEC DAIs on the other side. Note that you'll
>> also need to re-work snd_soc_dai_link_event() to handle multiple
>> inputs/outputs. I'd factor that part out into a separate patch.
>
> Here, I'm lost :-)
>
> What struct should be made multiple in that case?
>
> Should we consider that the following list can handle multiple sink/source?
>
> 	/* We only support a single source and sink, pick the first */
> 	source_p = list_first_entry(&w->sources, struct snd_soc_dapm_path,
> 				    list_sink);
> 	sink_p = list_first_entry(&w->sinks, struct snd_soc_dapm_path,
> 				  list_source);
>
> [...]

See the attached patch.

If you don't want to worry about these things for now it should be fine to 
add a check in soc_probe_link_dais() and make sure that num_codecs == 1 for 
the CODEC to CODEC case. This means we'll not support multi-codec links for 
CODEC to CODEC links, which should in my opinion be fine for now.


--------------000908080101000104000700
Content-Type: text/x-patch;
 name="0001-ASoC-dapm-Handle-multiple-DAIs-in-snd_soc_dai_link_e.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ASoC-dapm-Handle-multiple-DAIs-in-snd_soc_dai_link_e.pa";
 filename*1="tch"

>From feea1b5612da70bef7dc15a8af8797e56a93e129 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 4 May 2014 13:06:15 +0200
Subject: [PATCH] ASoC: dapm: Handle multiple DAIs in snd_soc_dai_link_event()

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 115 ++++++++++++++++++++++++---------------------------
 1 file changed, 54 insertions(+), 61 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b34139a..2fa3f8a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3139,35 +3139,60 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_controls);
 
+static void snd_soc_dai_event(struct snd_soc_dapm_widget *w, int event,
+	struct snd_pcm_substream *substream, struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_dai *dai = w->priv;
+	int ret;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (dai->driver->ops && dai->driver->ops->hw_params) {
+			ret = dai->driver->ops->hw_params(substream, params,
+				source);
+			if (ret != 0) {
+				dev_err(dai->dev,
+					"ASoC: hw_params() failed: %d\n", ret);
+				return ret;
+			}
+		}
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		ret = snd_soc_dai_digital_mute(dai, 0, stream);
+		if (ret != 0 && ret != -ENOTSUPP)
+			dev_warn(dai->dev, "ASoC: Failed to unmute: %d\n", ret);
+		ret = 0;
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
+		ret = snd_soc_dai_digital_mute(dai, 1, stream);
+		if (ret != 0 && ret != -ENOTSUPP)
+			dev_warn(dai->dev, "ASoC: Failed to mute: %d\n", ret);
+		ret = 0;
+		break;
+
+	default:
+		WARN(1, "Unknown event %d\n", event);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
 static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 				  struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_dapm_path *source_p, *sink_p;
-	struct snd_soc_dai *source, *sink;
 	const struct snd_soc_pcm_stream *config = w->params;
 	struct snd_pcm_substream substream;
 	struct snd_pcm_hw_params *params = NULL;
+	struct snd_soc_dapm_path *p;
 	u64 fmt;
 	int ret;
 
-	if (WARN_ON(!config) ||
-	    WARN_ON(list_empty(&w->sources) || list_empty(&w->sinks)))
+	if (WARN_ON(!config))
 		return -EINVAL;
 
-	/* We only support a single source and sink, pick the first */
-	source_p = list_first_entry(&w->sources, struct snd_soc_dapm_path,
-				    list_sink);
-	sink_p = list_first_entry(&w->sinks, struct snd_soc_dapm_path,
-				  list_source);
-
-	if (WARN_ON(!source_p || !sink_p) ||
-	    WARN_ON(!sink_p->source || !source_p->sink) ||
-	    WARN_ON(!source_p->source || !sink_p->sink))
-		return -EINVAL;
-
-	source = source_p->source->priv;
-	sink = sink_p->sink->priv;
-
 	/* Be a little careful as we don't want to overflow the mask array */
 	if (config->formats) {
 		fmt = ffs(config->formats) - 1;
@@ -3197,50 +3222,18 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 
 	memset(&substream, 0, sizeof(substream));
 
-	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		if (source->driver->ops && source->driver->ops->hw_params) {
-			substream.stream = SNDRV_PCM_STREAM_CAPTURE;
-			ret = source->driver->ops->hw_params(&substream,
-							     params, source);
-			if (ret != 0) {
-				dev_err(source->dev,
-					"ASoC: hw_params() failed: %d\n", ret);
-				goto out;
-			}
-		}
-
-		if (sink->driver->ops && sink->driver->ops->hw_params) {
-			substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
-			ret = sink->driver->ops->hw_params(&substream, params,
-							   sink);
-			if (ret != 0) {
-				dev_err(sink->dev,
-					"ASoC: hw_params() failed: %d\n", ret);
-				goto out;
-			}
-		}
-		break;
-
-	case SND_SOC_DAPM_POST_PMU:
-		ret = snd_soc_dai_digital_mute(sink, 0,
-					       SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret != 0 && ret != -ENOTSUPP)
-			dev_warn(sink->dev, "ASoC: Failed to unmute: %d\n", ret);
-		ret = 0;
-		break;
-
-	case SND_SOC_DAPM_PRE_PMD:
-		ret = snd_soc_dai_digital_mute(sink, 1,
-					       SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret != 0 && ret != -ENOTSUPP)
-			dev_warn(sink->dev, "ASoC: Failed to mute: %d\n", ret);
-		ret = 0;
-		break;
+	substream.stream = SNDRV_PCM_STREAM_CAPTURE;
+	list_for_each_entry(p, &w->sources, list_sink) {
+		ret = snd_soc_dai_event(p->source, event, params, &substream);
+		if (ret)
+			goto out;
+	}
 
-	default:
-		WARN(1, "Unknown event %d\n", event);
-		return -EINVAL;
+	substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
+	list_for_each_entry(p, &w->sinks, list_source) {
+		ret = snd_soc_dai_event(p->sink, event, params, &substream);
+		if (ret)
+			goto out;
 	}
 
 out:
-- 
1.8.0


--------------000908080101000104000700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000908080101000104000700--
