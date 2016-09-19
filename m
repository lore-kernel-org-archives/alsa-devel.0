From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: DAPM over two regmaps (and a mailbox)
Date: Mon, 19 Sep 2016 21:15:43 +0200
Message-ID: <20160919191543.GU8719@lukather>
References: <20160919105419.GK8719@lukather>
 <20160919111247.GL10189@sirena.org.uk>
 <20160919113415.GM8719@lukather>
 <CAGb2v67FSOKKREr49xkD6J6APs=sc=iVvmBJxQ4n9d2L9_oGjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5969755577370311870=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DBA826655F
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 21:15:44 +0200 (CEST)
In-Reply-To: <CAGb2v67FSOKKREr49xkD6J6APs=sc=iVvmBJxQ4n9d2L9_oGjg@mail.gmail.com>
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


--===============5969755577370311870==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4dbYIUm7Fhfg+fSv"
Content-Disposition: inline


--4dbYIUm7Fhfg+fSv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 19, 2016 at 10:56:10PM +0800, Chen-Yu Tsai wrote:
> On Mon, Sep 19, 2016 at 7:34 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Mon, Sep 19, 2016 at 12:12:47PM +0100, Mark Brown wrote:
> >> On Mon, Sep 19, 2016 at 12:54:19PM +0200, Maxime Ripard wrote:
> >>
> >> > That codec is mapped in memory, however, we have a bunch of DAPM
> >> > widgets that are mapped in a separate register space, that should
> >> > probably be exposed through a syscon (but isn't yet).
> >>
> >> Why not just represent those as a separate device?
> >
> > I don't know, this seems to be supplies to muxers, mixers, DACs, the
> > amplifier (and the amplifier volume too, even though that's not a
> > widget), and it looks really intertwinned, how would you separate
> > them?
>=20
> I asked Mark the same question a while ago. I was looking at the A31s
> codec, which is kind of a cross between A31 and A23.

We're working on the A33, that has yet another setup from the A23..

> Mark recommended using aux devices. AFAIU the codec would just
> register the DAC and ADC widgets, the digital volume control, and
> whatever digital bits there are. The analog side would be done in a
> asoc component driver, which would register all the analog widgets
> and controls. You then tie them together at the card level.

Ok. How would that work? Can you setup routes between widgets defined
in different components?

> AFAIK the digital parts and analog parts are in different power
> domains, probably to keep audio bypass working in standby mode.

I don't think we have control over those power domains though, do we?

> As for the A31s, I only got as far as implementing the regmap using
> custom read/write callbacks, and part of the register definition.
> Unfortunately I saved my work with git stash, which I accidentally
> wiped out with git reflog expire...

I guess some lessons are meant to be learned the hard way :)

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--4dbYIUm7Fhfg+fSv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4DlfAAoJEBx+YmzsjxAgBQMP/RMI4qN5iIbYtmD2tMQDhM5x
y8S3sCjNQw5xwgN3qfVRbCfTgCj3dciCYXEtT6qEJIoxrV4wL93cuuVtpF3g42sz
5KIyDbvU1Sb+N3a6VffJ939l+cTAsaw7ewxSsyYzfQFmpxogXG55N8n9pyVkUYpI
iXDehq0VR0b5appwdF50zl5HYeXyA0yMm+vRATvai7f17+Qq8CYzF/xA8rTKpjXT
sAS+iPJ1aimYYY4vU5TY8HRXr0bzePIo5lqACUyeCF0pUgtTghuuBf9iwQ/9IVLe
1927LxjZGJ6K+H7uJJIlmhZWIbMv3n5yiMt0qVMWSBfO/SRAymmVxvMuH2O7B1q8
48GgHbJteadzujMzm8SFcxGXkpySdLXBneLiegDtOqZCLrTu3e+NKicYkhs9/8Aw
fxWZFpTi+c7sdQpZpwrlzF8TkC4IQ9D+EWfCHlgfWFjchq90VWawdHYTY80up2mM
RXvx4xjBf/71FOWo44OWif3TJrRVjbHQXmQyanhZLjPvWu5o4Rh/9VaooIudcUhq
0AAOvo9ITD/GT7hLomHXgYgiWIuelJUgZEyWt2Mxdy6kDeFc0T1YaciQHvai5l7H
vtc6vrgdDTEl0Q1Dhz4uqELxqxo3zEKQ9uB0yMukI0q3ZOv1yDXneEG9A2+hvAxk
6vsadqq0RWFdypv/H+QQ
=/lll
-----END PGP SIGNATURE-----

--4dbYIUm7Fhfg+fSv--

--===============5969755577370311870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5969755577370311870==--
