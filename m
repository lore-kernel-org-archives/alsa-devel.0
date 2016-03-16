From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: Intel: Skylake: remove call to
	pci_dev_put
Date: Wed, 16 Mar 2016 16:07:17 +0000
Message-ID: <20160316160717.GY2566@sirena.org.uk>
References: <1458144438-28912-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6727274164685757018=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 216062661EE
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 17:07:26 +0100 (CET)
In-Reply-To: <1458144438-28912-1-git-send-email-vinod.koul@intel.com>
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


--===============6727274164685757018==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/hzbcv1ZPoZ/SOgH"
Content-Disposition: inline


--/hzbcv1ZPoZ/SOgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 16, 2016 at 09:37:18PM +0530, Vinod Koul wrote:
> The PCI bus takes pci_dev_get() and pci_dev_put() is also there.
> So no need for drivers to invoke these. In SKL driver we were
> calling pci_dev_put() only which is not right, so remove this

This doesn't seem to apply against current code (I don't have the
relevant SHA1s for the dependency) - can you please check and resend?

--/hzbcv1ZPoZ/SOgH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW6YS0AAoJECTWi3JdVIfQScwH/AvHDfJgWPwfMUenTpO8LKLb
r+4RFEgAu6JWVC/9TaybEcfE6xCGjEMBufE23cZ5qK/nlhwzDEGgS3BzCQqQJp8E
RcErwg2xtfuA10VBeJmKSQq3T0DRPnmcJOzYx5Ar0x1I4zofBdf0X1E/bQvDdSRS
3HDfwzvhEnD6Xau3nehYRAJm2X2qzg2bKYwvb6XBbzFsr2MDDdHEg8kZO3JE1Tdl
Vx7b6SObhZSxd+OkRTxlG9hagnz5FzaJvpfI136GzvRNHrYH+OgnyYqSrXwahGDK
4WrqF8W//ZBNYDIeG+mSyHNIrLQRIletZlEtZMfrFK0J/2Z7D/fngf5ie03a4IM=
=Q+Hh
-----END PGP SIGNATURE-----

--/hzbcv1ZPoZ/SOgH--

--===============6727274164685757018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6727274164685757018==--
