From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4] ASoC: Add Freescale SGTL5000 codec
	support
Date: Mon, 21 Feb 2011 18:47:33 +0000
Message-ID: <20110221184732.GC5192@opensource.wolfsonmicro.com>
References: <1298246965-22575-1-git-send-email-zhaoming.zeng@freescale.com>
	<AANLkTinVCB5RdcB9Um+d5La9-_0x6zKmH-9V5He+wJ+z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B226624492
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 19:47:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTinVCB5RdcB9Um+d5La9-_0x6zKmH-9V5He+wJ+z@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur.tabi@gmail.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, zengzm.kernel@gmail.com, zhaoming.zeng@freescale.com, linuxzsc@gmail.com, arnaud.patard@rtp-net.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 21, 2011 at 08:59:58AM -0600, Timur Tabi wrote:
> On Sun, Feb 20, 2011 at 6:09 PM,  <zhaoming.zeng@freescale.com> wrote:
> =

> > +#Freescale SGTL5000 codec
> > +config SND_SOC_SGTL5000
> > + =A0 =A0 =A0 tristate
> > +

> I meant that you should add actual "help" text so that a person
> selecting this driver would know what it is.  Like this:

> config SND_SOC_SGTL5000
>    tristate "Freescale SGTL5000 audio codec"
>    help
>       Select this option to enable the Freescale SGTL5000 audio codec, et=
c etc

Not for mosts CODEC drivers, these should be selected by the machine
drivers which use them rather than enabled directly by users so they are
not expected to have help text, except in the unusual case that they're
set up for use with OpenFirmware without bindings.
