From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: sh: fsi: add fsi-codec card
	support
Date: Tue, 3 Apr 2012 13:36:39 +0100
Message-ID: <20120403123639.GE3192@opensource.wolfsonmicro.com>
References: <874nt2aphw.wl%kuninori.morimoto.gx@renesas.com>
	<87398mapg7.wl%kuninori.morimoto.gx@renesas.com>
	<20120402213928.GD3160@opensource.wolfsonmicro.com>
	<878vidk6x6.wl%kuninori.morimoto.gx@renesas.com>
	<8762dhk207.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8039477328564600010=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AA3012452A
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Apr 2012 14:36:43 +0200 (CEST)
In-Reply-To: <8762dhk207.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Rafael <rjw@sisk.pl>, Linux-ALSA <alsa-devel@alsa-project.org>, Paul Mundt <lethal@linux-sh.org>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8039477328564600010==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Content-Disposition: inline


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 02, 2012 at 07:01:00PM -0700, Kuninori Morimoto wrote:

> > > I'd expect that these should always be the same, it's probably as well
> > > to just have one format and then require anyone who wants anything
> > > unusual to handle it.

> This codec_fmt/cpu_fmt is not only audio formats.
> It selects clock master / signal inversions...
> These are depend on platform.

Right, they should be configured by the platform - it's just that if
they are configured I'd expect them to be the same for both ends of the
link.

> And, FSI can use SPDIF format (it doesn't have SND_SOC_DAIFMT_xxx format).

For this case we should just be able to handle having no format
specified by the platform I think?

> This is a little bit complex...
> but is it OK ?

I think we should be able to avoid having a CODEC or CPU specific format
at all.

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPeu7QAAoJEBus8iNuMP3dfYMP/31XuRLr5d4vaIvbj4yVGteU
yqR6zTEMqcNFNur4yoDA/jKxCcKJCmbhGydG1ycRNBHxr8Gdys3yljYFxhqaoQIO
jWDsAksDpBLJ+4Q5NcmzfnM7usopf42JXFx2GssUjaOJ61n/QC1N7Z7BUWlCFE2l
ov7xVouU7EsI8oZR9TUA8933oSOkaFgY1pJifJdy10fyFWajJrxV5gnTg0QUXI3O
i0bJDMpdCMWy+S/ckgvam4zOezJwsX1Qtc/F4QJR3m9+tjCsuyu+gA5PYK7de8Pd
vRfZ4Gjm9rKPe5lsbuzvKM7i67xJrHgzSm5eG71DooX8/0Pe6Ntt3MPelTwfTnDM
IYWxVW0rpvWCZdq8IweW0WMYEmWYhznJ6xy57Hv19MfmqYWjEyoXjXS7rlz7zm8a
XbIgD0X8fv8LUXEcuD1IY4N0ztIwXmzJztNRBf1woaDHpeN0EZAnnCWpUCBn8N7C
vRa420pEd+U4W670aCzO8BI8rQiTgcrn9akPBbsSx4lIM42IgD7RjjTRiDqYYK/z
QnbGJyEodlxLHjFvHFmWWwDaDkz0Cj9w+0VoYZ4miW0u3HrN4AODjtbHuRa4trLy
7kTw4jrBP7Oq5dkcStx7CA0hW+aYygq4ahH0gmPyCTGMegAdNgTESeH5OkZQNAHi
/tKqYX256gV7dP0Gc12l
=VmWl
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--

--===============8039477328564600010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8039477328564600010==--
