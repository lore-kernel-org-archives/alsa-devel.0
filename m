From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 05/10] ASoC: Add support for dummy DAI
 links and PCM runtimes
Date: Mon, 17 Aug 2015 11:39:56 -0700
Message-ID: <20150817183955.GV10748@sirena.org.uk>
References: <cover.1439217448.git.mengdong.lin@intel.com>
 <0364569ce2898a20d08243ba59a92973b2dc4735.1439217448.git.mengdong.lin@intel.com>
 <20150814202210.GQ10748@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F8480D114C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7109506526167220248=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p2012.superclick.com (unknown [216.4.250.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 253F7260412
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 20:39:59 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F8480D114C@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7109506526167220248==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uTOHp36N6S0WjZTp"
Content-Disposition: inline


--uTOHp36N6S0WjZTp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2015 at 10:01:16AM +0000, Lin, Mengdong wrote:

> These *dummy* links are not place holders of real physical links.=20
> So they cannot come from ACPI but from topology.

OK, so this is something that should have been apparent from the
changelog and if that's what's supposed to happen that shouldn be what
the code does - it needs to be limited to these software only links.

But honestly this just doesn't seem like the ideal design - what this
means is that we're going to need to have a dummy link in place for any
link that is defined by the topology which means that we've got a hard
coded limit in the drivers for this dynamically defined thing from the
firmware.  It'd be much nicer if we just created the links from scratch
when we detect them in firmware rather than requiring these stubs.

--uTOHp36N6S0WjZTp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV0ip7AAoJECTWi3JdVIfQQjIH/0NsN36zSYXm0nXVQUfv+yaJ
j6n9Nb6ePEc7/4nnG58zKDVW6RP9ZFmOH8uFxzdK+kIjLu0Rep3GUqi4NERPjgqf
1/RnUe2dARP2fydtIg2R+N7sxuC9L8BxTSWkStmbh9RxRBPFjYlY88SpNpxI/Ucu
3DkS/tl7z2iv5OR/xSIB5Ew3fViiwxSgB2l0Je3muXJjGoBBKfYeO1KccDNHbVbR
BXtZqRjsNvFS+WROCaNo0XtG8uq23CPjfjgtOptgojrNWL/+fS200O3oVRsBCfcg
LBvvVQHRkgRTIDW38+oMFr9I0vEIK0bEYnMTVY6asvqFHvBXStOXXMHn4GuRtW8=
=31bW
-----END PGP SIGNATURE-----

--uTOHp36N6S0WjZTp--

--===============7109506526167220248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7109506526167220248==--
