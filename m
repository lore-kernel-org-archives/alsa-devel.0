From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add support to unload/reload
 firmware modules.
Date: Mon, 5 May 2014 12:44:11 -0700
Message-ID: <20140505194411.GV22111@sirena.org.uk>
References: <1399307497-6238-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9124920390720010990=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AF49264EE5
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 02:58:25 +0200 (CEST)
In-Reply-To: <1399307497-6238-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============9124920390720010990==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lwdfKABU4AhUWl+O"
Content-Disposition: inline


--lwdfKABU4AhUWl+O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2014 at 05:31:37PM +0100, Liam Girdwood wrote:
> Add some SST API calls to unload and reload firmware modules. This can be=
 used
> by PM code to restore state and also allow modular FW to unload and relea=
se
> memory blocks.=20

Applied, thanks.

--lwdfKABU4AhUWl+O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZ+oIAAoJELSic+t+oim9gI0P/2UhNkiQ7BKvCcVpTtSSvtfL
EM4JtdaAH5rZORBy/vbavT650JK51i8RIDu0Bs+wsgUojfI43zj1w6COvECHh6Im
sf8RM7mBpd9rThHSrFGWXg0EHJVmONoFvl1AdFJHZm2HqNBmM9pnet7ey48WIKsr
+J/A09/c4B2ch2+0XGvE6kffoaoh3AKiaKUa50SeYC2gmE6bASU2ihXemZm3xssX
Qa4K67B8iS7SXsoVU/PUCvsLeFeJtf0YAguTq3/ofTA2TVtSfq/NWwEZl/71ZVpN
AGrUIfxeJkcOsMsBtngU7EX1g0nONHL6cYzfkWVpX9cxYGT9SfhOYffeXXI/CJgx
vkPXMN5tihU/s2TXIAS32Lf2cNp215bzCIBlTA/vXunwXTwMIvTh7hX0x/R4FUGt
/3y0wmEDcGtyxw94VjUtveJv3UGZAf5LTlW+iaYWX0Ump7ha2uJFcaccNFGO7o2+
p8mmJNUtofj1+VrXkWEzYDRwSfTGFdU6V6Vt3r6Eyd4LQii7CMrpjiLrOIi+1gPR
2sUisICvUFz2zXDvFB7i+FdkNIY6GMLMTr9miNRNdT0TY4ZHJqZgGQH8vQEEy1fz
BZSL/PETz89EU61WRrSGx6c14c64me3ZQ6jWXdyAufZMf0CHV0lm0VwjaaWekvUL
RFoFcOVLJvasyyXlZlbR
=pzYe
-----END PGP SIGNATURE-----

--lwdfKABU4AhUWl+O--

--===============9124920390720010990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9124920390720010990==--
