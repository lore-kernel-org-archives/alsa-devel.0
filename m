From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ARM: kirkwood: extend the kirkwood i2s
 driver for DT usage
Date: Tue, 23 Jul 2013 18:04:07 +0100
Message-ID: <20130723170407.GI9858@sirena.org.uk>
References: <20130723104615.3696f1a9@armhf>
 <20130723123444.GW9858@sirena.org.uk> <51EE7E1A.3040301@gmail.com>
 <20130723132016.GC9858@sirena.org.uk> <51EE8591.7060005@gmail.com>
 <20130723135000.GW24642@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5935545024299966527=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E2FEA26513B
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 19:04:10 +0200 (CEST)
In-Reply-To: <20130723135000.GW24642@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org, devicetree-discuss@vger.kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5935545024299966527==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIW0mBdZQbss59/X"
Content-Disposition: inline


--WIW0mBdZQbss59/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2013 at 02:50:00PM +0100, Russell King - ARM Linux wrote:

> Not only that, but the lack of assistance from ASoC people on the
> multiple substream stuff really doesn't help one iota when it comes to
> making forward progress with SPDIF support.  I've explained to them the

It'd probably help if the people looking at this hardware started to
contribute some of the work that's being done here; this should help
move things forward by looking at concrete code rather than the very
general discussion that's happening at the minute.

> problem (SPDIF and I2S if used together must be enabled simultaneously
> or only one is permitted at any one time); they've suggested using the
> multiple PCM substream support, and then it's a case that "oh it's
> undocumented" "oh there's no examples yet".

As previously mentioned the OMAP4 and Qualcomm stuff is there, it's just
out of tree - there's also Haswell but I'm not sure if that's been made
public yet (Liam?).

> And then there's the problem of understanding the ASoC DAPM stuff
> "oh it's just a graph walk, you don't need to know the internals"
> is what I get from ASoC people.  Well, yes I do need to know the
> internals, so I can find out whether it's going to startup a second
> substream while a first one is active, and end up with SPDIF enabled
> non-concurrently with I2S.

As ever the answer is that DAPM will enable any connected audio path and
not enable other ones so it is possible to enable only one of multiple
paths (as you'd expect, really).

Can you be more specific about the problems you're having following the
code?  It should be relatively simple to trace through what's going on
=66rom dapm_power_widgets()...

--WIW0mBdZQbss59/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7reEAAoJELSic+t+oim923IQAIxzJ5uZKmJyoRsdvt5v4mvU
HWKkf6ajR8OkHmJAKh4x/lsGcr/tDhNK539Ya9MIIa8n/vn1MI2SPYXM0xrHJOfH
ZI71QxaIkcgyWMpat0hNzzU8Guu80mNc8lcfzdlBNFyCd5HQb+Fouq6xmGIaCGAM
85zSZXaWI0T4hvJV6DT/rT52wMSBalbYT3tkbuaXobm/tO5UDAtzdkfYVeJl+KsV
kTnoHKrJnN8ZlUmF+uqvgbkebHlMhiKAS4wP+2SyzeURPpv37s7sxAP6ZNRkSuhl
ysuIb+wgPT24xjeAjAaFb+D2wTdSWVc7EuU4NMlUAtmLeJImb9nVcWdp+fIqGfaG
oEjgCc/k4qzmsZFl+oie1R87fSIJ86YXC+ZGGsB8n+esqD5k+t+iMoM3jjv62hgi
9n2nNvyTrD+qq83mkpQ4H0tqjPXZPu1lcsZjORc13H4+7UEBGErx2RrfCf3pTVXf
aGxU6dcYUvfDP115CkPn//IrTGy/FmQO1LV6hxiw1tMvJgsRe/ODudgFHEiM5kVX
e05mZQRIfZriD9qpmCTO048ItK7CgR0/R6R4CEaNehndFewMv4kV1u+NeADwbaux
xPPtKjIFk2GDjNtyKfNWu7bBU91Qvb0Cu2tNC7y12RnnbfbHwWSzi6WjB2wR1fgs
xJoKvdTgNTwwle7SQjZP
=lXrC
-----END PGP SIGNATURE-----

--WIW0mBdZQbss59/X--

--===============5935545024299966527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5935545024299966527==--
