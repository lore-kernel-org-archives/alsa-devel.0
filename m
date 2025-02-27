Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58280C19F2E
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Feb 2025 07:02:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1609A60351;
	Thu, 27 Feb 2025 08:02:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1609A60351
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1740639759;
	bh=AbENd3rh+ZqB84Y0VY+S3ZID/ZQPE1RX+fpvwRkj3xA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=K+/F1GFwnAq8WZGhJwXrWE3qsQ+kcXQjLwGXjXV04wmvGS7ZNT1dpCe2HQlCQm4LL
	 XdqBxUHFDS2xI44b2c61qnavnN0aHOufsYWAabCttx6RRSvSARqtxIJdNehnkG0b/I
	 LEXhsB2sK2rni1t8NnAOhElod0/LzT3JtzVN1q1Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 88A65F800BD; Thu, 27 Feb 2025 08:02:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C6A2F805AC;
	Thu, 27 Feb 2025 08:02:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B76E0F804CF; Thu, 27 Feb 2025 08:02:06 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EE5BBF800BD
	for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2025 08:02:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE5BBF800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ffa++XjS
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5623961142;
	Thu, 27 Feb 2025 07:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C75C4CEDD;
	Thu, 27 Feb 2025 07:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740639720;
	bh=AbENd3rh+ZqB84Y0VY+S3ZID/ZQPE1RX+fpvwRkj3xA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ffa++XjSc94ZsuP7KA/LgNaUHH4FycIC9WVCJG/n2q+JCRIBeDdlY58+iAux2JsYp
	 UasMgQx6bF8Fv7jHimGGibFavqeK95pQ/F3odsByOFxpe7Qqlg84cpT0fRm+qEz6Fe
	 Z4yx67xPd2KBXNvgd+GN8edlzqwbX8L2+pH/7BfJ5ibt1K9xJB+QFh+mApWFQ81ACW
	 AbWx74erRxrvJTReaWz103zTebRb2he5A/wLAA2GDmhw39fVNUKgD56IljwqP9Jho+
	 FuIgIvCA5pOxyBxQpu8XxjxxZrcYeOuaaxaNjNyJKYAUV2Rm1J1oJXMMkWv5H1qWcJ
	 uu9hXEzCX64gg==
From: Vinod Koul <vkoul@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, yung-chuan.liao@linux.intel.com,
 pierre-louis.bossart@linux.dev, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 Mario.Limonciello@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250218065924.917915-1-Vijendar.Mukunda@amd.com>
References: <20250218065924.917915-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] soundwire: amd: change the log level for command
 response log
Message-Id: <174063971678.346386.9561215750981668144.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 12:31:56 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
Message-ID-Hash: R6HOEK5TXC5M4ZNWFTYB7T5PTD4JYXTT
X-Message-ID-Hash: R6HOEK5TXC5M4ZNWFTYB7T5PTD4JYXTT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/R6HOEK5TXC5M4ZNWFTYB7T5PTD4JYXTT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Tue, 18 Feb 2025 12:29:24 +0530, Vijendar Mukunda wrote:
> Change log level for command response log to dev_dbg_ratelimited when
> command is ignored.
> 
> 

Applied, thanks!

[1/1] soundwire: amd: change the log level for command response log
      commit: be2f35e15939836d0e0115e99d8cd7a49b89cc8f

Best regards,
-- 
~Vinod


