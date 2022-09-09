Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617D8ECAAD3
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Sep 2022 08:33:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2ACBE1652;
	Fri,  9 Sep 2022 10:32:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2ACBE1652
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662712382;
	bh=hfo8CnkfR0MgtMuIPw7dQaRQA5aYzERVm9K+1XsHS5s=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NwLOq/n9cgkJPcG/I3MCnU2QYts81hjeNWfxXCwU/TB7UE96ZJFbAbOVrJt5qKPLX
	 OCWIiOyDQdBhRhTpKjyYpRu3EW9CFWDrLUcTmTOtaSx89ffCF2OldMdFwy4culqPZb
	 +fx4X/nG6UUQp4eUqzk04l6fP9rDTH0lYsFUBCpM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5770F8016D;
	Fri,  9 Sep 2022 10:32:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6A05CF8023A; Fri,  9 Sep 2022 10:32:09 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id DA429F8011C
 for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2022 10:32:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA429F8011C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1662712325330811024-webhooks-bot@alsa-project.org>
References: <1662712325330811024-webhooks-bot@alsa-project.org>
Subject: po: Add Georgian translation
Message-Id: <20220909083209.6A05CF8023A@alsa1.perex.cz>
Date: Fri,  9 Sep 2022 10:32:09 +0200 (CEST)
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

alsa-project/alsa-utils pull request #169 was opened from NorwayFun:

po: Add Georgian translation

Request URL   : https://github.com/alsa-project/alsa-utils/pull/169
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/169.patch
Repository URL: https://github.com/alsa-project/alsa-utils
