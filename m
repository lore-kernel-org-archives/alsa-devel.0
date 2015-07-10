From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC PATCH 3/4] ALSA: core: add report of max dma
	burst
Date: Fri, 10 Jul 2015 10:35:51 +0800
Message-ID: <CAN8cciYf_oz+ozAesHu5j_V0=iDSuFrLM5E2i6f+CbaXqWX9uQ@mail.gmail.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1436350236-17509-4-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5hio9uhg16.wl-tiwai@suse.de> <559D61EA.7030308@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 448862664B0
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 04:35:53 +0200 (CEST)
Received: by oibp128 with SMTP id p128so41238939oib.3
 for <alsa-devel@alsa-project.org>; Thu, 09 Jul 2015 19:35:52 -0700 (PDT)
In-Reply-To: <559D61EA.7030308@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
>
>>> FIXME:
>>> 1. this was copy/pasted/edited based on the fifo_size fields, not
>>> sure why we would need this IOCTL1
>>
>>
>> fifo_size would fit, but it means that it also changes the current
>> behavior.  I don't believe that currently there are many programs
>> relying on this value, but who knows.
>
>
> I saw a mention of fifo_size in the VIA HDA controller, that's why I went
ahead with a different field. The fifo_size could be useful as a max value
for the internal hardware delay, when app use the 'delay' field in the
status structure they get a very dynamic value that isn't necessarily
straightforward to use.
>
>
>>
>>> 2. we also need the ability to set the actual fifo size, if suppported,
>>> by the hardware, to negociate the prefetch amount between application
>>> and driver. By default the default should be max buffering to allow
>>> for lower power, but for low-latency use cases we may want to reduce
>>> the amount of prefetching.
>>
>>
>> Right.  So a hw_parmas field looks suitable for that purpose.
>
>
> That 'set' capability is a lot more complicated, I am really having a
hard time with all the constraints for hw_params and how to represent
min,max and step values... If anyone is willing to help on that part I
wouldn't mind, this is really a part of ALSA I never looked into...

What is the usage of runtime->dma_bytes in
snd_pcm_hw_constraints_complete() in core/pcm_native.c ?

Was the usage similar to 128 bytes alignment ?

/* FIXME: remove */
if (runtime->dma_bytes) {
err = snd_pcm_hw_constraint_minmax(runtime,
SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 0, runtime->dma_bytes);
if (err < 0)
return err;
}
