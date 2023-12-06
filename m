Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D9DC4167B
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Dec 2023 21:31:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C41D1868;
	Wed,  6 Dec 2023 22:31:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C41D1868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701898287;
	bh=y8kQuX9pd8cBl2CQ5W6mXrhhOiqB2RDH5j2vAGHA9fQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=pe0+IBJJQG/DIJVlIM4mxpK+L2M23J92zjrjG+vQR1AaEwOstN7ef0dfNSyeIBxuj
	 1Ga82FG9iHTQ2NLknQTucEG0I4bh9RslKexVnk7sSoB4hJ8DjhCinWjImYxeMvAC4c
	 Q6kPiRh/l4G1Mlhj+JeuafKXLM39UOkWMhK5PuTk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 81E5CF8025F; Wed,  6 Dec 2023 22:30:56 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 14683F8025F;
	Wed,  6 Dec 2023 22:30:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 46301F8024E; Wed,  6 Dec 2023 22:30:47 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 45525F800D2
	for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2023 22:30:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45525F800D2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1701898241708122253-webhooks-bot@alsa-project.org>
References: <1701898241708122253-webhooks-bot@alsa-project.org>
Subject: aplay: fix buffer overflow and tainted format string
Message-Id: <20231206213047.46301F8024E@alsa1.perex.cz>
Date: Wed,  6 Dec 2023 22:30:47 +0100 (CET)
Message-ID-Hash: PKR7KVLVBHM2HM6U3G7KJAPPFTMT2VYX
X-Message-ID-Hash: PKR7KVLVBHM2HM6U3G7KJAPPFTMT2VYX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PKR7KVLVBHM2HM6U3G7KJAPPFTMT2VYX/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #246 was opened from szsam:

Prior this commit, memcpy from names[0] to format[] will overwrite if strlen(names[0]) is greater than 1024. Also, the length of malloc()ed names[channel] is insufficient, leading to another buffer overwriting when calling sprintf(). Moreover, the format string of sprintf() can be controlled by user input. An attacker can exploit this weakness to crash the program, disclose information or even execute arbitrary code.

Fix by allocating enough space for arrays and using constant expressions as the format strings.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/246
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/246.patch
Repository URL: https://github.com/alsa-project/alsa-utils
