From: Mark Brown <broonie@kernel.org>
Subject: Re: DPCM: skip DAPM_STREAM_STOP event to BE,
 if still used by other FE
Date: Wed, 29 Jun 2016 20:08:16 +0100
Message-ID: <20160629190816.GS6247@sirena.org.uk>
References: <1465109939.29781.2.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2595212733881556902=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 33A482652C2
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2016 14:15:59 +0200 (CEST)
In-Reply-To: <1465109939.29781.2.camel@mtkswgap22>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, chipeng.chang@mediatek.com
List-Id: alsa-devel@alsa-project.org


--===============2595212733881556902==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kVhvBuyIzNBvw9vr"
Content-Disposition: inline


--kVhvBuyIzNBvw9vr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 05, 2016 at 02:58:59PM +0800, Kai Chieh Chuang wrote:

> The BE receiving SND_SOC_DAPM_STREAM_STOP event, while still used by a
> FE who is in STREAM_START state. The DAPM will just inactive BE related
> widget/dai without checking. This just doesn't seems right.

Why not?  The backend is still active and running, why would it expect
to be stopped unless it's supposed to actually stop?

> Actually, i trace the log, when one of the FE sent stop event to "still
> in use BE", the BE power state will not be changed. Until the system

Sure, until all the users stop using it it should stay running.  What
would you expect it to do?

--kVhvBuyIzNBvw9vr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdByfAAoJECTWi3JdVIfQC78IAIY2GlB8ibplEkDPU/EbgtbR
1kZ81GG6cvIbA8kycyZzvbEcXI9AifJXNqB61jOGdG2voxmNUmcs9KfHIqsWP3W1
HDQ9n0lB3TXAtqQ6xvP1885PD14Ni8HCsT//IxGT969Epmo6U6qOeleIwC1VR0rZ
UUVCNT2wbRXqrB/pSuEPifr/nXNXgGYg9Mo/TG8AhTzQD/Vd8PKI/ubr9XxmcxrC
yM4F9mZI3EY5Ay23lYEw+oNDqYL5wQOvOCmWNvV2L8pYqZ+sZ1ojslxyvvfEzQ1j
OJfTvZLX1nSiAZYpEYyti1ITMJ8GoES1N3tcRASWZxUMPFkiRsFiYhudYHzIv10=
=uiUL
-----END PGP SIGNATURE-----

--kVhvBuyIzNBvw9vr--

--===============2595212733881556902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2595212733881556902==--
