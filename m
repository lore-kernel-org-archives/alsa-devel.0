Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368B5C001E0
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Oct 2023 12:30:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DE27850;
	Mon, 23 Oct 2023 14:30:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DE27850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698064251;
	bh=9p0AntcfbOKVuz+XGkFoDt43sFlFjI4w0DiNbSxTxHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=V9Tk3oxdRyhCFsfowSNu29y/hehZMXMTZBqwgtrawltnjcEYwq7TTVRBjaxALF2W1
	 FW++PIKY90eveQCl/5I87tk2cYbHneiAD5XXdkdCS0KSxo/uZpWuyJSkVvDZYWab+q
	 xsGj+bAtmekxh4685mkr7PqQbyF8RpTSKB8iici0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 118A0F80557; Mon, 23 Oct 2023 14:29:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D0255F8024E;
	Mon, 23 Oct 2023 14:29:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EDED2F804F3; Mon, 23 Oct 2023 14:29:25 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 32911F8024E
	for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2023 14:29:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32911F8024E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=T95jzUUf
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id F00DCB81200;
	Mon, 23 Oct 2023 12:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B3DC433C7;
	Mon, 23 Oct 2023 12:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698064153;
	bh=9p0AntcfbOKVuz+XGkFoDt43sFlFjI4w0DiNbSxTxHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T95jzUUffCVGKFhalCFOb3kmXNlmWGvOqolVd0L+7uAjMX0CXHdAeSg7iPHiQCv6b
	 XiDAsKRUp1fwZ9uurXiIFh14DPgoM9ht1G5am2BqVeNaki82nLZMdwttRex6D55zHX
	 1kQxMG7BgXkhZpipvIV8hKqTH/cm7rSPk78XmSFdcN5CRvxGyHwx+5L4a8JpjC/fYg
	 FCowMNLrp/S3jFHkEYZQwkbGo4WzfjimgX7w0ZLvfzmtgU3KulDSV4DnBdA7P7YSpi
	 6dF27XjIDcsKFfo/CSe3ubV0DR9UpwQV29kkO2nuw4vqcTr94MTVPP9dDkB1KP4KzT
	 LLFQ7E5MFjnPA==
Date: Mon, 23 Oct 2023 13:29:03 +0100
From: Mark Brown <broonie@kernel.org>
To: wangweidong.a@awinic.com
Cc: lgirdwood@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	perex@perex.cz, tiwai@suse.com, shumingf@realtek.com,
	rf@opensource.cirrus.com, herve.codina@bootlin.com,
	ckeepax@opensource.cirrus.com, 13916275206@139.com,
	ryans.lee@analog.com, linus.walleij@linaro.org,
	sebastian.reichel@collabora.com,
	ajye_huang@compal.corp-partner.google.com,
	harshit.m.mogalapalli@oracle.com, arnd@arndb.de,
	colin.i.king@gmail.com, dan.carpenter@linaro.org, trix@redhat.com,
	liweilei@awinic.com, alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	yijiangtao@awinic.com
Subject: Re: [PATCH V2 3/4] ASoC: codecs: Add code for bin parsing compatible
 with aw88399
Message-ID: <21bfa0bb-d936-402d-9ca9-6bcf181a0f35@sirena.org.uk>
References: <20231020083426.302925-1-wangweidong.a@awinic.com>
 <20231020083426.302925-4-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="epJqc3ICM0Spx94I"
Content-Disposition: inline
In-Reply-To: <20231020083426.302925-4-wangweidong.a@awinic.com>
X-Cookie: Disc space -- the final frontier!
Message-ID-Hash: DT33FVOKOU5QHBHAW77YE5GLQURD3FUV
X-Message-ID-Hash: DT33FVOKOU5QHBHAW77YE5GLQURD3FUV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DT33FVOKOU5QHBHAW77YE5GLQURD3FUV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--epJqc3ICM0Spx94I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 04:34:25PM +0800, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
>=20
> Add aw88399 compatible code to the aw88395_lib.c file
> so that it can parse aw88399's bin file.

This doesn't apply against current code, please check and resend:

Applying: ASoC: codecs: Add code for bin parsing compatible with aw88399
Using index info to reconstruct a base tree...
M	sound/soc/codecs/aw88395/aw88395_lib.c
M	sound/soc/codecs/aw88395/aw88395_reg.h
Falling back to patching base and 3-way merge...
Auto-merging sound/soc/codecs/aw88395/aw88395_reg.h
Auto-merging sound/soc/codecs/aw88395/aw88395_lib.c


--epJqc3ICM0Spx94I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU2Zw4ACgkQJNaLcl1U
h9BRnQf/e8OI4BUyMbll1FxLsSxKd/uMEJW3/Q3iIKUHcY3Co+mV/dNXbJquzZxc
y5A628DP72PFoSSttDaeD+ryG7L+IVViXyr2qieCq134de1NapdIijs9D3h+hRqm
aQ1N+FeXiuXSIz6tVfHQz4gO+zSUZtKXJCxpCDMPzpOCVeULps1wtnjNBjiXa+AZ
OHnjTZxWN9uB4RvF8uQfZetE8IYKzdHnqb4KJqXzBjb6XE6aFBCFuGFuntsJw4bC
X/mex6L1MZj051V77HufhwgRv9NOZj2jLGdHws9Lj6efK63c1mGsYgXSXVFc+PBu
tOjCez7YLOQ1TCSgxDDjo+JAYkpbKw==
=eJ2K
-----END PGP SIGNATURE-----

--epJqc3ICM0Spx94I--
