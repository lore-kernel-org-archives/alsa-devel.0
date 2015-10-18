From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [patch] ALSA: firewire-tascam: off by one in identify_model()
Date: Sun, 18 Oct 2015 10:00:16 +0900
Message-ID: <5622EF20.6010708@sakamocchi.jp>
References: <20151015181828.GC3163@mwanda> <s5hlhb1dcsx.wl-tiwai@suse.de>
 <20151017120232.GU7289@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20151017120232.GU7289@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Oct 17 2015 21:02, Dan Carpenter wrote:
> On Sat, Oct 17, 2015 at 12:11:58PM +0200, Takashi Iwai wrote:
>> On Thu, 15 Oct 2015 20:18:29 +0200,
>> Dan Carpenter wrote:
>>>
>>> In the original code, we potentially put a NUL character in model[8] and
>>> it caused a static checker warning.  We can put the NUL in model[7]
>>> instead.
>>
>> I guess it's better to expand model[] to 9 bytes instead.  The logic
>> is to retrieve the string from the config rom, and it's up to 8
>> letters.
> 
> Ok.  I will resend.

I think this idea is better, too.


Thanks

Takashi Sakamoto
