From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 08/12] ASoC: SOF: ipc: fix a race,
 leading to IPC timeouts
Date: Mon, 20 May 2019 08:36:09 -0500
Message-ID: <6e573117-d3f7-5086-3f35-1ee185846381@linux.intel.com>
References: <20190518202704.7772-1-pierre-louis.bossart@linux.intel.com>
 <20190518202704.7772-9-pierre-louis.bossart@linux.intel.com>
 <s5hftpaewq0.wl-tiwai@suse.de>
 <20190520071547.godyxigamihl5gav@debian.ka.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55CBFF89618
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2019 15:36:18 +0200 (CEST)
In-Reply-To: <20190520071547.godyxigamihl5gav@debian.ka.intel.com>
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
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org


>>> diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
>>> index 065cb868bdfa..9dfdc02192b7 100644
>>> --- a/sound/soc/sof/intel/bdw.c
>>> +++ b/sound/soc/sof/intel/bdw.c
>>> @@ -278,11 +278,15 @@ static irqreturn_t bdw_irq_thread(int irq, void *context)
>>>   	/* reply message from DSP */
>>>   	if (ipcx & SHIM_IPCX_DONE &&
>>>   	    !(imrx & SHIM_IMRX_DONE)) {
>>> +		unsigned long flags;
>>> +
>>>   		/* Mask Done interrupt before return */
>>>   		snd_sof_dsp_update_bits_unlocked(sdev, BDW_DSP_BAR,
>>>   						 SHIM_IMRX, SHIM_IMRX_DONE,
>>>   						 SHIM_IMRX_DONE);
>>> +		spin_lock_irqsave(&sdev->ipc_lock, flags);
>>
>> Here is an threaded irq handler, so the irqflag is superfluous.
>> You can use spin_lock_irq() and spin_unlock_irq().
> 
> Oh, sure, thanks for catching this! That was a blind moving of the
> spin-lock from lower-level functions. I'll send an updated version to
> Pierre, unless you want to apply it immediately, in which case I can
> send it to you now.

I can send a v2 with Guennadi's update and Takashi's Reviewed-by tag.

> 
>>> diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
>>> index 7bf9143d3106..5a11a104110b 100644
>>> --- a/sound/soc/sof/intel/byt.c
>>> +++ b/sound/soc/sof/intel/byt.c
>>> @@ -324,11 +324,16 @@ static irqreturn_t byt_irq_thread(int irq, void *context)
>>>   	/* reply message from DSP */
>>>   	if (ipcx & SHIM_BYT_IPCX_DONE &&
>>>   	    !(imrx & SHIM_IMRX_DONE)) {
>>> +		unsigned long flags;
>>> +
>>>   		/* Mask Done interrupt before first */
>>>   		snd_sof_dsp_update_bits64_unlocked(sdev, BYT_DSP_BAR,
>>>   						   SHIM_IMRX,
>>>   						   SHIM_IMRX_DONE,
>>>   						   SHIM_IMRX_DONE);
>>
>> BTW, is this usage of _unlocked() version safe?  The previous one also
>> contained that, and I wonder why _unlocked variant must be used here.
> 
> Some of those uses seem rather fragile to me too, but it looks like they
> *should* be safe in normal cases. There seem to be a potential problem
> on Broadwell, where an ISR is first configured, which uses *_unlocked()
> to access the SHIM_IMRX register, and then bdw_set_dsp_D0() is called,
> which also touches that register. So, it's relying on the fact, that no
> IPC interrupts will occur until probing is completed. This should also
> normally be the case, but if for some reason such an interrupt does
> trigger at that time, access to that register can be messed up. This
> should be reviewed and possibly refined separately.

There will be additional IPC hardening fixes that are being tested at 
the moment, the introduction of HDaudio support seems to have exposed a 
number of issues we didn't see with I2S/TDM/DMIC interfaces. I included 
Guennadi's patch in the series since we have evidence it does improve 
things on the Up2. we can look at the _unlocked parts in the next update 
with more validation.
