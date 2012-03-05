From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: dapm - Use card mutex for DAPM
 ops instead of codec mutex.
Date: Mon, 5 Mar 2012 16:45:33 +0000
Message-ID: <20120305164532.GU3224@opensource.wolfsonmicro.com>
References: <1330711872-27436-1-git-send-email-lrg@ti.com>
	<1330711872-27436-2-git-send-email-lrg@ti.com>
	<20120304140939.GH3083@opensource.wolfsonmicro.com>
	<1330958882.4370.15.camel@odin>
	<20120305152616.GS3224@opensource.wolfsonmicro.com>
	<1330962910.4370.21.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4531340688226651225=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 556E2244A4
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 17:45:36 +0100 (CET)
In-Reply-To: <1330962910.4370.21.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4531340688226651225==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q/AGl/UrDvkbRExF"
Content-Disposition: inline


--Q/AGl/UrDvkbRExF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2012 at 03:55:10PM +0000, Liam Girdwood wrote:

> PCM ops and DAPM don't fight with each other, there is a dependency with
> the snd_card->control_rwsem. The calling ordering is different for init
> that it is for kcontrol updates that causes the warning below :-

control_rwsem isn't in mainline...

--Q/AGl/UrDvkbRExF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVO2LAAoJEBus8iNuMP3dlq4P/0iuDEZd4rhx9aZT+WJRgqad
H66I2GSeDE9tVxAZZzORVwG+if5ehXI2OFiozUsPjkmzho/qBMxyfIXS5sVE1LEN
+LuOWgz6wPEA220ddJhd3v7KO8LN06U03h2VWUH5MWxzEqTO9tAuX8nQ2N9a6z7R
BQBm9zu59cRmWgXzjro7ZckGL3OwUdBus/BnvjbDlDahDbQ8YUHSexGcB5ONeO4G
ACpzUXuPPhdqHiQFrCryNBs8uQyGVxvcgqcrUnsTqeRIuFNdAcIcS8hiPPY3Y8nu
X+q/r3aIkZKQP05jJGuPFnLT2haJkbjnhF4eaa5pNEFZUnoxzSI3PZFAfev0Th0N
dpKcrfh3kzCeFwgH8op/aD6j516Gi/+uYWbVoUSGyKuXTFtPho+xAaii6dVaIRcA
4jPTAnej86a4b8cx0qlYSAKnPtsk6dM/2JWGjQSpVmez/HaiY6uB283I5T9ClfR+
a3GWp9LVeq3m2XiqLOkQCONamd9H/Iyl2PKWt2lrs3ZOQDvZmW/gbBnE6yefZhiP
PvkiOtW7wZgAnfOg3hUh65K6da1y632a1y+s5gIfFPvDX6bXPjHT7eRYGDngFxUd
gNjnNn0TMu4BOTvOQ1Zke+zC+caBPaQP/o67h0+NeecEhgiD4Wzd9Au4nGCuE4qB
k+NRBk+px06JLbyyft3Y
=cNYF
-----END PGP SIGNATURE-----

--Q/AGl/UrDvkbRExF--

--===============4531340688226651225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4531340688226651225==--
