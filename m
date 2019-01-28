From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 05/14] ALSA: pci: Remove superfluous
 snd_pcm_suspend*() calls
Date: Mon, 28 Jan 2019 13:28:49 -0600
Message-ID: <21711c90-595d-88b5-ec8e-f092e662c938@linux.intel.com>
References: <20190115162155.6308-1-tiwai@suse.de>
 <20190115162155.6308-6-tiwai@suse.de>
 <f675ffaa-9966-a05b-7915-a4a16eefbfcb@linux.intel.com>
 <s5hpnsx26tc.wl-tiwai@suse.de> <s5hh8e9fyam.wl-tiwai@suse.de>
 <a329b6ed-39aa-0730-cb90-b950eda7edf8@linux.intel.com>
 <s5ho98fd6fd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 763CA26749A
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 20:28:52 +0100 (CET)
In-Reply-To: <s5ho98fd6fd.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org


>>> BTW, while checking these things, I noticed that there are three
>>> exceptional drivers: sound/soc/intel/atom/sst-mfld-platform-pcm.c,
>>> sound/soc/intel/haswell/sst-haswell-pcm.c, and
>>> sound/soc/samsung/tm2_wm5110.c.  (You can simply grep the external
>>> snd_soc_suspend call, and only these match.)
>>>
>>> The former two drivers look really weird: they do handle the PM only
>>> with PM prepare and complete callbacks, while snd_soc_suspend() and co
>>> are called internally from there.  The prepare and complete callbacks
>>> aren't designed for the complete suspend/resume tasks, so I'd say it's
>>> a quite abuse.
>> For the Atom/SST driver, I remember there was a need to set/restore
>> the DSP state with a specific command that wasn't handled with regular
>> controls - largely a work-around due to the firmware design.
>>
>> For the Haswell driver, there was also a need to preserve/restore
>> state and pause/stop pipelines (a recurring issue with the "Made for
>> Windows" firmware).
>>
>> These drivers are quite old now and it's not clear to me if they are
>> broken or if we are talking of an improvement. Could you clarify what
>> you view as "abuse"?
>>
>> a) is this the fact that there are prepare/complete callback for those
>> drivers, instead of others such as freeze, thaw, etc.
>>
>> b) the fact they they call snd_soc_suspend/resume directly?
>>
>> c) the fact that they suspend the PCM streams?
>>
>> d) all of the above (which is entirely possible).
> The purpose of PM prepare and complete devops aren't for actually do
> suspend and resume devices there, while these drivers call
> snd_soc_suspend() and snd_soc_resume() to perform the complete suspend
> / resume procedure.  That's not the way these callbacks are supposed
> to be used.
>
> The prepare callback is called before the suspend callback of *all*
> devices on the system.  Ditto for complete, it's called after the
> resume of all devices.
>
> I guess they use prepare/callback to assure some tasks to be performed
> always suspend and resume.  But it's still puzzling,
> e.g. sst_soc_prepare() has
>
> static int sst_soc_prepare(struct device *dev)
> {
> 	struct sst_data *drv = dev_get_drvdata(dev);
> 	struct snd_soc_pcm_runtime *rtd;
>
> 	if (!drv->soc_card)
> 		return 0;
>
> 	/* suspend all pcms first */
> 	snd_soc_suspend(drv->soc_card->dev);
> 	snd_soc_poweroff(drv->soc_card->dev);
>
> 	/* set the SSPs to idle */
> 	for_each_card_rtds(drv->soc_card, rtd) {
> 		struct snd_soc_dai *dai = rtd->cpu_dai;
>
> 		if (dai->active) {
> 			send_ssp_cmd(dai, dai->name, 0);
> 			sst_handle_vb_timer(dai, false);
> 		}
> 	}
>
> 	return 0;
> }
>
> ... and it calls snd_soc_poweroff() for suspend.  That's odd and
> likely superfluous.
>
> And, the last part ("set the SSPs to idle") can be moved to
> card->suspend_post hook, and then we can simply call
> snd_soc_suspend().  Or it can be moved to PM devops suspend_late.
>
> Similarly for sst_soc_complete(), the task "restart SSPs" can be moved
> to card->resume_pre hook or PM devops resume_pre.
>
>
> The rest is to make sure the device PM ops order, and that's the
> hardest part.
>
> Further looking at the code, we can see that several Intel ASoC
> drivers have device PM ops.
>
> sound/soc/intel/atom/sst/sst.c
> sound/soc/intel/haswell/sst-haswell-pcm.c
> sound/soc/intel/skylake/skl.c
> sound/soc/intel/atom/sst-mfld-platform-pcm.c
>
> ... and there are codecs.  We need to list up and define the suspend /
> resume call order.

I had an offline discussion with Vinod and here are the key points for 
the Atom/SST driver

- the DSP isn't completely modeled with DPCM, there are some pipeline 
management and commands that need to be send manually. This isn't 
necessarily a perfect design but the one that was defined in 2013

- the choice of the .prepare is intentional. The tasks are split between 
the SST device (ACPI or PCI) and the platform device it creates. The 
ACPI/PCI layer handles DSP boot, config, shutdown, fw load, and the 
platform driver handles PCM/pipelines. The PM starts with the .prepare 
done in the child before the .suspend done at a higher level.

For Haswell I have no idea, and I wonder if there are actually any 
devices using this driver. Even from Broadwell we only know of the Pixel 
2015 Chromebook and the Dell XPS 13 where the I2S mode is activated (and 
the latter is deactivated with an ACPI quirk), most devices use HDaudio. 
Even if we found someone at Intel with bandwidth, changing this part is 
going to be very difficult between lack of devices and initial 
teams/individual contributors who have moved on.

SOF will support all these platforms, it might be a better idea to spend 
time making sure we do the right thing with the newer drivers than try 
to fix things but actually introduce regressions in legacy code.

-Pierre
