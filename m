Return-Path: <SRS0=iTaG=EB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945B1C2D0A3
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:15:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3932022400
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZTqKtlR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3932022400
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1199016E2;
	Mon, 26 Oct 2020 13:14:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1199016E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603714518;
	bh=QKKXc35p5R+2zg3mvn0sbWdS+q1Ix0nUuV/dVcpIZsI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZTqKtlR+g9U5cSOK+Y4/lnr1AWRSH2KcyFHaqUha6fyvFVXANvfID04IX27dJ7c4+
	 cnfbzhjl64AIVb9+OakCfFCO8xm0GaJ7YiFEG6EM8k09Q6+pYJB5nTqBiVMI29aq0+
	 drZJqrOZA28JTXr1LLFTY+7Q8hqDNQOLB3VsXntU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 866C3F800CC;
	Mon, 26 Oct 2020 13:14:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5313F80212; Mon, 26 Oct 2020 13:14:25 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 76316F800CC
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 13:14:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76316F800CC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1603714459620129108-webhooks-bot@alsa-project.org>
References: <1603714459620129108-webhooks-bot@alsa-project.org>
Subject: DOC or BUG: plugins dsnoop,
 dmix and dshare change mode parameter of  snd_pcm_open_slave
Message-Id: <20201026121425.E5313F80212@alsa1.perex.cz>
Date: Mon, 26 Oct 2020 13:14:25 +0100 (CET)
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

alsa-project/alsa-lib issue #92 was opened from RonaldAJ:

Using the dsnoop plugin sets the mode to non-blocking in alsa-lib/src/pcm/pcm_dsnoop.c:

    ret = snd_pcm_open_slave(&spcm, root, sconf, stream,
                             mode | SND_PCM_NONBLOCK |
                             SND_PCM_APPEND,
                             NULL);
Judging from the code the same applies for dmix, dshare. 

It took me a considerable amount of time to figure this out using the source code. So it would be nice if this behaviour where documented.

Personally I would prefer the code to throw an error message, when using blocking mode with these plugins. But I don't know how that ties in with the overall design.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/92
Repository URL: https://github.com/alsa-project/alsa-lib
