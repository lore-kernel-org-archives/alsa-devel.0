Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E4CF46139
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:16:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8AC4F601F7;
	Mon, 23 Mar 2026 16:16:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8AC4F601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774279016;
	bh=U4is7LKtYRZsC9X2nZAqPi0zl1Uo8xA9ktzM+POcnjg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=eX4pwGuetdZQCJx2rqDANuzfC7hN9LvT2T7jgGsz6vJTMq+b35ZQSc72S1k7XruIk
	 ZuLR8p7JLbg8cnkyM5i5V+D9OUmIUZeH3GBvtYRZqTaFO3K8DApCMRiAOjcSSr68Du
	 DNmrO2XatIZ46flK0eeTUpbp2EGvJNjz8UJ/c6iI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A199EF805EC; Mon, 23 Mar 2026 16:16:22 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 25CDCF805EE;
	Mon, 23 Mar 2026 16:16:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A6EBF80496; Mon, 23 Mar 2026 16:16:14 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 3902FF800C1
	for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2026 16:16:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3902FF800C1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189f8152ff72eb00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/501@alsa-project.org>
References: <alsa-project/alsa-lib/pr/501@alsa-project.org>
Subject: topology: decoder: fix wrong sizeof for enum control allocation in
 dapm
Date: Mon, 23 Mar 2026 16:16:14 +0100 (CET)
Message-ID-Hash: C44KG7U77Z5MJ7QQCL7MMV6RQMBRPMUT
X-Message-ID-Hash: C44KG7U77Z5MJ7QQCL7MMV6RQMBRPMUT
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C44KG7U77Z5MJ7QQCL7MMV6RQMBRPMUT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #501 was opened from kv2019i:

The tplg_calloc() call for enum control in the dapm widget kcontrol decode loop used sizeof(*mt) (mixer template) instead of sizeof(*et) (enum template). On 64-bit systems, snd_tplg_mixer_template is 72 bytes while snd_tplg_enum_template is 80 bytes, causing an 8-byte heap buffer overflow when the enum fields (texts, values pointers) were written past the allocated block. This resulted in heap corruption and e.g. glibc malloc hit an assert.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/501
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/501.patch
Repository URL: https://github.com/alsa-project/alsa-lib
