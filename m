From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 6/6] ASoC: Intel: Skylake: remove call
	to pci_dev_put
Date: Wed, 16 Mar 2016 11:03:10 +0000
Message-ID: <20160316110310.GT2566@sirena.org.uk>
References: <1458040168-3769-1-git-send-email-vinod.koul@intel.com>
 <1458040168-3769-7-git-send-email-vinod.koul@intel.com>
 <20160316100829.GS2566@sirena.org.uk>
 <20160316105244.GR13211@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2314552668485016919=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BA56265E1C
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 12:03:20 +0100 (CET)
In-Reply-To: <20160316105244.GR13211@localhost>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2314552668485016919==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tbn31orTZdSAVHoc"
Content-Disposition: inline


--tbn31orTZdSAVHoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 16, 2016 at 04:22:44PM +0530, Vinod Koul wrote:
> On Wed, Mar 16, 2016 at 10:08:29AM +0000, Mark Brown wrote:

> > Why is the fix for this not to call pci_dev_get()?

> Why do I need either, I see no reason why driver should be doing this,
> so removed :)

Well, the PCI documentation says that drivers are expected to record a
reference to their devices in probe().  This is a bit unusual given that
normally the driver core takes a reference to the device for us but
presumably there's some reason for this?

--tbn31orTZdSAVHoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW6T1tAAoJECTWi3JdVIfQcccH+wS0/hAKNXeWjs6bHrMBRINu
whH+SlF9mtqmMozYbImD+G8Qzw8XrjiVmJ1XawfPDZUlz/3lEazBy8DEwy6bI8qF
SNWBquCwYI2lixPgg5cRbUcZDzRcYJiVDoI0JnOONBhWEHchEJRoaR8HYNnMWSi8
wG5mYwHwYsI2Z938KBfjChx8vGIxRJGT9H/bl66ZBLNrkWjWQE526xgK2o2Su1K6
77X1L086hHZm8OMlUzndH8C5nYnEqlSUoovH+8NnERI6UFA4tCkqSdEkQ0Lryg2T
9t+D2ZPdMI3vmdUYJcNjcFCw3AHva6EInrdctrswE6sJBQJFp27RdAYhUE6OKy8=
=lCEi
-----END PGP SIGNATURE-----

--tbn31orTZdSAVHoc--

--===============2314552668485016919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2314552668485016919==--
