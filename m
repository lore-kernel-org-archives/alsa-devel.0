From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add TI ts3a227e headset chip driver
Date: Wed, 12 Nov 2014 22:14:52 +0000
Message-ID: <20141112221452.GT3815@sirena.org.uk>
References: <1415829023-13340-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3279367198913569745=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DC9C2657D2
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 23:16:09 +0100 (CET)
In-Reply-To: <1415829023-13340-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: alsa-devel@alsa-project.org, dmitry.torokhov@gmail.com, bleung@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============3279367198913569745==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CPL0NB1zLUi+bqjo"
Content-Disposition: inline


--CPL0NB1zLUi+bqjo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 12, 2014 at 01:50:23PM -0800, Dylan Reid wrote:

> This chip also has built-in support for the new button standard
> described in the Android "Wired audio headset specification" v1.0.
> These buttons will be reported on a separate input device.

We have a standard jack detection reporting interface in ASoC which can
cope with buttons, please use it for them instead of creating a second
device unless there's a strong reason.  There are enough slots for that
and an interface for specifying the values for the keys.

--CPL0NB1zLUi+bqjo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUY9vbAAoJECTWi3JdVIfQcrAH/0UfFoIJN8H6rsmJYT++/CHf
el5AnVF26+fi3yrOrBnKZFOhbcBka54pCaHYvd+B3uE7QKFgQpAQ8nupG805Sl6/
+Lqkv974ZGB8euKZ/bdiBuz3QW9CDiqauA3AK1ManjXOpVn10xFWMI5a+VkH6Jx0
/hhDximZrZnla1yp5fnEs4rlcN2cBFMYO5BBqTjY/dJ4DBCefk8wiOFMKUI2woX4
kkoHTlWvB4MuF2WoaELNxXzdyuaTf5HT8vfpUS16C1BTAvJrk2aPNOXpDQ+4yxgE
sOFpI61HhoHlhxJPpjH0sGC6lCpKjsZTFkJR20rHTrvPCCaYgSTmhDvy6/7T5vA=
=jwMp
-----END PGP SIGNATURE-----

--CPL0NB1zLUi+bqjo--

--===============3279367198913569745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3279367198913569745==--
