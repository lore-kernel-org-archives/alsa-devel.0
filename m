From: Lori Hikichi <lhikichi@broadcom.com>
Subject: Re: [PATCH 2/2] ASoC: add core audio driver for Broadcom Cygnus SOC.
Date: Tue, 7 Apr 2015 19:30:57 -0700
Message-ID: <552492E1.3050207@broadcom.com>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com> <1427771784-29950-3-git-send-email-sbranden@broadcom.com> <20150331064209.GD2869@sirena.org.uk> <551D8EB6.1050004@broadcom.com> <20150406161939.GJ6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150406161939.GJ6023@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Scott Branden <sbranden@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Dmitry Torokhov <dtor@google.com>, Anatol Pomazao <anatol@google.com>, abrestic@google.com, bryeung@google.com, olofj@google.com, pwestin@google.com
List-Id: alsa-devel@alsa-project.org



On 15-04-06 09:19 AM, Mark Brown wrote:
> On Thu, Apr 02, 2015 at 11:47:18AM -0700, Lori Hikichi wrote:
>> On 15-03-30 11:42 PM, Mark Brown wrote:
>
>>>> +config SND_SOC_CYGNUS
>>>> +	tristate "SoC platform audio for Broadcom Cygnus chips"
>>>> +	depends on ARCH_BCM_CYGNUS || COMPILE_TEST
>>>> +	default ARCH_BCM_CYGNUS
>
>> Okay.
>
> You don't need to reply to every single comment, the general assumpti=
on
> will be that if there's no other followup all review comments will be
> addressed.  It's better to just reply to things where there's somethi=
ng
> more detailed to say, if you explicitly reply to everything then that
> makes it easier for actual replies to be missed since there's a lot o=
f
> there's a lot of the mail that's just going to be skipped through.
>
>>>> +static void ringbuf_inc(void __iomem *audio_io, bool is_playback,
>>>> +			const struct ringbuf_regs *p_rbuf)
>
>>> So it looks like we're getting an interrupt per period and we have =
to
>>> manually advance to the next one?
>
>> Yes.
>
> OK, so that seems fragile - what happens if we're slightly late
> processing an interrupt or miss one entirely?  Most hardware has some
> way to read back the current position which tends to be more reliable=
,
> is that not an option here?
>
The hardware updates a read pointer (rdaddr) which we feed to ALSA via=20
the ".pointer" hook. So yes, the hardware does have a register that=20
tells us its progress.  This routine (ringbuf_inc) actually updates a=20
write pointer (wraddr) which is a misnomer.  The write pointer doesn=92=
t=20
actually tell us where we are writing to =96 ALSA keeps track of that.=20
The wraddr only prevents the hardware from reading past it.  We just us=
e=20
it, along with a low water mark configuration register, to keep the=20
periodic interrupts firing.  The hardware is tracking the distance=20
between rdaddr and wraddr and comparing that to the low water mark.

Being late processing the interrupt is okay since there are more sample=
s=20
to read.  That is, it was only a low water mark interrupt and we have=20
one period of valid data still (we configure low water to be one=20
period).  Missing an interrupt is okay since the hardware will just sto=
p=20
reading from the ring buffer when rdaddr has hit wraddr.
