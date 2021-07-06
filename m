Return-Path: <SRS0=47st=L6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04F6C07E96
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Jul 2021 12:32:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD48F6233C
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Jul 2021 12:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD48F6233C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0542F166F;
	Tue,  6 Jul 2021 14:31:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0542F166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625574726;
	bh=Me4h8Svxr0oEY24HAdRXkrZoovr8uE/hMjWWvsAowfw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a4TQjyDJe2baaqjDCalgFb01mHnn8hDEqHxBSVFiAEzaiCAry8cA5Zz6Om1BnrLUV
	 wPjEdE8vyKhaxmmW3u6gVe0jVnYnBz1M5bxfjFbIk8YWbSwMrmaHmTndQA2NxttxLa
	 WVacUmA9vT1zkJPageDzeGW398QO5rPV+5NerTFg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97694F8014E;
	Tue,  6 Jul 2021 14:31:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA9BCF80249; Tue,  6 Jul 2021 14:31:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 401BEF8014E
 for <alsa-devel@alsa-project.org>; Tue,  6 Jul 2021 14:31:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 401BEF8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HFt0g9ha"
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDD5D619C8;
 Tue,  6 Jul 2021 12:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625574667;
 bh=Me4h8Svxr0oEY24HAdRXkrZoovr8uE/hMjWWvsAowfw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HFt0g9haQ8yyxZbpnpFN9XSyMBSA/1s8NBR8RYEIjUmHvOMolZj8hsmjpDRONuKMD
 OAmsDyP0LBvkfs/mKR2/rQ3X9oG/rLM/8C1zuripKBsxY0TTeUEbEPW3nZoQ83De/b
 GYfN+kFYYX1LIpMAglDitkCIDVOR2RPni4wY/Hkb5nGmEBvs6aQBhMP84WLL0pw97r
 apiYmJqdf7zH8pAmz6OY4QFjZvvFiZevggUHwxC9/wS/CDSnJXydFpbGTnx32lqvzC
 lS8OQsinI0qoXoTed8W6mq4UNUZ7q4vMmd8AugjxqSGXLaznMXu9DP/xKpsBfJlkz4
 XEUuJlzvx9iuA==
Date: Tue, 6 Jul 2021 13:30:35 +0100
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH] ASoC: add dai_reoder flag to reverse the stop sequence
Message-ID: <20210706123035.GE4529@sirena.org.uk>
References: <20210705155830.24693-1-vijendar.mukunda@amd.com>
 <20210705174241.GF4574@sirena.org.uk>
 <7f1ad1b3-b509-24cf-00d8-f82766aae0d6@amd.com>
 <20210705192952.GI4574@sirena.org.uk>
 <48b0a8e6-ca29-3f77-2689-ad7515f8743b@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <48b0a8e6-ca29-3f77-2689-ad7515f8743b@amd.com>
X-Cookie: Some restrictions may apply.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com, amistry@google.com,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 open list <linux-kernel@vger.kernel.org>, Basavaraj.Hiregoudar@amd.com,
 Takashi Iwai <tiwai@suse.com>, Chuhong Yuan <hslester96@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, peter.ujfalusi@ti.com,
 Alexander.Deucher@amd.com, nartemiev@google.com
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


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 06, 2021 at 01:40:59AM +0530, Mukunda,Vijendar wrote:

> To make AMD specific platform change(which uses ACP 2.x IP), As per our
> understanding we should only update the flag in ACP DMA driver by adding
> flag in snd_pcm_substream structure rather than adding flag in card
> structure.
> Please suggest us, if there is any better place holder to add
> "stop_dma_first" flag.

I'd expect this to be configured by the machine driver in the dai_link.
It might need copying over to the substream for runtime use but the core
should do that.

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDkTOoACgkQJNaLcl1U
h9CD0Af6Aml9JrNZjaM7DWoPKWUc6A7Eh7aC5xXuVGPp6bPnt7nmt48yswr6l9nS
FYAFulGmlW7KmNOXQ2sLEbdmNQvWyKdKbQyfsLr3KqaKkhYkVL/c6oPjzrx9jQL2
2C05Ofe+Aue2VoT+6LXeeHcrJc4zzXkdgWw7Q1amvV+uBKSyN8T1QCjaAvh2cpKl
2CZsZZz8Eq6PAvoBhvEVLjjQgrAeW5+V3BfYvWdwhEhhiTitz7MoWLO5ntq0/+qJ
43mjCbqPLFYaUcvqriafZqW6xArg5WexmDC9NiNuCuyffjW36AQxkfizIPKZAFx8
yZrsX1SAYkBUtZQ9wUITPEq8kM+/Ng==
=gGgo
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
