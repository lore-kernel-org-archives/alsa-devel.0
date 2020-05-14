Return-Path: <SRS0=rado=64=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CE4C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 14 May 2020 09:09:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D984020675
	for <alsa-devel@archiver.kernel.org>; Thu, 14 May 2020 09:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TcUlPXpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D984020675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 720481665;
	Thu, 14 May 2020 11:08:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 720481665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589447378;
	bh=Gs/AmTRFDnI+ll4a8tkTghslb9uEVU8SydYIfRFDvPg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TcUlPXpmQ+fSxtcgJMjqvqbDOjkdkfAaIWCg9mFGzkk6BrcQfV4V4o4Ag80qKdEQO
	 zRStnmfyp5QgKgs/plwvYLbjwxkjVpV5Upr6rhccbH1xhDRcIpzTpwPKXvLC9c8+fm
	 CCNZvJsKZE3nDGa2ROHExpwV7W2qUHhQtNidd1+I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E707AF80227;
	Thu, 14 May 2020 11:07:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1CAFEF8014C; Thu, 14 May 2020 11:07:55 +0200 (CEST)
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
 by alsa1.perex.cz (Postfix) with ESMTP id 4FE95F80101
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2020 11:07:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FE95F80101
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
 by 156.147.23.51 with ESMTP; 14 May 2020 18:07:42 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: changjoon.lee@lge.com
Received: from unknown (HELO MacBookPro.local.net) (10.157.161.30)
 by 156.147.1.121 with ESMTP; 14 May 2020 18:07:42 +0900
X-Original-SENDERIP: 10.157.161.30
X-Original-MAILFROM: changjoon.lee@lge.com
From: changjoon.lee@lge.com
To: tiwai@suse.de
Subject: [PATCH 0/1] Documentation update
Date: Thu, 14 May 2020 18:07:15 +0900
Message-Id: <20200514090716.39413-1-changjoon.lee@lge.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: ChangJoon Lee <changjoon.lee@lge.com>, alsa-devel@alsa-project.org,
 linux@endlessm.com, linux-kernel@vger.kernel.org
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

From: ChangJoon Lee <changjoon.lee@lge.com>

Hi, ALSA Teams,

This is documentation update purpose patch.
This patch does NOT alter any of operations.

This patch allows an application engineer to understand why they received negative return
such as -EIO, -EBADFD, -ENOSYS, -ESTRPIPE and etc which are not fully documented on documentation site.

This patch also exposes Expected Status of PCM based on bad_pcm_state() with P_STATE to help engineer to understand API behavior to the documentation site.

TODO :
We may need improve consistency of return value especially for snd_pcm_hw_params_current().
It returns -EBADFD when PCM is not setup while other API returns -EIO in this case.


 src/pcm/pcm.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

-- 
2.26.2

