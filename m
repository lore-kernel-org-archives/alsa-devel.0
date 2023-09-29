Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BEFE71D2A
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Sep 2023 13:01:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9CBE11F1;
	Fri, 29 Sep 2023 15:00:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9CBE11F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695992509;
	bh=RZsnWRRCInrX3tHkuparIpzshIp1OvLMa+EXhKNjFA8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=RoXCQDSYKatkI5gvMHSySNsHrLO8WcLGjGMs2tbzf6T/3KBRbiIKA9/sACpyFKi60
	 9g31hZupXEWNbIii7DDpSQGT7dHRBYPq0/DCBQwJr9inDrx6RQv0gwrA78Ey5BkCU3
	 VSzikF+lJwD0pzsbhbCLq2OLV5d7vamUODWTmtos=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 16FD1F8016A; Fri, 29 Sep 2023 15:00:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3953DF801D5;
	Fri, 29 Sep 2023 15:00:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2676F801D5; Fri, 29 Sep 2023 15:00:24 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E22DF8007C
	for <alsa-devel@alsa-project.org>; Fri, 29 Sep 2023 15:00:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E22DF8007C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1695992418081869841-webhooks-bot@alsa-project.org>
References: <1695992418081869841-webhooks-bot@alsa-project.org>
Subject: pcm: Add error handler for `read` that `snd_pcm_share_thread`
 function calls
Message-Id: <20230929130024.C2676F801D5@alsa1.perex.cz>
Date: Fri, 29 Sep 2023 15:00:24 +0200 (CEST)
Message-ID-Hash: FN5TXB6CLSYPEYX7FFAGJCHQTUXONY4A
X-Message-ID-Hash: FN5TXB6CLSYPEYX7FFAGJCHQTUXONY4A
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FN5TXB6CLSYPEYX7FFAGJCHQTUXONY4A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #355 was opened from Korilakkuma:

Maybe, this error occurs if cannot read from a pipe.

<img width="1364" alt="compile warning" src="https://github.com/alsa-project/alsa-lib/assets/4006693/275e0b6a-ebdf-4cd3-a766-5be1b75d2eb0">

Request URL   : https://github.com/alsa-project/alsa-lib/pull/355
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/355.patch
Repository URL: https://github.com/alsa-project/alsa-lib
