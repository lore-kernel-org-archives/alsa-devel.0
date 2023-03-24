Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313C1C6FD20
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Mar 2023 20:03:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7877E8B;
	Fri, 24 Mar 2023 21:03:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7877E8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679688233;
	bh=EzaY0Fl9v5BxzweTvgaAnSVXX43HBc7xTvIAdo2UdA0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=BEXgiX+pvLL31fNoXcPIWal05iJ1w0MITx1yr9sqAjXTv926sWJTbmC2mmWi+by7u
	 z5vd+OTLVyR965HV3Aava/a3yVDp33wnB49rPHPx28rMDglTNL4NM8W+NJS0H1il02
	 JJKljWEhXmGy6iW/F5c1pmvQN5+TW/rAovPZfNLA=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3AB18F80093;
	Fri, 24 Mar 2023 21:02:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 93DD9F802E8; Fri, 24 Mar 2023 21:02:37 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id B259FF80093
	for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2023 21:02:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B259FF80093
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1679688154865501642-webhooks-bot@alsa-project.org>
References: <1679688154865501642-webhooks-bot@alsa-project.org>
Subject: alsactl: add fallback for loading driver state
Message-Id: <20230324200237.93DD9F802E8@alsa1.perex.cz>
Date: Fri, 24 Mar 2023 21:02:37 +0100 (CET)
Message-ID-Hash: AQD7KNTFZ5TZAJO3I6FMAF2K6NSMN7FL
X-Message-ID-Hash: AQD7KNTFZ5TZAJO3I6FMAF2K6NSMN7FL
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AQD7KNTFZ5TZAJO3I6FMAF2K6NSMN7FL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #197 was edited from MrCry0:

Support loading driver state from the vendor-specific pre-installed sound configuration file /usr/lib/alsa/asound.state.

This commit unblocks changes in the `alsa-state` yocto recipe to install `asound.state` into `/usr/lib/alsa/`. This is a good move to support ostree distros and to keep an initial `asound.state` in a safe place.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/197
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/197.patch
Repository URL: https://github.com/alsa-project/alsa-utils
