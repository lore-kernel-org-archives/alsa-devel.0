From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] ALSA: x86: fix error return code in
 hdmi_lpe_audio_probe()
Date: Fri, 30 Jun 2017 15:12:44 -0500
Message-ID: <20170630151244.Horde.nPNra38wHbiLkXMM9mTTsxB@gator4166.hostgator.com>
References: <20170630195901.GA5751@embeddedgus>
 <s5h4lux5jff.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h4lux5jff.wl-tiwai@suse.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Quoting Takashi Iwai <tiwai@suse.de>:

> On Fri, 30 Jun 2017 21:59:01 +0200,
> Gustavo A. R. Silva wrote:
>>
>> platform_get_irq() returns an error code, but the sata_rcar driver
>> ignores it and always returns -ENODEV.
>
> Which driver?  A copy&paste error?
>

Yep, I'm already working on v2 of this patch, which fix this error.  
I'll send it shortly.

Thanks
--
Gustavo A. R. Silva
