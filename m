Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0199BC00140
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Aug 2022 22:15:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B665161D;
	Mon, 22 Aug 2022 00:14:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B665161D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661120110;
	bh=mvJ0adMH5leMCRuDltCnKNF0nqat0qY7oC3JIQb7nTs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qujSX6NmAuGE/A6+5wwTTMw+ukMwOfnkxibM0zt+WuQ/sDiQfzavvoih94ykVhcLx
	 EfK7Ib0S1BfS6cbJR4NyMBstyjhmOifRHcX/xHbQCviJl8L9JXXJDTZt2dtz1oL6bZ
	 cxCAboskjf5nuGgIHcA5DbOknEumElrgHAmlXeNY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D93E6F80154;
	Mon, 22 Aug 2022 00:14:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6278F80163; Mon, 22 Aug 2022 00:14:16 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 46B0FF80163
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2022 00:14:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46B0FF80163
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1661120053641208887-webhooks-bot@alsa-project.org>
References: <1661120053641208887-webhooks-bot@alsa-project.org>
Subject: bug: Fix verbose logging in GitHub Workflow
Message-Id: <20220821221416.C6278F80163@alsa1.perex.cz>
Date: Mon, 22 Aug 2022 00:14:16 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #202 was opened from PatrickLang:

I noticed the GitHub Workflow `ucm_validate` was setting `LOGLEVEL` instead of `V` which is used in the `Makefile` to set the log level. The tests in this repo are still failing, but fixing the logging first should help.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/202
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/202.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
