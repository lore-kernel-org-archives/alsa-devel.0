Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68036CE7A94
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Sep 2023 14:08:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B33A5DF2;
	Mon, 25 Sep 2023 16:07:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B33A5DF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695650882;
	bh=z+beOv8eP8i270vZ1KGKwTfsMp2RfL6DAYL5zKJa3/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BD61fb0Xj20VjJwBq8zQpkBS+srMECMZjXKxRoh0yiYUmD5BtYN3bsBBB10Fexh0P
	 oZJOqSSJSdCEgzYSn2SV90IvpaUZV+GWn857ysoyVftvGUyz7j3ZjKRxOtS/fWyDQi
	 AUjNmQ+gKmPaROdzlZwMxv1VYNeBWaCx3ZwKuzIM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40300F80166; Mon, 25 Sep 2023 16:06:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D5194F8016A;
	Mon, 25 Sep 2023 16:06:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89033F8016A; Mon, 25 Sep 2023 16:06:30 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 175BFF8001D
	for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2023 16:06:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 175BFF8001D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=MG32E4D4
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 61A9A61011;
	Mon, 25 Sep 2023 14:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87208C433C8;
	Mon, 25 Sep 2023 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695650781;
	bh=z+beOv8eP8i270vZ1KGKwTfsMp2RfL6DAYL5zKJa3/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MG32E4D4v6lLAVuXEpIB0vGfmaXdid2BgKg/yfGteT0SAlvD/+tl/NWbfdW2wbqq6
	 eO8lAvso0JbMOjcKr3Z4ZKmomaScWlzWun6AWg9kIK/BMlEj6vYruZwA41b/cqbX9R
	 lls3NzvHM1USHU/uhE1FszvWEz5ZGOAiEUp5tQhXZJ/0nBr2ygi3bpMiYk53uHqUnF
	 0XnAVdpzLOGgC9nKlOV5agNM3wcH59ka2pivMJLD/H5aBJbuNau5NkASuklgK77834
	 klvPEiJbjd8Kg+h7egHmthYazXTXyfnr/DLaF6J76m+d1lENd4oaHHa8bYV/jvQqln
	 N0+6fybY3WkEw==
Date: Mon, 25 Sep 2023 16:06:18 +0200
From: Mark Brown <broonie@kernel.org>
To: wangweidong.a@awinic.com
Cc: lgirdwood@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
	herve.codina@bootlin.com, shumingf@realtek.com,
	ryans.lee@analog.com, 13916275206@139.com, linus.walleij@linaro.org,
	ckeepax@opensource.cirrus.com, povik+lin@cutebit.org,
	harshit.m.mogalapalli@oracle.com, arnd@arndb.de,
	yijiangtao@awinic.com, yang.lee@linux.alibaba.com,
	liweilei@awinic.com, u.kleine-koenig@pengutronix.de,
	colin.i.king@gmail.com, trix@redhat.com,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 4/7] ASoC: codecs: Add code for bin parsing compatible
 with aw87390
Message-ID: <ZRGT2oLQaJBVVYFH@finisterre.sirena.org.uk>
References: <20230919105724.105624-1-wangweidong.a@awinic.com>
 <20230919105724.105624-5-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QFIK27TUvqKWMvSN"
Content-Disposition: inline
In-Reply-To: <20230919105724.105624-5-wangweidong.a@awinic.com>
X-Cookie: HELLO, everybody, I'm a HUMAN!!
Message-ID-Hash: WZDYGRECEDECJTE5KYG467NNOTOUVJJT
X-Message-ID-Hash: WZDYGRECEDECJTE5KYG467NNOTOUVJJT
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WZDYGRECEDECJTE5KYG467NNOTOUVJJT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--QFIK27TUvqKWMvSN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 06:57:21PM +0800, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
>=20
> Add aw87390 compatible code to the aw88395_lib.c file
> so that it can parse aw87390's bin file
> Modify the function return value

This breaks an x86 allmodconfig build:

/build/stage/linux/sound/soc/codecs/aw88395/aw88395.c: In function =E2=80=
=98aw88395_prof
ile_info=E2=80=99:
/build/stage/linux/sound/soc/codecs/aw88395/aw88395.c:199:21: error: too fe=
w arg
uments to function =E2=80=98aw88395_dev_get_prof_name=E2=80=99
  199 |         prof_name =3D aw88395_dev_get_prof_name(aw88395->aw_pa, cou=
nt);
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /build/stage/linux/sound/soc/codecs/aw88395/aw88395.c=
:17:
/build/stage/linux/sound/soc/codecs/aw88395/aw88395_device.h:184:5: note: d=
eclar
ed here
  184 | int aw88395_dev_get_prof_name(struct aw_device *aw_dev, int index, =
char=20
**prof_name);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~

--QFIK27TUvqKWMvSN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmURk8wACgkQJNaLcl1U
h9AbHAf9GUfsbOtVMPrTo9cIihIM3OVqHie4TXTSEVdAf9Lg9U2Z9NDs92Cbjc9N
7uisNTtQA6NMvc1UAYTYm7R2yRyHiaJRkW8gYmh2opw7WZgO7nbMAchxGMGvZjH8
huc1lVOvgxbdcRnaZYG4RA8l4htTrMQTD2P+8fMmWQNW16d/xn+1/q0baZ/v8KWJ
lAHGTem14Ry7ocS3WxxCJRrCYIp98a7SbyL3t0EbFHFFZM4JQ019PwaI7poDXRTx
CeQmqsUQwnBwqSDCF+pFl15TEmlXEC7QFPm9B+zGjRN+TLD2ilsT3XgJfDfs9tn5
u7FBcRLo6DeHIqOKu41HCAOkMVenfw==
=xBek
-----END PGP SIGNATURE-----

--QFIK27TUvqKWMvSN--
