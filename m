Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEDFEB64D8
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jun 2023 21:53:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E53BD823;
	Wed, 14 Jun 2023 23:52:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E53BD823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686779615;
	bh=i3KYHrQF/zfDpSHRj9mrwb72rhmC3M5HYtjIMGAVNZ8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=OBxnikUynP20zxKmOZ8rRheuyz9Fgf8w1AV7glAaxpVdCwuj2eRVabB1QEGB0L8x4
	 tKTJwdupXefEDyTtQbWirC4FXXPsNHDVWIf6d1ZnTTtnGiLYbA6x/yYrwAbnNEumZn
	 B6FhlzvAHPmCKY9up6Lxy+WWm0x7rQ6gjUEKxxb4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4E55EF80149; Wed, 14 Jun 2023 23:52:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1458BF80149;
	Wed, 14 Jun 2023 23:52:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C2A2F80149; Wed, 14 Jun 2023 23:52:40 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D226F800BA
	for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2023 23:52:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D226F800BA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1686779557984104633-webhooks-bot@alsa-project.org>
References: <1686779557984104633-webhooks-bot@alsa-project.org>
Subject: pcm: fix minor bug in ioctl
Message-Id: <20230614215240.6C2A2F80149@alsa1.perex.cz>
Date: Wed, 14 Jun 2023 23:52:40 +0200 (CEST)
Message-ID-Hash: 2MWCTGT7VRYXPHZHOMNXP26B4BXLWD7W
X-Message-ID-Hash: 2MWCTGT7VRYXPHZHOMNXP26B4BXLWD7W
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2MWCTGT7VRYXPHZHOMNXP26B4BXLWD7W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #330 was opened from dancrossnyc:

Commit 2115cdb added a new call to the `SNDRV_PCM_IOCTL_SW_PARAMS` ioctl on line 675 of src/pcm/pcm_hw.c, but passed the `sw_params` argument by value; this should be passed by pointer.

I ran across this in the context of the direwolf software modem for amateur radio; debugging details are in
https://groups.io/g/direwolf/message/8286

Fixes #329

Request URL   : https://github.com/alsa-project/alsa-lib/pull/330
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/330.patch
Repository URL: https://github.com/alsa-project/alsa-lib
