From: Mark Brown <broonie@kernel.org>
Subject: Re: question about two ASoC commits
Date: Wed, 10 Sep 2014 11:11:28 +0100
Message-ID: <20140910101128.GQ2601@sirena.org.uk>
References: <540EBC14.6090002@mentor.com> <20140909101954.GO2601@sirena.org.uk>
 <857E9EDCA6C0904DB3357321AA9123EBE61DF1E9@NA-MBX-01.mgc.mentorg.com>
 <540FDEFE.5000600@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2286498878025432842=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98AA02615BF
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 12:12:13 +0200 (CEST)
In-Reply-To: <540FDEFE.5000600@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jiwang <jiada_wang@mentor.com>
Cc: tiwai@suse.de, ALSA development <alsa-devel@alsa-project.org>, Joshua_Frkuska@mentor.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2286498878025432842==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c7o3IEw+vx/jOhmI"
Content-Disposition: inline


--c7o3IEw+vx/jOhmI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 10, 2014 at 02:17:50PM +0900, jiwang wrote:

> Yes I can read this from commit message,
> But I am not very sure why not initialize dai format variable in driver
> itself.

If the user doesn't specify anything we have to pick a default, this is
the quickest and simplest way of doing that.

> Now we are having undefined hole between NB_NF and NB_IF,
> don't you think it's better to shift all the others down by 1, to keep them coherent?

Sure, feel free to submit a patch.

--c7o3IEw+vx/jOhmI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUECPQAAoJECTWi3JdVIfQRs0H/1Dr1S/hvMAMrj/ni9fPN0VI
oZZvumBAvFQvkyzDCB75iivRMBf5juTK7Mu36daRdx1IhiqQAd0L8s6QJhQ9V2V4
13URs2EDQX2yH/eUShjcAAdUKjULUqhh5lcKV0KVHDRL4tSzH0+wubSpmqSL61DJ
yyPZ6sQd4hD4OJrvSCkLgzgIo1jchkSx5/HDWAMFnko8Z0AbpdyxkjxrcDhSPp7V
/aYCCuMD0D9YZmF79vBbZ5crTOrX3k8xYFdjx/9stYblet9Le0dwzMWDreUJE5s2
r5JaaKQN9yRz+lTacNerS+aElKWizoMxBRFlw+b0N8xwKTEnkGscIg7snIkBiWE=
=zUjr
-----END PGP SIGNATURE-----

--c7o3IEw+vx/jOhmI--

--===============2286498878025432842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2286498878025432842==--
