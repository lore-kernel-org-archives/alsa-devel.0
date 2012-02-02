From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Thu, 2 Feb 2012 18:15:36 +0000
Message-ID: <20120202181535.GG22048@opensource.wolfsonmicro.com>
References: <4f1f2489.c602440a.208e.ffff9d7bSMTPIN_ADDED@mx.google.com>
	<1327511249.11901.37.camel@odin>
	<1328087231.1610.28.camel@vkoul-udesk3>
	<CABS+qY2GADPO+wkmDf5hzT7uaH7v1zNrdAGKnLbip-QAL8V_RQ@mail.gmail.com>
	<1328181472.3974.5.camel@odin>
	<1328184200.26182.8.camel@vkoul-udesk3>
	<20120202120602.GB7428@opensource.wolfsonmicro.com>
	<1328185101.26182.16.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1281328315130001365=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E7E9103CAE
	for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2012 19:15:38 +0100 (CET)
In-Reply-To: <1328185101.26182.16.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1281328315130001365==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B0nZA57HJSoPbsHY"
Content-Disposition: inline


--B0nZA57HJSoPbsHY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2012 at 05:48:21PM +0530, Vinod Koul wrote:

> your thoughts on how this should be done?

Well, the most pressing things are to do something about the hard coded`
codec_dai/cpu_dai in the rtd structure, and to make the mechanism for
starting up streams a bit more integrated with the rest of the world.
Once those are in place it should be a simple matter of programming.

--B0nZA57HJSoPbsHY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKtK+AAoJEBus8iNuMP3dge0P/0tLpJtFdLK1bPQZAebH6tfL
QtaeZirjtbfJDbsoSyDxQAY76eMUvturfm7sVRbTRhaP3wHJ7cFcrcdbdG+NyQGb
wyVoIz6aIN+3hunTYRM+xkkLSQsfPuXsuhaZ+aCdE9iKTsHbeDaZUKnrCWk0pu/k
9ki+9kUjDZvTrS7hIMxcW8DS2SCqtsRBNDCWd6AE98ovjVHvm4C3n5Sb/dTi7nDj
OyzRI4SUFt//ZXH2hQ4N0yh8StZhmCyYJ2Td4hAAWwnFD1jsRhNGySylvWaB+R+s
+ZMXrslX7n0osReJe6qcPvW2quwoPqEIhJQ9OH3RbPPJPBqrjBiDk9tQTrhz83KE
PUJ53c8hpdt67Kwm4G71tOULvCp4XIxGymfLcwABt76xLA73gcgs7ycJVVzS3AWo
+imYg3zSnH42+nye7WejzFWMIrI+X8/PF2fjSMw+yat3yhYRhg2UuO1B4oDI04Ta
EzpoOjsERxXDkSRJrLCtwa2D26E5kthyS/iQ4K5hCi+c9zoq9lPe6HD/8LKaaJNj
aZ/GtUTQ/zI5RyqXoMvNG+VkySUY76TmihAIb1DA8Jn3XFnyQwDi5gkMs9k0PROD
0TMMuFBw53B35adZld7UQDW8SRGtQ8biotkgP0af+7HSEHPAC1c934PtY4ku+xAT
RiXutlgVk5DRDOxWw+lI
=weMA
-----END PGP SIGNATURE-----

--B0nZA57HJSoPbsHY--

--===============1281328315130001365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1281328315130001365==--
