From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: dapm: Add cache to speed up
	adding of routes
Date: Thu, 7 May 2015 17:33:02 +0100
Message-ID: <20150507163302.GL22845@sirena.org.uk>
References: <1430994839-32584-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1430994839-32584-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20150507124811.GV15510@sirena.org.uk>
 <554B7C6E.2030701@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6681915457418243438=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EAEB265146
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 18:33:15 +0200 (CEST)
In-Reply-To: <554B7C6E.2030701@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6681915457418243438==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sxt2Jc1F/sO/Ms16"
Content-Disposition: inline


--sxt2Jc1F/sO/Ms16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2015 at 04:53:34PM +0200, Lars-Peter Clausen wrote:
> On 05/07/2015 02:48 PM, Mark Brown wrote:

> >Should we just have the cache in the dapm context or the card instead of
> >locally?  It's only two pointers at the minute so there doesn't seem to
> >be much cost from keeping it around and it might generate somme more
> >hits for some use cases.  Or to put it another way why is the cache
> >optional and created and re-created here like this?

> I don't think the cache will produce hits anywhere else other then adding
> routes from the same route table. That's the only place were the same widget
> or widgets close to each other are accessed sequentially. I'd prefer to keep
> it locally.

It's probably the overwhelmingly common case with the current
implementation at least, we might get some extras from things like mic
biases on boards and CODECs that handle variants by using multiple
routing tables but they'll be vastly less common than things from the
same table.  My thinking here is more that improving the encapsulation
makes it easier to do a better job later for no meaningful cost now.

--sxt2Jc1F/sO/Ms16
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVS5O4AAoJECTWi3JdVIfQuDcIAIPAboBuOYPsoQXnt2NRPm03
7KQxuRSfrxHxl6wvT+RIdxn4Jp1mxLlI/Bz3Ymrxv05NcE2a6QrFpip86/yx8062
IeDh+H/FdMX1oNbVg/enFZmFAVmvAEYcXOd06RZq4vLUbq6htoaMp5rCiThCjshQ
bgV5DPA5i+ZIIxcrPdWaRtMF2tJHzj6ZITjnATPtAGODNSrN3t4Axw50IkTkyUTB
iyVZQEB65Jic/uY2owTosLCCwwlj8UUXYuiPUg3/9f/5BB4q68QnTHzjYPvhfqJx
aoYWAgs2ITG7maCb8sGt370KGUxjZbcaQ7ja6F0jZsz9cV+s2PHN/mbaBkvhmKg=
=tx/+
-----END PGP SIGNATURE-----

--sxt2Jc1F/sO/Ms16--

--===============6681915457418243438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6681915457418243438==--
