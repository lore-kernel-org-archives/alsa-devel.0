From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ak4642: show error if register write fails
Date: Tue, 11 Mar 2014 18:44:37 +0000
Message-ID: <20140311184437.GV28112@sirena.org.uk>
References: <1394475355-7069-1-git-send-email-ben.dooks@codethink.co.uk>
 <20140310234038.GE28112@sirena.org.uk>
 <531EF106.3020809@codethink.co.uk>
 <20140311112112.GP28112@sirena.org.uk> <531F16DB.30200@metafoo.de>
 <20140311142138.GU28112@sirena.org.uk>
 <s5heh2822dm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7853049455492147082=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C460261AB0
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 19:44:56 +0100 (CET)
In-Reply-To: <s5heh2822dm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============7853049455492147082==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3WNG/pnnEPQXt+KF"
Content-Disposition: inline


--3WNG/pnnEPQXt+KF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 11, 2014 at 04:15:01PM +0100, Takashi Iwai wrote:

> This should be decided for each case, and I agree with the usefulness
> of error logging for this particular case.  The I/O errors are
> basically exceptions, and shouldn't happen in normal operations.

Quite.

> That said, if the driver behavior depends on such lowlevel errors,
> its design is wrong, must be fixed in anyway.

Indeed, this shouldn't be something that happens in normal operation.
Usually you'd see this during board bringup if you'd got something like
I2C, regulators or reset GPIOs hooked up wrongly or missing, though you
can see things like incorrectly handled ramp or reset times triggering
it too.  By the time the system is actually in use it shouldn't happen
which is why we've not been having problems with ignoring errors.

> Still an open question is whether it should be dev_err() or
> dev_dbg().  Ideally speaking, dev_dbg() should be used, while
> dev_err() would be more practical.

I think given that it's generally a sign of substantial hardware failure
dev_err() is justified, probably the user will be noticing other issues
and it'll help a lot with root causing.  I'd guess Ben had something
like one of the situations above and needed this to figure it out.

--3WNG/pnnEPQXt+KF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTH1mSAAoJELSic+t+oim9yq4P+wVTJwtqnBhOUNrueffJnEtW
n0m4yrh1R1lILok1wTheZhowNDbPrv64VLfdd1oqKearCM+Cb7gEB+RMI4BV0zva
YUVmCt2Fa3ZJeGLRdvUTFh/tWepTTnsLO8IKbwLjqF/hM08SiEGfi31CTVyDH7Yl
OrYJlKFavMwlpB3wM8z28Zonikm/ToSKcTK57Izyk5YEAfx3ZKCejbP3BaToMxhU
WPFoJDyo5JfuHYlBcClVyrzfNFghZfordejLLTamXa0SKHI6e2M2JlCGtE8lA+Zg
wWPWlmGtfEx53ZIGpH/jKW5eOIq0mW1yYCfvXdjBocAfuogiIaSZ5gApE0yTn0Uy
J02VHpkKgQOIw9+Gi0b1KZABcPsyofGKRrNLFwzXnBWdnLwR/Zp1NralVG3Vh9iZ
xGYHQUC637qvE4c1yANPmLn3CyIxaDn4DxckQUf068MCx19L+tYjevQ6JYT2FQ4a
A/I1PnA0DymeF0kxfChVNRm35BcKOQuVTDdfi52uqna++ufjn5KQLAYQFcXeGz1c
SZJaW103L9dVJT+jx4IKLP40tEfRUsn1ndR5OrZ9hsenHd21uFMQDpwYdz/1NNKu
Q8m1zCaO/2U79KH3beqM7JpS0kLndjnDXADBLkgna8nWl/lxjNWFNS9SbtFh8EQV
AOVIv7hj+K+c9HknNkmH
=F1sv
-----END PGP SIGNATURE-----

--3WNG/pnnEPQXt+KF--

--===============7853049455492147082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7853049455492147082==--
