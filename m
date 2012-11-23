From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v2] ASoC: fsl: fix miscompilation of snd-soc-imx-pcm
Date: Fri, 23 Nov 2012 11:21:42 +0100
Message-ID: <20655.20022.819710.39381@ipc1.ka-ro>
References: <20121123081307.GA4529@opensource.wolfsonmicro.com>
	<1353661933-27659-1-git-send-email-LW@KARO-electronics.de>
	<20121123100849.GC4529@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121123100849.GC4529@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

Mark Brown writes:
> On Fri, Nov 23, 2012 at 10:12:13AM +0100, Lothar Wa=C3=9Fmann wrote:
> > Due to a broken make rule, sound/soc/fsl/imx-pcm-dma.c or
> > sound/soc/fsl/imx-pcm-fiq.c (whatever is selected via Kconfig) will
> > not be compiled into imx-pcm.o when building as module, i.e.:
>=20
> What I've been trying to do is get you to tell me what the problem is
> with the Makefile rule, it's really not clear to me what the issue is=
 or
> why your change is better.  I can see the practical results but nothi=
ng
> about how they came to be which makes it very hard to tell if this is=
 a
> good fix.
>=20
I already included the actual error messages I got when loading the
sound module.
I also mentioned, that in case of module build some source files
aren't being compiled with those rules. What else do you expect?


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
