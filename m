Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B30CD11DF
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Mar 2024 18:14:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 028162CA6;
	Thu, 28 Mar 2024 19:14:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 028162CA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711649673;
	bh=hCHdpwkQBt9D0yMTx2ID7nt+cY5d0EFBST40naks2r0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=O54ro8OeaoQKzpINqjz1PVTOKVZh5Es1hMevolDBpBTKXa80BeByk+2cX1ICxvHpN
	 bJmNBiI+ysGaU8dXsdfkJGU+yJOP6mwk80G94rgMR/ZSSLTGox+6QHuSbbcYO/26hI
	 4OVkCqFkJtWTARaKs1pJLQTeNnQf+cGZsV9UJ0DM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3B24BF805AC; Thu, 28 Mar 2024 19:13:53 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A5F0CF80564;
	Thu, 28 Mar 2024 19:13:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 848C0F8025F; Thu, 28 Mar 2024 19:13:46 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5D199F801EB
	for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2024 19:13:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D199F801EB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rkrW4yMp
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 233D1CE2C46;
	Thu, 28 Mar 2024 18:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B029C433C7;
	Thu, 28 Mar 2024 18:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711649618;
	bh=hCHdpwkQBt9D0yMTx2ID7nt+cY5d0EFBST40naks2r0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rkrW4yMpNKammkh6VnlYoGTSI61Cf/DYDWVzq+ebUOmLNBMtLw9emfbc8Xa+N0Nm5
	 KbWJPXrNm08wgzy9C4y4W53WRCmIVOIf+W+S/b0bum8RABA3KJtrJPvF4VGUGLNFA5
	 H8b+Dmsx94qVa4Wk27ghS1hivKX6jcPD168PXb96jW1ooJk+8ax1g2ilCTlj1tlL2i
	 rGjgR9INYVy2Q6FyLfmBCdQyRKWUZTeuYc1xF0AIMgAI5g1z8VoknMuqQfarH3AIpb
	 JG1FKiag+LpQuvEiuIYSEtHhUi/WixnPUhJoM+J4glc9rjMF6Yvb7alT+oo/2Z7+7w
	 uVBe3/IG0+6ig==
From: Vinod Koul <vkoul@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240327063143.2266464-1-Vijendar.Mukunda@amd.com>
References: <20240327063143.2266464-1-Vijendar.Mukunda@amd.com>
Subject: Re: (subset) [PATCH 1/2] soundwire: amd: use inline function for
 register update
Message-Id: <171164961371.128029.7404950092235266679.b4-ty@kernel.org>
Date: Thu, 28 Mar 2024 23:43:33 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Message-ID-Hash: VRVB3UG5SJ2YHC6P2WOOGRF2KPYIPGC4
X-Message-ID-Hash: VRVB3UG5SJ2YHC6P2WOOGRF2KPYIPGC4
X-MailFrom: vkoul@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VRVB3UG5SJ2YHC6P2WOOGRF2KPYIPGC4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Wed, 27 Mar 2024 12:01:42 +0530, Vijendar Mukunda wrote:
> Define common inline function for register update.
> Use this inline function for updating SoundWire Pad registers
> and enable/disable SoundWire interrupt control registers.
> 
> 

Applied, thanks!

[2/2] soundwire: amd: fix for wake interrupt handling for clockstop mode
      commit: 63dc588e7af1392576071a1841298198c9cddee3

Best regards,
-- 
~Vinod


