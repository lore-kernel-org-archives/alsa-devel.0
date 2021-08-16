Return-Path: <SRS0=rgkk=NH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BA8C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 19:50:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2512960F55
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 19:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2512960F55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B8CF83A;
	Mon, 16 Aug 2021 21:50:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B8CF83A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629143456;
	bh=CXis/bLdJRagXths2UirWKpEOJvLoH555N5N/vRF1Lc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=li6ASFqxQHtlVsSsKo45Mn32nbqXuR3Utlr7I/itnVqI788wpOYLhrrShmyOFwaPG
	 WJ5Pwxle72wO13pPCxVb3aj23W3SKy6wE6evj7C6lQCh0r/mIWnz9LAGIP20dkpMdH
	 4LZ2Ome4ym05duTMAerqV7Ff9q7QnpkoVFrsFFrg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CAB1AF80246;
	Mon, 16 Aug 2021 21:50:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2190EF80249; Mon, 16 Aug 2021 21:50:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2FE13F80134
 for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2021 21:49:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FE13F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="obB85TFb"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AF9260F4B;
 Mon, 16 Aug 2021 19:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629143396;
 bh=CXis/bLdJRagXths2UirWKpEOJvLoH555N5N/vRF1Lc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=obB85TFbyXkO09lmk8jBjXqGvOX4FMtvwUbKgPOSdWCyok9wNXm6TbPU4D7f+wVUn
 RkcKY7s6dNR4oYJteih7wKu9lwQuCn3TOJ5i5lvSw+jJWBBvRoWTwWh1PXwh0SZG9Z
 stuLfA3oL52++Urj0xi4NRcoq4A3Rg4OgLIzND4NaTfIdycSBVGlccuRBPKdg8U8k4
 9k517Y5UaV5Xnp7kt4zPvXpDut42GaRomTfeDgMj+ReLeekAPK6je2ZLyGCgEyoU10
 tK7KYj+wixt4JteSl7UygrhN3gdY5ug2ZQ+pCArPPpa1Z/lprgq1qw19lLW3NyT2rV
 AsUZKqGd7E7WA==
Date: Mon, 16 Aug 2021 20:49:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Aakash Hemadri <aakashhemadri123@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: tegra30: ahub: Use of_device_get_match_data
Message-ID: <20210816194934.GD4253@sirena.org.uk>
References: <cover.1628971397.git.aakashhemadri123@gmail.com>
 <e568d621c9c05ee23732a6a6f9e3606a780b1707.1628971397.git.aakashhemadri123@gmail.com>
 <20210816183906.GC4253@sirena.org.uk>
 <20210816194621.mrudqykxvkbt3a2w@xps.yggdrasil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline
In-Reply-To: <20210816194621.mrudqykxvkbt3a2w@xps.yggdrasil>
X-Cookie: Allow 6 to 8 weeks for delivery.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Bjorn Helgaas <bjorn@helgaas.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-tegra@vger.kernel.org
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


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 17, 2021 at 01:16:21AM +0530, Aakash Hemadri wrote:
> On 21/08/16 07:39PM, Mark Brown wrote:

> > Thierry, are you sure about your review here?  As others have been
> > pointing out of_device_get_match_data() returns match->data while
> > of_match_device() returns the device.

> Sorry for the confusion, and the glaring mistake.
> Will fix and send v2.

Since I applied the patches please send an incremental fix on top of
what's been applied rather than a v2.

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEawU4ACgkQJNaLcl1U
h9CXuwf+OBGMX8GLE249lvMUXgZkRMEjs9nIi42wzOcnwaLRMAMaBkIvAUHulfYL
TM277DlFjKtwdAh/oGeC9OMPPsq3dwxeGCe1CvJxwOxt2CtEVs3XHuljeylxR+0A
OxSnMqseEhvXbQI08QAqn9nQvzYOwaMgCxJEKSVl8Euy61Mzv0l4mi27Ynk4Xld4
4rhZ0E+MWcQG/6oAUcmNiEJ9SDcQloVHD6VbmBZ3zsMfavSsnv8QO1I6TY5HZq56
HOoJDODMhYiArCzj3Szpv+8XQUh7OrfcZjNds6SO9B9EEcxNtTllCpgpHXRs3GbU
WezDQX8TTXAPo6/Lg7dkRmHYLNlhHQ==
=BD+A
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
