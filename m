From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl-ssi: fix SDMA starvation
Date: Wed, 13 Nov 2013 13:16:30 +0100
Message-ID: <20131113121630.GH30263@pengutronix.de>
References: <1384255056-25673-1-git-send-email-mpa@pengutronix.de>
 <52822529.5090502@tabi.org>
 <20131112132441.GG30263@pengutronix.de>
 <CAOZdJXUWv3_ZV6p9VQ+zYqwUDVQC6BMb-VhVoVtEh1yC23VuTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOZdJXUWv3_ZV6p9VQ+zYqwUDVQC6BMb-VhVoVtEh1yC23VuTg@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Juergen Beisert <jbe@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Nov 12, 2013 at 02:17:34PM -0600, Timur Tabi wrote:
> On Tue, Nov 12, 2013 at 7:24 AM, Markus Pargmann <mpa@pengutronix.de>=
 wrote:
> >
> > No, I don't have access on PowerPC hardware, so I didn't test it on
> > PowerPC.
>=20
> Can you change the code so that the interrupts are enabled only on
> i.MX?  On PowerPC, the interrupts are used only for debugging.

Why is this necessary? The interrupts were enabled for all
architectures before.

However, this patch is wrong as J=C3=BCrgen mentioned, the SIER_FLAGS a=
re
written to the SIER register after we enable the DMA enable bits which
leads to missing DMA enable bits at the end.
I created a new patch to cleanup the whole interrupt flag setup. I will
post it later.

Regards,

Markus

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
