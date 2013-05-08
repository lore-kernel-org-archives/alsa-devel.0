From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 6/6] ASoC: ux500: Use the first two AD slots for capture
Date: Wed, 8 May 2013 12:12:53 +0100
Message-ID: <20130508111253.GE3459@gmail.com>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
 <1367997261-32048-7-git-send-email-fabio.baltieri@linaro.org>
 <20130508105654.GC7478@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130508105654.GC7478@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Baltieri <fabio.baltieri@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 08 May 2013, Mark Brown wrote:

> On Wed, May 08, 2013 at 09:14:21AM +0200, Fabio Baltieri wrote:
> > Set AD_OUT1 and AD_OUT2, corresponding to LINL and LINR pins, as th=
e
> > default input slots for the capture interfaces.
>=20
> If these are routing specific analogue inputs to specific timeslots t=
hen
> this is routing that should be being exposed to DAPM as muxes, not ha=
rd
> coded in the middle of TDM slot configuration (which is both obscure =
and
> not what the TDM API is there for).  The TDM API should be purely abo=
ut
> placing the timeslots for the audio interface on the bus.

Again, I think this patch is a valid bugfix. If the driver requires
refactoring, it should be done by someone else. That's not the purpose
of Fabio's role.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
