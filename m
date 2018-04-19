From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 0/3] ASoC: Add Multi CPU DAI support
Date: Thu, 19 Apr 2018 20:24:59 +0530
Message-ID: <20180419145459.GK6014@localhost>
References: <1524131359-24387-1-git-send-email-vinod.koul@intel.com>
 <20180419111239.GA27188@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5688713017480679997=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 606EB267235
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 16:50:26 +0200 (CEST)
In-Reply-To: <20180419111239.GA27188@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5688713017480679997==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 12:12:39PM +0100, Mark Brown wrote:
> On Thu, Apr 19, 2018 at 03:19:16PM +0530, Vinod Koul wrote:
> > As discussed in [1], ASoC core supports multi codec DAIs
> > on a DAI link. However it does not do so for CPU DAIs.
> >=20
> > So, add support for multi CPU DAIs on a DAI Link by adding
> > multi CPU DAI in Card instantiation, suspend and resume
> > functions, PCM ops, stream handling functions and DAPM.
>=20
> The main reason it's taking me a long time to get round to reviewing
> these is that they're big, invasive core changes with tiny commit logs
> that I'm going to need to go over in great detail.

Okay we can try adding more details but in essence it can be summarized to =
one
liner of patch series title. I.E make cpu_dai in rtd same as support for
codecs. We are adding capability to support multiple cpu_dais in a dai link.

Yes the changes are intrusive as we have to replace every instance of use of
cpu_dai with multiple cpu_dais in the core.

Do let us know if you are looking for some specific to add here..

Thanks
--=20
~Vinod

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJa2K3DAAoJEHwUBw8lI4NHOs8QALJyUcBgpQEl9KXqJQ5ZVjjv
EzQGxJdFnwJnif6/II8uiH+xauweoq/IP61E2GE4V4qNdd6QrQzNuPlkHtDi4OJG
5JrfLce4WGvcnqYgToG8II7/2bd2nvIiPKX6TtjXl2EKviQPXWgFgOkgIHhrHEZZ
LE3bPC3u8fwIchim54rH1vzTKENqxifVt4+CDGGdhOLoaMlLNCRR6rjfkhPKqSiW
ncq+pkvVgmmqmZeVT2PIfDmRlA/+PsNL8NQBJRsBgvHRDIRXO24gr/Cbun543Cqw
O2E/JjP7WOSJxTbnlzwSA5UIcIGFeLivdj1vDGRKq52suRgQ91M7JIiAPsyi6F+p
UUqQGHVkB9ATqZg8J+URepje7lnciwHcpFKo3KOgVl6yim0Hy/UuVd352Ty4ta3S
1RyYNILkyd80obgnYmpZXnwAS3LXBMJ7UT2vENggWm8f/Vpjqrq5nwTQ5lUm7nsD
FaHmB+V8ixn1x51CiH34QBrlmpWg6s6NWIDlk8f8xiJ8q7cYmcIX/z0vtzbvZhyy
M3wQAuoxNgN2LT1wfu2vCOAPDkyzcjM22ax1NXEeOZmnTOEE33cIbXPOBy89017o
IZ5Ahqxi2Y5PrHdaRoV1RMP/hPcYCLRL39OCf6Lyg1LqkFxVpZle6n9t2NOi04Ky
27Koq9hrlVP4rGwdkSoN
=flgR
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--

--===============5688713017480679997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5688713017480679997==--
