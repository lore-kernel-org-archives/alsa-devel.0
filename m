Return-Path: <SRS0=PPjj=MG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87D0C07E9C
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 16:30:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8758613BF
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 16:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8758613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AEC91678;
	Wed, 14 Jul 2021 18:29:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AEC91678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626280244;
	bh=pmQetu+Bir8TxMBj+0fiQ8Bjc4bVEbxamtjh0p8vBxY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CYGeLUpDfYnq6vVEpElUjHimmNMnCoSuK4oT/fko1tFcmWCWeoLM6i9Oayr4/NYQc
	 bAaMRi/8waeDRFmss2fOPAOiLDAAXNJdCh70VYxWXOHD7lhEVdWCz/g/xI78jS5mMW
	 csBgAweiIBN6kfS0roEFabTrhe6kaHcSOyVxa3p4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0B17F800D3;
	Wed, 14 Jul 2021 18:29:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A86CF80254; Wed, 14 Jul 2021 18:29:46 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4E5DF800D3
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 18:29:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4E5DF800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZryUHeq/"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B9A8613AF;
 Wed, 14 Jul 2021 16:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626280178;
 bh=pmQetu+Bir8TxMBj+0fiQ8Bjc4bVEbxamtjh0p8vBxY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZryUHeq/hyh6nZg+WCjZjGBej0gnLhVOBxT7tySR1TH9knORamI6mIxWA2QUfwx/o
 ThCbYmNn0hjo/uZbEEQ9Zkv7meZpR5mTLCammWE/vS9mc1bcKsxdOVi/4R7AE87jM2
 nknVGxDkK+/L+Es03Vw42xZ+7RTMGojSlzIvbiv+UW7S6+7yuwLASW95D7CPW534+7
 puphms/4fratOIyDsnRPAwDeYT7yryc6wKpTEzviTDw5TLGGhlCa0NVtnsj3zvVW2n
 wx1c6Udk/3bpPrDEbu1I0FjyhiXxcouG+TadNyhiwr5A3upDD5/GhV6X7yLeCLMPnL
 gJ66D3By2nfbg==
Date: Wed, 14 Jul 2021 17:29:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 2/2] ALSA: compress: Initialize mutex in snd_compress_new()
Message-ID: <20210714162901.GF4719@sirena.org.uk>
References: <20210714162424.4412-1-tiwai@suse.de>
 <20210714162424.4412-3-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
Content-Disposition: inline
In-Reply-To: <20210714162424.4412-3-tiwai@suse.de>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Vinod Koul <vkoul@kernel.org>
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


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 14, 2021 at 06:24:24PM +0200, Takashi Iwai wrote:
> Currently the snd_compr.lock mutex isn't initialized in the API
> functions although the lock is used many places in other code in
> compress offload API.  It's because the object was expected to be
> initialized via snd_compress_register(), but this was never used by
> ASoC, which is the only user.  Instead, ASoC initializes the mutex by
> itself, and this is error-prone.

Reviewed-by: Mark Brown <broonie@kernel.org>

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDvEM0ACgkQJNaLcl1U
h9DsdQf8DPO4wkGqNtQ7M/uGD9u0/JtlzJQT1YkJ6bbq7dOCWuZQHCP9fiR0QGVv
0Gz5kiI5zpvfxpQEduIxxn1SQ0g5xy9PledC/BJ3Xb3CmWIwqx+DPtxr094RzW+x
jWWYYuDNekn+QrpCaOh4TDDENV9CMtEY8ymTzPdmSGx7BbUn7fui6aCBRRDd3kRV
Oj5l8s8EbdNEasTRLynkq4c4fImtuxrokos6Rv48QiZkQl0GqWD+97cE+TpdYzIM
/7uQ0e8bY9oTJKYe6h2036MI6nnXFH9oCMfD9MYdE1azi/ogY4nsVkCYAxiuVr0D
EC0nTS9EomDNV6jvX7Q+8AyPqSDeYQ==
=ihlo
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--
