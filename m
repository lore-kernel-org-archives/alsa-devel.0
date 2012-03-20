From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
	protection mode
Date: Tue, 20 Mar 2012 17:04:46 +0000
Message-ID: <20120320170444.GA6938@opensource.wolfsonmicro.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
	<20120320160154.GI3445@opensource.wolfsonmicro.com>
	<CANOLnOPjqbeEbSDUHokkGRUa7KwJ-+hAczWSmQ3LEccCh9-c7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2332031456868797943=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A599D24149
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 18:04:49 +0100 (CET)
In-Reply-To: <CANOLnOPjqbeEbSDUHokkGRUa7KwJ-+hAczWSmQ3LEccCh9-c7w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============2332031456868797943==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 20, 2012 at 06:15:34PM +0200, Grazvydas Ignotas wrote:
> On Tue, Mar 20, 2012 at 6:01 PM, Mark Brown

> > though this should probably have the note about working around broken
> > applications from the cover letter in the changelog as with the
> > changelog alone it's really not apparent why we're doing this here as a
> > driver specific thing.

> I wouldn't really call them broken, it's enough to set period size to
> 512 with smaller start_threshold (something like 50ms) to have
> problems, those parameters are perfectly valid for a program trying to
> achieve low latency.

If they can't cope with the parameters they've set I'd call them broken,
they should've asked for more sensible parameters.

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaLikAAoJEBus8iNuMP3d750P/2iF1excocA+OE+b1N3sU5cS
gJP4zMhwyQGQYY87XF17cSswS0u/nvYLftCZ9f3RCCdMyrLXd0OX8l2zijLgRGP6
7sMXDczaUozVuOP/PY+vELoPUUfMvBy5zImoM0QPgt6PF7mobTFREM9moV/r5vIa
0AiYYZPJtD1a7RZ5o2qHVEd2JHwNMoxUZSoIE3Yejsw4HaPgPVCaoZ7JGtKt9YtC
nRsqdWqhGpY+ZuECjp7IP6s7BzaFX96016FVTyxPr6AeMi52oNxgw9YbF7SJn0bx
28oc+sRW7vfEwpg4vO/8xvGYKJMSZg/+HB/v31I+T8QCxYXafNur1bJ1wniUnfPP
9edww3LZWK/X/BQj72KNXWVNDIPr8Vcr2OsfxbNetGYRURa3imy7rjkWxPmcfHIy
VbCJpUsLsEC3ycn60oSA5VJfgzFYbjJAqHO8mrQG6PnajCSlOnc1fhIrAgm3QmiF
M/N/90HNB1cAZIoiV1LLr1DlmsPM+NKTrz9QlYmRbaKCicA6GQi788FEi/Lg+FlS
z2JqDfxFvYZL0hCxoIvmku7ucx9o4PVZ0dNXCTLF4lAIVEuGz7Qt3Rc1tSuzeVAy
Wfj0fa2IWdsPVhpwrNCeWPHIxQmbgcon+342qwtcSUbOxYKjc/RbQv2R1rGlWz0W
ifs+f6CZRCeOpssYhpB2
=lPNS
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--

--===============2332031456868797943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2332031456868797943==--
