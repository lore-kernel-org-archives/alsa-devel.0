From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] ASoC: davinci-mcasp: Fix bit clock
	polarity settings
Date: Tue, 8 Apr 2014 19:04:51 +0100
Message-ID: <20140408180451.GM6518@sirena.org.uk>
References: <1396611107-30765-1-git-send-email-peter.ujfalusi@ti.com>
 <1396611107-30765-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1405599311749571315=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E42B4264F40
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 20:05:06 +0200 (CEST)
In-Reply-To: <1396611107-30765-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1405599311749571315==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qgof7w7UksPF5inF"
Content-Disposition: inline


--Qgof7w7UksPF5inF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 04, 2014 at 02:31:41PM +0300, Peter Ujfalusi wrote:
> IB_NF, NB_IF and IB_IF configured the bc polarity incorrectly. The receive
> polarity was set to the same edge as the TX in these cases.

Applied, thanks.  I'll apply the rest after -rc1 comes out since there's
an interdependency between this fix and the rest and I don't want to
rebase at the minute.

--Qgof7w7UksPF5inF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTRDpAAAoJELSic+t+oim90fMP+weXH4pP3ke8eWuALIc7YsS1
01UuC1i7IsmFaESkg0JVYUZplLLDdnp7e0WhHcdr79hgG5426FoIDYk3taNyeyJo
6Mfkhk3nSskrN6LE/z+XvRPB7rRpkhvX5+0gFrpKMSjCUxhVFJ48d2L2WVN4u1Eo
3wDoEW2vftAYCL0bGXarozsX7xdw9SHhLUuC5/syeevmcqjjOK7IiwdXY74dOPeu
qTbi7ZK1MSfCI+agjKB29dhc0Z4IMG9pSFke/p/nCs01oF6S6TUuxpfu/5uYluxr
TF9fulYNUBE2rFhNRJvvIea3sk/Z6619O/8Sq54enZFV6QBaD+GowRH1G/ZRFwp0
OXwJ0gYFsgfuqCxnh5j5pCtRfzIOHOkLrlkbVuzVy39ipOYkXy5D1DiF0t0dYjCk
bT5GQrby4nmUvHt/Pr2CB/kLH7VQX9JKED8Lg87UdZ0nmx5bS187aBsH+FbhbYRu
q/aKXTh3b2EU4SmGGG7PO/t1Fbfqh5cLOH7gSxcd1GFTHb37hyGKMF5uimVG8vTn
P9QDwjctAYh+aXSaAIKFLXJzYKjdAJAyp/Jo09Zfe68tSBEvGxskCZNxJRVGKH7Y
XR6XZAHt/h2sZm4A/ondRK3qOi/ickVb7YyrTbbKMl/+yQPu2pRn2W7pBx92Awm1
qSbcno265pIKVVMdD9id
=S3p/
-----END PGP SIGNATURE-----

--Qgof7w7UksPF5inF--

--===============1405599311749571315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1405599311749571315==--
