From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASOC: imx: audmux: add a integrated
 configuration function
Date: Fri, 1 Feb 2013 00:35:19 +0800
Message-ID: <20130131163517.GC13321@opensource.wolfsonmicro.com>
References: <1359614566-4660-1-git-send-email-b13634@freescale.com>
 <20130131142243.GE2735@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6507544263138766505=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CAE862615D5
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 17:35:28 +0100 (CET)
In-Reply-To: <20130131142243.GE2735@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Gary Zhang <b13634@freescale.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6507544263138766505==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 31, 2013 at 10:22:45PM +0800, Shawn Guo wrote:

> Mark,

> I just found there are much more code between imx_sgtl5000_probe
> and imx_wm8962_probe than just above audmux setup.  I'm thinking
> about consolidate them at a higher level.  But can you give it a
> go on Gary's patch, and then I can start the consolidation from
> there?  I promise I will send a follow-up patch to do it.

I'm not sure what you mean here?  I don't have any intention to work on
this stuff.

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRCp0uAAoJELSic+t+oim96AsP/Rcr0rjx4GxdRzUfz8fqXJUf
TQ9cVDOKh2zQNBtIfyA6GoI5wjcSnL+EUnao/NfHMwAGNoQW+cm8xB6JBBTqY1hi
tF3kDB/abjMCrR/PI7erWOWx8tDKQFwI+wBLvYZ7B2SGY9lBffi3Pf1vin80+LLv
kqWRuXa4ojibnF+OuFiJ6kslwpxAnDmN426ZkcLltjXDotgFFCTUft26DPPaFXUs
YOUtHvX700mczpybonXifrHC7K4Ld1fEsAYltqY6H3IvBYO2WPZVGGIb3/6zyiXR
WHCw4gYIuL+huMZaectNYqCIj2UuyBd6+hjV+s7LUf9ldWm71NCPQ14OzI9ePRCl
FWGwP0/1brRyhqCIwrmoSL517Phia3RehkeZKIdcBYe8wrRxogPPurVZsvtyFTgk
UTWOStW8K9TuTykncjOYNdul0kcm0FsgwQWddmHXDuPtATwdpwSp80CIlMlMDdyc
Fo0vYtlfL81KMp4Kzm1zSNkz+dCeqB9bRYaaoJNi9Hz6zqzeVC/TjuWrC80LhDxs
wJ8O1NOhBcQuIlEwdcwFG55RW35Hbl9hrK045wJKUkhHVWV37l23UjKbhRQHXaHN
7eaew+e2FNpt1AU9oTW6DeojH4S6x+DwJBWwL9KmhlTiMEnXkprqXcbiekrJmMzd
LUIHESJ5EaAuA+nHHlnr
=lYWG
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--

--===============6507544263138766505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6507544263138766505==--
