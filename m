From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Fri, 14 May 2010 13:07:40 +0900
Message-ID: <AANLkTimQ8I3NWwCuOV7M8mTpzBMwDkrmhb5wWYao_CGs@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<AANLkTimF0qrCaiIk6-cjkxm1s-hA3bOgKdmsDe8PdV1a@mail.gmail.com>
	<AANLkTimPaE9JTd8XIVcM6JQvmD73JHkSWMjKT8zsdGR2@mail.gmail.com>
	<20100512141653.GB4312@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id E2BAE243FA
	for <alsa-devel@alsa-project.org>;
	Fri, 14 May 2010 06:07:42 +0200 (CEST)
Received: by pwj2 with SMTP id 2so247815pwj.38
	for <alsa-devel@alsa-project.org>; Thu, 13 May 2010 21:07:40 -0700 (PDT)
In-Reply-To: <20100512141653.GB4312@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, pl bossart <bossart.nospam@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 12, 2010 at 11:16 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 12, 2010 at 08:50:42AM -0500, pl bossart wrote:
>
>> This might be almost equivalent to the timer approach in terms of # of
>> wakeups, however the timer can be reprogrammed on-the-fly whereas
>> periods can only be changed by closing and reopening the device. You
>> can also adjust the timer shall underflows occur. And the timer slack
>> lets the kernel group events. Not to mention that you will need
>
> The timer is also useful for allowing PulseAudio to dynamically adjust
> the period size as the runtime situation changes - if you're running
> high latency streams and have a low latency application start up then
> PulseAudio can just change the timer to get more frequent events.

AFAIU, the only issue is lack of ability to fine-tune period size of
DMA runtime.
Otherwise, for the requirement, having period-size almost equal
to ring-buffer serves better than disabling interrupts and using timer
based updating, more so for VMs with inaccurate timer source.

Then I think, rather then providing a way to disable hw-intr, we'd
better provide
a way to modify runtime period-size at DMA Driver level, and
snd_pcm_period_elapsed seems already capable to handle that.
That way, disabled interrupts would just be a special case with
period-size := ULONG_MAX.
