From: Chen Jie <chenj@lemote.com>
Subject: Re: [alsa-devel] [PATCH V4 12/16] ALSA: HDA: Make hda sound card
 usable for Loongson.
Date: Thu, 9 Aug 2012 11:35:15 +0800
Message-ID: <CAGXxSxVs0cq08d+xk3rew6tQttkw1XM7pugn142m1_F6tJBWNQ@mail.gmail.com>
References: <1343977571-2292-1-git-send-email-chenhc@lemote.com>
 <1343977571-2292-13-git-send-email-chenhc@lemote.com> <s5hobmsqqeh.wl%tiwai@suse.de>
 <CAAhV-H5ATFD7pksBkA374ShYWmvrgttGSs0vgu8QJ1F3VeRyzA@mail.gmail.com> <s5hipd0m3bj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <s5hipd0m3bj.wl%tiwai@suse.de>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Takashi Iwai <tiwai@suse.de>
Cc: Huacai Chen <chenhuacai@gmail.com>, linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Zhangjin Wu <wuzhangjin@gmail.com>, Hua Yan <yanh@lemote.com>, Ralf Baechle <ralf@linux-mips.org>, Hongliang Tao <taohl@lemote.com>, Fuxin Zhang <zhangfx@lemote.com>, Huacai Chen <chenhc@lemote.com>
List-Id: alsa-devel@alsa-project.org

Hi,

2012/8/3 Takashi Iwai <tiwai@suse.de>:
> At Fri, 3 Aug 2012 18:36:40 +0800,
> Huacai Chen wrote:
>>
>> We write these quirks on 2.6.36 some time ago, and then we port them
>> to 3.x (3.2, 3.3, 3.4 and 3.5). As you say, PMON (BIOS for Loongson)
>> doesn't set the pins correctly. Anyway, I'll try your suggestions.
>
> Thanks.  I guess it should work by just adding a new entry for your
> device in cxt_fixups[] containing the right default pin-configuration
> table, then point it in cxt5066_fixups[] with the corresponding PCI
> (or codec) SSID.
>
>
> Takashi

I've found it is a little difficult to get proper pincfg values. The
original patch builds  'input/output path' manually, the new way does
it automatically as long as providing proper pincfgs for 'end points'.

I tried to copy related pincfgs from a workable lemote a1004
laptop(kernel with the original patch, read from
/proc/asound/card0/codec#0), didn't help much.

I guess the pincfgs are not correct, and on the platform, the pincfgs
are not touched by BIOS, so I have to calculate proper pincfgs, how?

HDA spec explains a pincfg as four bytes. For each byte, it has bits
indicate amp/in/out/vref/ept.

In the kernel side, it reads a pincfg and explains it as a 32bits
flag, indicating
connect/location/device/jack_connect_type/jack_color/misc/association/sequence.

Why they differ? How to get proper pincfg values?



Regards,
-- Chen Jie
