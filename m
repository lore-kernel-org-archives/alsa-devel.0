Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E41C00140
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Aug 2022 12:34:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9997583A;
	Fri, 12 Aug 2022 14:33:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9997583A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660307673;
	bh=FUfc1TFo94swYywRR9ki3WQ1R4VUwdEZ+9NUnE3thjU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jez6KwnTfs1SqPQzETTqzVgJNtXzn1Jt6jJjr4daspug2OMoxc0c9NVEAt9BK9C9b
	 L/itZa/ghSp6d6Kf/KO26diMM8A7PHvHbSdtwzq+Dh2lJn5sq1Q2EaKpt3K+arm5DP
	 uFy5yjKhKRo3nQB2pRUGp2qu6ZMSdmJt5YGmKIjc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21B58F80152;
	Fri, 12 Aug 2022 14:33:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26347F8026A; Fri, 12 Aug 2022 14:33:41 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87E5DF8014B
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2022 14:33:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87E5DF8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="q4KOADSO"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 60CD461786;
 Fri, 12 Aug 2022 12:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D419C433C1;
 Fri, 12 Aug 2022 12:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660307614;
 bh=FUfc1TFo94swYywRR9ki3WQ1R4VUwdEZ+9NUnE3thjU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q4KOADSOuJUBf44A8BVVm9ZGOfi3J+RRo3RCr8qQQBV1gTQPgGscyjU+VsRWfko7x
 cOZwfNKqBcU4N/wYGexx3EPC+IPHBFpwKMNc3Qq6CI+4NJqt4g7Jy8u7mozZM/rUCk
 wxD/yvnyfxyRttL7D+ZUcvGc7fnff2WPSlomPe/1COUP5/6rCtzT7wcRt+pWv0q1z2
 GLGWHlHoRNfBymjNYt0BFbMclTHfymRnLj04KhNMbxpsQ/J4hx9gK1rJtMwgk1qPbg
 cdG+sshiD3X77prvAUPcBdnMkgaXdk5BjzqGMI8NVzB4Rt0ZWmMdruFr3rhayRtgu4
 YEwhJKQIV+Pdg==
Date: Fri, 12 Aug 2022 13:33:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Syed Saba kareem <Syed.SabaKareem@amd.com>
Subject: Re: [PATCH 03/13] ASoC: amd: add acp6.2 init/de-init functions
Message-ID: <YvZImUY5VUgnqNGk@sirena.org.uk>
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
 <20220812120731.788052-4-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B0pljCE077v7zEjS"
Content-Disposition: inline
In-Reply-To: <20220812120731.788052-4-Syed.SabaKareem@amd.com>
X-Cookie: No foreign coins.
Cc: alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com,
 open list <linux-kernel@vger.kernel.org>, Basavaraj.Hiregoudar@amd.com,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 mario.limonciello@amd.com, Vijendar.Mukunda@amd.com
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


--B0pljCE077v7zEjS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 12, 2022 at 05:37:21PM +0530, Syed Saba kareem wrote:

> +	/* power on */
> +	ret = acp62_power_on(acp_base);
> +	if (ret) {
> +		pr_err("ACP power on failed\n");
> +		return ret;
> +	}

It would be better if you passed the device in so messages like this
could be dev_err() rather than just pr_err().

--B0pljCE077v7zEjS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL2SJgACgkQJNaLcl1U
h9DlOQf9HdVqSnXnN96Td4SQOGqazW0R4j9ss0dhrbUPKYN9e/+jEcE184D1mqqi
v1xQCwSPhsHWIp0E6CcV7j7j6gZP9mN8S+IZbtlbCRX+OryIXtBnmqvQA74j4Eod
7H5+FsPWXNpni76NvzfFiEaNXTZZMGUb7jmjqJ78D1mWYju46F5yHpbFgilVvHkf
j343RbHp3Xj+iZBPcmapv8tVIInoLBYv2nqfpioycJG/WAIi1k5rLNDJ6C0TyhAw
q6LwW4vmo/jptfJsaWYNwI7mCZh992XmhlGctC7sUy1Uxe+iwAnDvIrM/AHkV2qW
XAei8F1c0rFanUkRCuzPEkVJtoNZvw==
=EBfU
-----END PGP SIGNATURE-----

--B0pljCE077v7zEjS--
