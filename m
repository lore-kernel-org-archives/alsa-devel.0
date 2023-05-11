Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D2CC77B7F
	for <alsa-devel@archiver.kernel.org>; Thu, 11 May 2023 21:21:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5791A1EB;
	Thu, 11 May 2023 23:21:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5791A1EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683840114;
	bh=UVN59RcW0uyDCITM7v2+mpuLhrYW629Lun0ndhM6vHg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Od6GN1GqrqS6axsX8p2BhdonoqWGk4VFfCljwz0/9/T2lP0OWUw+hgVMhIQFpC5Sx
	 UrXcr0MsIGpBX7XsktH8qicqkj4vzgPc2lqGcJ5Cli3elVKfeVDMrszwyfF+pIM+ax
	 VyzZcOlWbsXgLRIK7TI/BLSug5nrTceXhCZgFLeY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 05FC3F80549; Thu, 11 May 2023 23:20:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A08E5F8052E;
	Thu, 11 May 2023 23:20:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7AF5BF8052E; Thu, 11 May 2023 23:20:31 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E21EF8032D
	for <alsa-devel@alsa-project.org>; Thu, 11 May 2023 23:20:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E21EF8032D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1683840021507306099-webhooks-bot@alsa-project.org>
References: <1683840021507306099-webhooks-bot@alsa-project.org>
Subject: Looking for alsaunmute script
Message-Id: <20230511212031.7AF5BF8052E@alsa1.perex.cz>
Date: Thu, 11 May 2023 23:20:31 +0200 (CEST)
Message-ID-Hash: 7KDZ4LZ3RXKLRKIMTOGC65BME44XTOF6
X-Message-ID-Hash: 7KDZ4LZ3RXKLRKIMTOGC65BME44XTOF6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7KDZ4LZ3RXKLRKIMTOGC65BME44XTOF6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #211 was opened from DenverEllis:

I have a friend that is having trouble with their legion 7 laptop. Perusing a very long kernel thread I saw mention of an alsaunmute script and I am having a hard time tracking it down. I believ perex authored it and I saw it mentioned that it was a part of alsa-utils, but alas I have had no luck in finding this script.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/211
Repository URL: https://github.com/alsa-project/alsa-utils
