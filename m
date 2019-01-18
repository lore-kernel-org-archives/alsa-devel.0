From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer dereference
 in soc_find_component
Date: Fri, 18 Jan 2019 17:02:08 -0600
Message-ID: <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Reichl <hias@horus.com>, Mark Brown <broonie@kernel.org>, rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, lgirdwood@gmail.com, plai@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, srinivas.kandagatla@linaro.org, Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org, Ajit Pandey <ajitp@codeaurora.org>, Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org


On 1/15/19 3:16 PM, Pierre-Louis Bossart wrote:
>
>>> Beyond the fact that the platform_name seems to be totally useless,
>>> additional tests show that the patch ('ASoC: soc-core: defer card probe
>>> until all component is added to list') adds a new restriction which
>>> contradicts existing error checks.
>>>
>>> None of the Intel machine drivers set the dailink "cpu_name" field 
>>> but use
>>> the "cpu_dai_name" field instead. This was perfectly legit as 
>>> documented by
>>> the code at the end of soc_init_dai_link()
>> This should be fixed by the patch
>> "ASoC: core: Don't defer probe on optional, NULL components" which Mark
>> already applied to his tree. See
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144323.html 
>>
>
> Ah yes, I missed this patch while I was debugging. Indeed this fixes 
> the problem and my devices work again with Mark's for-next branch. 
> Thanks Matthias!

This PROBE_DEFER support actually breaks the topology override that 
we've been relying on for SOF (and which has been in Mark's branch for 
some time now). This override helps us reuse machine drivers between 
legacy and SOF-based solutions.

With the current code, the tests in soc_register_card() complain that 
the platform_name can't be tied to a component and stop the card 
registration, but that's mainly because the tests are done before the 
topology overrides are done in soc_check_tplg_fes(). Moving 
soc_check_tplg_fes() from soc_instantiate_card() to an earlier time in 
soc_register_card() works-around the problem but looks quite invasive 
(mutex lock, etc).

There is also a second problem where we seem to have a memory management 
issue root caused to the change in snd_soc_init_platform() added by 
09ac6a817bd6 ('ASoC: soc-core: fix init platform memory handling')

The code does this

static int snd_soc_init_platform(struct snd_soc_card *card,
                  struct snd_soc_dai_link *dai_link)
{
     struct snd_soc_dai_link_component *platform = dai_link->platform;


     /* convert Legacy platform link */
     if (!platform || dai_link->legacy_platform) {
         platform = devm_kzalloc(card->dev,
                 sizeof(struct snd_soc_dai_link_component),
                 GFP_KERNEL);
         if (!platform)
             return -ENOMEM;

         dai_link->platform      = platform;
         dai_link->legacy_platform = 1;

This last assignment guarantees that memory will be allocated every time 
this function is called, and whatever overrides are done later will 
themselves be overridden by the new allocation. I am not sure what the 
intent was here, Curtis can you please double-check?

Details, test code and logs are available here: 
https://github.com/thesofproject/linux/issues/565

Have a nice week-end everyone, that's it for me until Tuesday.

-Pierre
