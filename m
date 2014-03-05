From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/15] ASoC: fsl-ssi: Use regmap
Date: Wed, 5 Mar 2014 14:21:14 +0800
Message-ID: <20140305062114.GT13126@sirena.org.uk>
References: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
 <1393430538-32333-2-git-send-email-mpa@pengutronix.de>
 <6dc5873dcdf54e13aecbf7c6be03f8bf@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0013832744309674078=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <6dc5873dcdf54e13aecbf7c6be03f8bf@BY2PR03MB505.namprd03.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============0013832744309674078==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aiJlF+TB2UsRxGRQ"
Content-Disposition: inline


--aiJlF+TB2UsRxGRQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2014 at 02:08:45AM +0000, Li.Xiubo@freescale.com wrote:

> > +static const struct regmap_config fsl_ssi_regconfig = {
> > +	.max_register = CCSR_SSI_SACCDIS,
> > +	.reg_bits = 32,
> > +	.val_bits = 32,
> > +	.reg_stride = 4,
> > +#ifdef PPC
> > +	.val_format_endian = REGMAP_ENDIAN_BIG,
> > +#endif

> Is this really needed for your PPC platforms?

> If so, I think this should depend on one specified platform, which
> the CPU is in LE mode while the SSI is in BE mode...

Since the entire series depends on this patch due to the fact that it
makes changes throughout the driver we need this resolving to make any
progress here.  Perhaps it makes sense to restructure the series so that
this is at the end rather than start of the series?

--aiJlF+TB2UsRxGRQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFsJXAAoJELSic+t+oim9EhsQAIYkSnW5wnSqHeTml69Weacp
KGvAFKjFGRMcT5lOFD9SD2JE1i8/TLMLgzRkZzVIcKcxGiECUpqT8FVu0RV8zzU6
pQr5OAghDxI0TjTMCAJ8CMhOtoRJT/xd21hcMlSHRCtzmRGBHzBWfMD9jJDU8DNZ
g9O9H6DoBYET6+3duC4NKeLcYYQ96g81W0j1w/4aIBRflI//8OCs3vJ4y2jykmJ4
iCe5SiouBqqEsmTpZoFj4dSyVa8sapIDeO9f2kJOOtuEyJ1v+Y0y1vilWgBur8w4
lorJHier4L6gUW0Ma4q3vGxoUBZJq7p+B+SiBVu4jhF6rUqYF02hAl9A7CA7wLmF
nk8n/z/HVlFDeytKqOVqD0cCxnmhG4wfKafimh1JPEdXrJ45Kf+pr1ZblRJgC8Om
JdrFDCm434PL2XOp8x1BCMu5WZvwRGDsjxlnjOBis/fUQKONvYHAVgLMGb8LzS8R
yA50ShbVjwfTvibtVl/htWc+mnUIlSkr4S6v0qqkfsc1BXe0k1tKTsZCRrTfKov9
9OLDnb6bYiq9ja0p5qlqusS3TUOdaOuCIlpSorknPe58BFWntMySx4a+slhNO4wp
ep6DXAMoaC4TmpJ97tdSicJib/KcsoOREdsZnERZZPVl9fkHInyq9lmxonahtcwx
rqvWkTpGXmHAvzfJ37bZ
=gqRU
-----END PGP SIGNATURE-----

--aiJlF+TB2UsRxGRQ--


--===============0013832744309674078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0013832744309674078==--
