Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B343EC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Mar 2022 17:26:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E4D91753;
	Tue, 29 Mar 2022 19:25:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E4D91753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648574762;
	bh=5L73kpv1rrIpyUGOuigpT7NzaQev0Ulcqo1n9VDo0pM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VWvWLYFLbPminDN9SCRHZzxmmeM9gLvpTLR67Smyh82YPbAGpGXOOj0oaUopDx2s/
	 g115DpXUWWtZO4x+zVs/myVAb80h1+CVYt0/ptMJuJD609SOK9HIQTW/mgD6W69zek
	 NXBDbj08UT9156LLkl7Q3eKUq8mIQ12CDSY/huZc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B90CF80121;
	Tue, 29 Mar 2022 19:25:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD6CCF80311; Tue, 29 Mar 2022 19:25:10 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 4FFBEF80121
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2022 19:25:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FFBEF80121
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1648574706329361916-webhooks-bot@alsa-project.org>
References: <1648574706329361916-webhooks-bot@alsa-project.org>
Subject: Nhlt plugin and simple plugin interface
Message-Id: <20220329172510.BD6CCF80311@alsa1.perex.cz>
Date: Tue, 29 Mar 2022 19:25:10 +0200 (CEST)
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

alsa-project/alsa-utils pull request #129 was edited from juimonen:

Initial something... I need to figure out:

- where to specify which plugins to load/run (nhlt now hard coded)
- where to install the plugins
- how to get the to-be-loaded plugin names and where
- is the "hidden-visibility" gcc flag ok to hide other than .so entrypoint

Request URL   : https://github.com/alsa-project/alsa-utils/pull/129
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/129.patch
Repository URL: https://github.com/alsa-project/alsa-utils
