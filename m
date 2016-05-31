From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: cs53l30: Add support for Cirrus
 Logic CS53L30
Date: Tue, 31 May 2016 18:35:05 +0100
Message-ID: <20160531173505.GI29837@sirena.org.uk>
References: <1458082066-2859-1-git-send-email-tim.howe@cirrus.com>
 <20160517234333.GB29471@Asurada-Nvidia>
 <20160531165358.GH29837@sirena.org.uk>
 <CAG5mAdw-gh2_ZQ17h3HS=pMZaW-bGhoKgNDz_hbwzw2rBKs8ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7768230431913732740=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BF90265EB0
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 19:35:13 +0200 (CEST)
In-Reply-To: <CAG5mAdw-gh2_ZQ17h3HS=pMZaW-bGhoKgNDz_hbwzw2rBKs8ig@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, paul.handrigan@cirrus.com, "Howe,
 Tim" <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============7768230431913732740==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tgQ0jN0vM+YIGDGO"
Content-Disposition: inline


--tgQ0jN0vM+YIGDGO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 31, 2016 at 10:10:11AM -0700, Caleb Crome wrote:
> On Tue, May 31, 2016 at 9:53 AM, Mark Brown <broonie@kernel.org> wrote:

> > That's a really rare thing to have as an option, most things either do
> > TDM or parallel data signals but not both.

> Interesting comment.  While I'm sure that's true for the moment,
> microphone arrays are changing this quickly.  I fall into the oddball
> category that the main chips I use are the TLV320AIC34 and CS53L30,
> and both of them can switch between TDM mode or dual I2S mode for 4
> channel support.

I'm not sure why mic arrays would drive that, it's not like they're
particularly new or innovative technology here and multi channel output
has been even more widely available for a long time?

> Since I need to get many channels on board, and SoCs (except for TI)
> rarely have enough parallel I2S ports for mic arrays, I opt for TDM
> mode often.

Modern systems all use TDM for the most part, the usage of parallel
data lines that I've seen has been for surround sound applications where
a 5.1 or 7.1 decoder will often be built by taking a bunch of high end
stereo CODECs and wiring them up in parallel, partly for performance and
physical design reasons and partly because such system designs have
often had their roots in very old systems.

This also matches the trend with more modern SoCs to use programmable
serial ports rather than dedicated I2S controllers so TDM is very easy
to configure, and of course it's fewer signals so it's easier from a
board design point of view too.

--tgQ0jN0vM+YIGDGO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTctHAAoJECTWi3JdVIfQ0coH/0ublotqWDHQfxgzhLX14ti9
UXynOhoOf65XCgQ+t2+81e7j7wAjRY5coPdRAajrOUrrDujk+wtcNKvYvZH8Wss4
lqFptFTtxXf2/3eWxrgf9c8wKCCZUYw7n7oM1bU8MjKEiPPjMemODnAPuaV008j/
KWjapFeF5Bmdu5hmfChFgWTFYUdk9KEKzkXCheUWuwLnhsavHteYf9S5S8qktDUe
nUN3vAm9VEOVg6huU8q+5vI8V+w8zZqVtKSc9/2dM+IJNAIvMh7We8NkTEiQ3NXj
/JRhGF+R2SaCXNWjqwJkfT8axPkIrbYONYEEcBSJVcxB1km3RCVMOUE8tPiboq4=
=8bsp
-----END PGP SIGNATURE-----

--tgQ0jN0vM+YIGDGO--

--===============7768230431913732740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7768230431913732740==--
