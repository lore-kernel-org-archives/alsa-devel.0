From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 2/6] ASoC: hdac-hdmi: Add hdmi driver
Date: Mon, 2 Nov 2015 15:36:42 +0530
Message-ID: <20151102100642.GK21326@localhost>
References: <1445931737-30393-1-git-send-email-vinod.koul@intel.com>
 <1445931737-30393-3-git-send-email-vinod.koul@intel.com>
 <20151101030231.GB17819@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2257374658569090026=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D01402607C8
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 11:03:15 +0100 (CET)
In-Reply-To: <20151101030231.GB17819@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, tiwai@suse.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Yakir Yang <ykk@rock-chips.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2257374658569090026==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 01, 2015 at 12:02:31PM +0900, Mark Brown wrote:
> On Tue, Oct 27, 2015 at 04:42:13PM +0900, Vinod Koul wrote:
>=20
> > +	if (err < 0)
> > +		dev_err(&hdac->dev, "Failed to query pcm params for nid: %d\n", cvt-=
>nid);
>=20
> That looks like the NID is being printed as an error code.

No this prints the NID for which query fails, but agree we should print the
error code too, that might be very helpful :)

> > +	/*
> > +	 * Currently on board only 1 pin and 1 converter enabled for
> > +	 * simplification, more will be added eventually
> > +	 * So using fixed map for dai_id:pin:cvt
> > +	 */
> > +	return hdac_hdmi_init_dai_map(edev, &hdmi->dai_map[0], hdmi->pin_nid[=
0],
> > +			hdmi->cvt_nid[0], 0);
>=20
> I'm not entirely sure I understand what this is all doing.  It looks
> like it's trying to translate the HDA widget map into a DAPM map which
> seems sensible but it appears it's making some simplifying assumptions
> about the device it's dealing with?

The device is actually quite simple and yes we simplified even further by
ignoring multiple pins for now. We will keep adding more features and adding
stuff to map as we go along..

--=20
~Vinod

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWNzWyAAoJEHwUBw8lI4NH2y0P/RgaTwvVTAFO6qfRQxlxkxRv
HiE4S+6pC4Zm9L9Qe3M4ijGGuO5YFSlYGFON0Ypv2FvnfPD2zaLNQtqsNYkjZ3qT
aPCUvzf2Zwu9xF5LWBU9IrjHsPNn4wazEFQo2EPXtmNQdbvcIfTJCrSSh76zX9xB
Yi6xZeTvLcPOVuuTTdrroPJJwOS4LuUYd89B438JHwAiDasWgkj0uA39BKILQEXo
9QAYWVFnvzXVYmA7cXrNtmWfNVWXd2InCmbN/SYYPW6Jarwoc1+3Ha0Scbgbj8lb
SxltcmwW+eP/v1MnWBR9UjibfXii3M/J5t40T7li7hXBh7VMmHtazb1Qt4dGaztm
ejRth3BxiupfRpu8Tr9hmnosfeZWPT+HB7RXHfvqK/Jgptgqv+ZVqWQlgpKeHLn5
wmwUf+YS1ppMJ3aRUutmZlQbL6OfEbMeWHpVf9IMB7mlaF+fQJ+Ra6gNHjg9lzFZ
8H9GLpUH57MDmY+Yp/P1oZ7B/rHXehsHPMjm4iT+j6MwwJLJ6nRAc6PPYymAiqdP
20d6SWJx3lIpxnMYjBgJUpspbKxmxsUvMMOoiZQCZ2Y5woMcJipPzoZ8lqHnzepO
1gTdlOmqUORhyH4dpJHno3zRTAvZxLfjvDk39ZMz/6FvMszFercfQe47rNr+XSAQ
wljI+zID2SZIFXeLcuLO
=HSAF
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--

--===============2257374658569090026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2257374658569090026==--
