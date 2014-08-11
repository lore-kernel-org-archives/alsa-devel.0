From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Fix uninitialized variable in
 snd_soc_dapm_get_enum_double()
Date: Mon, 11 Aug 2014 19:59:28 +0100
Message-ID: <20140811185928.GL17528@sirena.org.uk>
References: <1407511775-26479-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wdme1YbLdpFkySuv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1407511775-26479-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--wdme1YbLdpFkySuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 08, 2014 at 05:29:35PM +0200, Geert Uytterhoeven wrote:
> If soc_dapm_read() fails, reg_val will be uninitialized, and bogus
> values will be written later:

Applied, thanks.

--wdme1YbLdpFkySuv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6RKNAAoJELSic+t+oim9328QAIICIThkROPRmo28+ZsC83mI
9kJKMBEqD4F7Nzh8v/kapgC8frzgRn/Uzx0prW/wNsjo3BOrYY6udrIPsL6l05ZR
jfNDPJU4AOEBCpRxgaisNth69W0aVmN2OrrKjhfa+Pefaae6yHLQee5/g5ph2Tpd
aqDNuVxpuSz0doV/XNinCnV7H557UvfGp4x/KV7srzlEFJgPsaOVojcIPzmOVQXe
nFqZbQFIffdSSlc2oWUdPlYll2SqcM/kPgFuxsc7B23C0hz/jNhfDT/Y6YoeBrKC
3mQ6q0u++lA6rNI9zE75POjzEUWjK8oI3Ra1qoEsHvVYNWSSoqdz2mT6zGrVMFmL
Z24P71k1ahKcmh0egj5opZzTdCej+Xv8JSc+rfT7YdgS2tAFEIBaaTu29MTZcmg0
9GENq7u0U/3BAhx8yo8e4lW6AFSf3br+5zPW+aJJ77WEBW6Th7KZanRX63TfkIOj
9+G5In3fEnAAEXGqaAaBXL++HLGQbYm/Fmw+Egvf4TxJox1LhDmKV8TUPRePFKEE
LaG2JwAX7B7KvtALoFQHOkhZGdFO5GwV7Srf6l7c0Y/aO1Llb+ITMBssI+AOjZnX
zHY9efjnaBuRk9MMQcURh7YmUdPsiPcAjq2rZ4HudiM6tvxJKj7wJ/ve52b1vG8t
CZTrl0HZqYBJLwNtuVXn
=loMz
-----END PGP SIGNATURE-----

--wdme1YbLdpFkySuv--
