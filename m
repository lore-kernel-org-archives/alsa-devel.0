From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC:Question rate constraint between the dais
Date: Fri, 16 Mar 2012 19:22:33 +0000
Message-ID: <20120316192231.GI3158@opensource.wolfsonmicro.com>
References: <64362.10.252.27.21.1331805184.squirrel@linux.intel.com>
	<20120315175310.GR3138@opensource.wolfsonmicro.com>
	<9DF50024A2F6A5439EBFE2E74F4E9198055254@BGSMSX101.gar.corp.intel.com>
	<4F63105E.3080705@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7961976359082445172=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E8E402434F
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 20:22:37 +0100 (CET)
In-Reply-To: <4F63105E.3080705@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, Ramesh Babu <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7961976359082445172==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Content-Disposition: inline


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 16, 2012 at 03:35:18PM +0530, Omair Mohammed Abdullah wrote:

> You are right to say that it is not a machine constraint but a codec
> constraint. The problem is that if a DAI (say the "SN95031 Headset
> DAI") is opened with a 44.1 khz rate, then another DAI (say "SN95031
> Voice") is opened with a 48 khz rate, then we need to reject the
> second open because the codec cannot support both rates at the same
> time.

> Is there any way to do this with constraint_lists? The way it is
> done in the wm8988 driver does not apply here because there it is a
> single DAI.

There's a way to do this, and it's the way that the WM8988 driver is
doing it - obviously you'll have different criteria for choosing
constraints but the actual application of the constraints is going to be
done in the same way.

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPY5LuAAoJEBus8iNuMP3daCkP/3NguSmiklwMqjesw6iObXGg
olWTLyswKQNnsocfwQoOsEjspU5I6wj2KEC3i+LJkH9rupznxghKEkQc0pq3g4YJ
WdONkHeZ6Neip8NLCs/uCpnHM8hEqh5+Ripwh6Pjdbbm5u/Obk1NAFkWdjbFYtRJ
egP99/9nC4UZc4o1fpQSJnecxGFoXrlnuvIOX1h9es91PVzi14bsHqweQHDk9Fkt
/61Ih1g+v8YVx9t473/VL029GzQkFsWT2OtVDtoawkPLG8WqytfXgGudshouUzNW
z5VSuUCcyYKRp9gadFPZty3LKnxNTCu++6sKPbErVCOZzEZJ7wuJRHytp7d0Ela3
WKEOHoltdvi8p+7DQgfsNK6T8Nf6tUx+p/mNASwIJHa/a8AWj15M1eJ0VsJHY5ec
KSxLTip7zOhie1l+CiBNBvZ9ZbeFpqVYbzKOs2NVfKaWCZdd4Bzas+2dgsD2kLdB
5I4andLi9dULt4nTYcNZ4iFs1YZFK+WKznAPSBa2Way/Mna60GeAgu4ZPa+Ek9KI
U3VN7gPkkcp1wALKTq5UCBRri7foeOovI5RJnlcTGiH3W9VCxlFAAoGMJ2Ro+vQt
1UWW25uwVjTqpos6D8kbyl/fjsBtUND3enjU64/T7uCKBpeO+Qp5R2esptLdblXh
OTZPUlVf40O1QdFvyErB
=hyzC
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--

--===============7961976359082445172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7961976359082445172==--
