Return-Path: <SRS0=hSRK=XO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D40C3A5A6
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:17:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D50121924
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SaW9UJzU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="TJ2hpf2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D50121924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 439581660;
	Thu, 19 Sep 2019 13:16:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 439581660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568891823;
	bh=m2hBw72vfcxSQKKAxpHXk6cB7ACt8XBy5Q794qv0odk=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SaW9UJzU29tcBy9nGJjjXFKXJqXL/bbjAjohZbqEqqNPwVNU9W+DZwX6K+Md+GI1X
	 Wudfo2tqCQQUpDHcujWEsRMIHmFlEeZ0/AQbavnna9DdPf8noYW4uJuoQzup+lMxHD
	 S/M67PXegcAbHlnEqWBCpCr6GLKN5VucSAqoEAOs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B138DF80307;
	Thu, 19 Sep 2019 13:16:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B441F80361; Thu, 19 Sep 2019 13:16:04 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DAC0FF80292
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2019 13:16:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DAC0FF80292
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="TJ2hpf2U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zx86BvANDXqgOlLMEfxHJJQ82VLZs40MXnR+BWGjgUU=; b=TJ2hpf2U3qoR50HAvcViHkI3t
 dphCsbl8eNgiyl5OMqg3wuM1keZom3KgdyTvUA2+8PM/4p37WAkjKpzf+a7pDjFQMQy2YDaC3z5cN
 3Fd5TksH5E0DiMvADV+7IDB+HmL3Vkw2tQI2hxMf0etaYBsj7ON3n3Fei+L8+WzDuoe0Y=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iAuPo-0002Dj-Gt; Thu, 19 Sep 2019 11:16:00 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 3AF732742939; Thu, 19 Sep 2019 12:15:59 +0100 (BST)
Date: Thu, 19 Sep 2019 12:15:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Message-ID: <20190919111559.GB3642@sirena.co.uk>
References: <87h859hrv1.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
In-Reply-To: <87h859hrv1.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: I'll be Grateful when they're Dead.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-component.h: tidyup for
	soc-component.h
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
Content-Type: multipart/mixed; boundary="===============6489447320221517351=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============6489447320221517351==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2019 at 12:44:50PM +0900, Kuninori Morimoto wrote:

> And it is included from soc.h only. No need to header-test.

We don't currently ever use this but it's still good practice to try to
make sure that headers can be independently included so it's better to
keep the include, it doens't do any harm at the minute and may help
someone in future.

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2DY24ACgkQJNaLcl1U
h9AqRgf/fDi8MYTlxlEAdy9lbFewtzZ5IlgESM9Oe+pWjQuTqtEUFja32bZFszw8
QKw9QEMMUekBClysAArsPJxXsSQ2d989v4X+njIX33KtAraTkT7pav/aknsq4j0V
SbgrQSylQLFGX7pjX3l1wZNIELvmbwmKw+TqwKeaUIO8KR491Cx9OYOqOgQWFwIH
2j69TBrXqwtOl6gkIoX2mg3X+8/4WKcUEWGZDmb49HC4q8OnT7eIYCup+zC785Vp
+yO2wi1rJYGUm/KsnXsxKiz9De9e66aY0D+8yoaKbkFQC2HvczUUEwfOUqp/U2Wt
p+5IUOOGr1Y+6XbeGOiIUmRF1/mXjA==
=A7Hh
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

--===============6489447320221517351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6489447320221517351==--
