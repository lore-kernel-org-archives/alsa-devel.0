Return-Path: <SRS0=0Rat=K2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD3AC47080
	for <alsa-devel@archiver.kernel.org>; Mon, 31 May 2021 17:31:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED3860FF1
	for <alsa-devel@archiver.kernel.org>; Mon, 31 May 2021 17:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED3860FF1
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E72A415E2;
	Mon, 31 May 2021 19:31:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E72A415E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622482313;
	bh=l34SQnuo7S11uA9KreYVnSmxswfD5Vc2qjSHW7fYTNw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OWQfWvkWo2Aw4Vej4NLfQUUp+14pxnDORV6+f1xnyBNySiVmcj6RXVj9z8mqWS6D+
	 NKd9tG5bz6sNAXnEngLWOZ6HTgDaRU7plWxE9mpD7Swww49I56hmAaIKV+Do+xxJhP
	 OvsUrH71d6FxGfdCJoSasHo5++e4mpmbYWB5LVlM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8228BF80273;
	Mon, 31 May 2021 19:31:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B3934F802E2; Mon, 31 May 2021 19:30:59 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 0F377F80161
 for <alsa-devel@alsa-project.org>; Mon, 31 May 2021 19:30:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F377F80161
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1622482245334261894-webhooks-bot@alsa-project.org>
References: <1622482245334261894-webhooks-bot@alsa-project.org>
Subject: Release tarballs ship other version, break build scripts
Message-Id: <20210531173059.B3934F802E2@alsa1.perex.cz>
Date: Mon, 31 May 2021 19:30:59 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #95 was opened from dvzrv:

Hi! I package this for Arch Linux.

The release tarballs on the ALSA website ship the 1.2.5 data in a directory with a differing version number:

`alsa-ucm-conf-1.2.4.81.g4884e/`

This breaks build system assumptions about the contents of these tarballs. Please provide the data in directories that match the release version.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/95
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
