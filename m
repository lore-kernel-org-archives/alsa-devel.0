From: Mark Brown <broonie@kernel.org>
Subject: Re: Question about patch ASoC: Prevent components from
 being bound to multiple cards
Date: Fri, 2 Oct 2015 15:48:31 +0100
Message-ID: <20151002144831.GQ12635@sirena.org.uk>
References: <s5hlhcfd5az.wl-tiwai@suse.de>
 <20150909145158.GK9751@sirena.org.uk>
 <s5hh9n3d4bk.wl-tiwai@suse.de> <55F04AA1.3030607@metafoo.de>
 <1443782064.10151.28.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3574921164653002429=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF35E2612AC
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 16:48:46 +0200 (CEST)
In-Reply-To: <1443782064.10151.28.camel@mtksdaap41>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Koro Chen <koro.chen@mediatek.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============3574921164653002429==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7kD9y3RnPUgTZee0"
Content-Disposition: inline


--7kD9y3RnPUgTZee0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 02, 2015 at 06:34:24PM +0800, Koro Chen wrote:

> I have two cards originally but the second one failed because of the
> patch ASoC: Prevent components from being bound to multiple cards.

> My configuration is like this:
> card0: use platform's DAI component A
> card1: use the same platform's DAI component B

What do you mean by "DAI component" here?  It's not a term I'm familiar
with...

--7kD9y3RnPUgTZee0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDpk+AAoJECTWi3JdVIfQjYwIAIUeGnLADJGHN4W/64/3XPQB
/Wr0R4UPJxxhEijT65JXUqrMFOCpoNqmgyMFLoZma/pw8iy5GwykoRwiluFhsXo6
AUmWZB7hPk5tczAEb2lDXnxLU46ik2kiKvK87stfOWKSPPz6XhFe8WgLCU4I/YIS
6c55j53ITJzumWyZHWrgSkqsUkkrhHeqaBcp5PTtMao9L0J3VJLUnxixqRqPc5kl
ti8sI9ISfj8teXTX50hKI5UI+irzbIg7s6y1QnUxC8AiCRFb9dcRwY09INkR2NF4
3EobAbSOhBvEuvhnklCOHsb8Rn55P6zCQYT/+o99VVsp5x0oae4XfGNwZ/SKRpY=
=u6Rl
-----END PGP SIGNATURE-----

--7kD9y3RnPUgTZee0--

--===============3574921164653002429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3574921164653002429==--
