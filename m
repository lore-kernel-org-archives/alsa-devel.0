From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 6/6] ASoC: Intel: Skylake: remove call
	to pci_dev_put
Date: Wed, 16 Mar 2016 16:22:44 +0530
Message-ID: <20160316105244.GR13211@localhost>
References: <1458040168-3769-1-git-send-email-vinod.koul@intel.com>
 <1458040168-3769-7-git-send-email-vinod.koul@intel.com>
 <20160316100829.GS2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5667675666310669966=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id DC137265DC8
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 11:48:26 +0100 (CET)
In-Reply-To: <20160316100829.GS2566@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5667675666310669966==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Content-Disposition: inline


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 16, 2016 at 10:08:29AM +0000, Mark Brown wrote:
> On Tue, Mar 15, 2016 at 04:39:28PM +0530, Vinod Koul wrote:
> > In driver remove we call pci_dev_put(), that is not required as we never
> > call pci_dev_get() so remove that.
>=20
> Why is the fix for this not to call pci_dev_get()?

Why do I need either, I see no reason why driver should be doing this,
so removed :)


--=20
~Vinod

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW6Tr8AAoJEHwUBw8lI4NHBj8QAMuPNs+e1mJ59vpebn47kF/D
vgI9YQHOssSkWKqtElTkUsOJecBf+Jfue4WwFupcw6LAWoMajojEoPIKHX3Ax0ZO
jaHIkexbSCCK4pDffRYgt+3UZMxxRgHeosxv/S3FvrsOQpmahVNxnDhh0gZE07K0
dfeY8nMRgTdeMZbb8SjorzDL6bgIZu0/6GFBHVP6LLzGG8UpRPr4+x9oDpsk/qpH
DSSHEby60Yq5y3t+udcGKXK8bNbKjIdpvDHEPdMSj6xgtO+GxqmNOqwfxw2DVb2v
roOBP33sZyn6Az1R0kujGN3qW8xdKJooh1tus/9zUOzEGG/Zw61mcz9CG2q0jAjW
PMuFVsv1aID8bsdizAdwR0YIADsZWpLlZM6xdsyyOv3NUqU+feiBnFWLR1F6LJ2/
K+BHQgSBCPs4ZFhw7Z0Ve3VXi2KbuEX6uTMwNo6Mn1wWD0VwHRS0Me+UV855hj+J
77AaXYS8NsiZjr09xaJvDmsnXf/GZi8gTcNjlIF8CdW04B9hIHWbswQbOUQz9jEA
FLkglTxP2OEMs1o96cAs7v5p7gI2/ceoI/f+6+JzKiNbLV0KCGlVv9tPsCAE10qz
x94LjPZO9ePSRafwE58Ma2kGGStlydV9baktUcvHmrBVvUUneKWhrsXVoKhF8DEq
lZ6GPIqW5l51xYG7aYgu
=vAxI
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--

--===============5667675666310669966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5667675666310669966==--
