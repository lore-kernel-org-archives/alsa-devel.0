Return-Path: <SRS0=0EZw=NY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC57C4320E
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 14:50:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED0E60FDA
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 14:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BED0E60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B7D81777;
	Thu,  2 Sep 2021 16:49:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B7D81777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630594243;
	bh=74B1g330j3XFo5x7ASCrKG7fXjCkSQ81tfsxRgQUxzw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R1Vz+Rbg3cNiH1+1VgZ5RQBPQd8/RkSEE27VYOZ0JDjwHdAj/yV96cAhvqpMkVPLS
	 VtlH35HA7PrzkHXgaWuxv2BMg/h23gf/ubZ/hq9PeJKMLl3cKkHOeAwTsG/enEO+PL
	 5uSXI563nd7Zfv/bX45Yi26MvNOMorI+weL26hPo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C1A0CF80125;
	Thu,  2 Sep 2021 16:49:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7CF6F80269; Thu,  2 Sep 2021 16:49:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F689F80125
 for <alsa-devel@alsa-project.org>; Thu,  2 Sep 2021 16:49:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F689F80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Dk+1RcI9"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66B4560FDA;
 Thu,  2 Sep 2021 14:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630594185;
 bh=74B1g330j3XFo5x7ASCrKG7fXjCkSQ81tfsxRgQUxzw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dk+1RcI9IZWuLycsGUAXMvaiX1zWc3TIBzrflsE1irzo5FSEjc40XYEvMmtUXD6ZD
 7KTVJg9+PDs3ITsCcVV77WYVQs79i+HN90MNIIG+KrN3s4uTWUXPG4UhWFyu7dcYBb
 b75dIHkCF7xuI5uoPp97CuegYyHmELwL4ewWOjrBch3v3b8A+00KXeIcG0vdBRuk+u
 gJmWwumQkBbvcdnFn6LJPGc9kswNQsxabbJAovvewCpl0PHe7/uPljqUSapqamWENv
 bgGedZ/GjkdjDRpBgoO806YJsMKGqVp5eZrWptPZE4ndL5aEbx0guOrEJ/s4YIy3oF
 9KMFJxlYTqonA==
Date: Thu, 2 Sep 2021 15:49:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH 1/2] ASoC: SOF: imx: Add code to manage DSP related clocks
Message-ID: <20210902144913.GE11164@sirena.org.uk>
References: <20210902123216.787025-1-daniel.baluta@oss.nxp.com>
 <20210902123216.787025-2-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline
In-Reply-To: <20210902123216.787025-2-daniel.baluta@oss.nxp.com>
X-Cookie: Famous last words:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Daniel Baluta <daniel.baluta@nxp.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
 festevam@gmail.com, peter.ujfalusi@linux.intel.com,
 ranjani.sridharan@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de, s-anna@ti.com,
 shawnguo@kernel.org, linux-kernel@vger.kernel.org
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


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 02, 2021 at 03:32:15PM +0300, Daniel Baluta wrote:

> +	for (i = 0; i < clks->num_dsp_clks; i++) {
> +		clks->dsp_clks[i] = devm_clk_get(sdev->dev, clks->dsp_clks_names[i]);

Looks like this could benefit from the use of the clk_bulk_ APIs?

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEw5GkACgkQJNaLcl1U
h9D6dQf8CQ+j2eYy3OLz8n4W9uYfdEiX+7mQIfuhP8KESkfKUchq2YshYjNxgXdh
89mN6XH8LiikrIMYk+ID0VZ84f5fEKsKSLWlRTNfCU0VV9Gk9lBzGqX0wcfKHn1r
pNAXj7LZD2uJmqMQmXgLcRjBLVHtLgjnrc6XZPxZElzlEzewhMta37io4I/a/Yyz
wp1+BPUxv3wIWFZE4IblYZaX4lA3WnYf2gJDNx3EJCOnuR/xHIrnGrpValgiHUVG
PN6hkNaXcpvru8KVEb7jQR4OFDKQ/IKFdpnXPZeXN8QLw2K6Gi35RqPYwddtQog3
rMbgSPa9NNBVUO0PeY5xBq6AjAFdeA==
=PxVd
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--
