From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: overwrite DAIFMT_MASTER of
 cpu_dai->fmt
Date: Tue, 11 Mar 2014 13:25:53 +0000
Message-ID: <20140311132553.GR28112@sirena.org.uk>
References: <1394542472-16580-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mNjSOha/DCXOSUzN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1394542472-16580-1-git-send-email-Guangyu.Chen@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, moinejf@free.fr, Li.Xiubo@freescale.com, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--mNjSOha/DCXOSUzN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 11, 2014 at 08:54:32PM +0800, Nicolin Chen wrote:

Adding Jyri who's been looking at this as well but not added anyone else
working on simple-card so you might've missed his mails.

> It's pretty fair to do it for DAIFMT_INV since two dais might have differnt
> definitions in their drivers even though it'd be better to keep it same if
> we could.

No, that's not at all OK - anything that requires this is broken.  The
same DAI format should be usable by both ends of the link unless the
board itself is inverting one of the signals or something.

> Thus this patch fixes it by overwriting the DAIFMT_MASTER bit of cpu_dai->fmt
> with the one of codec_dai->fmt since we defined DAIFMT_MASTER basing on CODEC
> at the first place.

This seems closer to what I'd expect for something like this but it does
mean that any format settings on the CPU DAI will be ignored (rather
than say warning or something).  I'm not sure this is a bad thing
though, probably wants the binding documenting at least.

--mNjSOha/DCXOSUzN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHw7eAAoJELSic+t+oim9JekP/0Xpe0vQTHaXnfV/ryBhaacS
lRRAby85yvszOgAzjR3ycuCP9HtRCY8WJaAun4ziMdooo6ODz67tmAuSDUWtYAJi
j/HKC3qrn8fngmC+8TWLrjbsQOmfXd7VtPz8lD6JTWUAuoIW17amwfyoZHwEsclq
oThjnHe+zNAuJfFrHnBF1M7toH/4pyBFEg+hOYWvNsasIJ6u6+NkV6vNrr7YF7sl
B+wftFZw5LrTSbteePP6Y5n6qorI0ATD1daiKvXx+13MyoFfexRnGh4zbfofiKxN
okEiIqzqu0H2jKn5ZF8fhu1Z8N1Lf2Sv7XgsJocfv2ceYzi1B8NC61M3YbvofZQf
zZId/ToMDCD41cG2N8Srd5K1/TVSKo1aw+EcMZeozgoAoMxtRIF3Vgxj5x5yuE6x
ux5SpVJf/Ja0YkCG3dXwE8IaPomYiyD9KYDVfjC79+t0kgPveB00QNsEzdK6sB1g
R9kZfH8IGzmMFbmgfgABFVG8igUg+7ja66kxa7TUbMwKh7AtJxEMV16YtMIKf7GC
UfKPJHA/Gb+6vXPNzetP67CEVMZusUynXUuHlClGkWogzyQ5BgyzUh2vlRPf9pct
TAZ7gCvA6CMrdz8RyBrvPbztsX+RzTp3fRNTqwMR7wmO1zMeCjBeBZhPPYftHfx/
XRHIa9M+bcyqHCY/vVk1
=iGzZ
-----END PGP SIGNATURE-----

--mNjSOha/DCXOSUzN--
