From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: pcm - introduce soc_delay
Date: Mon, 23 Jul 2012 22:27:23 +0100
Message-ID: <20120723212723.GD12438@opensource.wolfsonmicro.com>
References: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
 <20120723101851.GG4435@opensource.wolfsonmicro.com>
 <1343039946.1726.4830.camel@vkoul-udesk3>
 <20120723104720.GK4435@opensource.wolfsonmicro.com>
 <500DAB54.20705@linux.intel.com>
 <20120723200512.GB25707@sirena.org.uk>
 <500DB11C.1050007@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8318382526591272432=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 29C0A260323
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 23:36:24 +0200 (CEST)
In-Reply-To: <500DB11C.1050007@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============8318382526591272432==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2012 at 03:16:28PM -0500, Pierre-Louis Bossart wrote:

> >Right, but this depends on the ability of the device to pause reading
> >data when it reads up to the point where the application has written.
> >This is a separate capability to any latency that's been added by the
> >buffering, and most of the systems that have the buffering don't have
> >this capability but instead either don't report the buffer or rely on
> >the application being a full buffer ahead of the hardware.

> We don't have such fancy hardware (and I don't think anyone has).
> This can happen even with simple IP that has an embedded SRAM and
> bursty DMA,  if the IP buffer amounts to the period size to avoid

The usual way of representing this is to have the pointers in the buffer
represent where the input to the hardware pipeline is at (ie, where the
actual DMA is reading) and handle underflow on that normally.

> partial wakes or transfers, and the application cannot provide more
> than one period initially you get an underflow that isn't a true
> one.

Normally this is handled by requiring that the application has at least
one period ready for the hardware at all times, otherwise as you get
down towards the end of the buffer things get racier and racier.  It's
not really about the delay, either - it's about when the DMA wants to
read the memory which isn't quite the same thing.  It could be that it
does this with half the buffer remaining, it could be that it waits
until it's got some much smaller amount of data left.

I think what's really needed here is to represent the buffer in the
hardware and how it's filled up to the stack more directly.  It's not
the fact that there is data buffered that we need to tell the stack
about (we can already do that), what we need to tell it is that the
trigger level for refilling that may not be what's expected.

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQDcG0AAoJEBus8iNuMP3dX6AP/ifbPn+Cci/V4U6ikbzgzFIk
AhmBeqZ1RxB81dmmXqikvLdyRJEaNWYFQtJZns81jf7gPrfxrOebofN0Mg7whpWO
6a+4mQcSzmx/os6kgpa4fXIHxM3ZsUX+zwG0wgWp9B6b4RpGVSBbxzTHIlMlcACi
5BnTgXaKpPCvEp9Y3pP//YC0QVl7fzej1lFXZsDXC62a/klcDwtQHBm/cCYYEM/N
bDT1aacLRlbI1MJrspWODSQVFicMqKYLwGVI98/dNmNremA9iZixmnCS6uOZIj+O
aSBTNfNyBpZljlyzijYrHrFXFym43iBQFBWRSuO3aFMJ10nlZRJWfGp86tqbNNv7
dSvVKzK++49hHczjRdlLZbczftqWslEf1v8KXmS5fCwT3eVB2cBepCkNr6BMYAVy
dUTe5ZwrJz92MW2E+z/ulhsfcCJVpFTau0HEDiZeyUmAxJitN8VDzlo5LqkN3uzE
wuXqO/VA0DrSZ+zDs543UEh1k1vElWXBuW0uV71TPrhdvmgo8doNPyS0y5d6JrUX
SXqThXTHYOZajLZZamKFCwoF35a+7myQyVwycm3Lh4/J4TPez8+tSrKOqzi3dkTC
ta6PeatTwaUAqeXSJcSHnFg0lH6PgyxLUCOLUwRxrBM4jvrhP7nR2S4LB9se4a+c
goPKdQMyFgoBK5lHeqZF
=Y+iK
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--

--===============8318382526591272432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8318382526591272432==--
