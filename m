From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Make sure we only build SST
	drivers on X86
Date: Thu, 20 Feb 2014 00:00:40 +0900
Message-ID: <20140219150040.GD2669@sirena.org.uk>
References: <1392818784-6248-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392818784-6248-2-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8517834973675945828=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C77492656E0
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 16:01:05 +0100 (CET)
In-Reply-To: <1392818784-6248-2-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8517834973675945828==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x9/jIR7Zx/0waMhV"
Content-Disposition: inline


--x9/jIR7Zx/0waMhV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 02:06:24PM +0000, Liam Girdwood wrote:
> Disable build on non X86 architectures. This fixes the following build
> errors on PPC :-

> sound/soc/intel/sst-dsp.c: In function 'sst_dsp_outbox_write':
> sound/soc/intel/sst-dsp.c:218:2: error: implicit declaration of function 'memcpy_toio' [-Werror=implicit-function-declaration]
>   memcpy_toio(sst->mailbox.out_base, message, bytes);
>   ^

But lots of architectures do actually have these operations, I suspect
looking at some of the existing users depending on PCI is enough if
excessively strict (this will improve build coverage which tends to be
useful even if the driver can't be run).

--x9/jIR7Zx/0waMhV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBMcVAAoJELSic+t+oim9I3EP/irV/xN/tU4N7aF8xjeOoyWV
7F5DrSm/vD91iO8ALEcq5wdx1g9mwe6MiX1bXaVw9t/HZufdZN2dHWyF1zkYYCV5
T1dnKsjxFkc2HBf0pyU9UNF19jnj5HMWDtu3pDDHFXsXec0sTGMH4oPvyPkyzDZL
Tq03XA9GUWkBga5/zcixW5xUc7gB5wf2msqLuKnXQRRI2CIAvaaInjsvYABqKx9l
fqPO530cjhV7JdIHljFZA91Tlvjn6JhiYHcGt2WmNJzb3d4Y625xQEazZgAy7aC8
eYwvUrHTmHTroOoSem2rv1a4jAri9ity3TKL5f4MJxglgRAzPKiI6pNNrG7+hjNf
EQHDAFP11NGbLzhf5wMcjFHpa9IbMrAznpoKotLLNkw78IELYuX/dr3Oe3iACxs+
6/OxRNBRdlJgBGOmXwtZwRPxQeAFRWxxym2CFM+A6naoa/DehPtZtB1AgVMICQjv
MI//pBH+jk5E7tjXR+d2C1wG71rRgP5vCwZNVrRBVg0+sgKqIxOpePEbKtgzCqpR
HMiFC7D2HK6waIa6VfngWb5h8dom1Yfcto012TdDrFB4b5sxYNDD65y0VPWtQ6es
FzgAabHECaOm9hO7dh/3RI61UIxrqgymxuDEkdvyI3tEWJXemr1zPdpJBzPGzSnx
s2/TVSBFOKM0KzcGOIse
=5A0L
-----END PGP SIGNATURE-----

--x9/jIR7Zx/0waMhV--

--===============8517834973675945828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8517834973675945828==--
