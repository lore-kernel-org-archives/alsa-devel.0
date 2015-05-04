From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6] ASoC: rt5645: add device tree support
Date: Mon, 4 May 2015 12:59:07 +0100
Message-ID: <20150504115907.GG15510@sirena.org.uk>
References: <1430389127-24609-1-git-send-email-bardliao@realtek.com>
 <1430389127-24609-4-git-send-email-bardliao@realtek.com>
 <20150501163247.GC22845@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D701066F9B@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0914681792661375746=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DDD4260586
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 15:16:24 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D701066F9B@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============0914681792661375746==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UKNXkkdQCYZ6W5l3"
Content-Disposition: inline


--UKNXkkdQCYZ6W5l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2015 at 05:21:59AM +0000, Bard Liao wrote:

> > > +  Boolean. Indicate if codec IRQ is used or not. It is usually used
> > > +for JD
> > > +  and/or headset button detection.

> > I'm not sure I understand what this is for?  I'd expect that the interrupt
> > would be used if specified, though if a GPIO is specified I guess that'd
> > override it.

> It is for codec IRQ though it is called en-jd-func. rt5645 IRQ is not
> for JD only but also other functions (like button detection). Another
> thing is that a separate CPU pin is used for JD IRQ in some HW
> design. It means some HW design use their own JD function. That's
> what hp-det-gpio for.

I'm still not clear here - why is there a need for a separate flag over
just specifying the additional GPIO/interrupt to use for this function?

--UKNXkkdQCYZ6W5l3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR18KAAoJECTWi3JdVIfQ69gH/RQmUF+l+QuZliSW6GCTKuRR
oKScTMWzx+Hff/CmYi8oIsG6l6jc/VPS5nLVZ8rU7GegV/woyZZmW3GsMUaXkFGk
qSacw8IcBbnovl4tM4ZPYM98zKickQLztRDPSyOYJ5Nw8AnXJdaxk2Eqcb72frLr
p5cyP6BnXa5r/RkCHEE2XoCmf7AOjciaAmOrdY9mkvUYEwtkkNBIwSgKyXh+8c/P
0WhTdHiuJM4kAoBefwUQgkX3DvjHFQGddrhSdZJKDA4bunYKvHUUtctzK0Ct3vTe
vub9DXhvWPNu6DOCQhETSYgxtsqqSiPtls80jr+Q6Q5k/M0yzuItkNAkkuXqlAk=
=RKFH
-----END PGP SIGNATURE-----

--UKNXkkdQCYZ6W5l3--

--===============0914681792661375746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0914681792661375746==--
