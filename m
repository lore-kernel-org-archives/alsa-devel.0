From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH 4/7] Alchemy: DB1200 AC97+I2S audio support.
Date: Mon, 8 Jun 2009 17:42:56 +0200
Message-ID: <f861ec6f0906080842r3472f2ci4e1c309ee9a302cd@mail.gmail.com>
References: <20090608092521.GA7858@sirena.org.uk>
	<20090608102018.GA6547@rakim.wolfsonmicro.main>
	<f861ec6f0906080425i388a99a1kb89667c749a815c8@mail.gmail.com>
	<20090608115336.GA25827@rakim.wolfsonmicro.main>
	<f861ec6f0906080521y4443b888gb81a78305dfca5e2@mail.gmail.com>
	<20090608124411.GA3396@rakim.wolfsonmicro.main>
	<f861ec6f0906080611i2c03709cg621aeb87d084dd00@mail.gmail.com>
	<20090608134541.GA4765@rakim.wolfsonmicro.main>
	<f861ec6f0906080748x4b9fd196m27c1ef3a8af9542d@mail.gmail.com>
	<20090608152420.GC6413@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 25DD0244D8
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 17:42:57 +0200 (CEST)
Received: by bwz11 with SMTP id 11so3177185bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 08:42:56 -0700 (PDT)
In-Reply-To: <20090608152420.GC6413@rakim.wolfsonmicro.main>
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
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Mon, Jun 8, 2009 at 5:24 PM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
>> I attached an untested patch (an addon to the patch which started this t=
hread)
>> which does this. =A0Please have a look and tell me if this is what
>> suggested initially?
>
> Pretty much, though I suspect there's some confusion between the probe
> functions going on there (there's far too many of them in ASoC at the
> minute - I intend to streamline things a bit in the future but first I
> want to get the new models implemented).
>
> I'd expect it's possible to have standard platform devices declared in
> the CPU definitions for each PSC that the individual boards can just
> reference (rather than having to copy out the resources, which
> presumably are fixed for each CPU) but I'm not sure if that's idiomatic
> for MIPS code or not. =A0Most of ARM works that way.
>
> I'd be tempted to not bother creating the separate device for the DMA
> driver in au1xpsc_pcm_add() but that's just my personal preference.

This patch was just a quick hack, I'll clean it up and develop it further in
the coming days, then submit it to you after some testing.


> Also, you've missed a name for your audio_dev.

Nope, it's set in the following hunk depending on switch setting.


Thanks a lot for your patience!
        Manuel Lauss
