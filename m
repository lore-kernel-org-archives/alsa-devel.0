From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] ASoC: arizona: Add support for
 directly setting the FLL REFCLK
Date: Wed, 20 Feb 2013 16:44:09 +0000
Message-ID: <20130220164409.GH2726@opensource.wolfsonmicro.com>
References: <1361376579-29051-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0338672562146036379=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1BBFE2616B9
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 17:44:11 +0100 (CET)
In-Reply-To: <1361376579-29051-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0338672562146036379==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uJrvpPjGB3z5kYrA"
Content-Disposition: inline


--uJrvpPjGB3z5kYrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 20, 2013 at 04:09:31PM +0000, Charles Keepax wrote:
> This patch series adds support for specifying the source of
> REFCLK directly for Wolfson Arizona based devices. This should
> allow for improved performance by using the highest available
> REFCLK source. Should the REFCLK source not be directly specified
> then the patches will default to the older behaviour of using the
> 32kHz clock for REFCLK.

These don't apply to either topic/arizona (where I'd expect them to go)
or ASoC -next.

--uJrvpPjGB3z5kYrA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRJP1SAAoJELSic+t+oim9F/oP/0Beyh5X5eiKqLIh6juS+yus
2ccpdQKILjBRUQrEWfK10ndAUnVR5BEgbysHBBIJnxmMcv7xZoja4g/+NDcRkyZs
AO8yUm6zDnLYbMZANFrji2DjhzYmdnHikROCKpuxElHl3SWblM9P2jZkbL12EG99
E/Hk7M6/XOgnd7e02/s6bzclJ/QwUoT/qiovhYiZ12p1rTdNDvBMqfKnyUrCfHrP
2qeQAZJbeN10Nf/FHagmC22V0n8GhiDm566VEserODEBNOvttwDUXPgVvQ/oXnqk
M3BoLWBXFQtPYSiOHlA8GHTc7xsXxWU98lQgbrdt05Gng3Lp77LyRSkE/UQsBm5Y
2F68Sk3Vhk7YPnUrqFicLfmzA81wYHmd6QzkQPqsUYQy0RUIU7ASvfQ2NN4hqeJl
wvFCTP7aVWS3eqeA75YGoD2Z16YXclLQ8Ph39cUpMyZRlmu+/PfLKJH9Z+oKUn30
GtNiYDizCuYG5mUhLVzYysa6kgHTW2yxXB4SpSa3es0BOqlCBDSN5x8bkIUBjM6g
55FOjItgv0nrzpJjM8GcGLpqvBdk8iZbB981kYiNg4+Qo0KyI5CMWXgjYjr8NYW6
PHQChK3jZMQg68gPU2S9g79w/9XyVlnptCvON+RjGBG8ii10MsXlyy+ExG2wW9E4
e19czy9yQaZ9utkBCxXD
=Zprc
-----END PGP SIGNATURE-----

--uJrvpPjGB3z5kYrA--

--===============0338672562146036379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0338672562146036379==--
