From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 9/9] ASoC: Intel: Skylake: Remove CPU dai
	that is not used
Date: Sat, 15 Aug 2015 19:49:55 +0530
Message-ID: <20150815141955.GG13546@localhost>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-10-git-send-email-subhransu.s.prusty@intel.com>
 <20150814220633.GX10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6354785608201147107=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A6D622608EC
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 16:17:55 +0200 (CEST)
In-Reply-To: <20150814220633.GX10748@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6354785608201147107==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2015 at 11:06:33PM +0100, Mark Brown wrote:
> On Sat, Aug 08, 2015 at 01:06:24AM +0530, Subhransu S. Prusty wrote:
> > From: Jeeja KP <jeeja.kp@intel.com>
> >=20
> > For each endpoint instance, need to create CPU dai,
> > Removed unused CPU dai DMIC23/HDA-SPK/HDA-AMIC dais.
>=20
> I'm not sure I understand the first line here?

We need to create CPU DAI for each endpoint instance. For this we should
have one DMIC DAI, one HDA DAI and SSP DAI. DMIC23, HDA-SPK/AMIC was not
required so this patch removes

Will fix the description

Thanks
--=20
~Vinod

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVz0qLAAoJEHwUBw8lI4NHHYMP/2AXmAgo1UfvISw1RoZU0uFj
YjttNLBRSU6m36XQiHtSENBbk9xWlfM+yeKIFORTfagdWxfvbEOuNkPH+nnwIS7A
+4sRRN87gWf+FX9xTHe7vMV8neB/JJ/OCbg842UOwmUjsKrfBPEnpdZFgfY15iD3
ceGizKfubqwBTY9u1plLFzhAE/1kqwLR8f/1pTIlWuxYKJfp/9klPRqwjMz7oBhC
/Ybx7sqyTXUcKmF6hp2WSRxLztU8004lsCAR4ezjPEo55BOsRiXW5MbfR3YOI1X3
UZaZQFQ21BCe8iBMlJyd8h76JosIghrk48ZJga/QHgFwQpOJaxoVH1qhdyfsdnjG
W+zhgayopezNGYfnYnryQbvqpM1pyEJ7MQwCFtDI+YZGy4y2bteRiWIVpJ0j6C1H
N90838FHFw1G69R6PRx8jtvzCtwgbGo7txDjgfCW4f4DBbJDP61quEta9A7C31hd
IlNqwajztVtcvNeDqfZKUZ0CyqBOa5Z0l0ZjYJ7bWNhERPUeUWwJYQotehj5oMn3
yy9aB4FiD5nG29ajAn3Nu+yMaJ4/Yqb/h6tD9VN5kO5hwsAAFhUShaWaTAIl8sgj
ZWSlGQLTnyagxB2eeShxNA7mOiAqwHoCgZv/ekVekxxnRCIncnld60tAoUEGlLnf
f/ZeX6gnxJG38uvNIf4t
=45kl
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--

--===============6354785608201147107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6354785608201147107==--
