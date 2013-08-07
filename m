From: Jussi Kivilinna <jussi.kivilinna-X3B1VOXEql0@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] 6fire: fix DMA issues with URB transfer_buffer
 usage
Date: Wed, 07 Aug 2013 17:50:25 +0300
Message-ID: <52025EB1.6090605@iki.fi>
References: <20130806115324.23908.18291.stgit@localhost6.localdomain6> <s5h7gfx7jsw.wl%tiwai@suse.de> <20130807155907.dfea021b3b73fcac33e4323d@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130807155907.dfea021b3b73fcac33e4323d-ytc+IHgoah0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Torsten Schenk <torsten.schenk-ytc+IHgoah0@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 07.08.2013 16:59, Torsten Schenk wrote:
> On Wed, 07 Aug 2013 14:43:43 +0200
> Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org> wrote:
> 
>> At Tue, 06 Aug 2013 14:53:24 +0300,
>> Jussi Kivilinna wrote:
>>>
>>> Patch fixes 6fire not to use stack as URB transfer_buffer. URB
>>> buffers need to be DMA-able, which stack is not. Furthermore,
>>> transfer_buffer should not be allocated as part of larger device
>>> structure because DMA coherency issues and patch fixes this issue
>>> too.
> 
> Thanks for the information. There is another section where this applies
> in midi.c/midi.h. I can post a patch later.

Appearently in pcm.c/pcm.h too:
 http://lxr.free-electrons.com/source/sound/usb/6fire/pcm.c#L571
 http://lxr.free-electrons.com/source/sound/usb/6fire/pcm.h#L35

-Jussi

> 
>>>
>>> Patch is only compile tested.
>>
>> The changes look OK, but I'd like to let it checked with a real
>> hardware before putting to stable kernel.
>>
>> Torsten, could you check this?
> 
> The patch works nicely.
> 
> I'm just wondering if instead of calling kmalloc() every time it'd be
> better to put a global sender_buffer and a mutex into the comm_runtime
> struct and lock it every time a writeX is performed. This also would
> have the advantage that message blocks would never overlap which
> currently is possible.
> 
> I can prepare a patch on top of this one and send it later, if you
> agree.
> 
> Thanks,
> Torsten
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
