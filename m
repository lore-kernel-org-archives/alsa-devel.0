From: Chen Gang S <gang.chen@sunrus.com.cn>
Subject: Re: [PATCH] sound: soc: soc-pcm: Remove useless varialbe 'i'
Date: Sat, 03 Jan 2015 18:15:51 +0800
Message-ID: <54A7C157.40404@sunrus.com.cn>
References: <54A7BA55.3020607@sunrus.com.cn> <s5htx08dw1q.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5htx08dw1q.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 1/3/15 17:59, Takashi Iwai wrote:
> At Sat, 03 Jan 2015 17:45:57 +0800,
> Chen Gang wrote:
>>
>> 'i' is useless in soc_pcm_set_msb(), so remove it, the related warning
>> (with allmodconfig under s390):
>>
>>     CC [M]  sound/soc/soc-pcm.o
>>   sound/soc/soc-pcm.c: In function 'soc_pcm_set_msb':
>>   sound/soc/soc-pcm.c:307:11: warning: unused variable 'i' [-Wunused-variable]
>>     int ret, i;
>>              ^
> 
> Thanks, but this was already fixed.
> 

OK, thanks.

-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
