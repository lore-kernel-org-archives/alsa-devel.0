From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Add support for platform and
 CODEC drivers on same device
Date: Sat, 26 Jan 2013 17:19:39 +0800
Message-ID: <20130126091937.GG30594@opensource.wolfsonmicro.com>
References: <1359020951-25904-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1122492631989902646=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 747362616FE
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2013 10:19:52 +0100 (CET)
In-Reply-To: <1359020951-25904-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1122492631989902646==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BzCohdixPhurzSK4"
Content-Disposition: inline


--BzCohdixPhurzSK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 24, 2013 at 09:49:11AM +0000, Charles Keepax wrote:

> So this patch will check for existing widgets during soc_probe_platform
> and only create new widgets if no existing ones exist.

Why not do these extra checks in new_dai_widgets() itself?  That'd be
cover more cases and generally seems more robust.

--BzCohdixPhurzSK4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRA5+iAAoJELSic+t+oim9RaYP/2S2BuJVoH3M1T6MIC28WAin
gbgfo5D6MA/CqbSKrCD8VRlxq93vPwcalohJEVbBHm/eDAt8LbxWeoOxQi6tqrB7
ibnw2qFVcYzsJlXL0sVBXHQfFwTB/OMMp6d4cIz5QYFqU+/VubdZmRRLj9e+ciw8
hJQN3zx8xOSexrZY9qk0XXIKOOuURiVVEKt1LtFkhiLJWrT9NaQfP6Ij9H8kmekh
qqHoysjtep0KMxSIhPS260ntSvv1HkoL8OAlr2+kg2Mr+wuJEsy4nriLouktnVFE
dElDcuXULb9ZkS+4n96P89mg+9s9gnGVNVkMsPttwjTs4W5iydpHQMPwS/yNgxfU
JA4d79mIukDUXWoFHjRF2AeTy5ncEqk7bKqrgc+Tzygj8OVkFtYyiUNFiML9EFMg
ONU8WACc/iM3TJ6ksXNJG0kyUaAvWhUSHhgamEBTVSpSaByMiGLvPq2lSETPCbQk
Gffi/bIuI5fMBTGtRaofHmXHylJ/aGLmxQSzJ3IhsU7lmYaXxJjsyU/t4mSLJ1bg
XNkJ2MLtppF1OWpHdNDJUNVeqjAyDgO1MTXjBrtLBgBqOsDl7fKI2axEwpBNUTt3
31uEv/SOzeZFqperFKN84mo2NXeJfbToCsn6cVdOip5MOxHtk2rv9ZeHNuHOt/ye
n3O2Rf+ha64vjvVrH3Lm
=d+2g
-----END PGP SIGNATURE-----

--BzCohdixPhurzSK4--

--===============1122492631989902646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1122492631989902646==--
