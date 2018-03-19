From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix parsing descriptor of UAC2
 processing unit
Date: Tue, 20 Mar 2018 01:32:16 +0200
Message-ID: <CAB=otbRC+5CxFAW2doYDps9p14dJXRNSw1-XyW7iqb=NvsMNiQ@mail.gmail.com>
References: <20180319061108.24178-1-k.marinushkin@gmail.com>
 <20180319074019.GA30688@kroah.com> <s5hzi34o6ai.wl-tiwai@suse.de> <s5hd100vzl2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hd100vzl2.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Kirill Marinushkin <k.marinushkin@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@linux.intel.com>, Philippe Ombredanne <pombredanne@nexb.com>, Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 19, 2018 at 5:45 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 19 Mar 2018 08:47:49 +0100,
> Takashi Iwai wrote:
>>
>> On Mon, 19 Mar 2018 08:40:19 +0100,
>> Greg Kroah-Hartman wrote:
>> >
>> > On Mon, Mar 19, 2018 at 07:11:08AM +0100, Kirill Marinushkin wrote:
>> > > Currently, the offsets in the UAC2 processing unit descriptor are
>> > > calculated incorrectly. It causes an issue when connecting the device which
>> > > provides such a feature:
>> > >
>> > > ~~~~
>> > > [84126.724420] usb 1-1.3.1: invalid Processing Unit descriptor (id 18)
>> > > ~~~~
>> > >
>> > > After this patch is applied, the UAC2 processing unit inits w/o this error.
>> > >
>> > > Fixes: 5e1ddb481776 ("UAPI: (Scripted) Disintegrate include/linux/usb")
>> > > Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
>> > > Cc: Mark Brown <broonie@kernel.org>
>> > > Cc: Jaroslav Kysela <perex@perex.cz>
>> > > Cc: Takashi Iwai <tiwai@suse.com>
>> > > Cc: Thomas Gleixner <tglx@linutronix.de>
>> > > Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
>> > > Cc: Philippe Ombredanne <pombredanne@nexb.com>
>> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > > Cc: Ruslan Bilovol <ruslan.bilovol@gmail.com>
>> > > Cc: linux-kernel@vger.kernel.org
>> > > Cc: alsa-devel@alsa-project.org
>> > > ---
>> > >  include/uapi/linux/usb/audio.h | 4 ++--
>> > >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> >     Cc: stable <stable@vger.kernel.org>
>> >  perhaps?
>>
>> Yes, it deserves.  But I'd need to double-check the UAC2
>> specification.  It's interesting that such a basic thing hasn't hit
>> until now.  Maybe just because it's a fairly minor feature.
>
> ... and the patch looks correct, after confirming the UAC2 spec.
> Now I applied it, with a minor correction of Fixes tag, which actually
> was introduced by 23caaf19b11e ("ALSA: usb-mixer: Add support for
> Audio Class v2.0"), and adding Cc to stable.
>

I also checked UAC1/UAC2 spec and the patch looks good.
What's interesting it seems nobody faced this issue (after searching
ower Internet can't find any mention) which was present from the
beginning of UAC2 driver implementation.

Thanks,
Ruslan
