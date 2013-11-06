From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/31] ASoC: wm8580: Use WARN() instead of
	BUG_ON()
Date: Wed, 6 Nov 2013 10:31:53 +0000
Message-ID: <20131106103153.GP11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-8-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2866513954568889552=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3506826171D
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:31:56 +0100 (CET)
In-Reply-To: <1383673218-18405-8-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2866513954568889552==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sj9mcRtP+pTWLOo"
Content-Disposition: inline


--6sj9mcRtP+pTWLOo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:39:54PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN() instead.

Applied, thanks.

--6sj9mcRtP+pTWLOo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehqWAAoJELSic+t+oim904gP/3eFmwVfGPDodzXqbgbpXRsP
mb+/w95viLrSKLZPzcb6ZXeVb5Am2iDu8zWt2mELfzu9vMz+GGPbztLqWFhguXW+
ZZ8npMamMhZ2KtfV7Yx+J7ZFUj4PY6xCnGZVMYNTyuehQbGBm+vauI5DW7fuml5D
djaRsBqzdJxdGqF7DbD33TitQin00wOev1YNXjhV+u+H3JV6h2s+vAWF+BwM0fjq
w7j9nbtvM/kyGQM0uef1CpP1/rANuWoOg+4L8mMF+bjZokwhdRiWZt5KU73NpcW2
S5raCnH/mER69huQln+euXZXwdQ+Ov6n2cYetO6YrssTdUbtfghs3BVuCPvWj+uo
OYuhhE58BZ/i4XRYPj1jUqS29zQk9l8utRNI6MvRlPk5A2Vxal2XQqx/WLlscbjQ
t45rfzRK/6yExUduG35HFwN83iHt2/xt2mSOnUlm/GOEL5aQisFmdg8dh8I1zBVb
hUMeZvgTkGKmMdpoNBi4ZhlY7A/2NJjPcXMOL72U2wgPIouL7em4HBCyjHFaAgvB
LpWNNiH8MZ6pCiOhH6+IKNL2IEImblJbJWKprIqUXvS58ox1mi6LQIUQxotAYojB
jVHMFCIIOlFzq2NuwQ5WvhdhMxrDIT6SmChNS9LvDX+TPk7b3mJjAHEfCtu62LmD
Lx9pQhB2nipUflyug8vd
=0gAv
-----END PGP SIGNATURE-----

--6sj9mcRtP+pTWLOo--

--===============2866513954568889552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2866513954568889552==--
