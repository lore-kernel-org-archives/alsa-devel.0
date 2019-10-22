Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68865CA9EA0
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 12:16:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C81F21872
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 12:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eVI5e97i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C81F21872
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31B8B1607;
	Tue, 22 Oct 2019 14:16:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31B8B1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571746612;
	bh=E33HQ4KgVbK1sibi56kRHP6ZyhJSYfwXR8oTb5lQHpc=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eVI5e97i+65LsVdY8awbCmQtMzzb+MjoUhrJ3Ziv8o8Iu4QDxDDf5sOdfmfRDneYB
	 vkWCDnzWeADQEnk44hSQ4qFGOBNRfbpcvHx/OD4ZD5i+lV9I9TGQb8OTAiaCLj178C
	 4v/oT8zz7GmmfXyM+JulVBLmXGoS0Ms4PkndG3y4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD0BDF802FB;
	Tue, 22 Oct 2019 14:16:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48E00F8031A; Tue, 22 Oct 2019 14:16:00 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id CD26CF80112
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 14:15:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD26CF80112
MIME-Version: 1.0
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1571746557006731033-webhooks-bot@alsa-project.org>
References: <1571746557006731033-webhooks-bot@alsa-project.org>
Message-Id: <20191022121600.48E00F8031A@alsa1.perex.cz>
Date: Tue, 22 Oct 2019 14:16:00 +0200 (CEST)
Subject: [alsa-devel] sof-skl_hda: add device definition to speaker disable
	sequence
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #3 was opened from juimonen:

For example Pulseaudio is not able to run the disable sequence
if the device is not defined. So add the definition.

Signed-off-by: Jaska Uimonen <jaska.uimonen@linux.intel.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/3
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/3.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
