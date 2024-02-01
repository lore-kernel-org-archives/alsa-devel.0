Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA035C47DDB
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Feb 2024 09:33:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99E71BC0;
	Thu,  1 Feb 2024 10:33:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99E71BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706780006;
	bh=F9ZhnmxLGNXbPBDPKDtubZCB8545bjIysuWLt9y7cV4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=jqWqZIwuVf+bPZaOc7MfeSrdwqOAy+TLcGmlA0tHRofpNiMxhKvy0zKc4PYRanw+N
	 f0ikSO4myGnLFDJzGHo43E7IicwunBxcphjQL3jpf65SNjO8LiHDq9897msk7eJv1H
	 tCL090zu1aLcQMbYuujUlIAXLziPrYkF+ZW0LAW4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C763DF805A9; Thu,  1 Feb 2024 10:32:55 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 05F4AF805AA;
	Thu,  1 Feb 2024 10:32:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3FBE4F8055C; Thu,  1 Feb 2024 10:32:48 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EC2AF80149
	for <alsa-devel@alsa-project.org>; Thu,  1 Feb 2024 10:32:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0EC2AF80149
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1706779957923728466-webhooks-bot@alsa-project.org>
References: <1706779957923728466-webhooks-bot@alsa-project.org>
Subject: Add UCM2 Configs for Qualcomm sm8550 HDK platform
Message-Id: <20240201093248.3FBE4F8055C@alsa1.perex.cz>
Date: Thu,  1 Feb 2024 10:32:48 +0100 (CET)
Message-ID-Hash: X7EIULGA4YA6FOJPPSYHPSFNMAHFDET2
X-Message-ID-Hash: X7EIULGA4YA6FOJPPSYHPSFNMAHFDET2
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X7EIULGA4YA6FOJPPSYHPSFNMAHFDET2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #393 was opened from superna9999:

This adds the UCM2 Configs for Qualcomm SM8550 HDK platform.

Tested with PulseAudio 16.1.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/393
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/393.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
