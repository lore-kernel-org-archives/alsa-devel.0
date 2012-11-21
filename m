From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: firmware core: Add core support
 to	create and destroy firmware components.
Date: Wed, 21 Nov 2012 15:49:15 +0900
Message-ID: <20121121064913.GP4673@opensource.wolfsonmicro.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
 <1353348765-6238-4-git-send-email-lrg@ti.com>
 <s5hr4npqvlh.wl%tiwai@suse.de> <50AB718D.10207@ti.com>
 <20121121003038.GB4673@opensource.wolfsonmicro.com>
 <s5ha9ubpibs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3225787066484695649=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E89502651ED
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 07:49:33 +0100 (CET)
In-Reply-To: <s5ha9ubpibs.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3225787066484695649==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uGrbifh0UoBBidu/"
Content-Disposition: inline


--uGrbifh0UoBBidu/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 21, 2012 at 07:43:03AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Could we make the endianness annotations in the header explicit for now
> > but refuse to handle anything except LE?

> I guess Liam's idea is to check the first 4 magic bytes as endian
> identifier, too ("ASoC" or "CoSA"), and refuse else than native one.
> It would work, but I'm not sure whether this is the best form...

Yeah, and I do think that's OK for the implementation - I'm just
suggesting to mark up the header with the endian correct types from the
get go.

--uGrbifh0UoBBidu/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrHlJAAoJELSic+t+oim9F14P/RL4Nm1kaSDp4LdZBmhcmrwH
nQQ1UpUc5R71lCxyM7GX5XnbPCI/es3WcIGNNdz/CTDpqMNZXSU99VdsvD/ylT3t
618HnpNE8OMzErVVIy/aYS2NvzdURwEESKQ6xviqkJwNfY7d+NZeKt+7XSmWUmjL
iPMzc/yKlfSBbzLr6hP6/jxTP4k+5F/picC9UOwYD1sZDJKb48q24yw2/eEKdbpX
v1nlJuCY0wCM0T01rhGb2oWoE8tMluzcmoeZmCwGMkipvz25aNrvkpUzMKH0xvHD
fRM2XA1TJDGPOcUEBzeRxlilxROe2W8HcuGmTGzDgc8vaVW2aM7IWMdDY/vbYPFh
5hTeB0RgZe5DDPoGwi0ujQbgVXDgIKXaDplvKxuOCdZByEJLgRy6fblLyWIKDHKm
kKHfr4/TRkqLvS/tXWvIK1VmvdaEJFT1qTl8lYkd38UEnzyHkHLkvMgQmA7FvKtk
e+3u4qM0I/11W2W2YjPVmjdiWJhcAgOnPW3Wg/R0Unu57EEWRk2uTOZkhSu8nV4q
VOdp8RnolkYzFhQTRi68B+5PhAo1O9E/ziD8o5iwFcUNFfK5S8bC9z2QCaddgg3q
cpgBvVjM4kVkDeaxAfUgHQFMNqEsIcW+5x97UBW37HvGMbdh4NV0DEhZsF6Aa6aU
5tpQHgDxaIM/kxNzFJft
=NHHh
-----END PGP SIGNATURE-----

--uGrbifh0UoBBidu/--

--===============3225787066484695649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3225787066484695649==--
