Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4D9C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:29:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B67220637
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="etSX+WLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B67220637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1FDB1692;
	Tue, 10 Dec 2019 07:28:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1FDB1692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575959367;
	bh=iELEyAZEx9+sjLR/oeXqXnmJuI1nFUO9xLLuE5j7u6E=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=etSX+WLHvpg4caqPFGm6kdR4dLwYB9TF2fm3HcHvdxZi3nWHLw9fwaHcodM5qqxQN
	 MnQ36W+d58HVmFYNZMhDNVipYiEj/93ikhSkP341HKtLpJobUWUMx7fxZgb3vo/P2r
	 qU4GEjNfOSC4APhner5bLsj0M7cG7pBJKQZLOVXA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7BB29F8020C;
	Tue, 10 Dec 2019 07:28:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D7D2F80234; Mon,  9 Dec 2019 17:40:34 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 7F37CF8011E
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 17:40:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F37CF8011E
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1C7B1045;
 Mon,  9 Dec 2019 08:40:29 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E38B23F718;
 Mon,  9 Dec 2019 08:40:28 -0800 (PST)
Date: Mon, 9 Dec 2019 16:40:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <20191209164027.GG5483@sirena.org.uk>
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-10-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1575600535-26877-10-git-send-email-skomatineni@nvidia.com>
X-Cookie: We read to say that we have read.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Tue, 10 Dec 2019 07:28:27 +0100
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, pgaikwad@nvidia.com,
 lgirdwood@gmail.com, mturquette@baylibre.com, mperttunen@nvidia.com,
 thierry.reding@gmail.com, josephl@nvidia.com, digetx@gmail.com,
 linux-clk@vger.kernel.org, mmaddireddy@nvidia.com, daniel.lezcano@linaro.org,
 krzk@kernel.org, jonathanh@nvidia.com, spujar@nvidia.com,
 devicetree@vger.kernel.org, arnd@arndb.de, markz@nvidia.com,
 alexios.zavras@intel.com, robh+dt@kernel.org, tiwai@suse.com,
 linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, tglx@linutronix.de,
 allison@lohutok.net, sboyd@kernel.org, gregkh@linuxfoundation.org,
 pdeschrijver@nvidia.com, linux-kernel@vger.kernel.org, vidyas@nvidia.com,
 Jisheng.Zhang@synaptics.com
Subject: Re: [alsa-devel] [PATCH v3 09/15] ASoC: tegra: Add fallback for
	audio mclk
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
Content-Type: multipart/mixed; boundary="===============9109763122779485353=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============9109763122779485353==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UKNXkkdQCYZ6W5l3"
Content-Disposition: inline


--UKNXkkdQCYZ6W5l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2019 at 06:48:49PM -0800, Sowjanya Komatineni wrote:
> mclk is from clk_out_1 which is part of Tegra PMC block and pmc clocks
> are moved to Tegra PMC driver with pmc as clock provider and using pmc
> clock ids.
>=20
> New device tree uses clk_out_1 from pmc clock provider.
>=20
> So, this patch adds fallback to extern1 in case of retrieving mclk fails
> to be backward compatible of new device tree with older kernels.
>=20
> Cc: stable@vger.kernel.org

Why would this need to be a stable fix?  Presumably people with stable
kernels are using the old device tree anyway?

--UKNXkkdQCYZ6W5l3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3uePoACgkQJNaLcl1U
h9D66wf9EtL0BmittcbTOCbTdEmV+6j2kRHf90+8kREBk+po5Zgw/f04NXW1VR/o
kLtbsSNRWvW6HVGcWiKcNfqwBnq6P5mb2ufc9OsvjWAKJJNBnZxF2AacAn7/I2my
ck6qGzJj4X70Xdt+KkhdTorKJX8PdX3Az9abC77DTq8cH2kbWt/domujEXrR/36g
XCAXHpj+Id9dTLaqKz8z0ZhYsZlzaaW+QTJ12Ocuayna4rF/JB/P0n94rSjBVSVG
ozfOhg7YYn9Q0NaGtjX7tUNX6vSF48kHKfrhfMIEDtkidq3AogcQACno8rg4amIL
EhtifDhVUKFWuXliJGz3WveE8/2MrA==
=CHYQ
-----END PGP SIGNATURE-----

--UKNXkkdQCYZ6W5l3--

--===============9109763122779485353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============9109763122779485353==--
