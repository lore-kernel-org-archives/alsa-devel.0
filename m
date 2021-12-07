Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A3DC433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Dec 2021 21:41:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A37362567;
	Tue,  7 Dec 2021 22:40:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A37362567
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638913260;
	bh=mzbCebkAQ2lumaGN7IJ6XixLyedE6QuReMfIPwIST5s=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V9vViu9KZlkbdy59uHBpnXvAyBMNViKDXjUkX5WTLa/IdkkK5E4qP1G53bEVWAzsJ
	 IRgd7X8z0E08yYGnZNhaf5ykyMb1rrFLURK+yKDKNoyRJk3+aCKzkGo9oXPqzonHgn
	 XKVwJYLhXJJMk6wJ2RYRa6BIEBUqQ+1Y3FTAFcaw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A196F80259;
	Tue,  7 Dec 2021 22:40:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 36115F8028D; Tue,  7 Dec 2021 22:40:08 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9E164F80253
 for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2021 22:40:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E164F80253
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1638913204697031975-webhooks-bot@alsa-project.org>
References: <1638913204697031975-webhooks-bot@alsa-project.org>
Subject: Feature request: ACPI NHLT generation for topology2
Message-Id: <20211207214008.36115F8028D@alsa1.perex.cz>
Date: Tue,  7 Dec 2021 22:40:08 +0100 (CET)
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

alsa-project/alsa-utils issue #124 was opened from juimonen:

I'd like to add ACPI NHLT generation into topology2 parsing.

Why: In certain future sof firmware versions this is needed for DAI configuration
Why to alsa-utils: adding it to kernel driver was internally rejected, also I can't link to topology2 parsing outside alsa-utils

Good thing: if you ever wondered how acpi nhlt blobs are created and what they contain in intel platforms -> this code is doing it.

Bad things:  I can think many, but I'm trying to do this with least harm to every party (kernel driver, firmware) 

Example of the code can be found here: https://github.com/thesofproject/alsa-utils/pull/4

So mainly asking for comments/suggestions from @perexg

@lrgirdwo @ranj063 FYI.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/124
Repository URL: https://github.com/alsa-project/alsa-utils
