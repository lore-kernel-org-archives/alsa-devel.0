Return-Path: <SRS0=+bKl=72=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CE4C433E0
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Jun 2020 15:52:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95842074D
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Jun 2020 15:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SCmB5SAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95842074D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5DAD51607;
	Sat, 13 Jun 2020 17:51:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5DAD51607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592063519;
	bh=E1pU+ylqMPUwlFqyn/zw1GrW8EVNP9rnKFqnNgKmU1U=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SCmB5SAtH05HelNCcyTK54m5zrjDvQ7EEzoPbaupzzoWsfHnkaBdA+/2D7D0d4g+l
	 aMSVTWlEbf+qymWfbHNPPMNlsmkxZOMAClnErMlej6O7V1eiSn/F/Yc6grVYEZckOt
	 TsVVETfvF86ILevT2VgmK3Drb58meDsF9k0nQPa0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DF5A1F80278;
	Sat, 13 Jun 2020 17:51:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6CC27F800C7; Sat, 13 Jun 2020 17:51:06 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 033A2F800C7
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2020 17:50:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 033A2F800C7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1592063458222615004-webhooks-bot@alsa-project.org>
References: <1592063458222615004-webhooks-bot@alsa-project.org>
Subject: dlmisc.c: fix uclibc build
Message-Id: <20200613155106.6CC27F800C7@alsa1.perex.cz>
Date: Sat, 13 Jun 2020 17:51:06 +0200 (CEST)
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

alsa-project/alsa-lib pull request #58 was opened from bkuhls:

RTLD_DL_LINKMAP & RTLD_DI_ORIGIN, are unsupported on uClibc:
https://cgit.uclibc-ng.org/cgi/cgit/uclibc-ng.git/tree/include/dlfcn.h#n106

This patch adds detection for uClibc because uClibc also defines
__GLIBC__:
https://lists.gnu.org/archive/html/bug-gnulib/2010-11/msg00280.html

Request URL   : https://github.com/alsa-project/alsa-lib/pull/58
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/58.patch
Repository URL: https://github.com/alsa-project/alsa-lib
