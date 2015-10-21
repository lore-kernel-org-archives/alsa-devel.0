From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC PATCH] ALSA: compress: Add
 SND_AUDIOCODEC_BESPOKE'
Date: Wed, 21 Oct 2015 21:02:49 +0530
Message-ID: <20151021153248.GE27370@localhost>
References: <1445348358-23306-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <56267E4E.8010609@linux.intel.com>
 <20151020193711.GF32054@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1084662890924513502=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CA7C26067D
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 17:29:35 +0200 (CEST)
In-Reply-To: <20151020193711.GF32054@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============1084662890924513502==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9RxwyT9MtfFuvYYZ"
Content-Disposition: inline


--9RxwyT9MtfFuvYYZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2015 at 08:37:11PM +0100, Mark Brown wrote:
> On Tue, Oct 20, 2015 at 12:47:58PM -0500, Pierre-Louis Bossart wrote:

> > If you need to set parameters maybe we should also change the definitio=
n of
> > snd_enc_generic so that the reserved fields can be used for custom
> > parameters, or document that their use is permitted for this sort of ID.
>=20
> It does mean the core can't grab them but quite what the core is
> supposed to usefully do for something like this is unclear to me so...

Well in case of compressed formats, core doesn't do anything, we just act as
a transport and shove down data and information.

I do like Pierre's idea of giving some meaning to formats and use some
reserved fields, but somehow I can't think of a clean solution for this!

--=20
~Vinod

--9RxwyT9MtfFuvYYZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJ7AgAAoJEHwUBw8lI4NHDQ0P/j9OGg5C46/eQQRqa/l3EXlL
3kZfUg7hOTxrUi1xKGVMGA/7DJ4w0f0rClu5ojgJllpq4kMJs2YkrjXXM6CVscf6
8rmCZuOGVP3B7YFW3J7dFcQl4hadMsEkGGafgfTpd4q/FUcCtXsvJq0HKysDYbzf
trJA/E7yHELjlZN0SiMqq9PLoFBkeCwpKKIcMxVDS7oeGSRdp4op4nG1AgmfkqHu
8jgTSxC9eolOB0YL0+3CkiyXnAmekV8Ydf6PCYKPs0iqHN0cUBBPSB/RTlgDGHRy
ZP5VhvLmqs9H3Bh7CrujLU4CWnaX4flKCQYHKfZrbDXXWCw18oApGs49BODdWW59
SUtPoTKP1DqSoukMdHnat+yffymQueioDG05Sv0Xwh6W+UDu9Meuc/a26q+Cg7Ms
HSqf8pEP1SgbmQbDcJgwajoBpfnug8h8h1hgxIMXbB1U5sr1nOXZIpbwiKoLIBKE
Y6Q9XVEhdIsW5HK2rBGL4vpBt0wXLR7sKjwmZD0SrwV15PL7qwxFwIAgTxQzHF78
hcGiARYtwehW+uybkC9K7WqA4+rGJ0govupNgRV4B8GlJybZFg+3/OGbHjB/XQ6L
Ckw/zQX+Wx/wNqRuRckfog29qJfmqvYF+WrYjFWWoIbW3By3A6Gu1LPpF5ZxH+lV
tlz1hfiW7Xut9uGFVlTU
=Bt41
-----END PGP SIGNATURE-----

--9RxwyT9MtfFuvYYZ--

--===============1084662890924513502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1084662890924513502==--
