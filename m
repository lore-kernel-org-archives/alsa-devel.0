From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v6 11/15] ASoC: hdac_hdmi: Don't fail in
 dai startup to make userland happy
Date: Tue, 16 Feb 2016 09:06:13 +0530
Message-ID: <20160216033613.GQ19598@localhost>
References: <1455243375-16067-1-git-send-email-subhransu.s.prusty@intel.com>
 <1455243375-16067-12-git-send-email-subhransu.s.prusty@intel.com>
 <20160215205521.GE18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2593412057928753530=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 04B07265593
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 04:32:26 +0100 (CET)
In-Reply-To: <20160215205521.GE18327@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2593412057928753530==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ulDeV4rPMk/y39in"
Content-Disposition: inline


--ulDeV4rPMk/y39in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2016 at 08:55:21PM +0000, Mark Brown wrote:
> On Fri, Feb 12, 2016 at 07:46:11AM +0530, Subhransu S. Prusty wrote:
> > In dai startup, driver was checking for ELD and would fail if no
> > monitor is connected. This causes userland like PA, CRAS to be
> > unhappy as they scan the device list at bootup.
> >=20
> > So move the ELD check to hw_params and fail, if valid ELD is not
> > found.
>=20
> Should this not be sent as a fix?

Same reason here as well. In 4.5 since this series is missing we do not
enumerate the codecs and machine does not have these dailinks.

Btw SKL driver does the enumeration on HDA links and creates codecs, that
patch along with machine will be last one after this series.

Thanks
--=20
~Vinod

--ulDeV4rPMk/y39in
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWwpktAAoJEHwUBw8lI4NH0oUQALJ12P+PCLNIvpg1AQ0Puvyy
DqnqaiFCQJJnPUVWgx199XxTietYMhuW5kgnfU9Yv1DZBaV9J/32nszJYd/GJ6nd
wJdi9C0OneYubuU+NTKSG32TMixaG8b6Tq84GT0aSmDetfRwHo1tOC2FYY7CU7nO
e3z+qZ7oVENYKPc4t/p77apNSe9kBnvgUsEQN0YB5j33oY8G3Mp39ZM46O5khczs
IKk3GkQ9lT1covkMAbNbjFOH7CErsubAgwXoxvEWuqKB9tum1crG7Z8LbDqGN+2n
ARzF5w0+BLvAQe1BZPhshF9/SyruF7TlctK4BpO6vptTyWYdzd0ITX2OAiI45HYi
bHisTcngmNSN7r8MGqzPYRoX2oT4Y19rfGw29o2PvZmJf5FBWpY2bI8vSuvb6UfA
oT7T5WgF45a1I/LJwwbm/84VDmu6p7pBngheSIC0s1WyaF6fracOzo7qTiL8pgI0
PTVps+Rs5q2cGxumAQp+8l/o7JJ7unewrH985T8l/rq73zA+QDTplmH2vVGJyeZP
C/KwYjsNSADb0+jhyqYyVfS7GYTSYxLezU+oH64VkHKGwmhhYYElLIB+s8IuCW4t
mjDMB7IMWQaiLDHmozd9v9BeDbP02Zpee1P51VYbysihQp9CnyCU93N1tlJFirjU
AVUVTTHJPefPRmvWSlX4
=HeRQ
-----END PGP SIGNATURE-----

--ulDeV4rPMk/y39in--

--===============2593412057928753530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2593412057928753530==--
