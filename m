From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Required/preferred multichannel order for ALSA
Date: Fri, 27 Apr 2012 13:22:26 +0100
Message-ID: <20120427122225.GG18260@opensource.wolfsonmicro.com>
References: <4F99BF45.4020909@ti.com> <1335518497.4150.6.camel@odin>
	<20120427095734.GC18260@opensource.wolfsonmicro.com>
	<s5hmx5xwete.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5888276306062467246=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6CB9C103FD9
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 14:22:28 +0200 (CEST)
In-Reply-To: <s5hmx5xwete.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Castaneda Gonzalez, Axel" <x0055901@ti.com>, alsa-devel <alsa-devel@alsa-project.org>, Ricardo Neri <ricardo.neri@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "Guiriec,
	Sebastien" <s-guiriec@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5888276306062467246==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S5HS5MvDw4DmbRmb"
Content-Disposition: inline


--S5HS5MvDw4DmbRmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 27, 2012 at 02:15:57PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > As well as being able to reorder things there's also the cases where a
> > multi-channel link can be assigned to send several independant streams
> > rather than actually be a multi-channel link.

> True.  OTOH, separating to different streams can be done mostly
> without extra configuration.  The driver may neeed to handle the
> open/close race, but basically splitting can be done uniquely just by
> the number of channels.  Of course, there might be other excpetions
> and corner cases, though.

Yes, I think it's mostly just a slight generalisation of the same
problem from an implementation point of view.

--S5HS5MvDw4DmbRmb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmo6OAAoJEBus8iNuMP3dcXAP/AjorxwVHPiAL9t6fes0FEiN
WGPK1yPnxXWgQO97u24kl3ZLVPPKXCN8Nr9+io8lresbrsqVrLL3YFFKhjSBOcgf
EGJm2nrzG9tnZD3+aF6zUV8Voan2R8sCj+9WvlIGxHXS48+wQejAdZmcyqB3GHsg
/j5AKtdAHgLxMoSMg0kkb1kLmwFkYey6WGstgh6tBhKXHwnWi+Exx2hzlN9Bbfr+
IBDX140gGDj1U2l6Srz+kLGh13IEJcQCvOETJ/mleK2+sZdfzYYh1JtsILzt8Vus
eovPzFphIidcHDRtYSYkJTWRPl9jLmMigoGE8bxwo7McS4Xb98XqCtWd6WpNsCCI
tbeHavy9tT+Uhlf8N9LtoE9okeSxlMDSmWAzy8zUE/t8olwlimzZMIzDAUYAeu5F
naP5DkpDGSM1IBKT6icm54iOAa/cpX5XknOiNymCJyE3JbZrt+okNDYo9kxPykAo
PfJ0PSuAZZ/F8xKWasn7h2JKsoD6IoXNU8m6ozXYbMBPQj50kSSuOOcPHSSgS+kf
P+IRIFPHECUHe8Hcyl5rw6/yDh2jEzxYFKPpOuEf7m2BAHipkzTvefJgZwWCKKFR
jTkESLRgnN3M7j+dcRS3eDUUKfKV+IFVisvgQQOX9hijP23JBuqSQPTkLmMmYSnD
Z9qWnA0QbS7j/vsXgsgk
=kH6a
-----END PGP SIGNATURE-----

--S5HS5MvDw4DmbRmb--

--===============5888276306062467246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5888276306062467246==--
