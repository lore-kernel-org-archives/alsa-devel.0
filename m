From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix wrong sizeof argument
Date: Thu, 2 Aug 2018 14:54:05 -0500
Message-ID: <23ef19da-3c37-4902-62e9-c1042d9e178e@embeddedor.com>
References: <20180802141723.GA7258@embeddedor.com>
 <s5hbmakluin.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hbmakluin.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 08/02/2018 09:20 AM, Takashi Iwai wrote:
> On Thu, 02 Aug 2018 16:17:23 +0200,
>  Gustavo A. R. Silva  wrote:
>>
>> The correct argument to be passed to kzalloc is sizeof(*pd)
>>
>> Addresses-Coverity-ID: 1472224 ("Wrong sizeof argument")
>> Fixes: 7edf3b5e6a45 ("ALSA: usb-audio: AudioStreaming Power Domain parsing")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> It's already fixed, thanks.
> 

Good to know. :)

Thanks
--
Gustavo
