From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/5] ASoC: add mt6351 codec driver
Date: Mon, 23 Apr 2018 12:39:08 +0100
Message-ID: <20180423113908.GC19834@sirena.org.uk>
References: <20180416003252.4177-1-kaichieh.chuang@mediatek.com>
 <20180416003252.4177-2-kaichieh.chuang@mediatek.com>
 <20180418164040.GG10061@sirena.org.uk>
 <1524268164.3290.31.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2784896682938972740=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F2FDC2675DF
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 13:39:11 +0200 (CEST)
In-Reply-To: <1524268164.3290.31.camel@mtksdaap41>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, chipeng.chang@mediatek.com, wsd_upstream@mediatek.com
List-Id: alsa-devel@alsa-project.org


--===============2784896682938972740==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 21, 2018 at 07:49:24AM +0800, KaiChieh Chuang wrote:

> > These gains should be put in TLVs rather than an enum so userspace can
> > handle them (also it should be dB not Db).  You can handle irregular
> > step sizes like these with DECLARE_TLV_DB_SCALE(), there's several
> > examples in the code already.

> We declare this enum for user space to operate on enum directly,
> unlike alsa-lib, we use tinyalsa in Android, if declared in tlv,
> the mixer control just become a integer control, which is not
> informative for user space.

Your custom userspace isn't really a factor for upstream.

> > > +	if (ucontrol->value.integer.value[0] == 0x1f)	/* reg idx for -40dB*/
> > > +		ucontrol->value.integer.value[0] = ARRAY_SIZE(dl_pga_gain) - 1;

> > Why do this rewriting?

> A little awkward gain register here,
> the range is  for 8dB ~ -10dB and -40dB, corresponding to reg index 0 ~
> 18 and 31.

> 00000: +8dB.
> 00001: +7dB.
> 10010: -10dB
> 11111: -40dB(Mute).

> and where 19 ~ 30 is not defined, and shouldn't be set.

> i think tlv not yet support this kind of gain control?

You can say there's a mute value, but gaps like that aren't easily
handled AFAIR.  You could assign vales to them (I'm guessing there
probably are some that just aren't doucmented for some reason) or...

> Maybe i'll just declare 8dB ~ -10dB for now.

...this is also common, the mixed mute and gain controls aren't always
super useful.  Depending on what goes on with pops and clicks a DAPM
autodisable control might be a good application too.

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrdxdsACgkQJNaLcl1U
h9B0CAf/fzwacihi4ov/LuMNew4/eQFtZwHbQ58HsgO+vkO7r44CsVwwkx751g7h
69oUsMc8FSMs5wVGqz8KNuUA4VNTcbQORVFqMXxuk3zsjTMwgSuEaeRuhKt6PQmA
lz7VCAXdSjSTcnIF02t3e/Q1DOhVWE1JiQjvQi+W+lSTJwRYCXbkbIHXydkGcpSt
JaS6+zuKt0ihnq8oixhcx+/Y+TjHIsBgXijv8dIihD8xXnG4xWajo5z9xvg6eg6H
jEabHdiEh0/JZlYwrAeBeCh0brOJ1E1snKNBUuND8WzFj6ozWiDwcxGsuCtAsy2B
lwe8QL7uZdHWA889oH750Z5IM9+4Vw==
=I0hL
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--

--===============2784896682938972740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2784896682938972740==--
