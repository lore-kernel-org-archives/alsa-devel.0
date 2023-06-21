Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB2BEB64D7
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jun 2023 05:24:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F8021CF;
	Wed, 21 Jun 2023 07:24:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F8021CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687325097;
	bh=D+a2fIP+FvcRNUy0gwO96/Y9cbIf48GeaSC+CFwrUpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=czXTvNOBD9icNYWEeuuRm2qXXG8JWoekt76vyRnh2CYqsLAEF5GLd6KU3UqhysIR5
	 fFf1s1Tgdf2MKMxAG30fB4LyAVGW9k5HN6ebgIjfsAv/ekX3VgaS8EaxcwMARpuq9g
	 FeYbAz4PacSgL5ETrEPYFMURkc0/v1bPZ0S6gbjI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 009CFF80169; Wed, 21 Jun 2023 07:23:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D4D2BF80141;
	Wed, 21 Jun 2023 07:23:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8629FF80141; Wed, 21 Jun 2023 07:23:32 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8D40DF80022
	for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2023 07:23:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D40DF80022
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HisZojYC
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0285561452;
	Wed, 21 Jun 2023 05:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997B5C433C0;
	Wed, 21 Jun 2023 05:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687325003;
	bh=D+a2fIP+FvcRNUy0gwO96/Y9cbIf48GeaSC+CFwrUpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HisZojYCZBzljKy0VjOa+EoQ1/I7zC99q8ha39jZkpNiVLIZ/Gnu5bX2g7g+mnxzL
	 lsya92qHek4tX0OagUd/qAOAFVEWfQK0/QZEWE7UzUHSnyMkrutYysrsu4LNrqw+CW
	 IepQp421GjTNwMMbq7eNgM6XZbXC4P/k5kGrubUvvtvrUaN9QFTjBomATLpxwwJR6A
	 JMN+UQ3dSlYBtmHIZQ7BogzhP0MpHXwE7dLPWXx9u0pN+OY28+Tq1KozNljJCn1MHT
	 SH3OeXTYe+1zf83ICvzJT7Vs8dPCHeSdDS1DFIYwS43+F2vsbV/3O2gG7Q+58bCKYU
	 WaDBsHlWj94VA==
Date: Wed, 21 Jun 2023 10:53:18 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, tiwai@suse.com, corbet@lwn.net,
	alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_plai@quicinc.com,
	quic_mohs@quicinc.com
Subject: Re: [PATCH v3] ALSA: compress: allow setting codec params after next
 track
Message-ID: <ZJKJRnMuYvy7GrsD@matsya>
References: <20230619092805.21649-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619092805.21649-1-srinivas.kandagatla@linaro.org>
Message-ID-Hash: LISX342LIKHWLPBV4TQ76S3E2UJ274L7
X-Message-ID-Hash: LISX342LIKHWLPBV4TQ76S3E2UJ274L7
X-MailFrom: vkoul@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LISX342LIKHWLPBV4TQ76S3E2UJ274L7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 19-06-23, 10:28, Srinivas Kandagatla wrote:
> For gapless playback it is possible that each track can have different
> codec profile with same decoder, for example we have WMA album,
> we may have different tracks as WMA v9, WMA v10 and so on
> 
> Or if DSP's like QDSP have abililty to switch decoders on single stream
> for each track, then this call could be used to set new codec parameters.
> 
> Existing code does not allow to change this profile while doing gapless
> playback.
> 
> Reuse existing SNDRV_COMPRESS_SET_PARAMS to set this new track params along
> some additional checks to enforce proper state machine.
> 
> With this new changes now the user can call SNDRV_COMPRESS_SET_PARAMS
> anytime after setting next track and additional check in write should
> also ensure that params are set before writing new data.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
