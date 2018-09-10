From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/16] ASoC: au1x: ac97c: use
 devm_snd_soc_register_component()
Date: Mon, 10 Sep 2018 14:59:43 +0100
Message-ID: <20180910135943.GF5856@sirena.org.uk>
References: <87sh2mruw6.wl-kuninori.morimoto.gx@renesas.com>
 <87pnxqruut.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8677608934218961462=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 565ED2676ED
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 15:59:45 +0200 (CEST)
In-Reply-To: <87pnxqruut.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============8677608934218961462==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Content-Disposition: inline


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 01:00:32AM +0000, Kuninori Morimoto wrote:

> @@ -288,8 +288,6 @@ static int au1xac97c_drvremove(struct platform_device=
 *pdev)
>  {
>  	struct au1xpsc_audio_data *ctx =3D platform_get_drvdata(pdev);
> =20
> -	snd_soc_unregister_component(&pdev->dev);
> -
>  	WR(ctx, AC97_ENABLE, EN_D);	/* clock off, disable */
> =20
>  	ac97c_workdata =3D NULL;	/* MDEV */

This will mean that instead of unregistering the component so nothing
can use the hardware then disabling the hardware we'll do things the
other way around so there's a race where we may break anything that
tries to use the driver just as we're unregistring, possibly causing the
system to hang or something depending on what happens if you try to
access the disabled IPs.

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluWeM4ACgkQJNaLcl1U
h9BywQf/Z+PEea5L427dMxXYTObggiH7ka1U55bVDWFof9L5x+DjM67qPv+4KEFX
cDmokqFBL8Bprhs7Hw945ANOGBOmRDtb5abJXzIEwOM3DPUzJHGW1GztqXj8cbso
y58dVviLw+Gi5ouiotVXnF8130+hwViCSQpqHRYO4VtyQxZXbCRWEs6LeNfypnlQ
IKmcSE1uBhbpI797uytzOzCiEcBQWAVG2JZLPhppSzzBpodzeTLDkgZiaczqFlFT
TQAqMSl4XPi8+MUY0PvI5TklwnXk0MC+w3FqCedHsYpSH+LJFHyMIq0J1b32iBfh
mWEBY/XNwWV/2AxSfKM5Ip+SRrvILw==
=pO84
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--

--===============8677608934218961462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8677608934218961462==--
