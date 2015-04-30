From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ALSA: hda: register selectively for
	SPT-LP
Date: Thu, 30 Apr 2015 21:33:55 +0100
Message-ID: <20150430203355.GP22845@sirena.org.uk>
References: <1430405556-19166-1-git-send-email-vinod.koul@intel.com>
 <1430405556-19166-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5798677012060339236=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E5C8E261ABF
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 22:34:04 +0200 (CEST)
In-Reply-To: <1430405556-19166-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5798677012060339236==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ihr1HbZZ2fheRKVn"
Content-Disposition: inline


--Ihr1HbZZ2fheRKVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2015 at 08:22:36PM +0530, Vinod Koul wrote:

> -	/* Sunrise Point-LP */
> -	{ PCI_DEVICE(0x8086, 0x9d70),
> -	  .driver_data =3D AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },

> +static const struct pci_device_id azx_intel_adsp_ids[] =3D {
> +	/* Sunrise Point-LP */
> +	{ PCI_DEVICE(0x8086, 0x9d70),
> +	  .driver_data =3D AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
> +	{ 0, }
> +};
> +MODULE_DEVICE_TABLE(pci, azx_intel_adsp_ids);
> +

>  static int __init azx_module_init(void)
>  {
>  	int ret;
> =20
>  	ret =3D pci_register_driver(&azx_driver);
> =20
> +	if (!hdac_adsp_enable)
> +		ret =3D pci_register_driver(&azx_intel_adsp_driver);

This feels like the wrong idiom here.  I'd expect us to do this by
binding to the device but ignoring the DSP functionality, or if the
device has only DSP functionality (it's not clear with the context I
have but I think that's the case) just printing a message and not
telling the sound core about it.  Having the driver just fail to load
seems like it might be a bit obscure.

Though to be honest if it *is* going to register as a separate HDA
device then it seems like userspace quirking for this is just as viable.

--Ihr1HbZZ2fheRKVn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQpGyAAoJECTWi3JdVIfQF44H/RYtDKLRizkMUbdIMqJuWNZ2
LfjoHjzx6ClCh3KGoleOK0DU+4OoGiiv1PGOf/VFPtbbvMdVSXt9UBuWEJNaoitn
Q4in111SmoF9vlY3TLSdz1o6YxpOmqCZ/HVuo0fu1QGRcWmsDWX/qoC5floX4o3v
GeQu14rQNenQ2NjmSRHK0lCXrObjVT+7BShJHRopRnZioLiSWgcwjjY+2WcF4TiP
LzeN3FDycEfJxWSop5qkKdikRLjf/zK6wAlKgwTDYE/hK43XNLeH9TUfxaXO7aQ/
M0Kx9dV2W6spGFr+uvzX9AQqBTcIDgbWCIZO2/waOa2X2Yl+GmjTfFHxR7MsW7I=
=g14a
-----END PGP SIGNATURE-----

--Ihr1HbZZ2fheRKVn--

--===============5798677012060339236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5798677012060339236==--
