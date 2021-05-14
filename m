Return-Path: <SRS0=jeAA=KJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85B0C433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 12:26:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 583EC61285
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 12:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583EC61285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11848176D;
	Fri, 14 May 2021 14:25:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11848176D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620995183;
	bh=nGDwE35C18UoKa4fmYoRbQeMCmVI6QFhhfBDHADfbnk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hSUxWMXgcvvwOz5onCccyELiU64T0vaybgpfsQp29RfwkGqS+/mDit+p2UWQcFivM
	 O0ufgYZpnmEwFcnB/j96vdG7NIBaOptXXt14nrUywPhA7KzJBlvrxL5e32yI47vmKF
	 cvsoZ8VBj/heOYv3J3IY+mcE+KjttFbvdC7b5T1Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BD4DF8020C;
	Fri, 14 May 2021 14:25:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 78BE2F80240; Fri, 14 May 2021 14:25:31 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E43D7F800BF
 for <alsa-devel@alsa-project.org>; Fri, 14 May 2021 14:25:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E43D7F800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="iNwEXETO"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63F6261285;
 Fri, 14 May 2021 12:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620995123;
 bh=nGDwE35C18UoKa4fmYoRbQeMCmVI6QFhhfBDHADfbnk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iNwEXETObatwCh+yJfmmelZ3UmseQYJSyn6G5LQwjcpxlYHqNrJWQUAs8g6xugGdn
 ZzoKzs0I6eZ9y/dIGA/UzdN4ZsceFPWivZAQQA5C6R1228cFzMF2Mt/IyT7Zy49ctg
 Jc3QGuYWpVsOwKuJdAROazDtf4SwcjPE6YopLm6EASzCfiAudqjhnAWaTTeyLQWGlz
 +ixDFTm2PPzBofrTS/NtsdRAo52/gv1RsEAmnh6+bK+teAxIGXnGcwWWjZ2yTRXR1X
 IulX+AqrdY+87JjshE4YN6J9DhYGhKc29KlcmHK+l3VrRMpkyI6PzJSaNHt39WufWV
 NasR86s28kjlg==
Date: Fri, 14 May 2021 13:24:42 +0100
From: Mark Brown <broonie@kernel.org>
To: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] ASoC: soc-core: use DEVICE_ATTR_RO macro
Message-ID: <20210514122442.GA6516@sirena.org.uk>
References: <20210514081100.16196-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20210514081100.16196-1-yuehaibing@huawei.com>
X-Cookie: Necessity is a mother.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 14, 2021 at 04:11:00PM +0800, YueHaibing wrote:

> -static ssize_t pmdown_time_set(struct device *dev,
> -			       struct device_attribute *attr,
> -			       const char *buf, size_t count)
> +static ssize_t pmdown_time_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)

This unrelated formatting change should be in a separate patch.

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCebAkACgkQJNaLcl1U
h9C8Zwf/WCXNNLFDpGJITMlCXC5ESa2WDBxBO9T3AlyWzM2KLbeZb0bblG26X9/5
vwxONIeyznOd43vSciX167g1x1UlRiinVJ1EQomVHYpBjL8scHVldqYHULopuxaB
kJWV0SAecg0EkTSdCmZN7xN0foloT5dhKVuFFelQceJwL1iqjIQMk43rw7wpP89C
ztVG4huaxnRoT9LTUuU+q1j/mzcVhTtW54LnP5safV9+YfnNbFweHzmTJ9L0wH4I
dutENtL9zwaUFLwZzKXJmdYc3irr1+JF29o0tIGYKdKhRM0fGYLHJ21c0Un5+sSu
YMxkM4pgDHOlOQoEhhPCXk6NtBsR4A==
=dk20
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
