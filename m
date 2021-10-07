Return-Path: <SRS0=Vpzd=O3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CE1C433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 10:25:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A8460F57
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 10:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 86A8460F57
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71B3F9F6;
	Thu,  7 Oct 2021 12:24:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71B3F9F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633602331;
	bh=xMZHQ+++NXlNmoABgcCr8htsbOvBj5cLXwDdKUSXr3g=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gGnTdKoviOXzvCHbB5LjXRhmkr5qQv4GdMAD9RLPqHJ6ua7SLoPnz2wRmOALduCup
	 MfkwR1DrW7OZ5oSLWRLri4qufwbti0ZbcHcFOK6B0DBMZ5l8nwGoDXNnP3gf43UvWu
	 Q+KdY0PUsFXgxkni0CR/dG0Gobyq3wEwyy0BoucE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EFF95F80259;
	Thu,  7 Oct 2021 12:24:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A6BCF8027D; Thu,  7 Oct 2021 12:24:39 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7DBB2F800F0
 for <alsa-devel@alsa-project.org>; Thu,  7 Oct 2021 12:24:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7DBB2F800F0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1633602274573642969-webhooks-bot@alsa-project.org>
References: <1633602274573642969-webhooks-bot@alsa-project.org>
Subject: dlmisc.c: Avoid double unlock in snd_dlobj_cache_get0()
Message-Id: <20211007102439.9A6BCF8027D@alsa1.perex.cz>
Date: Thu,  7 Oct 2021 12:24:39 +0200 (CEST)
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

alsa-project/alsa-lib pull request #182 was opened from johado:

Remove call to snd_dlobj_unlock() in snd_dlobj_cache_get0()
All lock/unlock is done by callers of the function.

Fixes: https://github.com/alsa-project/alsa-lib/issues/181

Request URL   : https://github.com/alsa-project/alsa-lib/pull/182
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/182.patch
Repository URL: https://github.com/alsa-project/alsa-lib
