Return-Path: <SRS0=uvWr=PX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A40EC433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Nov 2021 11:24:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF40611C9
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Nov 2021 11:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3FF40611C9
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C45881674;
	Thu,  4 Nov 2021 12:23:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C45881674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636025087;
	bh=qElAx3mkc0SUEsav9OVv1mSqvMptwPQT2nwsQQTnUYw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mFrdba5kHm88gSnpROQ2Ea8/UdG9mWOR7HUeo4G/h4AJhoF12yhjsqoX3NgnonylD
	 HcRHsTSTa/WFul/1/BKkZak8VqdYsei1bxPg5Qdo8xWS0p1jdd74jgKJV7c9IgE6OS
	 oh4ayHMyweB5AUansOipHf6SSmmtUzqMFtn445E4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C329F80229;
	Thu,  4 Nov 2021 12:23:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5CE99F8025D; Thu,  4 Nov 2021 12:23:55 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C05C4F80224
 for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2021 12:23:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C05C4F80224
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1636025031617399931-webhooks-bot@alsa-project.org>
References: <1636025031617399931-webhooks-bot@alsa-project.org>
Subject: HDA-Intel: fixes for Headphone+LO variant (Realtek ALC233)
Message-Id: <20211104112355.5CE99F8025D@alsa1.perex.cz>
Date: Thu,  4 Nov 2021 12:23:55 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #116 was opened from perexg:

Issue: https://github.com/alsa-project/alsa-ucm-conf/issues/114

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/116
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/116.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
