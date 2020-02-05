Return-Path: <SRS0=flyq=3Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E104C35249
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Feb 2020 04:23:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B07321741
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Feb 2020 04:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RE2J/Qd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B07321741
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46A841662;
	Wed,  5 Feb 2020 05:22:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46A841662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580876607;
	bh=m44FqNMVWnMxKCmTLZSqoU8ErxFVhUNwUm3P5Xg12To=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RE2J/Qd+uUv5csMDpTONgi8F0oim9rcCnDjaJMTOfmds2H36Pggxo8dhhk4ZAYZ29
	 KQKhRvDj1hBAB8Zs2y0rebBKtLsaHG3DpqnXwTulJZsC4KJOdYl51vW/sEqLHF2m8r
	 OU2McuuXLCTQ7WsBqyM7UTC/oAyQkEMnYXmtsZHY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4EFAF80051;
	Wed,  5 Feb 2020 05:22:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D212BF80148; Wed,  5 Feb 2020 05:22:33 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9854EF80051
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2020 05:22:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9854EF80051
MIME-Version: 1.0
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1580876547858634949-webhooks-bot@alsa-project.org>
References: <1580876547858634949-webhooks-bot@alsa-project.org>
Message-Id: <20200205042233.D212BF80148@alsa1.perex.cz>
Date: Wed,  5 Feb 2020 05:22:33 +0100 (CET)
Subject: [alsa-devel] alsa-gobject: Add support workflow of Github Actions
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

alsa-project/alsa-gobject pull request #5 was opened from takaswie:

Github Actions is tool to automate software development workflows for CI/CD.
This tool has a remarkable point to share 'action' in repositories in github,
which is a unit of processing defined by users. The users write and push
'workflow' with the 'action' into repository in github.com. When any workflow
file is added to 'default' branch, the automation runs[2].

The defined actions run on virtual machine in Microsoft Azure (Standard_DS2_v2
as of today[2]). Three types of operating system are available: Windows, MacOS
and Linux (Ubuntu). On the MacOS and Linux machine, 'sudo' is available to
setup host environment for CI/CD, as well as Docker container is supported on
the host.

This commit adds a workflow file to automate build test. In this automation,
Fedora 32 in Docker container and Ubuntu 19.10 in LXD container as build
environments in Linux host. The automation is triggered in each 'push' and
'pull_request' event. The result is available in 'Actions' tab of repository
page in github.com.

[1] https://help.github.com/en/actions/automating-your-workflow-with-github-actions/about-github-actions
[2] https://help.github.com/en/actions/automating-your-workflow-with-github-actions/configuring-a-workflow
[3] https://help.github.com/en/actions/automating-your-workflow-with-github-actions/virtual-environments-for-github-hosted-runners

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/5
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/5.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
