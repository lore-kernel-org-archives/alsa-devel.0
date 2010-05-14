From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Fri, 14 May 2010 14:27:51 +0900
Message-ID: <AANLkTikNYCg9f2dZyn-Lsr4BFcmBtMRYNBCICpvbONGo@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<AANLkTimF0qrCaiIk6-cjkxm1s-hA3bOgKdmsDe8PdV1a@mail.gmail.com>
	<AANLkTimPaE9JTd8XIVcM6JQvmD73JHkSWMjKT8zsdGR2@mail.gmail.com>
	<20100512141653.GB4312@sirena.org.uk>
	<AANLkTimQ8I3NWwCuOV7M8mTpzBMwDkrmhb5wWYao_CGs@mail.gmail.com>
	<AANLkTil47RvspYnd0cTgCU-_y0d6PRHgaakns17edstr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f202.google.com (mail-pz0-f202.google.com
	[209.85.222.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 8464224451
	for <alsa-devel@alsa-project.org>;
	Fri, 14 May 2010 07:27:52 +0200 (CEST)
Received: by pzk40 with SMTP id 40so1254761pzk.23
	for <alsa-devel@alsa-project.org>; Thu, 13 May 2010 22:27:51 -0700 (PDT)
In-Reply-To: <AANLkTil47RvspYnd0cTgCU-_y0d6PRHgaakns17edstr@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 14, 2010 at 1:39 PM, pl bossart <bossart.nospam@gmail.com> wrote:
>> AFAIU, the only issue is lack of ability to fine-tune period size of
>> DMA runtime.
>> Otherwise, for the requirement, having period-size almost equal
>> to ring-buffer serves better than disabling interrupts and using timer
>> based updating, more so for VMs with inaccurate timer source.
>>
>> Then I think, rather then providing a way to disable hw-intr, we'd
>> better provide
>> a way to modify runtime period-size at DMA Driver level, and
>> snd_pcm_period_elapsed seems already capable to handle that.
>> That way, disabled interrupts would just be a special case with
>> period-size := ULONG_MAX.
>
> Is this a realistic option?
We have to see as it is certainly a more desirable solution.

> With the majority of existing hardware
> period interrupts are programmed with a flag set in a descriptor when
> the DMA linked list is created. That includes HDAudio and numerous
> others. I am skeptical that one could reliably modify these
> descriptors at run-time, specifically in the case where the controller
> caches the descriptors.
As we all understand, the requirement is expected to be met only by
some h/w that has the capability.
Among those candidates, cards that don't support period resize may
respond only to "period-size := ULONG_MAX" (i.e interrupt disabling),
while more flexible cards can exploit the period-resize feature.

Also, let us not forget that almost every embedded device
use general purpose DMA that can be re-programmed for different
period-size without much trouble.
