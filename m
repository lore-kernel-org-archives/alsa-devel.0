Return-Path: <SRS0=T8Ko=BQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909F5C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:38:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2378423103
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OLrcDQ1d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTKNqPDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2378423103
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6819811C;
	Thu,  6 Aug 2020 14:37:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6819811C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596717528;
	bh=jL9tYWE9iw+uSM7TMvqp3lXSaJ38TCtcHbCBzrH9URk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OLrcDQ1dNnJE9/A4Xk2hekiPwhe7GhjSAICPeV1fvI3iApOqeZM5AMWLyd5qUQBym
	 FAEOJI6Nh/Mx0+H2i7I0PAW6Zf4LC00OIzvt4GpYJAwLfSL4xOz7DnUR1f5P1EGXEs
	 jpnkfIbv3mvts3dWsrfz9w33inuMq6GrUUP2+HSk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB472F80150;
	Thu,  6 Aug 2020 14:37:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27FD9F80159; Thu,  6 Aug 2020 14:37:56 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 845AFF80086
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2020 14:37:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 845AFF80086
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FTKNqPDO"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0563C22DBF;
 Thu,  6 Aug 2020 12:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596717466;
 bh=jL9tYWE9iw+uSM7TMvqp3lXSaJ38TCtcHbCBzrH9URk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FTKNqPDOSoDVsrkVCQRBkhh82E5jMj1JeoqvMgmSvt/r52lW6IP0hCZe5xb6yX1XW
 Fc8UcvHlqyqILzqf79rqJaDtp8Yb62k7F06R3KpYF6ZDrdDO38gupAtHWt5GOOVQgy
 nVmjkYs7ZtApS1RJ24E/VGn1ob8gmyOC0Nm9rgi4=
Date: Thu, 6 Aug 2020 13:37:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Get "extal" clock rate by
 clk_get_rate
Message-ID: <20200806123721.GC6442@sirena.org.uk>
References: <1596699585-27429-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
In-Reply-To: <1596699585-27429-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: Hedonist for hire... no job too easy!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 nicoleotsuka@gmail.com, festevam@gmail.com, linux-kernel@vger.kernel.org
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


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2020 at 03:39:45PM +0800, Shengjiu Wang wrote:

>  	} else if (of_node_name_eq(cpu_np, "esai")) {
> +		struct clk *esai_clk = clk_get(&cpu_pdev->dev, "extal");
> +
> +		if (!IS_ERR(esai_clk)) {
> +			priv->cpu_priv.sysclk_freq[TX] = clk_get_rate(esai_clk);
> +			priv->cpu_priv.sysclk_freq[RX] = clk_get_rate(esai_clk);
> +			clk_put(esai_clk);
> +		}

This should handle probe deferral.  Also if this clock is in use
shouldn't we be enabling it?  It looks like it's intended to be a
crystal so it's probably forced on all the time but sometimes there's
power control for crystals, or perhaps someone might do something
unusual with the hardware.

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8r+YEACgkQJNaLcl1U
h9AgUQf/RsD8CeWYDbaeEKFdJGHhIhdtwKO8qRAL1Z0U+AS4lEQwWdvppChPN90d
SjiFV8GtE1TIQ3IrzShwKjq4ZU1Kg8qWKcuqnTiqjQDoMJ11Fj6bWXqdwPSGioZ1
3mKOsJKQihgFHiXY+Xm1R3VuwpJiq19qSM94KYTy+K4p1NcS9Usdr5da5007rE/d
2RiyA2UvQjMtbCgOU8ZhM2XCRzwBUyFSGgmHvifONQIX0Sacr85m5SxW7teUVz36
5//kIoJlF/aOpi0dvugXYBPu1Ic8TVAAYWsIxVthtSvmV2dwKlorbO2X/VCJjbgS
V3SZRTvuY8ZlZdkOdxOSlCA8DNgtTA==
=nUjz
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
