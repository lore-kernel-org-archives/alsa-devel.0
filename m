Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D49C61DA4
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Mar 2023 13:55:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9BA4F125A;
	Wed, 15 Mar 2023 14:54:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9BA4F125A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678888539;
	bh=yGS0GCC0GsTeb+jtCVuIDSjV+3hiMFhFbaDICAwfixs=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MkxTgZ+PnRE/qtmYhLb4Kg87Shw2OpSPrQsuT9z9TOrJrpZIFsfdiadKqeL0An7Qt
	 ouJLAwxlc5I2G7YHR4TZvsUdcENFxg8ry+iQ4N6SgOtsgKnJGDkzCSjlRgeWsln1Vl
	 6sXOa4TbfktCXYMRWMizyFtTj+lrLAMQqta9NTN0=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C255F80423;
	Wed, 15 Mar 2023 14:54:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1026F80423; Wed, 15 Mar 2023 14:54:22 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 18ADBF800C9
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2023 14:54:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18ADBF800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qr0dllfQ
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2E86061D5C;
	Wed, 15 Mar 2023 13:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7B2C433EF;
	Wed, 15 Mar 2023 13:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678888457;
	bh=yGS0GCC0GsTeb+jtCVuIDSjV+3hiMFhFbaDICAwfixs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qr0dllfQS6siP2cK1jtNU4TyIqm5Zyo/KZbSvK02zdvSlhmFGh+YgnR/iDyeiQhKn
	 eyG9B8zBv1sZl5oL4GHsaxgnXElVOKXjBz9nTPLCZfzglsaLVbYdzd4ULWy7PH8Ayi
	 g1MT2MlAw6jvDNg+Iq6IdLOQdpNFIE0bdjzhpDO5l50zDNd1+bxy5BTeFa8VmWhtmq
	 lTPKBXicQVXdEtJgP6NbULuksMUn8Xi+bkVEIKdIp9r6IdH60pPX0M8cMyLWXQ5g9d
	 2QqM6AJzCwFNjz/3mdA9MIo/XodkyQKPr2jmZDiouf4/ijjRmWJNnVtC/zCC8RCySD
	 Y9KcjIguDgABQ==
Date: Wed, 15 Mar 2023 19:24:12 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 00/16] soundwire: updates before LunarLake introduction
Message-ID: <ZBHOBM2P1kTgdmer@matsya>
References: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
Message-ID-Hash: 4VTKAPYOZ3DH5PL674P65JX7BZAA6MZR
X-Message-ID-Hash: 4VTKAPYOZ3DH5PL674P65JX7BZAA6MZR
X-MailFrom: vkoul@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4VTKAPYOZ3DH5PL674P65JX7BZAA6MZR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 14-03-23, 09:53, Bard Liao wrote:
> This series provides a set of cleanups and new abstractions needed for the
> introduction of LunarLake support.
> 
> For now this is an iso-functionality change, with changes on the Intel and
> Cadence sides. The low-level support for LunarLake will be introduced in a
> follow-up series that depends on HDaudio multi-link extensions.

Applied, thanks

-- 
~Vinod
