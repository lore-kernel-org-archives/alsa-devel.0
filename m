From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ALSA: compress: Add
 SND_AUDIOCODEC_BESPOKE
Date: Tue, 20 Oct 2015 20:37:11 +0100
Message-ID: <20151020193711.GF32054@sirena.org.uk>
References: <1445348358-23306-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <56267E4E.8010609@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3158868560433300657=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 299152604C3
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 21:37:18 +0200 (CEST)
In-Reply-To: <56267E4E.8010609@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, tiwai@suse.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============3158868560433300657==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SnG0pWpA7SYxRffL"
Content-Disposition: inline


--SnG0pWpA7SYxRffL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 20, 2015 at 12:47:58PM -0500, Pierre-Louis Bossart wrote:

> Since this is clearly an escape mechanism for a non-standard codec, maybe we
> should use an ID that's not in sequence, eg 0x00001000.

0xDEADBEEF.  Also the bikeshed should be purple :)

> If you need to set parameters maybe we should also change the definition of
> snd_enc_generic so that the reserved fields can be used for custom
> parameters, or document that their use is permitted for this sort of ID.

It does mean the core can't grab them but quite what the core is
supposed to usefully do for something like this is unclear to me so...

--SnG0pWpA7SYxRffL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJpfmAAoJECTWi3JdVIfQvAQH/ixpbiXOYMlFMiZe88Hajnu4
DWnU0sm0VmxMeTj1L9WjVck5IHoxLX3cz50CE5Ozo4j7LUHHmK/d+Y15HLmBG+Lv
aNjmhdDTmbhX0EKeezPx36jhcWuxRmYkjg5IklFbdEwId1eec7nZPCZ1FyLgX7Va
LhiwZfU1GUbxOa5Nv13ghSBtjLfYdPx3mFTKcO185XOFnzMFhTFXFKb2CzFVl0kr
BygOcJxJEetNfa9YeX7BUmBhACD4nOb128H9kiZzcmnJQGA8O09lDdWiUB1PTjMt
JiElGU7peLIuUeTUuL6TAx21JW8v9hbbjpZzeDqBknHdFmfCk1qD2IHVs3nO8TU=
=kO4a
-----END PGP SIGNATURE-----

--SnG0pWpA7SYxRffL--

--===============3158868560433300657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3158868560433300657==--
