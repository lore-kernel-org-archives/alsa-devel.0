Return-Path: <SRS0=jkt5=7E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1BCC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 13:13:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D16206B6
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 13:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RkS7oMHD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5GKNdFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D16206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 315D71881;
	Fri, 22 May 2020 15:12:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 315D71881
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590153223;
	bh=eJKC82/JdUZHlra7wt2AcwBxZx0GOUHbM5qLt27y8DM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RkS7oMHDar00dVu306M54RY01AG/ChPnJckoXdKHJ45m94KkTupzHt3t25JFO79/V
	 QaOV8Jr7gR+XioNHEiW42LimXUbbkQskNuwayu3ZwSBcxzyJzfHhJfQk8ITjkf9Frp
	 l8sKRrHPIRbyHOO3L001vJuIK+bxGCyPzltdN4Hs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2BE0F801DA;
	Fri, 22 May 2020 15:12:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0567F801F9; Fri, 22 May 2020 15:12:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC183F80140
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2020 15:12:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC183F80140
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="f5GKNdFg"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B4C7E206B6;
 Fri, 22 May 2020 13:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590153165;
 bh=eJKC82/JdUZHlra7wt2AcwBxZx0GOUHbM5qLt27y8DM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f5GKNdFgRnnBIO23cQpX5VzjxVD3vjqLDm5zKWQYH9PGzsWz88uDSXU4smxDdAEXw
 DuNIoPjen0K7HCQd+h/fexnZt0GCdHeqg99S0u9/zoItXB2B9XKxiQ9/4fuSQ5PaaE
 bXVA5rstzRikNPoIOt1rnpDxZXLvYgs5dXdkH0XQ=
Date: Fri, 22 May 2020 14:12:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: imx-pcm-dma: Don't request dma channel in probe
Message-ID: <20200522131242.GI5801@sirena.org.uk>
References: <1589881301-4143-1-git-send-email-shengjiu.wang@nxp.com>
 <0866cd8cdb0c22f0b2a6814c4dafa29202aad5f3.camel@pengutronix.de>
 <CAA+D8APhHvA39wmCayeCsAEKmOJ0n7qOQiT1tZmFHr4+yASgTw@mail.gmail.com>
 <53258cd99caaf1199036737f8fad6cc097939567.camel@pengutronix.de>
 <CAA+D8APAMRwtVneqFsuBgAhozmQo3R0AQi0bVdUCQO4Af4xVfw@mail.gmail.com>
 <20200520123850.GE4823@sirena.org.uk>
 <CAA+D8AOiVVi3B4dzU8r=rCMz=6w9R=wxBkzAQ=0=RAQLKCWy8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3U8TY7m7wOx7RL1F"
Content-Disposition: inline
In-Reply-To: <CAA+D8AOiVVi3B4dzU8r=rCMz=6w9R=wxBkzAQ=0=RAQLKCWy8Q@mail.gmail.com>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org,
 Linux-ALSA <alsa-devel@alsa-project.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, shawnguo@kernel.org,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org,
 Nicolin Chen <nicoleotsuka@gmail.com>, linux-imx@nxp.com,
 kernel@pengutronix.de, linux-media@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>, s.hauer@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
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


--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2020 at 07:30:04PM +0800, Shengjiu Wang wrote:
> On Wed, May 20, 2020 at 8:38 PM Mark Brown <broonie@kernel.org> wrote:

> > Other drivers having problems means those drivers should be fixed, not
> > that we should copy the problems.  In the case of the PXA driver that's
> > very old code which predates deferred probe by I'd guess a decade.

> Thanks.

> For the FE-BE case, do you have any suggestion for how fix it?

> With DMA1->ASRC->DMA2->ESAI case, the DMA1->ASRC->DMA2
> is in FE,  ESAI is in BE.  When ESAI drvier probe,  DMA3 channel is
> created with ESAI's "dma:tx" (DMA3 channel
> is not used in this FE-BE case).    When FE-BE startup, DMA2
> channel is created, it needs the ESAI's "dma:tx", so the warning
> comes out.

Not really TBH, this seems like another one of those csaes where DPCM is
creaking at the seams :/

--3U8TY7m7wOx7RL1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Hz8kACgkQJNaLcl1U
h9DJFQf+KOiSW3M/3ZDsfcMnTGh5HgNgjzZUpEU5f1ZyNw/EXh1ViAvYDpkQp2Er
kpo1Tgzodk1pkqsn1sWa5yWP+0c6LboBqkCq+02NHr3Kjyw3dQ6uV4ObJH35s/d1
39jbo9WIGQVqo8IOFdGhjpP4q72Vwxz1ki5asUYV3e1IO8aEowWvvbpnSIRlyuvH
rXKaqX6fYMsrMzXOhUx7afrt0n6HR/eBg/XkyIsnhXvvPpmxEAySIyKPOGGrftBM
rNmOV/XPKbLQXFzjWbK+3ChCcp6ETGTyUyHP25Dm+qXnIyvI6D1ssajhiZHN02RB
EdzpF/hkR+YLYUFNuN3fRvDOjQZT1A==
=fSbG
-----END PGP SIGNATURE-----

--3U8TY7m7wOx7RL1F--
