From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/6] ASoC: ux500: Do not clear state if already idle
Date: Wed, 8 May 2013 12:04:51 +0100
Message-ID: <20130508110451.GC3459@gmail.com>
References: <20130508080448.GG3102@gmail.com>
 <1368002354-15471-1-git-send-email-fabio.baltieri@linaro.org>
 <20130508103401.GX7478@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130508103401.GX7478@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Baltieri <fabio.baltieri@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 08 May 2013, Mark Brown wrote:

> On Wed, May 08, 2013 at 10:39:14AM +0200, Fabio Baltieri wrote:
> > As enable_msp gets called only after some audio data has been recei=
ved,
> > if the userspace closes the device before sending any data it cause=
s
> > ux500_msp_i2s_close to clear device state even if it was not previo=
usly
> > initialized.
>=20
> Ugh, please don't do stuff like this - you're posting an individual
> revision of a patch buried in the middle of a thread.  This just make=
s
> things hard to follow and error prone.  Repost the patch series

It's so much more convenient to do it this way. Re-sending entire
patch-sets for small fixups is clumsy and annoying at best. Creating
much more churn than is actually required. Sending patches again
signally i.e. not as a reply to the original [PATCH x/x], would be
even more prone to error.

Personally, I like to get the niggles and fixups out of the way using
this method, then send the entire patch-set again, complete with all
of the reaped Acks once there are significant fixes or when I believe
it to be finished and ready for applying.

Surely most people have their mail setup as threaded? Then the
time-line and subsequent patch versions are very easy to follow aren't
they? I get a nice trace like this:

> <date> Fabio Baltieri    (  0) =E2=94=9C>[PATCH 2/6] ASoC: ux500: <sn=
ip>
> <date> To Fabio Baltieri (  0) =E2=94=82=E2=94=94>
> <date> Fabio Baltieri    (  0) =E2=94=82 =E2=94=94>[PATCH v2 2/6] ASo=
C:   <snip>

=2E.. or even better would be to reply to the original one, then
subsequent versions won't be "buried in the thread" per say:

> <date> Fabio Baltieri    (  0) =E2=94=9C>[PATCH 2/6] ASoC: ux500: <sn=
ip>
> <date> Fabio Baltieri    (  0) =E2=94=82 =E2=94=94>[PATCH v2 2/6] ASo=
C:   <snip>
> <date> To Fabio Baltieri (  0) =E2=94=82->

> or wait until what can be applied is applied then repost.

Taking patches out-of-order, or 'willy-nilly', is asking for trouble.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
