From: gsantosh@codeaurora.org
Subject: Re: customized IOCTL in pcm platform driver.
Date: Mon, 8 Oct 2012 23:44:40 -0700 (PDT)
Message-ID: <4d3d244e3c337274675747eee0404a78.squirrel@www.codeaurora.org>
References: <d0ef8dd36b2e37d9f0f0886758cb5963.squirrel@www.codeaurora.org>
 <s5hipak6td2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 by alsa0.perex.cz (Postfix) with ESMTP id BCED62615C0
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 08:44:41 +0200 (CEST)
In-Reply-To: <s5hipak6td2.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com, gsantosh@codeaurora.org
List-Id: alsa-devel@alsa-project.org

> At Mon, 8 Oct 2012 23:30:09 -0700 (PDT),
> gsantosh@codeaurora.org wrote:
>>
>> Hi All,
>>
>> will ALSA framework provide any customized IOCTL functionality in PCM
>> platform driver.
>
> No.
>
>> in my  system there is a requirement to get some information from DSP to
>> user space and I am thinking to add IOCTL's, is there any method to
>> accommodate or how we can address this issue?
>
> You can use hwdep device for any extra methods.

We need to tie this ioctl with the on going DSP session which will be
difficult When used with hwdep interface.

>
>
> Takashi
>
