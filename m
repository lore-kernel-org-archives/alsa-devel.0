From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: fix interrupt fails and
 unstable after resume
Date: Tue, 1 Mar 2016 12:26:23 +0900
Message-ID: <20160301032623.GH18327@sirena.org.uk>
References: <1456686105-6885-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4279709963625154702=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 07D2A2664F5
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 04:27:11 +0100 (CET)
In-Reply-To: <1456686105-6885-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4279709963625154702==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wuDpG01jy+i78xzF"
Content-Disposition: inline


--wuDpG01jy+i78xzF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 29, 2016 at 03:01:45AM +0800, John Hsu wrote:

> +static int nau8825_resume_setup(struct nau8825 *nau8825)
> +{

I'd expect to see this shared with initial power on?

>  	regcache_cache_only(nau8825->regmap, false);
> -	regcache_sync(nau8825->regmap);
> -	enable_irq(client->irq);
> +	enable_irq(nau8825->irq);

We're removing the register cache sync here but I don't see us adding it
anywhere else.

--wuDpG01jy+i78xzF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1QvdAAoJECTWi3JdVIfQwScH/iHh2zvYTt1nkw2NfnblDZtm
rD9WnEq5WqTaZ9lXGX9nN2Fb9781SVLn2HGzjIjpeuaiXP2iRQblfmkQ7Udckwbt
dWTU/iEboX3xMpODVwjJsWK1FS8DwrEfglWGigxJfalJ/xhisSD6E/W4lVESH1WR
gCy/s62FpcI+D5w8IxgAnq2I59AWD1aFUblqLxxHXFzteFX4QC8z/ygf19ZD6BJO
Jqi/d9SycmGu88MYYgj9KoWgMifSuTmnBPqcpE4JjxgaiW77ldAA3/ANmBlo6Slk
prbBOJ5pgOHKD34fNc9760zh5Vf5XvghQa6io3rqsI0TCNVU96S44YdRdI+wIl8=
=o/4Z
-----END PGP SIGNATURE-----

--wuDpG01jy+i78xzF--

--===============4279709963625154702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4279709963625154702==--
