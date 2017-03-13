From: Chemsi Mehdi <chmsmehdi@gmail.com>
Subject: Re: Is snd_pcm_hw_constraint_mask64 really needed ?
Date: Mon, 13 Mar 2017 10:06:34 +0100
Message-ID: <CAHkWnPY_a1Vw3-3syHwckYCtwSbog8GTmJwq_Wix8U37Rk6USg@mail.gmail.com>
References: <CAHkWnPZu3a5WdsXzF8_faxdoYPOuSgcqkAu3tX_EL4VCczqYqw@mail.gmail.com>
 <dd51b96c-b367-3c64-1ebe-7a5e7496f6f3@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f177.google.com (mail-qt0-f177.google.com
 [209.85.216.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EB6F265823
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 10:06:36 +0100 (CET)
Received: by mail-qt0-f177.google.com with SMTP id i34so26795660qtc.0
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 02:06:36 -0700 (PDT)
In-Reply-To: <dd51b96c-b367-3c64-1ebe-7a5e7496f6f3@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks a lot dear Takashi, helpful as the habit

2017-03-12 2:24 GMT+01:00 Takashi Sakamoto <o-takashi@sakamocchi.jp>:

> Hi,
>
> On Mar 10 2017 01:23, Chemsi Mehdi wrote:
>
>> I am working with an alsa codec driver  where the driver is calling
>> err = snd_pcm_hw_constraint_mask64(substream->runtime,
>> SNDRV_PCM_HW_PARAM_FORMAT, formats);
>> my driver is already setting format before that so I wonder why this
>> function is called?
>> Looks like it is  needed to add audio constraints to substreams at
>> open/startup time, but why ?
>> what can be the issue if I do not call it ?
>>
>
> It's for user space applications.
>
> In protocol of ALSA PCM interface between kernel/userspace, parameters of
> PCM substream are decided via interaction between drivers and applications.
> Typically, applications keep memory object in user space for 'struct
> snd_pcm_hw_params' and set their preferable parameters to it, then call
> ioctl(2) system call for it with SNDRV_PCM_IOCTL_HW_PARAMS or
> SNDRV_PCM_IOCTL_HW_REFINE. In kernel mode, the memory object is copied to
> kernel space and handled by ALSA PCM core. The constrains and rules
> registered by drivers are applied to it, then the result is copied to user
> space. Finally, applications can get available parameters of PCM substream.
>
> Without this interaction, even if your driver can handle your devices
> correctly, applications cannot use them with proper parameters of PCM
> substream; e.g. wrong PCM samples per frame, wrong sampling rate, and so on.
>
>
> Regards
>
> # I'm another Takashi.
>
> Takashi Sakamoto
>
