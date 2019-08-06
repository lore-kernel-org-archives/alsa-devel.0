From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/28] ASoC: soc-core: set
 component->debugfs_root NULL
Date: Tue, 6 Aug 2019 17:22:58 +0100
Message-ID: <20190806162258.GD4527@sirena.org.uk>
References: <871rxz3x7e.wl-kuninori.morimoto.gx@renesas.com>
 <87y3072iib.wl-kuninori.morimoto.gx@renesas.com>
 <f7a47bad-b680-cbd2-2341-7be081ac4b2c@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4742733529560076660=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DF7CF800F4
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 18:23:01 +0200 (CEST)
In-Reply-To: <f7a47bad-b680-cbd2-2341-7be081ac4b2c@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============4742733529560076660==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
Content-Disposition: inline


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2019 at 09:49:20AM -0500, Pierre-Louis Bossart wrote:
> >   {
> > +	if (!component->debugfs_root)
> > +		return;

> that test is redundant, it's safe to call debugfs_remove_recursive() without
> checking the argument (done internally).

It's not completely redundant...

> >   	debugfs_remove_recursive(component->debugfs_root);
> > +	component->debugfs_root = NULL;
> >   }

...with this, the two in combination add protection against a double
free.  Not 100% sure it's worth it but I queued the patch since I
couldn't strongly convince myself it's a bad idea.

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1JqWEACgkQJNaLcl1U
h9A+9wf/ZveJix8ujFRvHR9XpYhqJK4aWlzU/QZ1KUPttRWCeGwQhSoda9nhlQut
t3oqq45QS8+bHRegkGLIfjJCU2gFaNweI/xvIvjozDrMB/fua+m4H0VMlWR+Paox
3OcgALUw5fU1bM1sWb6J7CVehXHurzV6sIF3oYmHV59hoWSDDBByHoT9m7JO1r4c
C4qoCurLKl29qB/JhRUJpYe90kulhxC7BQjRcYrI2LLmOpiVG0zO3BgN1NA/e2ht
I38Fe5XlC7MS3SSbe3deezK9/1B1wgANOX/hj+MGkwcuhHdlwFpgSjVjEYR5D+KO
Soz/Oy7jwCgX0PPAr6zY79imbjs5ig==
=z0Wv
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--

--===============4742733529560076660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4742733529560076660==--
