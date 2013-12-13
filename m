From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Correct S24_3LE support
Date: Fri, 13 Dec 2013 13:50:25 +0000
Message-ID: <20131213135025.GE11044@sirena.org.uk>
References: <1386939499-5163-1-git-send-email-peter.ujfalusi@ti.com>
 <20131213130443.GY11044@sirena.org.uk> <52AB0BBD.2020001@ti.com>
 <20131213133444.GZ11044@sirena.org.uk>
 <s5hppp0j2av.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0252819284794742968=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 50EF626163F
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 14:50:28 +0100 (CET)
In-Reply-To: <s5hppp0j2av.wl%tiwai@suse.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0252819284794742968==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hX3v94LCWtOgt2h1"
Content-Disposition: inline


--hX3v94LCWtOgt2h1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2013 at 02:41:44PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > No, I'd expect the wire behaviour to be identical for any 24 bit samples
> > (that's certainly what most drivers are written for).  The memory layout
> > differences shouldn't be visible to CODEC drivers.

> > Like I say we ought to be handling this stuff in the core :/

> But this codec driver declares the available formats as:

> #define AIC3X_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
> 			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)

> so the fix for inconsistency is needed anyway.

Ah, indeed - and that one should go to stable.  The changelog ought to
be more accurate though.

--hX3v94LCWtOgt2h1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqxCeAAoJELSic+t+oim9HEoP/jYjK1uptlBUooofiK/NAate
BkFKhGwqCaEQvWxlatvG91YLSGjGb1Te9aUfPtUbUNIXPvOQboXjLb48srzLHEBz
eRdI1bsvD4PEZRjssFjXCCS2V8ddl6BVGu1XFbktDo9wSZE0D9nzeVoy0M7tsBwh
t49WlRSverne5g3f7R947wbAlmEV4Nn6I8dg4bURlVfk8Rjb2xTbU4U9W7oWa1Yo
iuWD730swqhMMkLG6JVmYuI4SSRhFUOmpW7QkoORWDClkovBBDMFd6lNJr1Rd+zK
LhwGdB5G/bsMImofZRd/rNYMXN7CHLNGUzuKNQmNa7mGBZDqQskPDr/zQiWiul4S
pN2GZMsLvopmDfyAfZ3fMVUT4Dos/MiJf3OjkhCx5E9p7j0cDk9Dtvdw/JrgP/zZ
mHbguUhxn0qyZ8fihTYzSAy35tzfRPS/TU8vfNKfyiSCb8j2GTQzP/GFgqJYP75o
wT0UBumDgWNYM7iTiMX/ki1rtEWAupSSTvoaKsSpc95vjescYAYm/foNwqte3dNk
k8O3vwbxk05WoH6ANLZNpTqquQiMPI5P/xTDrQXXXkVaVGJViTCmCwVaJzNUjSLD
rFrgN4dEbylVR6JgD/oQTChNcBgWdS26g2ckACT2toy4311+TimnnYdt2oXTC+Db
Zf3aQYRwdbXNeQLHohFF
=sBBR
-----END PGP SIGNATURE-----

--hX3v94LCWtOgt2h1--

--===============0252819284794742968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0252819284794742968==--
