From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 0/9] Add SKL ipc handling code
Date: Wed, 22 Apr 2015 09:30:46 +0530
Message-ID: <20150422040046.GF2738@intel.com>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <20150420214441.GW14892@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4371178102032452166=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 833052604AE
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 06:03:23 +0200 (CEST)
In-Reply-To: <20150420214441.GW14892@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4371178102032452166==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2015 at 10:44:41PM +0100, Mark Brown wrote:
> On Fri, Apr 17, 2015 at 06:45:58PM +0530, Vinod Koul wrote:
> > This series adds support for managing DSP and posting IPC and processin=
g IPC
> > replies.
>=20
> Any dependencies on the generic HDA stuff you've been posting?
Yes.

So first we need to merge the SKL PCM driver series. Can you please review
that [1] one as well. Then this series.
Lastly the SKL aDSP support series [2] which uses the IPC code in this seri=
es.

One more would be when toplogy is merged, for supporting the dsp toplogy

Thanks
--=20
~Vinod

[1]:  [PATCH v2 0/7] ASoC: hda - add ASoC Skylake HD audio driver
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-April/090621.html

[2]: [RFC 0/7] ASoC: hda - ASoC DSP widget event handlers
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-April/090710.html

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJVNxzuAAoJEHwUBw8lI4NHFW4QAK9OaeUprRgq6Jdt6f8aFhqa
xlWSssC7qZfBBnY2K0sR2SYjQ13Aj+7nPq++itnM6LvR8HX1PBxnL1WlLA1VwNHf
1UkYRVHkxjWjlwE8FDMVdEkklY+UPSM+obVsxNq3ocYtDHZQVMWA91oi82nHLaVw
nkLk7/WPYqJWPr/1xh0VTzdai8d9KASBrIO1IIFqL6jf2SV46GlSIbxxWbtLYKn4
Hv9anTetKN0FtCOoddoFrx4gyrEQbm/O0wftL31HYWe5WpN4xeWa2DT5j0vQFfWG
exDjn7HKwCcY8YNLxMwWk01FXjCRyJBXIcXRaVr3YpJS+2SgJ+gwYWBjixP7Qtil
5cq5dNQ9/Epa3O4J4Oh6Bhirz6zGrnEUyPJ1uoOGUtF6lRxrt2rfGugs5N7VW5r0
kvXnvqcuWUMlzBq5y8DKdcQ5ZQxIqt25ZLTZf7KnXTFWu/2eXLWH99dftSqO9Ex0
Rn2ZguADXy07wxcY0TDbmURY+zAcAmlgb4BPSCGinqt+3Y41/Hq+UKpUEyzV4eox
jZiNr1kQtTT7VyycQ6brwqliF83G3k5mhDSjGMBeX+woU9/RklkKeUMBxGUJWvux
T+IvZ67hPvr0r5g/K5bK6DPdYSMkxqlwzEr/Wgci6YLYQmGodjLtwd+Hi1gkZJeQ
yo379VsSX9bigNcSTZY2
=EMDC
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--

--===============4371178102032452166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4371178102032452166==--
