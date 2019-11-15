Return-Path: <SRS0=30sX=ZH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDB3C432C3
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:15:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D684520728
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="d7MXfi9r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hGfqb+/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D684520728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C2911674;
	Fri, 15 Nov 2019 18:15:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C2911674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573838151;
	bh=oA7lZJb7VW/8iQ9astKTUtmRJrSTuXC5mD+Z8rpaLLk=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d7MXfi9r9oE1lUpjjARP0M3Nn03kZki7o8m2tV8ubpH8e0afbyJ3J1FE/Zr6pYrkj
	 Xk6UKUO4YslrVIGNWGZTNIG4fhO9MUJXar3nITRbAiCWMFR5I5yLXE50gJvAlCVov/
	 Q3dkmpL9rlgre8h6NjMeBvsT9n6XfBGPzc5G1UVU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9AE1AF800FF;
	Fri, 15 Nov 2019 18:15:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 169E7F80104; Fri, 15 Nov 2019 18:15:00 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD0B5F800FF
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2019 18:14:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD0B5F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="hGfqb+/m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RQJdKvZKfMsKQBwkCaC47KvblkeBygS3Ak3RT8kxRFU=; b=hGfqb+/mHc6s3XI50svFEuIPK
 jIXYHIDS3rfz8GPADtDIHhbe1ZJEbh4BPb+OTVbg4qbTvwH2kXzast2yWKmRS+Zo0BU85SGYK4fI4
 v85PwxDYKsoAXrKfrfcMAI6NAQFBAln4xoWyuH/XNnxHjXETf6bcXt69ZgdrN/qMfpwYQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iVfBP-0000m4-L6; Fri, 15 Nov 2019 17:14:55 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 7B0D727429D2; Fri, 15 Nov 2019 17:14:54 +0000 (GMT)
Date: Fri, 15 Nov 2019 17:14:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Message-ID: <20191115171454.GC4210@sirena.co.uk>
References: <20191115160819.15557-1-m.felsch@pengutronix.de>
 <20191115160819.15557-4-m.felsch@pengutronix.de>
 <20191115161210.GB4210@sirena.co.uk>
 <20191115162053.fgsd45seg526gafv@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20191115162053.fgsd45seg526gafv@pengutronix.de>
X-Cookie: Tell me what to think!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, KCHSU0@nuvoton.com,
 robh+dt@kernel.org, kernel@pengutronix.de, thomas.fehrenbacher@siedle.de
Subject: Re: [alsa-devel] [PATCH 3/3] ASoC: nau8810: add aux input control,
 available on NAU8812
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
Content-Type: multipart/mixed; boundary="===============2754368296783668270=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============2754368296783668270==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 15, 2019 at 05:20:53PM +0100, Marco Felsch wrote:
> On 19-11-15 16:12, Mark Brown wrote:

> > It'd still be better to only register these controls if the device isn't
> > a nau8812 so that userspace doesn't see them.

> That's the thing I tought about 10min.. Imagine that: You have an
> embedded device with a very good codec driver (all codec controlls are
> available) but the hw-guys didn't connect all the in-/outputs. So
> switching those controls are useless too. IMHO this is exactly the same
> thing here.

We do have the start of facilities to mask out unreachable controls
already (a machine driver could use them manually as things stand).  If
we ever get the graph API done properly that work is more likely to get
finished.

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3O3Q0ACgkQJNaLcl1U
h9ABdAf+JGTslv/txd8VsZLn4CfToO1Tctrdfr1vcqrb3bsI9hAKjuUuLFO1ffNR
Rh7dZLXeQx54u4KsAiqF8EUuFYIfzaDR2OSk8nKxCxheKSrcx92YyBN9zL2tBvj3
lW3B+pa+/o1Ioa2uP+TB7wd4UYy3w0uQXGky/Ihs5EYgc8ermvkwhgihQ25AwVyk
PtfCYFvAbGMivk3HzIGL4nffYs618v7LWeEzC3f+ZUr0iUlbAa+sYdQAuownwQHD
3PZqgTIJeQPyovRHK82B+nxf49KFfxrOUDDbkYCk8BFPsBOm8yTOVftdW2JCBmhK
qwdb+7uYDn6OH+mABTq0Erpv/vghsg==
=ozqw
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--

--===============2754368296783668270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2754368296783668270==--
