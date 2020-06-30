Return-Path: <SRS0=uo8V=AL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56395C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:37:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4D720759
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gzZTwR7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4D720759
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8AC911614;
	Tue, 30 Jun 2020 13:36:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8AC911614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593517027;
	bh=bxKN3vAdNWXnt0CK7YkWLOLnsWBGKSWVjsCMpMitgmA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gzZTwR7bQzxF7vKFR5D95eXEsDf8k88it8lVEJp7LTwQK7qj0QkOKTTbPEBwjDewI
	 0I/PNFtltm1OE1eLDt7wDnJrU3iVOJnFpACK5fx1+kF+tl7nkbZz6zCcrA9HE9C7ip
	 S3OAVoPBqtsir/HIoePZz/rrQlJ0ufWSvprbE5CY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1396DF80135;
	Tue, 30 Jun 2020 13:36:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30E39F801F2; Tue, 30 Jun 2020 13:36:15 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 65AAAF80135
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2020 13:36:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65AAAF80135
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1593516970720158100-webhooks-bot@alsa-project.org>
References: <1593516970720158100-webhooks-bot@alsa-project.org>
Subject: ucm2: Fixes for moving DragonBoard UCM files.
Message-Id: <20200630113615.30E39F801F2@alsa1.perex.cz>
Date: Tue, 30 Jun 2020 13:36:15 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #37 was opened from Srinivas-Kandagatla:

Hi Jaroslav,

Nico just noticed that you have moved and renamed all the DragonBoard ucm2 files.

We have below few issues with that patches:

1> DB820c belongs to APQ8096 SoC, so it should be moved to ucm2/apq8096 folder rather than apq8016.

2> DB410c belongs to APQ8016 SoC, so it should be under ucm2/apq8016 rather than apq8016-sbc.

3> All the board specific ucm conf file names with actual board file are now replaced with SoC names, like DB845c is replace with sdm845. Any particular reason for doing this? Are you suggesting us to use some matching on card long names to include correct board files from top conf file? Can you provide us some pointers on how board specific config files should endup looking like?

This PR fixes (1), and (2).

Thanks,
srini

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/37
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/37.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
