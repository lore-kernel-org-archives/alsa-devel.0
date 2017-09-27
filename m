From: anish kumar <yesanishhere@gmail.com>
Subject: Re: [PATCH v2] ASoC: dapm: Avoid creating kcontrol for
	params
Date: Wed, 27 Sep 2017 14:08:25 -0700
Message-ID: <CABCoZhDUmT9yYh1GVpoxUhjg9U+DjnXD2_xBEYQKb-=25G93Xw@mail.gmail.com>
References: <1506485471-59951-1-git-send-email-yesanishhere@gmail.com>
 <20170927101148.o24d5bncuddh6ykh@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f67.google.com (mail-vk0-f67.google.com
 [209.85.213.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D0DB267266
 for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2017 23:08:26 +0200 (CEST)
Received: by mail-vk0-f67.google.com with SMTP id 78so3893495vkc.1
 for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2017 14:08:26 -0700 (PDT)
In-Reply-To: <20170927101148.o24d5bncuddh6ykh@localhost.localdomain>
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

On Wed, Sep 27, 2017 at 3:11 AM, Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Tue, Sep 26, 2017 at 09:11:11PM -0700, yesanishhere@gmail.com wrote:
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
>> Changes in this version:
>>  - Review comments from charles to move common function of error
>>    handling in seperate function.
>> Changes in v1:
>>  - Included the review comments from charles regarding releasing
>>    memory in error path.
>>
>>  sound/soc/soc-dapm.c | 145 +++++++++++++++++++++++++++++++--------------------
>>  1 file changed, 89 insertions(+), 56 deletions(-)
>>
>> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
>> index d55cac6..5dae9d8 100644
>> --- a/sound/soc/soc-dapm.c
>> +++ b/sound/soc/soc-dapm.c
>> -     memset(&template, 0, sizeof(template));
>> -     template.reg = SND_SOC_NOPM;
>> -     template.id = snd_soc_dapm_dai_link;
>> -     template.name = link_name;
>> -     template.event = snd_soc_dai_link_event;
>> -     template.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
>> -             SND_SOC_DAPM_PRE_PMD;
>> -     template.num_kcontrols = 1;
>> -     /* duplicate w_param_enum on heap so that memory persists */
>> -     private_value =
>> +     *private_value =
>>               (unsigned long) devm_kmemdup(card->dev,
>>                       (void *)(kcontrol_dai_link[0].private_value),
>>                       sizeof(struct soc_enum), GFP_KERNEL);
>> -     if (!private_value) {
>> +     if (!*private_value) {
>>               dev_err(card->dev, "ASoC: Failed to create control for %s widget\n",
>>                       link_name);
>> -             ret = -ENOMEM;
>> -             goto outfree_link_name;
>> +             goto outfree_w_param;
>>       }
>> -     kcontrol_dai_link[0].private_value = private_value;
>> +     kcontrol_dai_link[0].private_value = *private_value;
>>       /* duplicate kcontrol_dai_link on heap so that memory persists */
>> -     template.kcontrol_news =
>> -                             devm_kmemdup(card->dev, &kcontrol_dai_link[0],
>> -                                     sizeof(struct snd_kcontrol_new),
>> -                                     GFP_KERNEL);
>> -     if (!template.kcontrol_news) {
>> +     kcontrol_news =
>> +                     devm_kmemdup(card->dev, &kcontrol_dai_link[0],
>
> Not sure I really like this new line style especially here the
> devm_kmemdup would be in the same place on the previous line why
> have the break?

Ok, will fix this.
>
>> +                             sizeof(struct snd_kcontrol_new),
>> +                             GFP_KERNEL);
>> +     if (!kcontrol_news) {
>>               dev_err(card->dev, "ASoC: Failed to create control for %s widget\n",
>>                       link_name);
>> -             ret = -ENOMEM;
>> -             goto outfree_private_value;
>> +             goto outfree_w_param;
>>       }
>> +     return kcontrol_news;
>>
>> +outfree_w_param:
>> +     snd_soc_dapm_free_kcontrol(card, private_value, num_params, w_param_text);
>> +     return NULL;
>> +}
>> +
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
>> +     int ret;
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
>> +     /* allocate memory for control, only in case of multiple configs */
>> +     if (num_params > 1) {
>> +             w_param_text = devm_kcalloc(card->dev, num_params,
>> +                                     sizeof(char *), GFP_KERNEL);
>> +             if (!w_param_text) {
>> +                     ret = -ENOMEM;
>> +                     goto param_fail;
>> +             }
>> +
>> +             template.num_kcontrols = 1;
>> +             template.kcontrol_news =
>> +                                     snd_soc_dapm_alloc_kcontrol(card,
>> +                                             link_name, params, num_params,
>> +                                             w_param_text, &private_value);
>> +             if (!template.kcontrol_news) {
>> +                     ret = -ENOMEM;
>> +                     goto param_fail;
>
> Will you not leak w_param_text on this path?

No, as this is getting freed in the common function.
>
>> +             }
>> +     }
>>       dev_dbg(card->dev, "ASoC: adding %s widget\n", link_name);
>>
>>       w = snd_soc_dapm_new_control_unlocked(&card->dapm, &template);
>> @@ -3899,15 +3938,9 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
>>       devm_kfree(card->dev, w);
>>  outfree_kcontrol_news:
>>       devm_kfree(card->dev, (void *)template.kcontrol_news);
>> -outfree_private_value:
>> -     devm_kfree(card->dev, (void *)private_value);
>> -outfree_link_name:
>> +     snd_soc_dapm_free_kcontrol(card, &private_value, num_params, w_param_text);
>> +param_fail:
>>       devm_kfree(card->dev, link_name);
>> -     for (count = 0 ; count < num_params; count++)
>> -             devm_kfree(card->dev, (void *)w_param_text[count]);
>> -outfree_w_param:
>> -     devm_kfree(card->dev, w_param_text);
>> -
>>       return ret;
>>  }
>>
>> --
>> 2.5.4 (Apple Git-61)
>
> Thanks,
> Charles
