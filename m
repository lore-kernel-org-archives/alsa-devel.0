Return-Path: <SRS0=YLi8=6B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34082C2BB55
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 06:41:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E49221E9
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 06:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mIJF/c29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E49221E9
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F0EC829;
	Fri, 17 Apr 2020 08:40:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F0EC829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587105688;
	bh=BJR17g+YJ0sVM6dhf+ImGEVDdLvDrbBdjpNHNf0zITk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mIJF/c29Z8yRLlfgLBGLuAoCPhuflqVoXrJRlIudGHw256/h0EMx2iR6oAZmNpjXC
	 BO+rKKKC4DZFGmqwcsA0jNGYLXn+jPOClRjjF05/aysMr3IKSzc/58srHoGSMYuCuu
	 jquF0K9Bc5v6LdXJjGcCGdVdo9qwHjbikxiRSDbc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AE8C9F80229;
	Fri, 17 Apr 2020 08:40:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97E16F80245; Fri, 17 Apr 2020 08:40:34 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 480AFF8012E
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2020 08:40:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 480AFF8012E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1587105616223323107-webhooks-bot@alsa-project.org>
References: <1587105616223323107-webhooks-bot@alsa-project.org>
Subject: sof-hda-dsp: Reverse order and priority of headset and headphone mic
Message-Id: <20200417064034.97E16F80245@alsa1.perex.cz>
Date: Fri, 17 Apr 2020 08:40:34 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #21 was opened from juimonen:

Headset mic is the analog input source in 99% of the cases compared to
headphone mic, so change it's priority higher.

Jaska Uimonen <jaska.uimonen@linux.intel.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/21
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/21.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
