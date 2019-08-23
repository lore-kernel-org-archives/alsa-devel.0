From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/35] ASoC: Intel: Clenaup SST
 initialization
Date: Fri, 23 Aug 2019 22:39:20 +0100
Message-ID: <20190823213920.GW23391@sirena.co.uk>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
 <a08b2547-3fe5-5c48-9513-c5ade151c01e@linux.intel.com>
 <50932a9f-2f3e-c150-77c7-f021f84ed4d1@intel.com>
 <20190823102652.GM23391@sirena.co.uk>
 <c845fda4-c18d-2ca8-7337-6e6af74d239c@intel.com>
 <70222fac-8c4e-5ceb-3c49-7020196b59df@linux.intel.com>
 <2e2a34b8-2451-01f6-79a1-14f06d1ed059@intel.com>
 <9dfd3a96-f286-34d6-fe57-9b6b8740e424@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3652906554290538228=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A896F80141
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2019 23:39:26 +0200 (CEST)
In-Reply-To: <9dfd3a96-f286-34d6-fe57-9b6b8740e424@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org, "Kaczmarski, Filip" <filip.kaczmarski@intel.com>, lgirdwood@gmail.com, tiwai@suse.com, "Wasko, Michal" <michal.wasko@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3652906554290538228==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="96icqjDFsSi85SgI"
Content-Disposition: inline


--96icqjDFsSi85SgI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 23, 2019 at 03:12:18PM -0500, Pierre-Louis Bossart wrote:
> On 8/23/19 1:44 PM, Cezary Rojewski wrote:

> > Wasn't lying about FW version being unreliable. Let's say vendor
> > receives quick FW drop with new RCR.. such eng drop may carry invalid
> > numbers such as 0.0.0.0..
> > In general, I try to avoid relying on FW version whenever possible. It
> > can be dumped for debug reasons, true, but to be relied on? Not really.

> Goodness, that's really bad. I didn't realize this.

At a previous employer I modified our build stamping
infrastructure to also include both a timestamp and a serialized
build number in the version number since one of my colleagues was
fond of sending people prereleases of what he was working on to
other people with identical version numbers on different
binaries leading to much confusion and checksumming.  You do see
a lot of things with those serialized version numbers, especially
SVN based projects.

> > Personally, I'm against all hardcodes and would simply recommend all
> > user to redirect their symlinks when they do switch kernel - along with
> > dumping warning/ error message in dmesg. Hardcodes bring problems with
> > forward compatibility and that's why host should offload them away to
> > FW.

> Cezary, I know you are not responsible for all this, but at this point if we
> (Intel) can't guarantee any sort of interoperability with both firmware and
> topology we should make it clear that this driver is not recommended unless
> specific versions of the firmware/topology are used, and as a consequence
> the typical client distros and desktop/laptop users should use HDaudio
> legacy or SOF (for DMICs)

Not the most elegent solution but I'm wondering if keeping a copy
of the driver as is around and using new locations for the fixed
firmware might be the safest way to handle this.  We could have a
wrapper which tries to load the newer firmware and uses the fixed
driver code if that's there, otherwise tries the old driver with
the existing firmware paths.  This is obviously a horror show and
leaves the old code sitting there but given the mistakes that
have been made the whole situation looks like a house of cards.

--96icqjDFsSi85SgI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1gXQcACgkQJNaLcl1U
h9BOXQf/ZU3txwyyuIG8wXXp+yRzT8z6cNlyN/FM/K2tKbTXlzhgkQW+RjuB5lV2
ocLIrYeUiEH4DoUVynSV0pFYWwMa4/gqVcn4vk2hvBgB454SQhjhU7pSEp9bu/9I
OEHJq1NpufiyBMcXGzBfTIMFZTxALEHRO2bq+rdnhKvRKyzXP/djfM00Wx8iOMN+
RxNxQDQVgk13BpwZAEmdc1Oz1c77hDi5WSaJPEAU3/4r/JvoYr+IkCmjpLhLz3c8
5EqM7wLd6P5pvLN/ka041o42CB+pjBqX7Rg0vfSR8ICwXYQJf6S3f2xbAdC10iM6
/eJk5AmqCMtbfHjvg2Sc1tUlmeZAUg==
=2Ej8
-----END PGP SIGNATURE-----

--96icqjDFsSi85SgI--

--===============3652906554290538228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3652906554290538228==--
