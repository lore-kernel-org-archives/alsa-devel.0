From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 08/11] ASoC: Intel: atom: Make PCI
	dependency explicit
Date: Thu, 3 Jan 2019 12:33:52 +0000
Message-ID: <20190103123352.GQ1846@sirena.org.uk>
References: <20190102181038.4418-1-okaya@kernel.org>
 <20190102181038.4418-9-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7052627913280738887=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9834A267BA9
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 13:33:56 +0100 (CET)
In-Reply-To: <20190102181038.4418-9-okaya@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sinan Kaya <okaya@kernel.org>
Cc: "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7052627913280738887==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GJ7e10BhKqIkML+d"
Content-Disposition: inline


--GJ7e10BhKqIkML+d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 02, 2019 at 06:10:35PM +0000, Sinan Kaya wrote:

> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly. This code relies on IOSF_MBI and IOSF_MBI depends
> on PCI. For this reason, add a direct dependency on CONFIG_PCI to the
> IOSF_MBI driver.

I still don't understand what's going on with dependencies here and
still don't have the cover letter or anything :( .  As far as I can tell
the above commit is in Linus' tree so I'd expect I can just apply it
directly but you were saying that this needs to go via some other tree
so I'm a bit confused as to what's going on here.

--GJ7e10BhKqIkML+d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwuAS8ACgkQJNaLcl1U
h9AfsAf/Y8iYvN5bwrUXaCdE6npcj44ip+VII6wzCtj/kkF12jE3fs038wm47Wy6
PMwMLgsThOPQ+xnpqR3kKGLVj3NPMXNPEQc88AKH628xL4CnQIlMDkZuTz3kQGBx
PWC3hm3SpPhqnJ4CMcAFMlkUr8pstJgYfYMrYU2lMKP6lcQnehULZH3CqNrVLCAP
RnDtVVM+7aG9Q9uSDCDHwyDHW6MGJSbu1Y1qneYBlAzDtRZLv70OPcKBUhOFp2Td
fV0+F8eu01xcu0OWEPsd6woapz5gWRrWjED4sZ//ORXC4z0S7C8AtquuVstD1pdq
XmOUm5jv+LM/UqCLQR9jFNkXD8XeyQ==
=2d4x
-----END PGP SIGNATURE-----

--GJ7e10BhKqIkML+d--

--===============7052627913280738887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7052627913280738887==--
