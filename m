From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 6/9] ASoC: mediatek: add mt2701 platform
 driver implementation.
Date: Thu, 9 Jun 2016 11:44:24 +0100
Message-ID: <20160609104424.GU7510@sirena.org.uk>
References: <1464929784-5489-1-git-send-email-garlic.tseng@mediatek.com>
 <1464929784-5489-7-git-send-email-garlic.tseng@mediatek.com>
 <20160607163112.GD7510@sirena.org.uk>
 <1465356742.18601.7.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/TDNEY6SkuiyIcFh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465356742.18601.7.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Garlic Tseng <garlic.tseng@mediatek.com>
Cc: alsa-devel@alsa-project.org, ir.lian@mediatek.com, srv_heupstream@mediatek.com, tiwai@suse.de, linux-kernel@vger.kernel.org, koro.chen@mediatek.com, linux-mediatek@lists.infradead.org, PC.Liao@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--/TDNEY6SkuiyIcFh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 08, 2016 at 11:32:22AM +0800, Garlic Tseng wrote:
> On Tue, 2016-06-07 at 17:31 +0100, Mark Brown wrote:

> > > +	SOC_DAPM_SINGLE_AUTODISABLE("Multi ch asrc out3", PWR2_TOP_CON, 7, 1,
> > > +				    1),
> > > +};

> > On/off controls should end in Switch.

> Do you means that the name should end in Switch? Something like "Multi
> ch asrc out3 Switch" (or maybe a shorter one)

Yes, exactly.

--/TDNEY6SkuiyIcFh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXWUiIAAoJECTWi3JdVIfQB9UH/0Ej7CAci3v4+aqhdCItJnpf
eorPDVX2csDcxEUIlpXGnxH/MQn0YfloED4aFcmrNlzKdudUuZ0EnmXxEK/b6NR4
WhLwXp9JbnInDbZDoXkqv9iIB5Xr1I1mpmIREBpMAsNMR2Be6s6PHV2OPId4aMSZ
j0dpwRrLryH+x0xWEuYzsdYL0ChfjdqkYxeriD0Tva5CJUra64PlxYAOA72x1Iby
Q9B/Cor/QPrAQ+C0GEnluMATboxlDWjjsr58hGQlSdfRapRuv4Qdj0SOSxaki19t
rC7KOUayivoLYV0XNO7MF3x6dhag6i7IF47VEYlgIUpE3LnzSqtWXieIHjVA1xI=
=UR6z
-----END PGP SIGNATURE-----

--/TDNEY6SkuiyIcFh--
