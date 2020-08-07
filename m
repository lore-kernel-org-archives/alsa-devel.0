Return-Path: <SRS0=pDBX=BR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6146FC433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:37:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11737221E2
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="t9D/NJBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11737221E2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B960826;
	Fri,  7 Aug 2020 16:36:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B960826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596811034;
	bh=/8S8Cv/FG9TD4t9LwrAWG6D5QvAr34LeehYO4R5yFFs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t9D/NJBHS85lLdadSPaWXeA9CD7Dewhc9S33zvjOJeise6Qzary3mnJi3xPYlH9CR
	 uVnQb3XThNxETm2v+PAK7gCRmxS9vCB+Y6bL2oLMhh8CWSRVl6p5vV6DnJU+pqKYtv
	 QE3cBeWlWD/CSazwFXngysUc15lNKC3Fps7ySeRw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19FC4F8020B;
	Fri,  7 Aug 2020 16:36:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8CD01F80218; Fri,  7 Aug 2020 16:36:22 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C3521F801F7
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2020 16:36:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3521F801F7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - reopened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1596810972284259081-webhooks-bot@alsa-project.org>
References: <1596810972284259081-webhooks-bot@alsa-project.org>
Subject: Correct conflicting mic in max98090
Message-Id: <20200807143622.8CD01F80218@alsa1.perex.cz>
Date: Fri,  7 Aug 2020 16:36:22 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #43 was reopened from jacobopantoja:

'mic' was conflicting 'mic' instead of 'headset', thus preventing correct configuration regarding microphones.

With this corrected, introducing a headset enables 'headset' mic and disables internal 'mic', whereas releasing the headset disables 'headset' mic and enables internal 'mic'

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/43
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/43.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
