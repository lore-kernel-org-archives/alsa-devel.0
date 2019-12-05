Return-Path: <SRS0=LzfN=Z3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC88C43603
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 09:20:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4765C24653
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Dec 2019 09:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SXe4MR3Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="sbz9UGQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4765C24653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74DC3167A;
	Thu,  5 Dec 2019 10:20:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74DC3167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575537651;
	bh=gL4ujdrl44/ZG79avrgEfS9DYrqr/CajFHuLNIpP+s8=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SXe4MR3ZvtZvax80aOKLi7l5EFaV/4RqPQJIJOUnLkK3kgFzV/hxRGwIGBlI4Pkzr
	 1wcO392C/FlDD7vU0OAi/ZtzJUIPfNkFuYJeRENv6ktzrrIz3vqejHvqm+AMxCH3aX
	 LZrptsP5p7p+FHqTRsiVKGA5eq21XFOL/f8pzsGE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CA6D8F80233;
	Thu,  5 Dec 2019 10:18:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64EBDF8023F; Thu,  5 Dec 2019 10:18:55 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3A30F80233
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2019 10:18:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3A30F80233
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="sbz9UGQF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qTXu1chSMvg/TqynZ+qvzZfYOW1kszelLHD2o9pJ19s=; b=sbz9UGQFtBChdPZN796th3p5o
 hAWrg303/MX02OJbR1kvEYfl/sLhkWapZlDpRnACsubM3lNrUG+5xpPz32fe9n/WMEGSfLhXtzqrt
 EPBLXcHrqH5E90vMyYSSoq1fp1hf9vicSKjCgANnAGikEqkanKxdkYtRfNms7qh/DLfQI=;
Received: from fw-tnat-cam4.arm.com ([217.140.106.52]
 helo=fitzroy.sirena.org.uk) by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1icnHf-0006Nq-AC; Thu, 05 Dec 2019 09:18:51 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id E1FE1D00466; Thu,  5 Dec 2019 09:18:50 +0000 (GMT)
Date: Thu, 5 Dec 2019 09:18:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Mack <daniel@zonque.org>
Message-ID: <20191205091850.GZ1998@sirena.org.uk>
References: <20191205081428.611572-1-daniel@zonque.org>
 <20191205081428.611572-2-daniel@zonque.org>
MIME-Version: 1.0
In-Reply-To: <20191205081428.611572-2-daniel@zonque.org>
X-Cookie: Cleanliness is next to impossible.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: simple-card: add support for
 codec-to-codec links
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
Content-Type: multipart/mixed; boundary="===============7250761348641672898=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============7250761348641672898==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hW3Q5Oh0pcvvyJMS"
Content-Disposition: inline


--hW3Q5Oh0pcvvyJMS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 05, 2019 at 09:14:28AM +0100, Daniel Mack wrote:
> DAI links in ASoC can be turned into codec-to-codec links by populating
> the .params field. This patch adds support for this to the simple-card
> driver and exposes the feature via three new device-tree properties that
> configure the pcm format, the sampling rate and the channel count.

This isn't exactly a simple card any more, and if we're doing
this we should really be encouraging people to use the graph card
not simple-card - it's more scalable (both up and down) and
flexible.

--hW3Q5Oh0pcvvyJMS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3oy1oACgkQJNaLcl1U
h9CNBwf/Q1yg/uS59R9BAUW9knQKG02SyHaLDXydtRTw+VDJyIp40euf4N2KGbYY
8CrCCLotZP1VflF1YKLfKqTsp0fadU3RCGU9AFZO6bx+mNmM2C1XVdDhG2EVXzQc
PGWHRNxCxqvQp7ous2CUfKzw+mry+rER88OGFdznF/XLgqvcI560R7D0D5Vtowo+
SzzlOTqshBiuUmznl457HA6i7B5kE7hECOR9ct4c9nj4xaPTCD8pYvPOythIF0Y9
HXCYSNV70/wB7YH+j7N5Bwy0gcHVR9xlHFK5w+KO+bb1JK3TdfysmCyNVzdJ2a7M
FB1g714mmKpwYFN8hWD6o3w9f8iuJA==
=VQqW
-----END PGP SIGNATURE-----

--hW3Q5Oh0pcvvyJMS--

--===============7250761348641672898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7250761348641672898==--
