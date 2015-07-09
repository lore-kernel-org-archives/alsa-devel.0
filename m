From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v7 2/4] ASoC: Intel - add Skylake HDA audio
	driver
Date: Thu, 9 Jul 2015 09:53:33 +0530
Message-ID: <20150709042333.GE836@localhost>
References: <1436153066-23962-1-git-send-email-vinod.koul@intel.com>
 <1436153066-23962-3-git-send-email-vinod.koul@intel.com>
 <20150708190114.GE11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2392062207695116765=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A0F4B265AF8
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 06:21:48 +0200 (CEST)
In-Reply-To: <20150708190114.GE11162@sirena.org.uk>
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


--===============2392062207695116765==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2015 at 08:01:14PM +0100, Mark Brown wrote:
> On Mon, Jul 06, 2015 at 08:54:24AM +0530, Vinod Koul wrote:
>=20
> > +static irqreturn_t skl_interrupt(int irq, void *dev_id)
> > +{
> > +	struct hdac_ext_bus *ebus =3D dev_id;
> > +	struct hdac_bus *bus =3D ebus_to_hbus(ebus);
> > +	u32 status;
> > +
> > +#ifdef CONFIG_PM
> > +	if (!pm_runtime_active(bus->dev))
> > +		return IRQ_NONE;
> > +#endif
>=20
> There's a stub for pm_runtime_active for !PM which does the right thing
> here, no need for ifdefs.

Ah yes, I will fix it here and as well as HDA driver :)
=20
> > +	/*configure PM */
> > +	pm_runtime_set_autosuspend_delay(bus->dev, SKL_SUSPEND_DELAY);
> > +	pm_runtime_use_autosuspend(bus->dev);
> > +	pm_runtime_put_noidle(bus->dev);
> > +	pm_runtime_allow(bus->dev);
> > +
> > +	pci_set_drvdata(skl->pci, ebus);
>=20
> Shouldn't you be setting the driver data before you register the device
> and enable PM?  Otherwise the PM callbacks might run without it being
> set.
Right, will update

>=20
> > +out_free:
> > +	skl->init_failed =3D 1;
> > +	skl_free(ebus);
> > +	pci_set_drvdata(skl->pci, NULL);
>=20
> No need to set the driver data to NULL, the driver core will do it.
Ok

--=20
~Vinod

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnfdFAAoJEHwUBw8lI4NHOfEP/j+gCyZ8MwMEqY63MK9lKPjC
AaNOb27JnUypKsIQLQtQAE0kTJDAAuomsfKypDBzUgJw5u5hkHx55eszCqrhI5BW
WrxNJW7SiHwgPyKxVMvQj1gsQR8UvyWdxXSqs3+m+azTghyPvJHD31FoNTdUEtaa
3g0lpv+i/slPDABbd90Y9obuyk0CSkwRJYseet9Yymu56u6tPmp7eZYtYqDHtbwW
xcNVuRHDZFPamnsIj6n8bMMlrNb2gmzjeSWfyUQpqzhQZUYX9Yx5si0Ql9++pH2/
uEOEFMd019QGUSIfwdafezLo0q4AQkNzt1H7gdJ7i00eiRViWkHDk6rWemj9dL/h
dWZF1jqWOKi274orPUPyHBCpJi4oIp5lBnu0dhNf+Y6uZk6/QUKoURxkBDZnHu0w
bTbJajPmuaZ0rrkW+CRVUtjexHg4zRYLu5avedj7A3Eojb2dGaRZsfhScFKjYPbw
uh/Gn2QDNOoHBskPVCXJUCrFO7Babgpvz5uFnrfPTkScSL269n+/Q1tlefVKtXtS
RFNDCTGp6LuiRkPK/+7HF0iVWmn+0IgHXhlSqvuc/5HmTzfe8cHw+2yU4Y6OQAKv
CCX7wdr+RBNjoRafq/hpgKgDzW7VJJRGS7Y7zXHMp0eQWVI9XlREDkQGDYjEL/z0
zF/mYTImAuwNrd9182HW
=XGDk
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--

--===============2392062207695116765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2392062207695116765==--
