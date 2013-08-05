From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8994: Fix class W controls
Date: Mon, 5 Aug 2013 21:28:04 +0100
Message-ID: <20130805202804.GA26637@sirena.org.uk>
References: <1375732994-19029-1-git-send-email-broonie@kernel.org>
 <52000743.7060700@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3161007065159471569=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A4B2265213
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 22:28:07 +0200 (CEST)
In-Reply-To: <52000743.7060700@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3161007065159471569==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2013 at 10:12:51PM +0200, Lars-Peter Clausen wrote:

> Hm, right. But I think it should be enough to just replace the
> snd_soc_get_volsw with snd_soc_dapm_get_volsw

Yes, that should work too.

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAArQAAoJELSic+t+oim9go8P/2HWjvyFLaUg3ewkoCCP7KS3
/2rulMJpQoiftjc3f2MZUMrYMLovqEQVbHLSlpsK0IeLyV1JX6Kg8u+m6qieRdPF
QnZU9jl2ssibf8uLYDT+7NTQe+5vCJWMMeig1YbokcaJP++35uHtS/ugCrnM6zd+
8vWJQQ8M9Oxv2eilxCAQJvOs1OUtro509uh1VncCo57j33+sbaqaD/BxDezPK4Kf
fEZJQn2+wOGzTNVNzRVnUmiEl+vMrdVHFdmlMjzEIlbye0TMNRkbTPR03ogkHZvv
rJWubV4pQZjTk3rAoijFszwvmNWBz3yVg3TAdJPGvRMOAFIJxxGP6kP/VpfDg9zv
2872Ggb5QLBsyb36RJXUEzgCTEizmVxdQtyyvOCASwmc6JaPWpgIqznEg/qrUcyK
66sfM1XacjJuN2IR8ogVLUnto4zC4RU4kt02u1CMHTpzrv1rHMRzzssFSIXk/GT6
KrIHlm5bFE49kuhZACecyltE1kiMkh/maGfKI1FRiOgjyMXbJyhiSeUKZxQeenN9
Cj1j7bEzEEMyOZYyrpxwc69yVcAts+3bDO7eDkweb2TupsgahRNtpr9dYKXlmKVY
sojxoJs6vJdwYImACgyQhcl6EUKeu3GHVThqhEbl9Tf+21J2YWtuHPI3XjUpnALb
r24y6OIoD5ytLSdwDAeO
=2KUX
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--

--===============3161007065159471569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3161007065159471569==--
