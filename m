From: anish kumar <yesanishhere@gmail.com>
Subject: Re: [Resend] [PATCH v1 3/4] ASoC: dapm: Avoid creating
	kcontrol for params
Date: Mon, 25 Sep 2017 13:22:07 -0700
Message-ID: <CABCoZhB-jxC_AF69d7dK-bbQZ2i24=CgE6ti2r=9L1q9xvYqDA@mail.gmail.com>
References: <1506066940-56758-1-git-send-email-yesanishhere@gmail.com>
 <20170925130955.utj7e4vgg5ze2zs7@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f66.google.com (mail-vk0-f66.google.com
 [209.85.213.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 574BF266991
 for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2017 22:22:09 +0200 (CEST)
Received: by mail-vk0-f66.google.com with SMTP id j189so2207595vka.0
 for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2017 13:22:08 -0700 (PDT)
In-Reply-To: <20170925130955.utj7e4vgg5ze2zs7@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 25, 2017 at 6:09 AM, Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Fri, Sep 22, 2017 at 12:55:40AM -0700, yesanishhere@gmail.com wrote:
>> From: anish kumar <yesanishhere@gmail.com>
>>
>> Currently in codec to codec dai link if there are multiple
>> params defined then dapm can use created kcontrol to
>> decide which param to apply at runtime.
>>
>> However, in case there is only single param configuration
>> then there is no point in creating the kcontrol and also there
>> is no point in allocating memory for kcontrol.
>>
>> In the snd_soc_dapm_new_pcm function, there is memory
>> allocation happening for kcontrol which is later used
>> or not used based on num_param. It is better to not
>> allocate memory when there is only a single configuration.
>> This change is to remedy that anomaly.
>>
>> Signed-off-by: anish kumar <yesanishhere@gmail.com>
>> ---
> <snip>
>> +int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
>> +                      const struct snd_soc_pcm_stream *params,
>> +                      unsigned int num_params,
>> +                      struct snd_soc_dapm_widget *source,
>> +                      struct snd_soc_dapm_widget *sink)
>> +{
>> +     struct snd_soc_dapm_widget template;
>> +     struct snd_soc_dapm_widget *w;
>> +     const char **w_param_text;
>> +     unsigned long private_value;
>> +     char *link_name;
>> +     int ret, count;
>> +
>> +     link_name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-%s",
>> +                                source->name, sink->name);
>> +     if (!link_name)
>> +             return -ENOMEM;
>> +
>> +     memset(&template, 0, sizeof(template));
>> +     template.reg = SND_SOC_NOPM;
>> +     template.id = snd_soc_dapm_dai_link;
>> +     template.name = link_name;
>> +     template.event = snd_soc_dai_link_event;
>> +     template.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
>> +             SND_SOC_DAPM_PRE_PMD;
>> +     template.kcontrol_news = NULL;
>> +
>> +     w_param_text = devm_kcalloc(card->dev, num_params,
>> +                             sizeof(char *), GFP_KERNEL);
>> +     if (!w_param_text) {
>> +             ret = -ENOMEM;
>> +             goto param_fail;
>> +     }
>
> Should this not also be done conditionally based on num_params?
> Seems odd to do all this to avoid allocations but then alloc this
> regardless of if it is used.

Nice catch.
>
>> +
>> +     /* allocate memory for control, only in case of multiple configs */
>> +     if (num_params > 1) {
>> +             template.num_kcontrols = 1;
>> +             template.kcontrol_news =
>> +                                     snd_soc_dapm_alloc_kcontrol(card,
>> +                                             link_name, params, num_params,
>> +                                             w_param_text, &private_value);
>> +             if (!template.kcontrol_news) {
>> +                     ret = -ENOMEM;
>> +                     goto outfree_link_name;
>> +             }
>> +     }
>>       dev_dbg(card->dev, "ASoC: adding %s widget\n", link_name);
>>
>>       w = snd_soc_dapm_new_control_unlocked(&card->dapm, &template);
>> @@ -3899,15 +3927,13 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
>>       devm_kfree(card->dev, w);
>>  outfree_kcontrol_news:
>>       devm_kfree(card->dev, (void *)template.kcontrol_news);
>> -outfree_private_value:
>>       devm_kfree(card->dev, (void *)private_value);
>> -outfree_link_name:
>> -     devm_kfree(card->dev, link_name);
>>       for (count = 0 ; count < num_params; count++)
>>               devm_kfree(card->dev, (void *)w_param_text[count]);
>
> Do we maybe just want to add a snd_soc_dapm_free_kcontrol or some
> such and call that from both places rather than having basically
> the same error path in snd_soc_dapm_alloc_kcontrol and here.

Sure. Let me re-spin it.
>
>> -outfree_w_param:
>> +outfree_link_name:
>>       devm_kfree(card->dev, w_param_text);
>> -
>> +param_fail:
>> +     devm_kfree(card->dev, link_name);
>>       return ret;
>>  }
>>
>> --
>> 2.5.4 (Apple Git-61)
>
> Thanks,
> Charles
