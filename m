Return-Path: <SRS0=ChbS=AA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ACEC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:11:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C03206F1
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EUOzFlIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C03206F1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0AE52166C;
	Fri, 19 Jun 2020 14:10:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0AE52166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592568696;
	bh=ls+7CCQbcGCOUgMP2L9gm/LuEVGgO5ZM581TY2fJ0jw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EUOzFlIyNa1Yy2YTc7OwgqL7K/SVjmxk1yQWws497QAE0nm82Ogtb/Nmgni9k3SHX
	 X1KjeDI1awcQk7UnI0+9Bw3Kp+/tdkOXGQj1ReE0TGizYtYrI3Vy/qHICSR8lS2lrO
	 9JCuuzp0lmN4mgzepCiqQItCy1ZdSoJs/iKOZuo4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84EA4F80245;
	Fri, 19 Jun 2020 14:10:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA2D6F80252; Fri, 19 Jun 2020 14:10:44 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 5D59FF80232
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2020 14:10:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D59FF80232
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1592568640831276894-webhooks-bot@alsa-project.org>
References: <1592568640831276894-webhooks-bot@alsa-project.org>
Subject: alsa-gobject: supplement to use guint8 for the numerical ID of
 client/queue
Message-Id: <20200619121044.BA2D6F80252@alsa1.perex.cz>
Date: Fri, 19 Jun 2020 14:10:44 +0200 (CEST)
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

alsa-project/alsa-gobject pull request #42 was edited from takaswie:

Some APIs are missing in #41. This patchset has supplements for them.

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/42
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/42.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
