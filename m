From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs42l73: Fix mask bits for
	SOC_VALUE_ENUM_SINGLE
Date: Tue, 18 Mar 2014 19:41:20 +0000
Message-ID: <20140318194120.GO11706@sirena.org.uk>
References: <1395168981-1905-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7421998206640400165=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 21B7926167E
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 20:41:31 +0100 (CET)
In-Reply-To: <1395168981-1905-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============7421998206640400165==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jnVjxEGowe9uNWSR"
Content-Disposition: inline


--jnVjxEGowe9uNWSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2014 at 01:56:21PM -0500, Brian Austin wrote:
> The mask bits values were wrong for the SOC_VALUE_ENUM_SINGLE for the mono mix controls.

Applied, thanks.

--jnVjxEGowe9uNWSR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKKFdAAoJELSic+t+oim9CpUP/2MkH6AlP8PlIGeb6zFDd1k/
8BfujASrDRcyx/C5y0FCEwtJVw4ysHazqFO7ULujhxyUOMF3y2anjuqPOLfy3b2m
2dU+MFWI8oP/TAROQPv5sr9vcjWDOvvGGY96xwUa/ebNsGFzGlTlP4xKvrnW6lnu
E7c6PDxOu+nU2jsdmZMS35nMynI38ToTK/W7PzUn0HYMCwg6W4OHc81i4ENql+ET
P4g0OrVdk/1Wa61hAuJ90V/8Ac9FVFWxQ4D6Pmwjss4lIF2jmKebwM1gll/+aES3
oATFv1qggUit8rSw8PuvcwFQezWu7YBDI5mHNGJd6bZhb5dW3nPssXsKrhp/xMSI
uMGK1aUTeBC3eCysJ4WuUTjoVqayor7rvKjVSvzzcKJ3n3R+CYfnzWrrmfpfoTXy
cPMuymb/yLWirJSKHac117J9Gx8M2CaO7FXQzkPgluxwa+ZiLd2lX+Ugo83HvlpZ
PZqrlebEmsU/N/TsYqmI6cqlFFBfzvUeS1QwoNcr/+ZFe/ewvxvGUfNnHT4a42oD
Gv3Li1JsVOKQ8XajhU6L8iZDg/aXN06wrdGX4CpS3fBvw0ue000DyiE6LqGFr6PW
D1UH0+UpOF36mTST1uuUa1zbhtdesBSimRREaWkI8HY9eVt4i1P8NeRW1JuJmplu
xprPDwspkadLpoZlof/g
=SpE5
-----END PGP SIGNATURE-----

--jnVjxEGowe9uNWSR--

--===============7421998206640400165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7421998206640400165==--
