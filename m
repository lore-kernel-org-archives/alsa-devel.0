From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/6] ASoC: Intel: Add helper to poll
 register for DSP status
Date: Thu, 9 Jul 2015 09:57:41 +0530
Message-ID: <20150709042741.GF836@localhost>
References: <1435919647-14049-1-git-send-email-vinod.koul@intel.com>
 <1435919647-14049-2-git-send-email-vinod.koul@intel.com>
 <20150708183621.GZ11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0589510590171588843=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 163CF265AF8
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 06:25:55 +0200 (CEST)
In-Reply-To: <20150708183621.GZ11162@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, "Kp, Jeeja" <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0589510590171588843==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2015 at 07:36:21PM +0100, Mark Brown wrote:
> On Fri, Jul 03, 2015 at 04:04:02PM +0530, Vinod Koul wrote:
>=20
> > +	for (time =3D 0; time < timeout; time++) {
> > +		if ((sst_dsp_shim_read_unlocked(ctx, offset) & mask) =3D=3D expected=
_value)
> > +			break;
> > +
> > +		mdelay(1);
> > +	}
>=20
> mdelay() not msleep()?  If we're waiting for multiple miliseconds that
> could be lots of busy waiting.
Usually this should get reflected in 1st iteration as the register update
would get updated farrily quickly. msleep will add up lots of latency to
this.

Thanks
--=20
~Vinod

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnfg9AAoJEHwUBw8lI4NHxAAP/287mBwXWYb3TfjubcTurJxP
ey3KIdgddm1cOlB43CYfQACf6kpscRm8qp+uJ49cSYi/CWIPbsljA+cqOanFcWRb
wxLGTGm0+iG5NjH3InW4DqjFFUBAcM8/pOZtD3sl72w+KFxfMTkEaJD8aIKNHtYy
+UQN1tL/UUpUWl23FvIgnm3waQQd5CTzstJvsJNcBwH/1fkOohNvlTuWAx3F7zQo
cXXLnCcd+rrKcUVJYy09sNHl7qOF8mR5303+F6abVyWoDzM69816YUtxNhHdb442
ABdjHofIGcBnj96szMqGeqcWLxd+RhiWHEwtoIZG58oU2X328h77lVU/ptBgRgOV
VqRM98BDo1hOIzPkBvAsAWMj8ZhAdw5YRT22bp+PG+ypUVZDiy/WqcibF6OxbilL
3lK9uhTlK3uRz3955NlRFYB8U5X60JUaGS6lj6/D1Musa+tR4ozM17jfOD61aVsq
rkyOCE/3KSLi7Ce6MtxC/qV6WouQpBCfEjh8B9HKA18Nys8zqENGA9zMebLfNW+k
gLfAeabAtufhDLt9E0JperkYenT3pADyOAiTKfRE+Vl0GuikLjpTMZ4LEVRl1A25
nh3wyMWDskL99x2v2w+fVOGngWki8DsHA/BTIqn18HkivljLw+wm9PwD69drHKC6
G4zONyq8imzf7OgzdV/6
=D/Hz
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--

--===============0589510590171588843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0589510590171588843==--
