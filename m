From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Fri, 10 Feb 2012 16:39:46 +0000
Message-ID: <20120210163946.GG6472@opensource.wolfsonmicro.com>
References: <1328644128-32630-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1328644128-32630-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F323405.8080902@canonical.com>
	<20120208114642.GG3120@opensource.wolfsonmicro.com>
	<4F327A21.8030805@canonical.com> <s5h39aj5569.wl%tiwai@suse.de>
	<4F3516E4.2080706@canonical.com>
	<20120210155003.GA11701@sirena.org.uk>
	<4F35413F.9000701@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6237036974343474994=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C115F2446E
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2012 17:39:50 +0100 (CET)
In-Reply-To: <4F35413F.9000701@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============6237036974343474994==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m0vRWufqUC70IDnR"
Content-Disposition: inline


--m0vRWufqUC70IDnR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2012 at 05:09:35PM +0100, David Henningsson wrote:
> On 02/10/2012 04:50 PM, Mark Brown wrote:

> >>Given that the normal desktop user does not usually look at these values
> >>these days, I'd say being parser friendly weighs heavier than being
> >>"normal English".

> >Not all the world is desktop.

> The normal end user of the embedded system does not look at those
> values either.

There's rather a lot of people who do embedded development and do need
to look at this stuff, though.  There's a real cost to raising the bar
for humans to understand things.

> >>I think both naming schemes are good, and I'm not too worried about them
> >>being too verbose. If we run into names being longer than the string
> >>length we could back off and drop the location, I guess.

> >It's a complete pain for actually working with them and doing
> >development - it renders badly in UIs (think about alsamixer for
> >example, or people looking at things on 80 column terminals) and isn't
> >friendly to people typing things in.

> So your suggestion was, to avoid "Front Headphone" and "Rear
> Headphone" because the names were too long, and instead have
> "Headphone" and "Headphone,index=3D1" and have "Front" and "Rear" read
> out of a TLV?

No, some of the information should go in the name but we keep on coming
up with more and more things to add and when we end up with "Left Silver
Headset Jack Headphone" or whatever (which would be a fairly complete
description of half the headset jack on one of my laptops) we probably
ought to be cutting some of that out. =20

Though thinking about it duplicating all the individual bits of
information in TLVs would be helpful to automatic parsing, we could
possibly even do something clever like make minimal subset names that
contained only the bits that were unique on a given system if we were
bored enough.

Oh, by the way the extcon (Android switch class more or less) code looks
to be coming along quite well which is going to be a third way of
getting jack information out to userspace.

--m0vRWufqUC70IDnR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPNUhMAAoJEBus8iNuMP3ddWUP+wZg9HBnJjrnfog6bMgZtvjX
HUokOyt1aE5ueIwP6xhoTY4cey7etyYRK4uvBWA0dKvp+LVE+4pG7M7nx88CoZHs
X9YUEztmANiFaW2h8wreu55HSpC9ld2RjIhjmoYNMBqYrleOn0fCgnjnkj0poCBb
t9sFAEsLO0fOJTXJ/R1CDosA8CmkWB+vPy1hS9zqVH30XHCKG2P6VURn3s8o29Af
FAhpi4G+X4Nn1HcrcMnhXwCsureObz14NjMy5ekJ8vL1yu1JKthekEk+nt7CWwdY
3E+NUAjcabNCP8jrfDJq7+grjx5mNjHfW55V8O7HfAaVXxTIvXvEy8MAQ/CPxvmw
TdLc0m3MiM+zoJ/gBf0U2/acM0i5P45rvxDuu1MPaLEkzTraExNfFOFytjIKvg0y
kFez5DUs6EyzDARLbmakCsLQ53hTvv/tN/38o6WPoK1XqiACQC4KRVw7nsZQp35+
IhgH9bbk0L55XK6lWdzEBwt0liqtqxIuPbi+N8Tboxqi/ew2pdYh1bB4HC9AlBZA
SmK7mcpEhUYCoqQQB9mMr+hq1sJYzWUDSx8TjEtfy0la2as8etDujKGV0e9f1IOy
z+s6x2xpHlMpX7jRlV351rqkw2t8yNC3NdzX2rmYUQEwO40Mr5oYLE5WBZFbx6ez
1OOfUXFM6yg71tnJgYx6
=6fUG
-----END PGP SIGNATURE-----

--m0vRWufqUC70IDnR--

--===============6237036974343474994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6237036974343474994==--
