From: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
Subject: Re: [RFC 3/4] ASoC: Enable dynamic DAIlink insertion &
	removal
Date: Tue, 16 Feb 2016 20:04:23 +0530
Message-ID: <CANQOkFEK3eF7omO_9m04Y9RhgmwDtO+MVReMSbcc66Hhq0r1ig@mail.gmail.com>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
 <1455538772-24926-4-git-send-email-vaibhav.agarwal@linaro.org>
 <20160215170219.GO18988@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f181.google.com (mail-ob0-f181.google.com
 [209.85.214.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D1BF260824
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 15:34:39 +0100 (CET)
Received: by mail-ob0-f181.google.com with SMTP id xk3so260066496obc.2
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 06:34:39 -0800 (PST)
In-Reply-To: <20160215170219.GO18988@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 15 February 2016 at 22:32, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Feb 15, 2016 at 05:49:31PM +0530, Vaibhav Agarwal wrote:
>
>> With the evolvement of modularized platforms, codecs can be
>> dynamically added to/removed from a platform.
>> Thus, there is a need to add FE/BE DAIs to an existing sound card
>> in response to codec inserted/removed.
>
> Like I say please format your changelogs normally.  It makes things much
> easier to read.  I'm still not seeing a user or how this will work on
> the client side here.
Will take care of formatting.
I'll also add some more details in commit message to show possible usage
>
>> Another kconfig option SND_SOC_DYNAMIC_DAILINK (default set to y)
>> is added to avoid compilation issues for client (machine, codec)
>> drivers with other kernel versions.
>
> No, don't do this.  We don't care about random other kernel versions, if
> we did the whole kernel would be full of ifdefs.  We have config options
> for things like adding substantial size to the kernel.
Agreed.
>
>> +int snd_soc_dapm_link_dai_widgets_component(struct snd_soc_card *card,
>> +                                         struct snd_soc_dapm_context *dapm);
>> +void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card,
>> +                                        struct snd_soc_pcm_runtime *rtd);
>
> Why void?
No functional change in snd_soc_dapm_connect_dai_link_widgets().
I have refactored it for individual pcm_runtime instead of complete soc_card.
>
>> +void dpcm_fe_disconnect(struct snd_soc_pcm_runtime *be, int stream);
>>  void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream);
>
> This seems like it should be a separate patch, it's not strongly tied to
> the rest of the code.
Sure, will share separate patch for this change.
>
>> index 3dda0c4..44d8568 100644
>> --- a/include/sound/soc.h
>> +++ b/include/sound/soc.h
>> @@ -796,6 +796,8 @@ struct snd_soc_component {
>>
>>       unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
>>       unsigned int registered_as_component:1;
>> +     /* registered dynamically in response to dynamic DAI links */
>> +     unsigned int dynamic_registered:1;
>
> dynamically.
will make the change in next patchset
>
>> +int snd_soc_add_dailink(struct snd_soc_card *card,
>> +                     struct snd_soc_dai_link *dai_link);
>> +void snd_soc_remove_dailink(struct snd_soc_card *card, const char *link_name);
>
> Everywhere else we write dai_link.
Another API snd_soc_add_dai_link() already exists (added by Mengdong).
How about renaming it to snd_soc_create_dai_link() ?
>
>> +config SND_SOC_DYNAMIC_DAILINK
>> +     bool
>> +        default y
>> +
>
> Like I say I don't see a need for this but note also that the
> indentation seems broken - might be worth checking this isn't creeping
> in elsewhere.
Got the point. I'll remove this completely.
>
>> +static void soc_remove_component_controls(struct snd_soc_component *component)
>
> This is only used once which means we're going to end up with two
> different ways of removing controls, one of which is essentially never
> used and hence likely to break.  It would be better to ensure that the
> removal path is the same as much of the time as possible so that things
> are more maintainable.  This is an issue through the patch, it feels
> like it'd be clearer and easier to review if it first rearranged things
> to split up things for reuse by dynamic addition and then separately
> added new interfaces that do the dyanmic stuff.
Will split this patch further between preparation & actual new interfaces.
>
>> +
>> +             long_name = control->name;
>> +             prefix = component->name_prefix;
>> +             name_len = sizeof(id.name);
>
> name_len is completely pointless here...
>
>> +             if (prefix)
>> +                     snprintf(id.name, name_len, "%s %s", prefix,
>> +                              long_name);
>> +             else
>> +                     strlcpy(id.name, long_name, sizeof(id.name));
>
> ...it's not even used here.  Just don't bother with the intermediate
> variables, they make things harder to follow.
>
>> +     /*
>> +      * should be done, only in case
>> +      * component probed after card instantiation
>> +      * assumptions:
>> +      * relevant DAI links are already removed
>> +      * mutex acquired for soc-card
>> +      * semaphore acquired for sound card
>> +      */
>
> Please fix the
> formatting of
> this comment
> so it looks more
> like normal kernel
> code.
will modify the comment formatting.
