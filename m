From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: DAPM over two regmaps (and a mailbox)
Date: Tue, 20 Sep 2016 08:41:02 +0200
Message-ID: <20160920064102.GY8719@lukather>
References: <20160919105419.GK8719@lukather>
 <20160919111247.GL10189@sirena.org.uk>
 <20160919113415.GM8719@lukather>
 <CAGb2v67FSOKKREr49xkD6J6APs=sc=iVvmBJxQ4n9d2L9_oGjg@mail.gmail.com>
 <20160919191543.GU8719@lukather>
 <CAGb2v65qARPr1cEL5oU6bsiwK61rFQx4Gma=Z0r8DK5WTBOnmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2705797806932122940=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AD8226673B
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 17:46:05 +0200 (CEST)
In-Reply-To: <CAGb2v65qARPr1cEL5oU6bsiwK61rFQx4Gma=Z0r8DK5WTBOnmA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Mylene Josserand <mylene.josserand@free-electrons.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2705797806932122940==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BEfR2jmXRHrz4elx"
Content-Disposition: inline


--BEfR2jmXRHrz4elx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 20, 2016 at 08:32:50AM +0800, Chen-Yu Tsai wrote:
> On Tue, Sep 20, 2016 at 3:15 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Mon, Sep 19, 2016 at 10:56:10PM +0800, Chen-Yu Tsai wrote:
> >> On Mon, Sep 19, 2016 at 7:34 PM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > On Mon, Sep 19, 2016 at 12:12:47PM +0100, Mark Brown wrote:
> >> >> On Mon, Sep 19, 2016 at 12:54:19PM +0200, Maxime Ripard wrote:
> >> >>
> >> >> > That codec is mapped in memory, however, we have a bunch of DAPM
> >> >> > widgets that are mapped in a separate register space, that should
> >> >> > probably be exposed through a syscon (but isn't yet).
> >> >>
> >> >> Why not just represent those as a separate device?
> >> >
> >> > I don't know, this seems to be supplies to muxers, mixers, DACs, the
> >> > amplifier (and the amplifier volume too, even though that's not a
> >> > widget), and it looks really intertwinned, how would you separate
> >> > them?
> >>
> >> I asked Mark the same question a while ago. I was looking at the A31s
> >> codec, which is kind of a cross between A31 and A23.
> >
> > We're working on the A33, that has yet another setup from the A23..
>=20
> Looks like the "analog control" bits are similar, if not completely
> the same. As described on page 221, the bits are accessed through a
> mapping mechanism in register 0x01f015c0.

Yes, we've seen that too.

> So the solution would likely be the same for A31s/A23/A33: a platform
> device/driver for that particular piece of hardware that registers a
> custom regmap and an ASoC component. This would be under the PRCM
> mfd. The main codec would list this (I think it's by name?) under
> it's aux_components.
>
> >> Mark recommended using aux devices. AFAIU the codec would just
> >> register the DAC and ADC widgets, the digital volume control, and
> >> whatever digital bits there are. The analog side would be done in a
> >> asoc component driver, which would register all the analog widgets
> >> and controls. You then tie them together at the card level.
> >
> > Ok. How would that work? Can you setup routes between widgets defined
> > in different components?
>=20
> Indeed you can. I think that is what the ASoC card is for, to stitch
> up various components. Not sure if you can directly use widgets from
> aux components in the codec component driver though. I guess it depends
> on the probe/binding sequence.

I didn't know about the aux_devs, but yeah, it definitely looks like
the proper solution.

We'll work on that.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--BEfR2jmXRHrz4elx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4Nn+AAoJEBx+YmzsjxAggYEQALMAKWf1cqlbn+T03IcbuslY
r3dyDs+2wr0Vif0RxG8LXK9ZPXNlP2/lP5ByrXVkooTGbZ/7LGXPFBsnaQZrdRMg
JDkFObpOg9U/hbjZ97a/o2vgzuontigOOWjUlhrBHuyRakGvFWq5SAfpYqYaNJoP
K8C9zmJtqVWAzHQT2kfFoRWs3TPNLHvh8wjHoGKX3i98lUqg0XccYOwnU6DodELT
FtbstgyhnUPjc1b8o5NqIvbPLqq43IneOmxYtA3v1MmaGGAOwEvbcEnBjrqd4gRl
GXjpgQ0gpYHxtUxwZSKypz4OfgSOTX99Cd2ayNcIA1v/cXkBfovdfSHkNNUAMFre
Yt9WJPklUfsb5yIhH2v0aYd+JCrCddbJZJZo2GL5dsO6yd6HEwoL/H4Y5prnVys3
p3yIaTBZLR2WqhFFA8sFAsVbiGXEWhG44pUHJfjZrtoZUwfIBjO/DuWBB2kKaY/k
POlTf14kWAZzl1AdO62ikbGbfeyhiCububVpOVsIGA5GKVMhOQ69qItxvfJMoNGV
tjkGRGia8GnQuHjiph0tTPJF2qzdW8rgxjoJDzF7tufBrl1eNVcFa7LgH0swBZUs
s/Nfv1E57zKCrt9BNnaU4QWxyMPwQheJPJE3eauAjtCfx6u0Lv3yb3BQ5Zri5ebN
3sgW/7TsNysueOWW87KM
=A/MV
-----END PGP SIGNATURE-----

--BEfR2jmXRHrz4elx--

--===============2705797806932122940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2705797806932122940==--
