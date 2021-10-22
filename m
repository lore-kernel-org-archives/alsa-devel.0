Return-Path: <SRS0=JyZJ=PK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E67C4321E
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Oct 2021 13:28:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6A0611C3
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Oct 2021 13:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E6A0611C3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 936EF84A;
	Fri, 22 Oct 2021 15:27:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 936EF84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634909316;
	bh=wk/Y2oaOZMvioFQ75GLhnMTaHw1hKxIVbLzV1dEoemg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aTwuLzbxnewClLSNJVMIUrLmEpt1+SrWWFUcw6ptIiYKAEincrSdExt9AF7lDJ1xA
	 wUQe2PYmGnA/gy3Rt8YQF+/1e6vJxmIarGOhYc/6yJeUA6ssH+4yLk7IaYpRIn+sU2
	 MGBJTRTpHaYeFXQe2BqSUusjzKPkYmEPABg6M8SI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2565FF80224;
	Fri, 22 Oct 2021 15:27:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E6B1F80224; Fri, 22 Oct 2021 15:27:44 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id EB181F80086
 for <alsa-devel@alsa-project.org>; Fri, 22 Oct 2021 15:27:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB181F80086
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1634909253407216072-webhooks-bot@alsa-project.org>
References: <1634909253407216072-webhooks-bot@alsa-project.org>
Subject: wrong test in alsa-info.sh
Message-Id: <20211022132744.5E6B1F80224@alsa1.perex.cz>
Date: Fri, 22 Oct 2021 15:27:44 +0200 (CEST)
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

alsa-project/alsa-utils issue #115 was opened from mhampl:

In line 691 of alsa_info.sh script (version 0.5.0) a test for $TEMPDIR/alsa-usbstream.tmp is needed instead of $TEMPDIR/lsusb.tmp

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/115
Repository URL: https://github.com/alsa-project/alsa-utils
