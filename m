Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8ECCD13D1
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Sep 2023 08:45:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33233206;
	Mon, 18 Sep 2023 10:44:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33233206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695026704;
	bh=dopU6kRG2NozDbSEYJ4FN7uY+hpvKqY3GAWKv7Om7oA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Jtxl/xyZ0M2LdKT4p9wSAq9FH06nIa6nHLK6Noyzf8xqIzJ2qSKKSErK2oRGU89Mx
	 JOcBUOBYZoRb4BEWeSTlSGJjK0pd2GB8aunnfWNgUih3UqD5+IzgX7x8+tlRqbSdvD
	 jDbqMWV5Fd/MVvd7hJKhYxtqGBDV5jphrEcVN0Io=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A09EAF80124; Mon, 18 Sep 2023 10:44:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C0A4F801F5;
	Mon, 18 Sep 2023 10:44:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5DD8FF801F5; Mon, 18 Sep 2023 10:44:10 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 098E0F80125
	for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2023 10:44:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 098E0F80125
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1695026647066370487-webhooks-bot@alsa-project.org>
References: <1695026647066370487-webhooks-bot@alsa-project.org>
Subject: bat: really skip analysis of the first period and update related
 comment
Message-Id: <20230918084410.5DD8FF801F5@alsa1.perex.cz>
Date: Mon, 18 Sep 2023 10:44:10 +0200 (CEST)
Message-ID-Hash: LEOVWO4DCEHUM7HOE7SPO3DG3C2XUOS5
X-Message-ID-Hash: LEOVWO4DCEHUM7HOE7SPO3DG3C2XUOS5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LEOVWO4DCEHUM7HOE7SPO3DG3C2XUOS5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #237 was opened from dbrignoli:

Prior to this change bat/analyze.c would skip the last period of the recording, contrary to what the comment in the code which stated the first period was meant to be skipped.

The comment has been updated to state that both the first and last period are skipped and the code has been updated to match.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/237
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/237.patch
Repository URL: https://github.com/alsa-project/alsa-utils
