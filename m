From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: zx: Add ZTE zx296702 pcm
	support
Date: Thu, 21 May 2015 21:04:42 +0100
Message-ID: <20150521200442.GE21577@sirena.org.uk>
References: <1430915885-30656-1-git-send-email-jun.nie@linaro.org>
 <CABymUCNRH13mO0xXBB6tAZokxWhZFE5CxURxpNgoVs+enU240w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2623064144022693120=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A3FF4265870
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 22:05:02 +0200 (CEST)
In-Reply-To: <CABymUCNRH13mO0xXBB6tAZokxWhZFE5CxURxpNgoVs+enU240w@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, "wan.zhijun" <wan.zhijun@zte.com.cn>, Liam Girdwood <lgirdwood@gmail.com>, ZTE-LT Mailman List <zte-lt@lists.linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============2623064144022693120==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bGD25dtqTBkDy1zG"
Content-Disposition: inline


--bGD25dtqTBkDy1zG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2015 at 04:04:30PM +0800, Jun Nie wrote:
> 2015-05-06 20:38 GMT+08:00 Jun Nie <jun.nie@linaro.org>:

> Do you have any comments on this patch set? Or you suggest to add HDMI

Please don't send pings, they just add to the mail volume.

> API calling in the same serial patch? For the HDMI calling, I have no
> good idea except direct call currently. Because I need dts hook to
> audio driver, while no HDMI call back data can be shared from video
> side to audio side in this independent initialization case.

My previous suggestion was to have a CODEC driver for the HDMI IP - I'm
not sure why that would require a "direct call"?

--bGD25dtqTBkDy1zG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXjpZAAoJECTWi3JdVIfQxUoH/ju3Hn3Iwk9iiVX3FBblgLMl
gFSs4l4nV1jwaYde7vClmeBt2j6jlxWxiUqtUc9uB98i/SWyKhayIUv1Oy6irfgs
4XjX7InJmXc6pdyE7APqxwcuheSHvjrUfWiZT/9JzlLFMlqsLdmYCj+yHlRDD3ZX
ESIb7dLjdy40OQpv1F+1gZSqzJtkVx6NeR80Jt+TB+wZFXntfANyir1PUducAXJU
Dgxg2GJrzQpxp2aHkK1T06Wr5dqQ0kqlbBJKkauA6J2+Bm7VR8EEkCou7igFKM6z
oqIGfQT/JZh1qL1QWcYCWr6He0lpb+Vtu0XTrpDu8IH2wmMsMHcX2diStJ9bCmo=
=PpOR
-----END PGP SIGNATURE-----

--bGD25dtqTBkDy1zG--

--===============2623064144022693120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2623064144022693120==--
