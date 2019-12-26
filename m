Return-Path: <SRS0=4Kwc=2Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4202DC2D0DA
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Dec 2019 15:37:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8599206A4
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Dec 2019 15:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MBPo1EcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8599206A4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4072216FA;
	Thu, 26 Dec 2019 16:36:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4072216FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577374656;
	bh=pL6C6iqqvtsFb2hVPLF7Iv27Q7XVnLkFrPvJ6ZO6v5Y=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MBPo1EcHL6k8kbUKJqZGt28xoe7WW11bwr+OV+GCabbADZc0iAfdyfRR0+KMeoBCz
	 zy4np98X2JkvNZmFhjCGV4+RDs8JgxUFmUOpf14UPYRdbw0EjQYRSCyy5YsGvXeTLD
	 ZBruc6AzljgIfFX2hsdxrWMsUgZHyiU0jVf8IVi0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD843F80138;
	Thu, 26 Dec 2019 16:36:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD857F80139; Thu, 26 Dec 2019 16:36:43 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 3ACA3F800E3
 for <alsa-devel@alsa-project.org>; Thu, 26 Dec 2019 16:36:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3ACA3F800E3
MIME-Version: 1.0
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1577374600304128885-webhooks-bot@alsa-project.org>
References: <1577374600304128885-webhooks-bot@alsa-project.org>
Message-Id: <20191226153643.DD857F80139@alsa1.perex.cz>
Date: Thu, 26 Dec 2019 16:36:43 +0100 (CET)
Subject: [alsa-devel] broadwell-rt286: add support for hardware volume,
	conformance fixes
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #9 was edited from dpward:

This commit by @perexg fixes a regression on broadwell-rt286 which causes PulseAudio to abort on startup with:

`E: [pulseaudio] channelmap.c: Assertion 'pa_channels_valid(channels)' failed at pulse/channelmap.c:401, function pa_channel_map_init_extend(). Aborting.`

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/9
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/9.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
