From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v5 05/14] ASoC: SOF: Add PCM operations
 support
Date: Mon, 8 Apr 2019 14:31:43 -0500
Message-ID: <7f8f25fc-0ea5-7562-37bb-64a8468f040d@linux.intel.com>
References: <20190321161016.26515-1-pierre-louis.bossart@linux.intel.com>
 <20190321161016.26515-6-pierre-louis.bossart@linux.intel.com>
 <s5hd0m2caz6.wl-tiwai@suse.de>
 <f5346e231c80876f0fa74e1172d570b0033cbf42.camel@linux.intel.com>
 <s5hv9zsy6qr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hv9zsy6qr.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, Alan Cox <alan@linux.intel.com>, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 4/5/19 7:30 AM, Takashi Iwai wrote:
> On Thu, 04 Apr 2019 21:13:43 +0200,
> Ranjani Sridharan wrote:
>>
>>>> +
>>>> +	/* set runtime config */
>>>> +	runtime->hw.info = SNDRV_PCM_INFO_MMAP |
>>>> +			  SNDRV_PCM_INFO_MMAP_VALID |
>>>> +			  SNDRV_PCM_INFO_INTERLEAVED |
>>>> +			  SNDRV_PCM_INFO_PAUSE |
>>>> +			  SNDRV_PCM_INFO_RESUME |
>>>> +			  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP;
>>>
>>> Does SOF support the full resume?  That is, the stream gets resumed
>>> at
>>> the exact position that was suspended.  Most devices can't, hence
>>> they
>>> don't set *_INFO_RESUME flag and let user-space restarting.
>> Hi Takashi,
>>
>> Thanks for your comment. The SOF driver definitely cannot guarantee to
>> resume from the exact same position due to the fact that triggers for
>> the host dma and link dma are not synchronized and also IPC scheduling
>> will affect this. So we should remove INOF_RESUME from hw.info.
>>
>> I do one follow up question for you. When a stream resumes/restarts
>> after suspend, we have the need for restoring the hw_params in the SOF
>> driver prior to handling the START trigger. I noticed that the
>> legacy/skylake driver does not seem to do this though. Do you have any
>> insights on what we might be missing in the SOF driver?
> 
> So, SOF mandates the re-setup of the hw params in BE at resume?
> Then the right place to do is in the prepare callback.  Without
> SNDRV_PCM_INFO_RESUME flag, the PCM core won't trigger RESUME, but
> returns -ENOSYS.  Then user-space will do prepare, and start with the
> normal trigger.

Takashi, some of us at Intel are a bit nervous about returning an error 
to force the application to jump to its error-handling code (typically 
only done for xruns and not always rock-solid) and as a side effect get 
a prepare ioctl. I checked that e.g. CRAS does support this mode but I 
wonder how many application developers know about this. I personally didn't.

Moreover, it seems that the default behavior is rather to support 
RESUME, even if the hardware can't precisely restart from the same 
position, so we are concerned about exposing new errors when SOF is 
selected instead of legacy drivers (Baytrail, Atom-SST and Skylake-SST).

In short, is this really your recommendation to remove this INFO_RESUME 
flag? And if yes, should we demote all existing Intel drivers and remove 
this flag as well?

Thanks for your feedback
-Pierre
