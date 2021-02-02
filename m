Return-Path: <SRS0=BHSX=HE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC1AC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 00:03:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246E564EDC
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 00:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246E564EDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=base.nu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C46C1170D;
	Tue,  2 Feb 2021 01:02:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C46C1170D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612224205;
	bh=KtkeQEH5WnpdsI8/Ie9vUZu6GdeaueYsLnJHY2/7b6A=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O+VeAbcgIul4rM1Nq7tYiR/bQUkJFUsNJw/v3nppzCzfU0yaMQdqxlgxC3tWJJofU
	 DPucntGoduXv6W/N6aYRWMdYL2+rW2pA580xE8mCpbbTMeOeFIauR+EVqG2v7u36wL
	 8Q2JmfcOYeJFkMYysVvU9Rf7rnUef8Q5SNXob7y0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50BD0F80152;
	Tue,  2 Feb 2021 01:02:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99C10F80153; Tue,  2 Feb 2021 01:02:33 +0100 (CET)
Received: from hellmouth.base.nu (hellmouth.base.nu [192.248.168.186])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E354F80151
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2021 01:02:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E354F80151
Received: from baphomet.hell (<unknown> [192.168.179.1])
 by hellmouth.base.nu (OpenSMTPD) with ESMTP id 28437bb8;
 Tue, 2 Feb 2021 00:02:26 +0000 (UTC)
Received: from baphomet.hell (localhost [127.0.0.1])
 by baphomet.hell (OpenSMTPD) with ESMTP id fb26d32b;
 Tue, 2 Feb 2021 00:02:12 +0000 (GMT)
Received: from base.nu ([192.168.178.2]) by baphomet.hell with ESMTPSA
 id t2s2KXOWGGA7QgEAnQSWfg
 (envelope-from <livvy@base.nu>); Tue, 02 Feb 2021 00:01:47 +0000
Date: Tue, 2 Feb 2021 00:01:22 +0000
From: Olivia Mackintosh <livvy@base.nu>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ALSA: usb-audio: Add Pioneer DJM-450 support
Message-ID: <20210202000122.5riso3tlhvwhqyqg@base.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: Takashi Iwai <tiwai@suse.de>
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

Here are a couple of patches to support the DJM-450. Un-suprisingly, a
device quirk is required just like the other DJM models. Testing was
done by "xfz" from #xwax on Freenode. Perhaps this is useful for
reference or if anyone requires information about this device. They were
hesitant to have their full details in the commit log.

Olivia Mackintosh (2):
  ALSA: usb-audio: Add DJM450 to Pioneer format quirk
  ALSA: usb-audio: Add DJM-450 to the quirks table

 sound/usb/quirks-table.h | 57 ++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks.c       | 20 ++++++++++++++
 2 files changed, 77 insertions(+)

-- 
2.30.0

