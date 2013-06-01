From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: wm8958: check for return value
 before using as array index
Date: Sat, 1 Jun 2013 19:56:12 +0100
Message-ID: <20130601185612.GH16790@sirena.org.uk>
References: <1369930931-9635-1-git-send-email-vinod.koul@intel.com>
 <1369930931-9635-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3329197156839885036=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 78180261ADF
 for <alsa-devel@alsa-project.org>; Sat,  1 Jun 2013 20:56:20 +0200 (CEST)
In-Reply-To: <1369930931-9635-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3329197156839885036==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TBNym+cBXeFsS4Vs"
Content-Disposition: inline


--TBNym+cBXeFsS4Vs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2013 at 09:52:11PM +0530, Vinod Koul wrote:
> return maybe EINVAL and needs to be checked

This is already applied...

Please also remember to CC maintainers on patches

--TBNym+cBXeFsS4Vs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRqkPJAAoJELSic+t+oim9e/MP/0DUSkLaZX157JudfRPQgW5F
4ZOUw5A2AIGNjslrwtHS8sKtsUnKqOv6oQPPudVWy73zkEsblYmiushOdxfvCXDo
AtGmoz96ZXcM9cwsgSwRcJxruVvkEc+KY7YPo53o/H7Tk/BwR6JCYFREJgB6L4gn
rkQMTnm3JXr+YvQtONYp4OXKcfDSFuIGJoI3Ep2Jv5K6reekcpRROStzno/k2U8G
0sYGceNk5kuoVFbQAIikjFHSx6zwfGWUrBhnebzugv1AOYfm4Vr9nPUE04w6flM0
bXbpE1iDz+QjCvIOcOtt6Mjbdt1F0V7RRflWdrvP0FfN/8HddQyOwidTOI7X9vAz
uigVQ3wWck7CZYACzXJGH1C8lw2rZP+uU1sBwuGgI07enhp2wioF0tcPRBFi61oW
1kuUxBlUJ/o7042qvmsBLgNU1t5eMOphe1c2YNiZ4Nhq6eu55hE0imAiOVDG0KoB
jAvT2CIevu1W+g1lWMAo61S/xb8LgbX/rM+uI3KrmjeTBkw/zaoX4FHXEOip2jII
skP0OhWoYTbyP2Ggo8XfIeX1pJe8EA2aObQAHpnXc40ArIYIlyBedUXadbUn3IDJ
vIrrPgx0vMnmjE/EZ6uYC28/JgZPOh2letdyNVG7B1DqhOMay2ngBgaVD59Fz9Vt
YV1qGUfauj4QWzl6HCk1
=jV39
-----END PGP SIGNATURE-----

--TBNym+cBXeFsS4Vs--

--===============3329197156839885036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3329197156839885036==--
