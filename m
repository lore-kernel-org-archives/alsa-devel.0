From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: soc-compress: Add support for not
 memory mapped DSPs
Date: Tue, 5 Feb 2013 13:56:19 +0000
Message-ID: <20130205135619.GA4720@opensource.wolfsonmicro.com>
References: <1359104400-18527-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130128040416.GJ26562@intel.com>
 <20130128045609.GA5683@opensource.wolfsonmicro.com>
 <20130128060914.GM26562@intel.com>
 <20130128064440.GB5683@opensource.wolfsonmicro.com>
 <20130128093449.GO26562@intel.com>
 <20130128104910.GB14418@opensource.wolfsonmicro.com>
 <20130129185116.GA27083@opensource.wolfsonmicro.com>
 <20130131030232.GB3143@intel.com>
 <20130205104147.GA22562@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5855639535340143244=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9EB152615DF
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2013 14:56:20 +0100 (CET)
In-Reply-To: <20130205104147.GA22562@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches@opensource.wolfsonmicro.com, tiwai@suse.de, liam.r.girdwood@intel.com, vinod.koul@linux.jf.intel.com
List-Id: alsa-devel@alsa-project.org


--===============5855639535340143244==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+9kyDs7IugQ0lHaC"
Content-Disposition: inline


--+9kyDs7IugQ0lHaC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 05, 2013 at 10:41:47AM +0000, Charles Keepax wrote:
> The ASoC compressed API did not implement the copy callback in its
> compressed ops which is required for DSPs that are not memory mapped.

Applied, thanks.

--+9kyDs7IugQ0lHaC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJREQ97AAoJELSic+t+oim95TwP/3M+8tO1zdz+QqvICw3TG3tZ
5W1LUKYsI7Sm4JRxFpCqTQzH3ezO1m4f5tH7+Tf9iemdmeheNk4j3thrYm0SHN0G
aRCYmRxG58KqS8DE9coP1ZG9XCtAgN4QM0iUsELObr+TAeHz1B0CmF0X9Y1UmCMd
Hj8UGgZRTCeBOPquDHm/W+MiJufi2u1gMuiV8WwM26t6BuMCAQmPXZs1+JjQjI7/
eEhpV1ucT1G18BrVHhf4UsxzXPB8lCWkfPep4ghT90D+8Xbicfw4pS4K4sflAmRU
+4bmdGz+cSonGZjRUZiKHDPyQ4o4GBoiCVsR2SZVJI3e/u12YRaKXco7H6nFUf/9
FX9AC5CgVdYN7kXpsC8UQC7SslXgIMjj43oQqyUg3HmwC8cb6ZX7ztlbk1rvqmVm
l4B4r6d7X4bE20kqywgA1o+ztYKNDIboRzOY3atu95c7eeHzXVY9yAukjqEsmTLQ
4foSdCItYWDBP85sRWgPialzZcumxONrLpgR9kfiNvg/pCrp94QvYHHlLqJ9HpQj
rIRNIFEeP3/FOITiKur7NNhfQ4NjZoXw5wkCHkz1AZHcFZqHjykzqKnrH/Wnb6SZ
incLxiFMK4J/pWKqBv6booV0Pm65qiGbH0BfspfoVv53glT1XGxGkwVPAm4F8M5X
0vWIOuvHWiaB3I0eJrIF
=uVoQ
-----END PGP SIGNATURE-----

--+9kyDs7IugQ0lHaC--

--===============5855639535340143244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5855639535340143244==--
