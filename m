From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: ux500: Drop pinctrl sleep support
Date: Wed, 8 May 2013 13:32:25 +0100
Message-ID: <20130508123225.GK7478@sirena.org.uk>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
 <1367997261-32048-4-git-send-email-fabio.baltieri@linaro.org>
 <20130508105124.GA7478@sirena.org.uk>
 <20130508114216.GB29130@balto.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7549645182666650134=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CDEF2607BA
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 14:32:38 +0200 (CEST)
In-Reply-To: <20130508114216.GB29130@balto.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============7549645182666650134==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LR9UEBmNK407lwl9"
Content-Disposition: inline


--LR9UEBmNK407lwl9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2013 at 01:42:16PM +0200, Fabio Baltieri wrote:
> On Wed, May 08, 2013 at 11:51:24AM +0100, Mark Brown wrote:

> > I tend to agree with Lee that this looks like a bad approach - there's a
> > whole bunch of other code in there which I'd guess is probably equally
> > broken but only the pinctrl code is being removed.  Why not just fix it
> > (or better yet simplify all this stuff)?

> Sorry I did not get the subject, are you referring to other broken code
> in the ux500 driver or to pinctrl and shared pins in generals?

I'm saying that if functions like enable_msp() don't work reliably then
removing some but not all of their functionality isn't an obviously good
approach to fixing that.  Why does the other functionality work well but
not this bit?  It sounds like there's some reference counting bug here
is all...

--LR9UEBmNK407lwl9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRikXWAAoJELSic+t+oim9XZwP/2lqobpaImrY6Jxc1tg9GR+2
8bTTu+Wckvz0V5AdnPyX3/Rf+BIgn3ZQLkQOWorm9W9jdb20QFaT5IbSzDyggw9H
8ScjZShjz+gOle1/qn9VNe2o/Hyh++wwbOYyR7Kr7SL6TbDFYLu52szR+VldcByO
lo/16ICzYec1Qq+tGisXXoAWbnJx3BVMnnS/ifuz5xsdLq8VN8cIz6QvLhujiA0T
nB1j+lpJlfAfdsmWpEjzI6cWLQ0mU4USDFKr5Sl0gqeEa31LEdhqYdUUU+7Co8jR
kqJt5K1J7IMn/6yqCskE4YRz4JojYu3FN9D2dSqo5d+mcXQ8YpcGtdJefXyYL3kf
tA7mOaWbxRtbDaHnXekFkvpOhWbyEFGzqiiqWx45Sr4jThND2ja/uIMNc6z8ufp3
asKjTdxSc88sor/P+DO1IZfxHkTJln6Uc93i1v4pVLAeLao0fmKUVaM3OhCYNpBy
TbfhlVB7Cw1kcnBL325/M1rMyYQUJ7h+WtJxErmUfJ+StMlnI23MKZxMKOXxCobr
BBZ8UJF+gfgX8jAie1agHwJd7wkUW9f+mbLxDU20LB83aUY0WoXoYIjp1asmaVJt
OjV0YV6JT/PHiNUhlnqxl8h1yvWY5HJ7ZspnABX6i57Ex1pk9O4g1S+WxEv3Mf5f
Q1qQk7JY035JAmB16cQ5
=g0eS
-----END PGP SIGNATURE-----

--LR9UEBmNK407lwl9--

--===============7549645182666650134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7549645182666650134==--
