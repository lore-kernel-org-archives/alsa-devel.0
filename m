From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: [BISECTED] 2.6.36 regression for ALC892
Date: Fri, 26 Nov 2010 20:37:51 +0500
Message-ID: <20101126153751.GA4185@belkar.wrar.name>
References: <20101125211803.GA4236@belkar.wrar.name>
	<s5h7hg0sk04.wl%tiwai@suse.de>
	<20101126091211.GA3505@belkar.wrar.name>
	<s5heia8qvry.wl%tiwai@suse.de>
	<20101126142737.GA3522@belkar.wrar.name>
	<s5h62vkrw6c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8226951030045648007=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from haley.wrar.name (wrar.name [109.74.195.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F7722413F
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 16:37:58 +0100 (CET)
In-Reply-To: <s5h62vkrw6c.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8226951030045648007==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 26, 2010 at 03:34:03PM +0100, Takashi Iwai wrote:
> > > Try the very latest alsa-driver snapshot or sound-2.6 git tree.
> > > You should have an individual "Headphone" volume as well.
> > Yes, that makes difference: I was able to use the headphones after rais=
ing
> > that new volume.
> OK, then this should be the patch below.  Care to apply it to 2.6.36
> and check whether it gives the same result?
I've applied it to 2.6.36 and got a "Headphone" volume, and it works.

--=20
WBR, wRAR

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBCAAGBQJM79RJAAoJEOih81koZvPBnrgIAJ8p5bCPqfXgX98xlx38Jwtg
Regfc+EYxLZEUC4zlc8xkZq1s03OXlxcc3nwqA3j6F0tCAppt/E+Rxz0phpKp+6X
WHNxD39gHeXrIZ38Ks13XVA/z6lrRD6NDKNMeLobZhpBgleHHwwl2Kua5VIOx9iY
PchVI6p2ra4WESsiu/pGSnf2eDNLFP1iVC2Z7U2DCOnwCaYRDoGQsuGcdopCIjl8
NNpODwYR55z+OWjZZbuv108BZNyXt9DedoFLmSz++vK7qXV1JMBL9bE6s9DhYBUx
hlLr7q8w3AhyeJBC0eGvy1r5AW5iSY79xtftQtt4r1tOGA60hTTz33+sUPdqnpw=
=pPtr
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

--===============8226951030045648007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8226951030045648007==--
