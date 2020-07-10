Return-Path: <SRS0=u2Q7=AV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7D7C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:26:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5D920772
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="txtnjUM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5D920772
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4BFB985D;
	Fri, 10 Jul 2020 13:25:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4BFB985D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594380391;
	bh=pwbQA70yAKzHCHiLm4J+ZYBmnMngvsopuQgL1aenr1k=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=txtnjUM9iYfScRwhkwCasHJ18Fjon54pN6LM34+jQmpytiBHk8zins5yYhOPITPPp
	 iTiFUnSjLbGe2l1kowWaUBN+MoL2MF8FBXMzS89Stlrp+WgxIgEakbGwWVvsiDLg7v
	 KtpQfdIBR6hIw+nZiwfk9w5spNQZYXV//nyjYM/8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE6E2F80150;
	Fri, 10 Jul 2020 13:25:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC3A9F8015A; Fri, 10 Jul 2020 13:25:38 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 35FBFF8011C
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2020 13:25:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35FBFF8011C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1594380326597882032-webhooks-bot@alsa-project.org>
References: <1594380326597882032-webhooks-bot@alsa-project.org>
Subject: Feature request: volume parameter for aplay
Message-Id: <20200710112538.CC3A9F8015A@alsa1.perex.cz>
Date: Fri, 10 Jul 2020 13:25:38 +0200 (CEST)
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

alsa-project/alsa-utils issue #45 was opened from flatsiedatsie:

I am currently in a situation where I'm trying to play a notification sound when a privacy friendly voice control system hears its wake word. Specifically, it's the [Voco addon](https://github.com/createcandle/voco) for the [Mozilla WebThings Gateway](https://webthingsgateway.com/), an open source smart home controller.

Up till now I used `aplay` for this. But I need/want to support a ReSpeaker USB microphone, and that device doesn't have a simple volume control. Unfortunately addons are not allowed to make changes to asound.conf (which could add softvol) or install something like Pulse audio to mitigate this situation, as those changes could affect other addons of the system.

My current solution has been to switch to a different available audio player, `ffplay`. It has a `-volume` parameter.

Having a `-volume` option actually works out quite nicely, as it allows sounds to be played at relative volume to each other. For example, I can play a music stream at 40% volume, while setting the audio feedback from the voice control to be louder so it can always be heard over the music.

The downside of ffplay is that it's slow to start up. It can take up to a second or two. Aplay's responses were pretty much instant, which I now realise was really valuable and important.

I'd prefer to switch back to aplay, but I'd need to somehow get aplay to output audio at a relative volume.

Is this possible somehow? And if not, would it be an idea to add this feature to aplay?

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/45
Repository URL: https://github.com/alsa-project/alsa-utils
