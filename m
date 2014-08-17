From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add merrifield machine driver
Date: Sun, 17 Aug 2014 09:57:50 -0500
Message-ID: <20140817145750.GP14537@sirena.org.uk>
References: <1405599225-31538-1-git-send-email-subhransu.s.prusty@intel.com>
 <20140729195043.GM17528@sirena.org.uk>
 <20140812060601.GA1115@vinod.koul@linux.intel.com>
 <20140812214822.GB17528@sirena.org.uk>
 <20140817142023.GA12530@vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1243321833784615915=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A2018265130
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 16:58:09 +0200 (CEST)
In-Reply-To: <20140817142023.GA12530@vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1243321833784615915==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PdAWLd+WEPmMbsbx"
Content-Disposition: inline


--PdAWLd+WEPmMbsbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2014 at 07:50:28PM +0530, Subhransu S. Prusty wrote:
> On Tue, Aug 12, 2014 at 10:48:22PM +0100, Mark Brown wrote:

> > Look at what wm8994_vmid_mode() does...

> If I understand correctly need to move this enabling/disabling of VMID
> to wm8994_vmid_mode().=20

No, it's exactly what wm8994_vmid_mode() is there to do already -
putting the device into WM8994_VMID_FORCE forces VMID on.

--PdAWLd+WEPmMbsbx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8MLlAAoJELSic+t+oim9OYYQAJNoapL1fK53QTDI83UKRORI
x9/X3G5xMkSvELc6kNi4y4ME7BnmRnL5Y5bltv2OHGxp6/LBDIWbK5OOzkGdpg/+
13GLrLiaPpM/8+2w6ocKC8YQBUDsFudDiAzFDUqI3Gypol25G4wpwwPFC8GQfa99
y0SqYpw1yMhX4N4cpYmtsd8cCRs3Ck++iKAk/s3WDl18nnqwliE6z/EsKCQaPkkX
fBvaOVkA9YqrGjzHrUfRihxOYuPw1WywA5VVqT0dXX6YDbk5ddS9Ygkmnlvwyd6d
Yo7X9oCaTDI1jtRsZRFQ9h843tThppHV0tH6d0ruvZI0Vr3zSJ0bzKKTkXiQrVXl
PH/f413ePnq7184vOVFBHqr7t+CxT1Ppe9MvriuBuNOM2Qgglxo44f4X0c7hgnOb
E9GUDPYFPNMYowj8GBD/hLCajBA+IQ2vAgQp/ASVeVKNcjWOl85M6F7pV0zDZqGI
3CFZi/HTMa9O5GsIws72tWZTwIUCSZDEnDB1e9Se0X1DDhklXfYESth3d/bMvKUz
nmFZySgfm/D77whRFVKCuPOsoZ+vjyQACXQxDQmDyDraVKaMl2Qwt8RpGx5u5FET
25xJNc6/FXcP1qcpf7r/1HQ5mOR5eri7xa/XXedB50xZU+NnHuRbgS50+Hijwypo
uHXtWwQ+4+TjNoPNodGo
=Bfm/
-----END PGP SIGNATURE-----

--PdAWLd+WEPmMbsbx--

--===============1243321833784615915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1243321833784615915==--
