From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: sst-acpi: Fix Oops in case of
 missing firmware
Date: Wed, 26 Feb 2014 08:47:21 +0900
Message-ID: <20140225234721.GD2927@sirena.org.uk>
References: <1393339067-10307-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0828778990001459601=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 360BB26565C
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 00:47:24 +0100 (CET)
In-Reply-To: <1393339067-10307-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0828778990001459601==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2014 at 04:37:47PM +0200, Jarkko Nikula wrote:
> I swear I tested missing firmware in commit e5161d7987f1 ("ASoC: Intel:
> sst-acpi: Request firmware before SST platform driver probing").

Applied, thanks.

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDSuGAAoJELSic+t+oim9dEIP/RNcTRNLXiAQLufzNIf8fnJT
m954UrUn3GH/ZxV6LJNDZTEsfYFwYuXSIU5787UuWle69wgcMSt/xvWbfPiHnHf7
ciLFUye+SAh2IZMLA7qd9Djo6C669zfwQTc36CQaCHFbs51xmTy335f1GhRWlh6T
5Q/9QebOzNm5IVxxJ73z7JBHoWjUw9ucbl8rjVoXBGofUkkxvpmyM2IhMZk8wwRK
qLPBN/737kJ3u6hGR0/4RkEzrUF6BCXt5gqGVnE3e1+qk0koXbe/8oMkkwhytra8
FkYCT5tq3Oyofi2noqW7b+UipHFSkCPr1ONpc4dFc61jVS6/Tm4H9TyDW3/gyfjg
Y6t2k/unIzLG65J1uoxK8HfUIGS9tDP4ffcFSW1ls+AkTOrv27Pz7lFAeCQtX8vO
gnM1dB9U4ZtNLYszj2ugzEaYHtVYjvWienmVqEhCTZQv993WAO7mI40Wqi4cN4LL
A+pZJXbvbQZ5DG6JkfqRylQ8f/nIXNzgTWQJbJ0Ks/J4DSzm1q25Rj9ABqjhkebp
Y81bAE5qgR5CwfQg5SwOv/4wZuwW+mCDEA2Tpp/3cuRzFzu3Y77yTs3Md/Gof4IC
VNy7k5zdcn7+dMs7d/PWhMV0hr50vwLe+8Cm1POFeGfffz9cK+RQZURl2nZ5wXNH
8+Xh641JtD+BYFAZEoH+
=CcAu
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--

--===============0828778990001459601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0828778990001459601==--
