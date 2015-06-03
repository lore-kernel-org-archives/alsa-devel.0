From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 6/6] ASoC: zx: add zx296702 hdmi codec
Date: Wed, 3 Jun 2015 12:01:23 +0100
Message-ID: <20150603110123.GB14071@sirena.org.uk>
References: <CABymUCNvM=k4tWJutpzoK-VFvKhBC4EGjh_OzWYMMRppUqvSOA@mail.gmail.com>
 <20150602181326.GB14071@sirena.org.uk>
 <CABymUCOWiHERfvw9c5ihsvgXXko1HLwv+7ectLOiQd3rGSHHPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5509132293811562315=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E860926058B
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 13:01:34 +0200 (CEST)
In-Reply-To: <CABymUCOWiHERfvw9c5ihsvgXXko1HLwv+7ectLOiQd3rGSHHPQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "wan.zhijun" <wan.zhijun@zte.com.cn>, Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============5509132293811562315==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="veZQh2nSsG1B2+Ku"
Content-Disposition: inline


--veZQh2nSsG1B2+Ku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2015 at 09:47:46AM +0800, Jun Nie wrote:
> 2015-06-03 2:13 GMT+08:00 Mark Brown <broonie@kernel.org>:
> > On Mon, Jun 01, 2015 at 09:42:34AM +0800, Jun Nie wrote:

> >> So I need implement dai link in machine audio card driver, while not
> >> use simple card and device tree initialization. In this way, I surely
> >> can embed HDMI audio codec in HDMI driver. Is that right?

> > I'm sorry, I don't entirely follow what you're saying here.

> I am guessing you suggest me to implement a ASoC board driver, like
> sound/soc/omap/omap3pandora.c. I can link HDMI codec with DAI with
> snd_soc_dai_link structure to avoid specify the connection in dts.

You can do that if you like, but it's also fine to show the link between
the S/PDIF and HDMI IPs in DT if you like.

> >> I had try to initialize audio all from dts, so need a HDMI codec dt
> >> node to connect with DAI. However, I cannot find a way to create an
> >> independent HDMI CODEC dt node because it is brought up from HDMI
> >> driver. If my above understanding is correct, a machine level DAI link
> >> shall resolve this issue with dropping simple card and DAI link in
> >> dts. Thanks for your comments!

> > If the HDMI encoder is simple I'd expect it to be possible to use it
> > with simple-card.  If it isn't then we can look at why.

> Most of devices is initialized from devicetree if not all on my board.
> So I need fill CODEC/DAI dt node for imple-card in dts. I experience
> the difficulty that I cannot create HDMI CODEC dt node. Because HDMI
> CODEC shall be part of HDMI driver and be brought up with direct call
> to snd_soc_register_codec in HDMI driver probe function per my
> understanding. Then I do not have an independent dt node for HDMI
> CODEC, thus cannot link the CODEC to DAI with dts information. Do you
> see any chance to connect a DAI to an embedded CODEC of HDMI video
> device? Thank you!

Are you saying that the HDMI IP doesn't appear in DT at all?  If the
HDMI IP appears in DT it should be possible to reference it.

--veZQh2nSsG1B2+Ku
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbt6CAAoJECTWi3JdVIfQHN0H/1sRFpgeUHcFuAjEhw4Yyfg2
r6Oue6pCdPxS6kbvuNlrdG0nVPMGNAqXz/h/0zXPRJblcIOB9xHjQoH7RSsCTveB
3mQmgznZ3odvv5tTkFpYw3FL1k5ak5J0U2y7P3Kjq3LTJllw15q8MZzz4lajRc0T
h6ydc8KzBkdgYXVNA+rDOBQHa46Wad6H2Bq90qjXKkdsCKw5xehoi0VWfm/Bp3aa
x4PvgALH2VEf5I+9gaIpvLgkN8Q7DwhoZonNoX7NI5HJ+iqaAUH1GcMG7p6CgYpn
fw9VcsDAeiYFaBlnPNlui9GUlCQQvQG7H3EkZTlB1Nd0gccxkh9XvJ3JEgxUzLM=
=P3+V
-----END PGP SIGNATURE-----

--veZQh2nSsG1B2+Ku--

--===============5509132293811562315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5509132293811562315==--
