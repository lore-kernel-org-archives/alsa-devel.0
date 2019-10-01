Return-Path: <SRS0=w4sP=X2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B82ECE587
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:56:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C012070B
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YgBC7INm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="cI5pL9xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C012070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 668AF166F;
	Tue,  1 Oct 2019 19:55:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 668AF166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569952559;
	bh=fvBTofsdGYz6jlQQwzsf3++lwnu7SMY6VB3L0E+PSTc=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YgBC7INm7abdS+XYBmk8bdCKB7UJ08tEBWlFC43W4RcAk97YbtRU8OvmGHN/uKX0k
	 WRXEVBRbo8kxUnx25fCod0qbCvd0dxEWE4a/rowvVEA6916axesF8tQfnmN17TVdKA
	 rOHrr45l2+FzL++3xM8Yx5zAUc7WRK8lyV5PFiQA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE798F804FF;
	Tue,  1 Oct 2019 19:55:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D843F80506; Tue,  1 Oct 2019 19:55:07 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3F43F80482
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2019 19:55:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3F43F80482
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="cI5pL9xv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UdeDTcRqRLmOWNI66TIvhiXBuusNntkv2kJPDqWMITI=; b=cI5pL9xvdMaZoQSXt/BoTvwCf
 6MS2X7NqiP8DNfNNUfGVb1cu90q/m0myKcYkXX8xFft8BLi1/eB1uQnWkEvPaSyVqJ7zv254ZjiaL
 0xfG4zbL4U3UWysSzRXKZSORC6SNhkkmiB1vOhVgMIPOuM7iGQ26qhGgh++OtljBweJ90=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iFMMZ-0005rl-6M; Tue, 01 Oct 2019 17:55:03 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 13E7327429C0; Tue,  1 Oct 2019 18:55:02 +0100 (BST)
Date: Tue, 1 Oct 2019 18:55:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191001175501.GA14762@sirena.co.uk>
References: <20191001142116.1172290-1-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20191001142116.1172290-1-arnd@arndb.de>
X-Cookie: Happiness is twin floppies.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 linux-arm-kernel@lists.infradead.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: atmel: fix atmel_ssc_set_audio link
	failure
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
Content-Type: multipart/mixed; boundary="===============2647782273404721673=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============2647782273404721673==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 01, 2019 at 04:20:55PM +0200, Arnd Bergmann wrote:
> The ssc audio driver can call into both pdc and dma backends.  With the
> latest rework, the logic to do this in a safe way avoiding link errors
> was removed, bringing back link errors that were fixed long ago in commit
> 061981ff8cc8 ("ASoC: atmel: properly select dma driver state") such as

This doesn't apply against current code, please check and resend.

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2TkvUACgkQJNaLcl1U
h9BpXwf/ZbLU57SSOIs72nreZTj7QYl5ewRdha8NvlgMpwL9Tpoann2+x+D1YwW4
YrgZi10+u/d5JJXj26Le5tfl9/XHOiEtnsmSGeyyZ4HCMkGdsN/pbOteyNVq8OSm
m0kbUZzyPrs4UShvQmtmf/NVGAEMno5FWExHJMesI+HCkAguc43qkgPrhCK6w6hE
OTG/+vIokBlBGCwqdM597185U5H/O/zeEtMF//UhLEOyzm7SiowvGAFOukr7PQzK
UCJeArfyY1ik0gYbptXvjoo3+Y1DKg/sRNdtNoF14WIS2oHOkTKm6dpuqxfN2RIt
He43J5QRq+JEaBnzvw/+7mvakg5Rjg==
=mk8+
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

--===============2647782273404721673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2647782273404721673==--
