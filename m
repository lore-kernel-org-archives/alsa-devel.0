From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v2 10/13] sound/core: add DRM ELD helper
Date: Tue, 5 May 2015 23:35:42 +0100
Message-ID: <20150505223542.GM15510@sirena.org.uk>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
 <E1YdbKA-00085Q-LL@rmk-PC.arm.linux.org.uk>
 <s5ha8ymy3e2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6984251981839207103=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DEFAA2604A7
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 00:36:07 +0200 (CEST)
In-Reply-To: <s5ha8ymy3e2.wl-tiwai@suse.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Philipp Zabel <p.zabel@pengutronix.de>, Yakir Yang <ykk@rock-chips.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6984251981839207103==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MhZKc0eW5aU1X1vX"
Content-Disposition: inline


--MhZKc0eW5aU1X1vX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 05, 2015 at 05:57:09PM +0200, Takashi Iwai wrote:
> At Thu, 02 Apr 2015 10:22:06 +0100,
> Russell King wrote:

> > +config SND_PCM_ELD
> > +	bool

> I don't mind much adding this one, but a new Kconfig is always a
> question.  I'd like to hear other's opinion, too.

One point in favour of this is that there's been some discussion
recently of IoT applications with very low resource requirements that
might need audion functionality so it's likely that people will be
taking a look at trying to minimize code size for the audio stack.  This
sort of configurability may well be useful for such applications.

--MhZKc0eW5aU1X1vX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVSUW7AAoJELSic+t+oim9OogP/AmLnCC2rNWaXC3VsS/TqhGf
1qE9jn8Y4ZLAaBmJtqHOHOLUojEdhPcleUXyJLEn08ILFcdYd+0Djf/9hv7pJx7t
5fHYCO0oBVWcEJ89XTLrMrRSTpbxhdRBauLsz7VYhA4tLzcWPec3PBhNc06+4vd9
ckN/pnje9HT3d+XC9YdCPzg19wpNvmPr+3w/ZfXoVVBdJi0EpW6FYObtdj0NMFV0
co5S+boFnefwHk2/Fm3i5DD/Qc/EMykE+9m8p0dVJY9iwsInXJTIRI24oOPykB/N
wW4kOR06da5ADiwXEUuvkENW82bj9o2zls78xm2ydkISauJYRbytBpZD2xwoBKYn
qWGK6gGl6coqGtBu102L8qcoB/d8UXvvEqcxL6SREecrZSRayYvX14I+V3edBDYN
zfv/VQyVI6oiGBEtKak2MR6ol56ySBPNI0MFch90/8dMEogpPAdG08vBhhHq7vpX
IpLMb6AWcu9yQAPDCbxSP78ObnF2QUOlXzXtZ7ecIaeZpYh45LyNBBG32ITwgNU9
3ar0fkYM+M02P+a/GbpZgySIKpVVuInKwL1Hfvb7SpXByV1/n96oA/M+RiSVD/X4
8NCur2O/9XCPFRVkDWXiOJ394PJIRgsrTGql11aw9lOfmzSOp/dSezryObw2G9xV
Ntd3Y3xnmv+f1Gz1QShe
=Mf5c
-----END PGP SIGNATURE-----

--MhZKc0eW5aU1X1vX--

--===============6984251981839207103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6984251981839207103==--
