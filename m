From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] ALSA: compress_core: Update calc_avail
 to use cumulative values
Date: Wed, 17 Apr 2013 15:27:49 +0100
Message-ID: <20130417142749.GV13687@opensource.wolfsonmicro.com>
References: <1365703245-20738-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1365703245-20738-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130415161354.GD12436@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8826491906937602684=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0C20F265D35
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 16:33:51 +0200 (CEST)
In-Reply-To: <20130415161354.GD12436@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============8826491906937602684==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Lez9QO3Seu3ycz0M"
Content-Disposition: inline


--Lez9QO3Seu3ycz0M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2013 at 09:43:54PM +0530, Vinod Koul wrote:

> As I said last time these doesn't seem to generated against either Takash=
i's or
> Mark's public tree. This comment is as below on all the public trees I ha=
ve seen
> 	/* FIXME: This needs to be different for capture stream,
> 	   available is # of compressed data, for playback it's remainder of buf=
fer */
>=20
> As a result I am unable to apply & test this on any of the trees I work w=
ith :(
> Pls clone either of these and regenerate..

Richard did say (dropping CCs, grumble) that these applied to Takashi's
tree but as he's now merged in the ASoC stuff for this release cycle
they'll need to be respun against his for-next or the asoc-v3.10 tag.
For the avoidance of confusion I'd suggest reposting explicitly
specifying what they're  based off.

--Lez9QO3Seu3ycz0M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbrFcAAoJELSic+t+oim9BV0P/3ZuGCW0gcpMajHLIXs4QKqa
pKiTimYSC3j+b3FRqN5fSWxkot34EM8jwuOlYgXFO4NavNxZJH2cKKPbTuu+mrme
BFzAcAy5bbWTmmoSTNbfHyjtBJTPAR4gYBh5Zn6AmrqaQwqqo/DGE748Z92Oz2tC
APTb/Gdfzx6ajJ6326Ehaxx94q0T3P1FSVSny1Xu5QB6CrOKvOIva6qSzGmQqZHE
fDnc6Wg+DBVm8TyByngb0N+t42JhNy/Yg2b8ZJ7bgifel5Cqa+5q3XRo6vf+CO5F
6T1lZJGj07iJR1gmu4fPjv53XqSpk6ROaE7SXJcwKTs+ApFZgsn22EH+r4bjSTQO
ERWfjaQTyHvWKTk/UHz0UICxzvPUq8hG/a8UBn0h8vvg8ubRQC1DRwoLHwoj0bvu
CAkOQGKloVnJOG9g9sYPKcfjR8GIYqxJh+zkr2HP4Dlfutc7WsMR+hLw0vhR/KRe
TdoKxHiVTW8FJv/J4464jwvm/dHgOx0+Sq+BvOw+7ISkvULvmZbxzCVF+yTkmgde
qLWYsFVft/6eYK2aYK0YlflT843C1mJyTvR3A8U1E5zkVSRNFT6W4QME3ZW3oyEt
49w5WRTlS2ipNPL0s2joHI6pX2RjetiwiIOFJz9Gat+nRMLl2r/nZjmp4TwykPLR
yfZGCVamXK/YX/b769gx
=DJWe
-----END PGP SIGNATURE-----

--Lez9QO3Seu3ycz0M--

--===============8826491906937602684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8826491906937602684==--
