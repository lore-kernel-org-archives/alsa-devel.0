Return-Path: <SRS0=Jhnj=L7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC86C07E95
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 16:38:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5AFF61CCB
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 16:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AFF61CCB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10B521664;
	Wed,  7 Jul 2021 18:37:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10B521664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625675928;
	bh=wC1t42xqWGR0RBPg6A/QyuiDHZS2a+3Q6OIeA/572BU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B9FAe5J/VVD3nC+eR6qGu09+RCRkNLG2L7L/kPB6f2H7FAvGYzftygOTSXpfF/dOd
	 JLohNdiUINMWFD/qh+bql+KFziFq7oLo3oMiY5MsD8/ojwaPHoXbDeJ1Od6+YMJ5Wo
	 GrWBogfZH4dZGuc670um4j7Bkw/l1gnA9xgMW+2c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B030F804EB;
	Wed,  7 Jul 2021 18:35:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01378F804E0; Wed,  7 Jul 2021 18:35:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 810B0F804E1
 for <alsa-devel@alsa-project.org>; Wed,  7 Jul 2021 18:35:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 810B0F804E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="LoFsrlWl"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00DF761CCD;
 Wed,  7 Jul 2021 16:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625675739;
 bh=wC1t42xqWGR0RBPg6A/QyuiDHZS2a+3Q6OIeA/572BU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LoFsrlWlJB19jNSBTDCnly/dtCrjarMSikpPrNi/demCkZs5tBR72NUMmbj+RUEz7
 Yb7Pua10fb9XZKk+FRB3miS2GvCB9QZLalrrWVlzqIpIIA/EnVkNcI3e7+nrhUiHZS
 ciRa3EneQicv9o/3Igf5XJlnEdgs6KJ5pxvejEuwU8h8j3tEB7tHAxOIrCG1jRvG6p
 d9BGX2sw7YI1oMFPZWppiDYGLG0PC0Y5XWudKL3SP37nQRRLCsfBtZajFCy8ri+srC
 Zc5X/VXfX4ylnlOU+gnNBt0EP/cb9Hg9PVyUUFWpbkcJ01343ToAf0YH55NlVWYLxf
 NccjmLr0mPhNg==
Date: Wed, 7 Jul 2021 17:35:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <vijendar.mukunda@amd.com>
Subject: Re: [PATCH 09/12] ASoC: amd: add vangogh i2s dai driver ops
Message-ID: <20210707163507.GI4394@sirena.org.uk>
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-10-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YZVh52eu0Ophig4D"
Content-Disposition: inline
In-Reply-To: <20210707055623.27371-10-vijendar.mukunda@amd.com>
X-Cookie: I will never lie to you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com
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


--YZVh52eu0Ophig4D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 07, 2021 at 11:26:20AM +0530, Vijendar Mukunda wrote:

> +	mode = fmt & SND_SOC_DAIFMT_MASTER_MASK;
> +	switch (mode) {
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		adata->master_mode = I2S_MASTER_MODE_ENABLE;
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		adata->master_mode = I2S_MASTER_MODE_DISABLE;
> +		break;
> +	}

As part of moving to more modern terminology it'd be good to move to
_DAIFMT_CLOCK_PROVIDER_MASK and associated constants (with a similar
change for the driver local constant) - see f026c12300 (ASoC: topology:
use inclusive language for bclk and fsync).

--YZVh52eu0Ophig4D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDl17oACgkQJNaLcl1U
h9AGwAf+PFey2i5kbYJ5CSOWJMW6PdybzvDUculaxKRphsGDic7OZk42xdyt2XzO
uraai+eNmVN+w9gpt+i1XAH8GPsmjzTWpB7QHGy8DWulldVFORxf9amqM9FVjKuF
L3mm58KZ62FFU3Ubrk/c79hfVToGGP4cAEC2jMW7+VLQYZ4boQYu4MiMynQkqt1X
kCtPm9CEtvcEGivIxFaCXtZQDmCAvP12TmR2dVVmjmOtubSbsyupiLy7PtsBtAud
ayN2859J3wztUuUUrGp3j6oXKmYL6MOF/m2tszsJAUBbeULDLuETuS23oNCIDX+u
nMadzz2vMFjZ9FMdocrT+xfISQEyIA==
=XEl9
-----END PGP SIGNATURE-----

--YZVh52eu0Ophig4D--
