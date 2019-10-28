Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97F2CA9EC0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:15:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1474208C0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iaGLddIg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="N/Vt6qJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1474208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 276911AE1;
	Mon, 28 Oct 2019 13:14:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 276911AE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572264946;
	bh=ffkFZrEsFdNt1yh0kGVxiUo2/03bxTMdFzZCzJvd+lA=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iaGLddIgXBR/8bt3nogtDOnVhV12NFgj3Gm6JUd4DMe1bb2aSHTJqy+tDBdIrNAGW
	 RvEzEBKuPtoBj8rljeA1LG80lQh2+7TRObE7SRxnujy5SNE1+PYwRlxK92aIdXcMFp
	 1VZwZAiTaao9sdUGf8SQgc0SetHckqdgGbL0PMcQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0A71F802BD;
	Mon, 28 Oct 2019 13:14:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1B9BF80361; Mon, 28 Oct 2019 13:14:54 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9E8FF80145
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 13:14:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9E8FF80145
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="N/Vt6qJj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JLe2c+EkG7wcTbmQqXIbCgw4WEkYtNnMoct2ekTYVVo=; b=N/Vt6qJj+37VNvQWF0xMt4I5Y
 qBxH1mHajhhMJMfj+fnkr47wT5Tuxu5GNdDowmDuJtZP3elSbXGAeQdRnyZ/bZl5Y06HlqPzpv2J4
 YZmWGIJgFPy0TOf057TZz2UoFScoTd8myacIg+Q6DG9iianV6G0L7QyE/EOzQhqJE3Tq8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iP3v9-00083V-6s; Mon, 28 Oct 2019 12:14:51 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 40F6E27432A5; Mon, 28 Oct 2019 12:14:50 +0000 (GMT)
Date: Mon, 28 Oct 2019 12:14:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Message-ID: <20191028121450.GD5015@sirena.co.uk>
References: <CA+Px+wUAzwf1kYD8eMogE9Y6Euw4_-itc5EPWU19c_Sg6+ypQA@mail.gmail.com>
 <20191024191411.GH46373@sirena.co.uk>
 <CA+Px+wU0MAJVbS42X5J=RhDoz4C1M5VcW0kV0ji73sBtMM6omA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+Px+wU0MAJVbS42X5J=RhDoz4C1M5VcW0kV0ji73sBtMM6omA@mail.gmail.com>
X-Cookie: The Moral Majority is neither.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@linux.intel.com,
 Benson Leung <bleung@google.com>, Dylan Reid <dgreid@google.com>,
 Hsin-yu Chao <hychao@google.com>
Subject: Re: [alsa-devel] Questions about max98090 codec driver
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
Content-Type: multipart/mixed; boundary="===============1056690676733580192=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============1056690676733580192==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 25, 2019 at 01:09:06PM +0800, Tzung-Bi Shih wrote:
> On Fri, Oct 25, 2019 at 3:14 AM Mark Brown <broonie@kernel.org> wrote:

> > Wow, that's a bit special.  I'm wondering if the PLL unlock error
> > handling isn't connected to the PLL configuration?

> I don't quite understand here.  Did you mean: when max98090_pll_work()
> get called, the PLL may have locked.  The code doesn't check
> M98090_REG_DEVICE_STATUS but shutdown and on anyway.  In the case
> max98090 may generate a new interrupt and again and again?

Something along those lines yeah.

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2227kACgkQJNaLcl1U
h9AwrAf/ZonLyPVpcBp9k/PCkQaRWhTRXjSY/JqWr8aFBCgCDt5esfdSxcZS20vf
Tzei+0SH1WzGxSGo7XHxvRsz99bbn5jVCNRCqN+UiAznebEPh//ZR4Ua+EzGdGB4
GVibQT2FNZty1HWgtlC1cCMORmDlveUcWTYkhiVJLf/jpr4abWDOjpYuD4DpNpsu
NPQNQKT7aScaboO4vETXOYql/xWZ7KxiC81zf+5Bsmnx+VA/+z0n8Of5tjVmjI04
3pcdaMsFFMS7JDtddHJ5Y68IZYxHsllv/Elojujam9lnoJdOmQqiKnoOH5M3VnnD
VxTUzu3dhQJ1RSs6nn0xRnpcbnzJPQ==
=kYw8
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--

--===============1056690676733580192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1056690676733580192==--
