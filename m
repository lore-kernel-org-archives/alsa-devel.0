Return-Path: <SRS0=oKMh=DZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA169C433DF
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Oct 2020 13:27:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D1121655
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Oct 2020 13:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Guqh0V3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D1121655
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F6A917A5;
	Sun, 18 Oct 2020 15:26:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F6A917A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603027617;
	bh=u3+MpJT70Nq+Hp67DcOdaRc2nlHsgGYOW6hN6tUBLSM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Guqh0V3iMGhpja0+l3EiND0DciIIrPdgMCpvpeazca4CyC684/weteHlHno+R097F
	 6cC+6rAK5PosbHMfOnNI7LhASUeSuzO2mvHNl6sbeLy8bpGYBEQ1A2cKVWzhLnE13+
	 jdEWZ6aKU3onri2JBvLFNXwkwfp1Kn5V1QoxP9BQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 152E1F8014D;
	Sun, 18 Oct 2020 15:26:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3405F801F2; Sun, 18 Oct 2020 15:26:05 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 391AAF800AD
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2020 15:26:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 391AAF800AD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1603027559622334957-webhooks-bot@alsa-project.org>
References: <1603027559622334957-webhooks-bot@alsa-project.org>
Subject: Add Slovak translation
Message-Id: <20201018132605.C3405F801F2@alsa1.perex.cz>
Date: Sun, 18 Oct 2020 15:26:05 +0200 (CEST)
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

alsa-project/alsa-utils pull request #68 was opened from jose1711:



Request URL   : https://github.com/alsa-project/alsa-utils/pull/68
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/68.patch
Repository URL: https://github.com/alsa-project/alsa-utils
