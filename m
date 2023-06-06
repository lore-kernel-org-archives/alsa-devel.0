Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECDBC77B7A
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Jun 2023 07:29:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9DD883E8;
	Tue,  6 Jun 2023 09:29:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9DD883E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686036590;
	bh=5SJ9XICdYCIVlS9rc+V44iOIVvdzq/4VZe/5nM/AjWc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=T6Jv/T5yGhVEN1GpEMb6okRYDU/Rs4fF4i9rv4pcwfyPtM0IPYbEf9tHl9o95YsvM
	 Ki9aW9hhcgFhmpNz7+UkPAMxNwczNg05fnodlHJPw4Iwp6XAS9PtGpJ3FtaaIhchvR
	 YjDMmNnw+bolvnNTE63bHloOq+Wo7nvcVhtP5C7s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0298CF80494; Tue,  6 Jun 2023 09:28:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C9A5F80199;
	Tue,  6 Jun 2023 09:28:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 36AF4F80199; Tue,  6 Jun 2023 09:28:28 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 759ECF800C8
	for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2023 09:28:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 759ECF800C8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1686036498546247721-webhooks-bot@alsa-project.org>
References: <1686036498546247721-webhooks-bot@alsa-project.org>
Subject: Add Asus ROG STRIX X670E-F Gaming Wifi to USB-Audio.conf
Message-Id: <20230606072828.36AF4F80199@alsa1.perex.cz>
Date: Tue,  6 Jun 2023 09:28:28 +0200 (CEST)
Message-ID-Hash: FST6MLA4LGQAEE6LRQ4RDB42GRQCFHNI
X-Message-ID-Hash: FST6MLA4LGQAEE6LRQ4RDB42GRQCFHNI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FST6MLA4LGQAEE6LRQ4RDB42GRQCFHNI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #320 was opened from ksenchy:

Since the id was already present in the list, I have only added a comment denoting this board also uses that id

My alsa-info as a proof can be found here: http://alsa-project.org/db/?f=1ad83f467dc312e2ac7743859c647695dbccb6ce

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/320
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/320.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
