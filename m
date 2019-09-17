Return-Path: <SRS0=kA1C=XM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F688C4CECD
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 21:05:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906EA2171F
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 21:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ghDXSSTS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="DE4HETvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906EA2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92F071614;
	Tue, 17 Sep 2019 23:04:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92F071614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568754327;
	bh=R7/I9QXjw/mWIBmR0asONZLWHkhTIBsQRa3l43Y4VM4=;
	h=Resent-From:Resent-Date:Resent-To:Date:From:To:References:
	 In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ghDXSSTS5WVphgpO7DcDLSLvacu8f6XfD5s/T+wZ5EM8X8sH2Iwni4J/8GgGW4Rx/
	 Uv2NAmPMXUuaDJ0oWVF+uTrKAlIGti9wWp3ZPxskYQ/azzkVZsnvepqCMZg7LCfTVn
	 8Yp1g7jqywxCoesqMEBZMlBT+tEDY7oaj6pFein4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 254AAF80307;
	Tue, 17 Sep 2019 23:04:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E47A2F80361; Tue, 17 Sep 2019 23:04:35 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05549F801DA
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2019 23:04:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05549F801DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="DE4HETvb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Resent-To:
 Resent-Message-ID:Resent-Date:Resent-From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Sender:
 Resent-Cc:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=61LTuPkSN5x9DFXM7C9aY5FpFIcjYyGAu/QnSRBR1+k=; b=D
 E4HETvbUlzzF3M3iH/ng0lYvOIsjH7nRAt2NW+DWbbPieI0WQnddvCWxqNBhOd+ST5Wl8vB9YeiXL
 hc6c3zaKqA+EVm0ajQoWVnXEANgns8O5WojtD82rxUqYOkL3nuKWbr+aKfy5tJMjCnv2wmtZUQs5B
 N2ypNAvyAc8XYKD8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>) id 1iAKeF-0000dX-Ud
 for alsa-devel@alsa-project.org; Tue, 17 Sep 2019 21:04:31 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id BE68D27428EA; Tue, 17 Sep 2019 22:04:30 +0100 (BST)
Resent-From: Mark Brown <broonie@sirena.co.uk>
Resent-Date: Tue, 17 Sep 2019 22:04:30 +0100
Resent-Message-ID: <20190917210430.GA47411@sirena.co.uk>
Resent-To: alsa-devel@alsa-project.org
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iAJbI-0000Sa-CD; Tue, 17 Sep 2019 19:57:24 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 2E53627428EA; Tue, 17 Sep 2019 20:57:23 +0100 (BST)
Date: Tue, 17 Sep 2019 20:57:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
 Mac Chiang <mac.chiang@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <20190917195722.GG3524@sirena.co.uk>
References: <20190917103858.GA3524@sirena.co.uk>
MIME-Version: 1.0
In-Reply-To: <20190917103858.GA3524@sirena.co.uk>
X-Cookie: Know Thy User.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [alsa-devel] Build failure after merge of the sound-current
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
Content-Type: multipart/mixed; boundary="===============6312366146357421911=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============6312366146357421911==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
Content-Disposition: inline


--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2019 at 11:38:58AM +0100, Mark Brown wrote:

> IIRC there was some previous discussion of a dependency on other changes
> here but I thought that was resolved?  I've reverted that commit for
> today.

This wasn't resolved, Stephen's been carrying a patch for it in -next.
I didn't see this mentioned in the pull request for sound to Linus...
might be an issue if it gets pulled before tip.

--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2BOqIACgkQJNaLcl1U
h9DUCwf+LB4ciD6K1POX0vMybBYDmoaK/pFqfxrWoarg2KptPZYr8EVbbe56EATh
ALFE39oibY/d79DrZAgo65uSrx/GHL82HG5xa+3nxoo7ERTvdEmSyj4bEczgBTn7
nmjEmpUkjogq9onvaEUkdcagnAmrVto/6PZwUiM4+4uvj+Sy9y7DjJ3GSMUgAuFy
ACb127VJn5Dr4dM307HM5jhk2bOf3ojt6QMRnh+6SjnvpV2Nzm1DM4OEB8nei0Uz
Mk0CwyAibs/ojrpOHl7i5OVnphz/lj+RLwuBZkquXrFkdme1ST/0c2Ld+N7YQZ8d
wfaSwZ1HHv/PVXd5AtvNvWiKg8MfEQ==
=DCvp
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--

--===============6312366146357421911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6312366146357421911==--
