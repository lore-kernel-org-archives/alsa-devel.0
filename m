Return-Path: <SRS0=7OoL=EF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671B9C00A89
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:55:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35EF20724
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZmctYNbI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zDy+5mup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35EF20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B20381612;
	Fri, 30 Oct 2020 18:54:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B20381612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604080530;
	bh=WyIRFsjXv5w+8VVFK7eNxhmPJtSeLSv3UXi+yyCplRM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZmctYNbI1wFEFJF+buOofh8avenEdZVN4A8p41Z1l1yTynyH/vy5IFX0nbxxWsRZ1
	 R13QoTenlv1F7zHCsRlp3yFd/2xQ0j250dW4wAcHVo8mRmR3fnbOtqvE7u4Frq43WO
	 ABIQ1vh8hyRtNBN9IWqffVG8jqRF7EUAbtTT7nWM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C4891F800FF;
	Fri, 30 Oct 2020 18:54:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 565BEF80212; Fri, 30 Oct 2020 18:54:38 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49263F80107
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 18:54:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49263F80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="zDy+5mup"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 63DD920724;
 Fri, 30 Oct 2020 17:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604080471;
 bh=WyIRFsjXv5w+8VVFK7eNxhmPJtSeLSv3UXi+yyCplRM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zDy+5mupTyPqwhFZOW7mD744CDzWz58CLBw1/RPEp2gnxtjY6r4JFNj/VDvnlhhp+
 pk2QAaOyZ5gyxO4gIX+zwUMJRMhleQKzIkIO+q1di43F49Ru8IN/q+vSv4SsFaJhJg
 hCRnoBCCokXd8NYCs+yLUMy1VE0MThP5FkMvpdOA=
Date: Fri, 30 Oct 2020 17:54:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [PATCH v3 0/9] ASoC: Mediatek: Add support for MT8192 SoC
Message-ID: <20201030175423.GI4405@sirena.org.uk>
References: <1603526339-15005-1-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qLni7iB6Dl8qUSwk"
Content-Disposition: inline
In-Reply-To: <1603526339-15005-1-git-send-email-jiaxin.yu@mediatek.com>
X-Cookie: Blow it out your ear.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, shane.chien@mediatek.com,
 Bicycle.Tsai@mediatek.com, tiwai@suse.com, tzungbi@google.com,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org, Trevor.Wu@mediatek.com,
 p.zabel@pengutronix.de, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org
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


--qLni7iB6Dl8qUSwk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 24, 2020 at 03:58:50PM +0800, Jiaxin Yu wrote:
> This series of patches adds support for Mediatek AFE for MT8192 SoC. At the same
> time, the calibration function of MT6359 is completed with real machine driver.
> The patch is based on broonie tree "for-next" branch.

I had some small comments but they were all pretty minor - overall this
is basically fine once those are addressed.

--qLni7iB6Dl8qUSwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+cU04ACgkQJNaLcl1U
h9C1ggf/YtHZAAqO9N519wguyC9a/9FWSK1GJNx4NkUmdW2O/CX/iCOyQUxNzKnt
uZTt9o6BWcs/GpIk8tDx5KtSsZc+fciFLz8wqlXmu5hgEgJ/pT9+5Wv9GSnAfiAQ
wkY98BDiiTXDFZqUUfkbMOW/gDjuCWhWYwxZCS7AVU+v3+3Mm6kw4fsbwAk2anUo
U98Sjh/26RgPpUaPXGJR2gCGhzYwy0aYodnKxEdsgF/5mhXyzjpG+ps/G1xfWDEe
Nk5T7UoQCGAwaWZYVc4DV4dk0jVGZR7h5Cywf97pUYaANBV4UUGwdH2Ssqt0tOc2
g1v0F4GmGt5dT98mnx4H6+Xiw3wiaw==
=FE4p
-----END PGP SIGNATURE-----

--qLni7iB6Dl8qUSwk--
