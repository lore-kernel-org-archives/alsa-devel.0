From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] ALSA: emu8000: Use swap macro in snd_emu8000_sample_new
Date: Tue, 17 Jul 2018 10:35:08 -0500
Message-ID: <6737f53c-3f06-84ce-1ec7-8d59d991da7b@embeddedor.com>
References: <20180717150610.GA10577@embeddedor.com>
 <s5hzhypzy7e.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hzhypzy7e.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 07/17/2018 10:19 AM, Takashi Iwai wrote:
> On Tue, 17 Jul 2018 17:06:10 +0200,
>  Gustavo A. R. Silva  wrote:
>>
>> Make use of the swap macro and remove unnecessary variable *tmp*. This
>> makes the code easier to read and maintain.
>>
>> This code was detected with the help of Coccinelle.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Applied, thanks.
> 
> (BTW one of your addresses in Cc was a typo; removed in this reply)
> 

Thanks!
--
Gustavo
