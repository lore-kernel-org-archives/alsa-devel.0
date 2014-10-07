From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: mc13783: Fix of_node_put() call
 with uninitialized object
Date: Tue, 7 Oct 2014 18:23:37 +0100
Message-ID: <20141007172337.GR4609@sirena.org.uk>
References: <1412698794-25536-1-git-send-email-tiwai@suse.de>
 <1412698794-25536-2-git-send-email-tiwai@suse.de>
 <20141007170938.GM4609@sirena.org.uk>
 <s5hppe3lrzf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5249687119691333743=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EDFB26052A
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 19:23:58 +0200 (CEST)
In-Reply-To: <s5hppe3lrzf.wl-tiwai@suse.de>
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


--===============5249687119691333743==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKaPnVNVpyX08bAX"
Content-Disposition: inline


--gKaPnVNVpyX08bAX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 07:17:08PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > On Tue, Oct 07, 2014 at 06:19:51PM +0200, Takashi Iwai wrote:

> > > -	struct device_node *np;
> > > +	struct device_node *np = NULL;

> > No, unconditional initialisations like this are worse than the problem
> > they're trying to fix.

> Which problem they're trying to fix...?

Shutting up warnings - because they just brute forcing they mean that if
there's anything else we've missed the compiler won't be able to tell us
about it.

> Initializing with NULL for the of_node_put() at error path is a
> standard idiom.  An alternative fix would be to add "if (!pdata)"
> before of_node_put(np).  But this isn't really intuitive, either (and
> even more error-prone, IMO).

Well, in this case I'd just move the of_node_put() into the existing
check for pdata since we don't ever reference np outside of that anyway.

--gKaPnVNVpyX08bAX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNCGYAAoJECTWi3JdVIfQ3uoH/0DkVavdkg/UwbOXaE3pJ0RZ
vkcQwKlzFpvqMr87D+fTxlYLwi+1UiG8FTDy/CsPv//ifwozL3KFrUFK+W12l4vw
+bc+kuHXW1DhQpy5bzB2ay3vWEzte2Z/PHz/2VLm6spsP7u1539bjqRdtfdKudVs
2ccpS7osh0wmA6E0btbgDPJ3OcqDl+Bo/07PHJO/bJPt5gmzqhbaPe/biVRMsxgx
oXDwgHod7mH9hCwdHZEOR2VIKRUzwVOEsI1e2yr1G8B00XpuQeULOQDLYdhol7Ab
aaF4/f5eV5ox/r2RairC4owVmgkOsVPgsRENI8lcsPyMkQwRgwQCDQIkAmV3fAI=
=yH1F
-----END PGP SIGNATURE-----

--gKaPnVNVpyX08bAX--

--===============5249687119691333743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5249687119691333743==--
