From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: export
	dapm_kcontrol_set/get_value functions
Date: Sun, 1 Jun 2014 20:26:49 +0100
Message-ID: <20140601192649.GQ5099@sirena.org.uk>
References: <1401357817-17942-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7956118700945871160=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 75CD1265475
 for <alsa-devel@alsa-project.org>; Sun,  1 Jun 2014 21:27:05 +0200 (CEST)
In-Reply-To: <1401357817-17942-1-git-send-email-vinod.koul@intel.com>
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
Cc: Kp Jeeja <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7956118700945871160==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ub0O6GltjzY0fXqz"
Content-Disposition: inline


--Ub0O6GltjzY0fXqz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 29, 2014 at 03:33:36PM +0530, Vinod Koul wrote:
> The DSPs like Intel ones use the DPCM to represent the DSP toplogy. So when DAPM
> triggers the widget, the DSP needs to know the kcontrol values and pass on to DSP
> firmware, so export these for driver use

I have to say that I share Lars' concerns with this one, especially for
the set function (which doesn't quite gel with the description above) -
it may be that this really is the best solution for the problem but it's
not entirely clear what the problem is and like Lars says there's some
other stuff in play here.  If there's something that the core just isn't
doing that any driver trying to do similar things is going to want we
should fix the core instead of requring drivers to do work.

--Ub0O6GltjzY0fXqz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTi352AAoJELSic+t+oim9goAP/jvz105Pdgo59MoI+4z13bMt
waDabzMxoz1N2uDutV5gjAYxZT9TrP4PpbA/gLULXiC1Xh9hbp3jrLdewGEhD5D7
68+BqQQxZq3bnuUadn5LoJcPgt6C3evOUt0k0g1X8ISaUkonYLpXgkbPbNyXXvIl
wWnQH9a9dgrIbU/DgJ4Abb/hGQjTGPu5HLf1UZ+6DhPKStS5V2zlcYW/qSJeFJvh
5SQhJIoB2D3/hSVQpDpcR9A2/qYDVCQokiM1RQq8FnSqprGpQ6EEIweJLQpJe2h+
nYMjwY+nbvC0oQ51SgJxFeWE/Ufk+pe8JFq4rdc1KSP9sna4FASm1Mz6pmJ1zJ6o
0/1i/cE5YwaDNViO2gBRsDJCyNUuHRuueiB0VJGt9hVcdvuqp7o0HkRgXutoEMQ8
JRok3JHFkXoJrWUM966DEDSaKrEMyR0MwDF/uQPNdQ/tBRwN1r4qUEyEIhtvG2pN
nIy+rs0UpGu26g7HvGEwSunFpV3o20UYNaHefBjZjmcyK4Gmlmz0e3caWw+/SXby
6fLe5DvdRDU8cNzpG9/xjRI0dMJA6FiKU5+/KU+9cSFixh5qwO7Xk6eNb0fN3PCM
k4bFmoVsBdj/Uxj6dKA2tOksQusA21cZMQziQ6wnt8MT7uS22/qCnWjgtrYQEFxw
7QEJe6Ied4FCRijMEr8b
=I5hG
-----END PGP SIGNATURE-----

--Ub0O6GltjzY0fXqz--

--===============7956118700945871160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7956118700945871160==--
