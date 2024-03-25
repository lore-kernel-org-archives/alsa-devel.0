Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4E3C54E58
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Mar 2024 07:48:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D49414EA;
	Mon, 25 Mar 2024 08:47:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D49414EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711352879;
	bh=z46hbfjTVVX4m58eLYRj7eugSfpKM/GGZCC2g7R75WU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=AqtzQsN3JYvjnIDQdXemOR9VnZ52DxRnRvhXsY+4Bk0A9MhbW3xl2lI1K3Ljhi3iP
	 rgKeGWeAAN4YehuBnfDq67r5hZl/GQc1E4yuVFOwGs2B+JsjP3F89Ja0/+Ocqc1NUZ
	 Na34vTwRnbBYmAZ6jmHDaQGheVTJesXx7Y2RIk5k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4DE6FF805AA; Mon, 25 Mar 2024 08:47:24 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E7C9F80236;
	Mon, 25 Mar 2024 08:47:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C93EBF80236; Mon, 25 Mar 2024 08:47:20 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 13012F8015B
	for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2024 08:47:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13012F8015B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1711352837484479427-webhooks-bot@alsa-project.org>
References: <1711352837484479427-webhooks-bot@alsa-project.org>
Subject: aplay: fix S24_LE wav header
Message-Id: <20240325074720.C93EBF80236@alsa1.perex.cz>
Date: Mon, 25 Mar 2024 08:47:20 +0100 (CET)
Message-ID-Hash: 72DDPQ7WHHCBVFDAQHGSDM4GAXQ57DMF
X-Message-ID-Hash: 72DDPQ7WHHCBVFDAQHGSDM4GAXQ57DMF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/72DDPQ7WHHCBVFDAQHGSDM4GAXQ57DMF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #260 was opened from psi-sue:

S24_LE is 32 bits in width storing 24 bits of data and 8 bytes of padding So wav header needs to be 32 bits not 24

Request URL   : https://github.com/alsa-project/alsa-utils/pull/260
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/260.patch
Repository URL: https://github.com/alsa-project/alsa-utils
