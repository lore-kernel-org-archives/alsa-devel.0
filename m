From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 05/11] ASoC: Add a set_bias_level()
 callback to the DAPM context struct
Date: Sun, 22 Jun 2014 10:56:00 +0530
Message-ID: <20140622052600.GM22053@intel.com>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
 <1402935191-18398-6-git-send-email-lars@metafoo.de>
 <20140621201437.GS5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8445434629906957071=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 11AE7261B03
 for <alsa-devel@alsa-project.org>; Sun, 22 Jun 2014 07:25:58 +0200 (CEST)
In-Reply-To: <20140621201437.GS5099@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8445434629906957071==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2014 at 09:14:37PM +0100, Mark Brown wrote:
> On Mon, Jun 16, 2014 at 06:13:05PM +0200, Lars-Peter Clausen wrote:
>=20
> > CODEC specific set_bias_level callback(). Not looking directly at the C=
ODEC
> > driver struct will allow non CODEC DAPM contexts to implement a set_bia=
s_level()
> > callback.
>=20
> It will indeed, but do we want them to?  set_bias_level() is partly
> legacy and partly there for the benefit of analogue devices which can
> have more complex needs than digital ones which can mostly just use
> runtime PM.  On the other hand there's a consistency thing going on
> here, but that applies both within ASoC and throughout the kernel.
I think it would help :)

Even on DSPs loading firmware and power sequencing the DSP can get some help
using these functions

I think I might find some use of this for my work!

--=20
~Vinod

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTpmjnAAoJEHwUBw8lI4NHmr4P/2Hjh2noVuXwl78P50x1QIru
iWt4x4LQxLH6ouj4ArbmdqwrAAhljU+XjDFvNtY/dGXfl6dLs4646haDVM8FVIxA
ZSevH/AK+0GTVxo+mLVlLu6k99tntlv84RkXoqxY+Dw637iitNB50UrljQOZRWZQ
cnAl+caqzBsxOyf3qHLhtiIRSvHXWLeJLnarWN8UoXPDWA8hI7VbA01OGjObwhIr
aeUxqdtz0XpVuGfro5iizgkpTMjsCsC9OICy0PSeWY4+z7nQvbLEyqJ9Obg9tdqB
fa09YapgqIlHc+HkweLH/HCGsINZH5/rwpdBmgOw47pHb9gJkeyxiLcJIUnzHpth
oUWOIE+mFDG+ktCYrIQALpaXoKWMyJFWOI4RwTR1xT6czkIUcZKCXzvoAaT8o8C4
agtapAbjkGQ77xCJ3imyzXglwdoIVprOrC/aVfzvmMZiGK16PMz7Qw4BS6H9qlMV
QF0eoLqys8AAHD2dFN04O8T4G8prQ2EnMnZbi0KpaFLsckUjn15rzMuhyxDXzOHS
hkriQE/Ars1rRnG682uaAq0k5ad3MzI9cer8N93OMtlQtk0bPg1VHNVPVzOifiye
OClXArFwaJy8zzd2IecXEEisSvtAm0He1w7uhZADeui5aDfkqDBfvXiKEDQdii7k
k7/s/PQbUv+y1xJWjm8Q
=5HKM
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--

--===============8445434629906957071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8445434629906957071==--
