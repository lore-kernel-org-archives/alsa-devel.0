Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B83EE4996
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Aug 2023 04:43:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D7B2F827;
	Sun, 20 Aug 2023 06:42:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D7B2F827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692506595;
	bh=IovkWFfGGV0QEswbjKRjt1/9tp7eNVto3eYzlRnFUQg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DSOUthXGy/1jobIPTje3dJmcrs5vzcg0FZHdS49Wgdixt2sX/a6O39glT5gNXjNX9
	 dDvhNIYe4hX3lmkU6eIFOJJVoEPaM7lULvebxfkL5rS0/LcTix4VxStVq92rpoT//k
	 FrfZJxcP0hhkDeUYu5kKYDPnJUHAxcuV43zgw/+M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 16766F80536; Sun, 20 Aug 2023 06:42:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AF07FF80027;
	Sun, 20 Aug 2023 06:42:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6733BF80199; Sun, 20 Aug 2023 06:40:00 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A48FF800D1
	for <alsa-devel@alsa-project.org>; Sun, 20 Aug 2023 06:39:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A48FF800D1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1692506395677828550-webhooks-bot@alsa-project.org>
References: <1692506395677828550-webhooks-bot@alsa-project.org>
Subject: raw midi open fails results in verbose message to stdout
Message-Id: <20230820044000.6733BF80199@alsa1.perex.cz>
Date: Sun, 20 Aug 2023 06:40:00 +0200 (CEST)
Message-ID-Hash: EZL5QULLWE4GNTPXCT6ICT3IOJQGK65Q
X-Message-ID-Hash: EZL5QULLWE4GNTPXCT6ICT3IOJQGK65Q
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EZL5QULLWE4GNTPXCT6ICT3IOJQGK65Q/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #344 was opened from symdeb:

ALSA lib rawmidi_hw.c:384:(snd_rawmidi_hw_open) open /dev/snd/umpC5D0 failed: No such file or directory

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/344
Repository URL: https://github.com/alsa-project/alsa-lib
