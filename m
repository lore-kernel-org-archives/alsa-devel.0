From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] ASoC: topology: Add topology UAPI
	header
Date: Wed, 3 Jun 2015 21:03:55 +0100
Message-ID: <20150603200355.GW14071@sirena.org.uk>
References: <1432922775-6583-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6925693609792957199=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 433DA265AFB
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 22:04:03 +0200 (CEST)
In-Reply-To: <1432922775-6583-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6925693609792957199==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5UgT1ku+qTHnlONB"
Content-Disposition: inline


--5UgT1ku+qTHnlONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2015 at 07:06:13PM +0100, Liam Girdwood wrote:
>  The ASoC topology UAPI header defines the structures
>  required to define any DSP firmware audio topology and control objects from
>  userspace.

Applied all, thanks.  I had to fix up a conflict with the DAPM topic,
please check but it was trivial.

--5UgT1ku+qTHnlONB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVb12rAAoJECTWi3JdVIfQLgcH/j0qRIqpeRWknuEq3eloKaYM
Z2SnFbLyEXGohBUgjivSUMET0pxizcbJ8FcyVjN/j/BcKxGGQTU/rrULP0ft70wC
3HCiW7kSPQbc5iJnOih/XgRuarO9SSqAR6J19F0L/ByARULAQTTjFi7Km2Lu3FyA
IXpYbGm3ShQiVJfxWqc2PXAogO69pBUx9VEmV72Va7DhaX+3yEtmnMjGeGVl6vEn
/TM6x+NirAVunaqiDlq6bBw4++50D7zKXdeRrZekrWopl+/fmbZNu/QxRPE/zCou
muRZ74Ynx92mazxZO0zDs9RgQg7Q1N/L8ANIA1bwInZPD0CzxEiWyhn4c2hW1BA=
=BsiJ
-----END PGP SIGNATURE-----

--5UgT1ku+qTHnlONB--

--===============6925693609792957199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6925693609792957199==--
