From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: blackfin: Fix missing break
Date: Wed, 13 Nov 2013 16:47:15 +0000
Message-ID: <20131113164715.GX878@sirena.org.uk>
References: <1384359300-21219-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5286617299710990963=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E170E264FFF
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 17:47:20 +0100 (CET)
In-Reply-To: <1384359300-21219-1-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5286617299710990963==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IfhPODtivl1BCmut"
Content-Disposition: inline


--IfhPODtivl1BCmut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2013 at 05:15:00PM +0100, Takashi Iwai wrote:
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=60768
> Fixes: 4b2ffc205cb9 ('ASoC: Blackfin I2S: add 8-bit sample support')
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Applied, though if you're going to include quite that many tags you
should probably be including something human readable as well.  At first
glance this looked like something sent by mistake.  This is partly
because of the bugzilla tag which is a bit of an innovation, it's only
been used by a few graphics things (and probably ought to have a
matching Reported-by if it is ever used).

--IfhPODtivl1BCmut
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSg60QAAoJELSic+t+oim98tkP/iV+3FDzlQpETaHohCwriABN
DXyePLLyhv5CPA3pXVFamJzBx1bBb8S2U6X8MxD8VWpEwNn6P8ndojKv6loM1Gqo
8o1lkUGFy6tdi7q9UpaN68MOJhdC7LKAP5FSSoj4QkWSE43Z88Sbu4U3x28TjLnd
N3RLb2JgK6Ec0yS/31/qEAEx4pWzGtQ7TVPFG8FRKpNo0wj9L07HGWGDgTZtL1/n
khK8DHe7Zq7vYuske5DlZ3cbaHxDEYy4yBl74E3c5nFHcS/83oL3FEshXy5v6A6M
STCNGBFt5QSyXHKBoLm0r+ghn2QOzjsnc7biENOFVdgnqjjK6QLpbukayKmg1RBd
1prcdgQJFkPOAD6H+go40JC73kpdSIlghc4e6Qo00RTefrAKW0oZTy4RzVKZmJFF
hqZ7tMesQ54HYSJ1XbtII/zxQ8uQiBUj85TEgGMxIw7272If3x3S7n+4Vsg71ReY
l+hSlYb8ozQPZrbyWm7V1Df/9E/Dmh+EghHIjT2J534O8GELBqc6Dv1bO74bjcIM
xhDVgM9Rnfgt9HH4EeEFO6hI4JBQpvdovertzdCCCwWay/NEq4xFPb+FpggyikWv
ZCYW6idCJL7gLup+jp6pfCzFpl19yUuG8E+6Ujrger1pYXuMw2B/i5eL27cDspcr
xUxIQHjYT7m0P/K/6vb+
=quS9
-----END PGP SIGNATURE-----

--IfhPODtivl1BCmut--

--===============5286617299710990963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5286617299710990963==--
