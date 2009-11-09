From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH V2] ASoC - Add support for upto 16 channels
	on OMAP MCBSP
Date: Mon, 9 Nov 2009 09:24:58 +0200
Message-ID: <200911090924.59029.peter.ujfalusi@nokia.com>
References: <1257454808.3576.397.camel@odin> <1257712022.15162.2.camel@vega>
	<20091109085722.49d40bd8.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E8F110382D
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 08:25:09 +0100 (CET)
In-Reply-To: <20091109085722.49d40bd8.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: Graeme Gregory <gg@slimlogic.co.uk>, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Grazvydas Ignotas <notasas@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Monday 09 November 2009 08:57:22 ext Jarkko Nikula wrote:
> On Sun, 08 Nov 2009 20:27:01 +0000
> =

> Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> > > Seems to be working fine, tried playing several different sample rates
> > > and also recording path. FYI pandora has TWL4030 256FS clock connected
> > > to OMAP's CLKS pin.
> > >
> > > Tested-by: Grazvydas Ignotas <notasas@gmail.com>
> >
> > Jarkko, Peter,
> >
> > Any chance we could have your Ack before applying.
> =

> Definitely. I just sent a patch which must be applied before yours to
> the Pandora. It is otherwise the same than I sent before but now with
> commit log and 8*32 replaced with 256.
> =

> Mark: The omap3pandora.c must be patches before Liam's patch.
> =

> http://mailman.alsa-project.org/pipermail/alsa-devel/2009-November/022921=
.h
> tml
>  http://mailman.alsa-project.org/pipermail/alsa-devel/2009-November/02279=
7.
> html
> =

> Acked-by: Jarkko Nikula <jhnikula@gmail.com>

I would reconsider this ack, since the patch breaks the McBSP slave operati=
on..
There is no meaning for the infrequency nor for the divider in slave mode, =
but =

we can invent something like OMAP_MCBSP_FAKECLK_MASTER to be 'handled' in =

omap_mcbsp_dai_set_dai_sysclk, when the OMAP_MCBSP_FAKECLK_MASTER is being =

configured, we just take the frequency, which ahs to be calculated in the =

machine drivers beforehand (sample rate * bits * channels?), than we need t=
o =

update all the machine drivers, where McBSP is slave to pass this informati=
on in =

order to pass the test in omap_mcbsp_dai_hw_params.

> =


-- =

P=E9ter
