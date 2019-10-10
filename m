Return-Path: <SRS0=8UIF=YD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC2BC4360C
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:52:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4BA4208C3
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fHrNC19k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="OLb5MxWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BA4208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 248471616;
	Thu, 10 Oct 2019 15:51:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 248471616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570715550;
	bh=TUFQfYwvXnFqJQ7hofLGsHM4QPFCo/smfWMZ/Y+4U8c=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fHrNC19koPpT0sRtNAlnC866wxp7BTw1LkmvZw7q5NTihF8GGWErgo8QWFYSpYiKh
	 JW+XLTkD6Dgnw/O+iFU4AAs5dhS+ToEDA+sppBzfiIwUQxq2naT1PamfhUH6lja9l/
	 d6Wk9SDzcZfnu/FXTVbRZa1S5fZbr6tZrAhVb99A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF4F7F80322;
	Thu, 10 Oct 2019 15:51:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A47EF8038F; Thu, 10 Oct 2019 15:51:38 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11E8BF80113
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2019 15:51:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11E8BF80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="OLb5MxWl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V/JXwCim9xHgJaWTIMmCuENQjrQuhOHBfhhfchcy6xI=; b=OLb5MxWlClMtaennmKs5dNMzk
 WKm8AfEJOMKoj2CQzV8gr+lnf5tOUXnAYmJ4c/gSwuc7iwu+YYKwIaGyUXrZT2x0srTY5W0rEcju2
 30C4X1niDQHVoFx8GdCfS/c7yRrOcBwAJ4bUh762OIwcaq1dEcH1t3Y3sbhZzwvuehp+0=;
Received: from fw-tnat-cam3.arm.com ([217.140.106.51]
 helo=fitzroy.sirena.org.uk) by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1iIYqs-0001Sb-Os; Thu, 10 Oct 2019 13:51:34 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 6041DD0003A; Thu, 10 Oct 2019 14:51:34 +0100 (BST)
Date: Thu, 10 Oct 2019 14:51:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Message-ID: <20191010135134.GR2036@sirena.org.uk>
References: <cc360858-571a-6a46-1789-1020bcbe4bca@linux.intel.com>
 <20190813195804.GL5093@sirena.co.uk>
 <20190814041142.GU12733@vkoul-mobl.Dlink>
 <99d35a9d-cbd8-f0da-4701-92ef650afe5a@linux.intel.com>
 <5e08f822-3507-6c69-5d83-4ce2a9f5c04f@linaro.org>
 <53bb3105-8e85-a972-fce8-a7911ae4d461@linux.intel.com>
 <95870089-25da-11ea-19fd-0504daa98994@linaro.org>
 <2326a155-332e-fda0-b7a2-b48f348e1911@linux.intel.com>
 <34e4cde8-f2e5-0943-115a-651d86f87c1a@linaro.org>
 <20191010120337.GB31391@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
In-Reply-To: <20191010120337.GB31391@ediswmail.ad.cirrus.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 lgirdwood@gmail.com, Vinod Koul <vkoul@kernel.org>, robh+dt@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, spapothi@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
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
Content-Type: multipart/mixed; boundary="===============4553181701931622082=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============4553181701931622082==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/o1eWYFqMAfOorY1"
Content-Disposition: inline


--/o1eWYFqMAfOorY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 10, 2019 at 12:03:37PM +0000, Charles Keepax wrote:

> Usually aux devices are used for things like analog amplifiers that
> clearly don't have a digital interface, thus it really makes no sense
> to have a DAI link connecting them. So I guess my question here
> would be what is the thinking on making the "smart amplifier" dailess?
> It feels like having a CODEC to CODEC DAI between the CODEC and
> the AMP would be a more obvious way to connect the two devices
> and would presumably avoid the issues being discussed around the
> patch.

Or is this a device where for some reason (consistency?) there
really is no DAI and someone has decided to make an analogue
amplifier with a soundwire control interface?

--/o1eWYFqMAfOorY1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2fN2MACgkQJNaLcl1U
h9BJVQf/VmhKdvjGO+iSItUddcgbReAtHb/ahdMnhBgNm54DlfDRuvW2kr32nZDa
6nV6JI0UShGgIrN50nZeXoOTJqJudBkKPeN3bA4qdH09K/3KoUUccKcWFF9XGUNi
C/Ej7gQs/QrIvb2Cs4khYDg3TTzBRQYZgS59UYO0cr/5wQml5uMYCRjwbPTQGkGE
Z12uk1POwiqB7/+PtYf7Il4yn+ijyQlVF51ZUGIRGMDGWQMHqXwGg/pc9VX6bAM1
SJ2IDQ6L+pMpu7Jwyq9ymbTRf94gt+yfjLbLR5lUzX1mAC8CSy9CeSb+d7c3jx61
m3I30E3ocl8sxR6JHqmUUqrsbEB9hg==
=QvNW
-----END PGP SIGNATURE-----

--/o1eWYFqMAfOorY1--

--===============4553181701931622082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4553181701931622082==--
