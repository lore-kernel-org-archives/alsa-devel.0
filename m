Return-Path: <SRS0=5/d5=AO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7D3C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:40:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD9F206DF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="evWtu6i8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD9F206DF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF06B16CB;
	Fri,  3 Jul 2020 10:39:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF06B16CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593765621;
	bh=y3hI8p4kPtsO8vUZLJr1m/0WFcTGGur8CoSfujgHM78=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=evWtu6i8y1V99AvZCHStCJnZmAzGLKGSZmDAkOTfNm0tT156/Gxs5Qscwn9JaJRre
	 ACHpK1+5hb4MiEUH2FlvVUkHSoRjRcIRpmCXa/pFPmOMihJCQWy9CRV05I80nEgzjm
	 fp1NAWEPWfN6O8BALv//Qr7qSCCS7k/En9OQOyn0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 320CEF80229;
	Fri,  3 Jul 2020 10:38:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 384D3F8025F; Fri,  3 Jul 2020 10:38:57 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B9C5EF800ED
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2020 10:38:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9C5EF800ED
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1593765534036065102-webhooks-bot@alsa-project.org>
References: <1593765534036065102-webhooks-bot@alsa-project.org>
Subject: sof-hda-dsp UCM doesn't work with the latest alsa-lib
Message-Id: <20200703083857.384D3F8025F@alsa1.perex.cz>
Date: Fri,  3 Jul 2020 10:38:57 +0200 (CEST)
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

alsa-project/alsa-lib issue #67 was opened from libinyang:

In the latest UCM for sof-hda-dsp, it has supported Syntax 3 and it uses $var for hdmi. In sof-hda-dsp/Hdmi.conf, It defines "HdmiNum 1", and later it will redefine "HdmiNum 2", then "HdmiNum 3". It will try to `Include.hdmi1.File "/codecs/hda/hdmi.conf"` to use these definitions. But actually, only "HdmiNum 3" will be used for HDMI1, HDMI2 and HDMI3. The old value of "1" and "2" will be overridden when parsing HDMI1 and HDMI2. This is the bug of alsa-lib initialization sequence issue.

HDA-Intel/Hdmi.conf should have the same issue.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/67
Repository URL: https://github.com/alsa-project/alsa-lib
