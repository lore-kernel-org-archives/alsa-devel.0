From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 6/6] ASoC: Intel: Skylake: remove call
	to pci_dev_put
Date: Wed, 16 Mar 2016 21:24:21 +0530
Message-ID: <20160316155421.GW13211@localhost>
References: <1458040168-3769-1-git-send-email-vinod.koul@intel.com>
 <1458040168-3769-7-git-send-email-vinod.koul@intel.com>
 <20160316100829.GS2566@sirena.org.uk>
 <20160316105244.GR13211@localhost>
 <20160316110310.GT2566@sirena.org.uk>
 <s5hwpp2d5ar.wl-tiwai@suse.de> <20160316144405.GT13211@localhost>
 <20160316145753.GW2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9194956988995020005=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id E1FA726655D
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 16:50:05 +0100 (CET)
In-Reply-To: <20160316145753.GW2566@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============9194956988995020005==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uJrvpPjGB3z5kYrA"
Content-Disposition: inline


--uJrvpPjGB3z5kYrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 16, 2016 at 02:57:53PM +0000, Mark Brown wrote:
> On Wed, Mar 16, 2016 at 08:14:05PM +0530, Vinod Koul wrote:
> > On Wed, Mar 16, 2016 at 12:35:08PM +0100, Takashi Iwai wrote:
>=20
> > > Maybe the document is obsoleted.  The PCI core, at least the probe /
> > > remove via the normal PCI bus, takes pci_dev_get() and pci_dev_put()
> > > already there.
>=20
> > Yes that is my understanding too, that is why we removed this from driv=
er
> > here..
>=20
> > Mark, is this fine now?
>=20
> You might want to put some of this analysis in the changelog.

Yup makes sense, v3 on the way then !

--=20
~Vinod

--uJrvpPjGB3z5kYrA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW6YGtAAoJEHwUBw8lI4NHKSsP/2FN3ACcLcwaMB2Ax/GNx7SW
YogmxQva4GFwLDpvpuuftPkLvlvTXiouWF/FIwpYLCBZbByBYZ+a5B9H1y2GMI1E
44otsUeydW3iCZWbGdjHVc3tnI7VCQHQN/5ZaqUbLzBRNwMImSaCQ/dUfy35jx4q
2K+GyXQUuaE+4h4Vk5ySBBRoJf0RYvPtioI451trSA009zIHvDt0ur4hc6yWLs0e
xeWxABTRF9Y4F59WFWm+BDALQOz22agr1GkvDPQSPP0eXxz1CoZSRzMAdvoDCvmW
iEYCbcn4YQ18R2bVhD9gs6BRWiqrfnXpKGb5hsYItCVCyQvl0buBljiFmhzwhS5S
BA/DgqXl8QYAzb5s0CNyd3JJLG4F9MNRyM+8MViF7Qih/lXzvsA1BxkzyN+SRGn7
qg+mYlR+tC5i8JXl+USb8QrOTvM+8YvSrbeyWMWvaANd43wm8O0iFLnKgFZdOBu9
b4/a2pTpRWCtC9Uo37xt5u75j+JyK6KNj4e4zycF1fq3q5u5ivEYWMFAL3j9ImTL
SpTWskBRqFoQUOnkMEbw541YzN6PUhWDxKDAvp9DWhbhrIODndA4x1WV+y6PwZHt
hVJXZ6w8UZ6M/rGwsef/Wcltp9dPyK8cnXpcJPUpYwDgVA6mt5L6LyHrv43/YJB+
I+ckXeJx7mWXLA/PvFzZ
=cTfC
-----END PGP SIGNATURE-----

--uJrvpPjGB3z5kYrA--

--===============9194956988995020005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9194956988995020005==--
