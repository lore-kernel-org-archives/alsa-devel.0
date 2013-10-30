From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/9] ASoC: ab8500: Add missing of NULL
 check of devm_kzalloc()
Date: Wed, 30 Oct 2013 09:33:45 -0700
Message-ID: <20131030163345.GC2493@sirena.org.uk>
References: <1383118507-21503-1-git-send-email-tiwai@suse.de>
 <1383118507-21503-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3730646344744655859=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EA9FE265558
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 18:10:22 +0100 (CET)
In-Reply-To: <1383118507-21503-2-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3730646344744655859==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2013 at 08:34:59AM +0100, Takashi Iwai wrote:
> Spotted by coverity CID 712316.

Applied, thanks.

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScTTmAAoJELSic+t+oim97fsP/RmwhP+hCFXfXg+FL8VecrT9
u2POucmZ1GZNJAFhCKEobJl5tZAIwTJoYYKYvEDyNmfd3pjzGjSLj0+GfZHyxQzP
lhbbhWV0E3BK9UYKzhMqC84hwH9mHUg8HyQzZYxwn1CFwpOS/lOSTAaFQUX0at2d
BChpP+LSOatNrukhzvRvHGGgpvM98PRjPo2g/zkxpw0KgeLGP7IRaI5W/kZxZNCl
PbLEFVEi1MOEFGDTp6IXdK7d15XukezroiNJU/yAvzOdcfsS6dt8mNgH+3HWxNED
N/n5rcOioEpzECw0eggyWg+meBnK6PC1GpoMHVL2qmRl2tyDR9UZV6Gwhl1BUsm3
zXb36exrymQ/WTT5bGNqzDEWmKVPeqiunRx8p1a23CapMyx+fcnuJ26sRsPNhCBN
D0i/6K6wjKjdJKvJeoJ7UMlW2wuIFrTW8j02nQNEfH0cDRJvboqeJKb7Vv8+vSeo
gtnxbCHshKVEiixz1Nn7q4iw9XRbuAFFD43c6H/ceTbJrrh2HT2M9OnEFvhkT9Zc
c2MOYBwGRpqev1qMygrdPKqN6+mHp54owCBfTYEREgZrryp+iYcBEPGVTQcCmmzM
ff0bOKT3u/JmpLn5kdtkCumhliWaHjq9DskI/5M2xHDerJOuNJSp4grRTv1C1vQ6
xJAM+P9gngFRlvI0VzWr
=t2SL
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--

--===============3730646344744655859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3730646344744655859==--
