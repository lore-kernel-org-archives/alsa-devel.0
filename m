Return-Path: <SRS0=DopR=5S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB978C43331
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Apr 2020 16:53:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8C120737
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Apr 2020 16:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uYgmsDZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8C120737
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A50181666;
	Thu,  2 Apr 2020 18:52:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A50181666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585846425;
	bh=Osivhqm+9pPMVP7mmCZZa4RnR6WOe6TvSQW6dNCfCnA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uYgmsDZ9jV8JhDgl63p0X3lhrDGSzCBRsZGOvAiKr+uhdCg9HC9Ajpgg3PO23lH96
	 weqvUDSd06Qf+LV18obaONJnJvsb8ny0ruL5BbunKt4f0Ch6CwdJ187xyE5wxa1upP
	 qFOye3c+Uq9bkj4mTvOE1FBWFpA3W5P+9930szgQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15699F80146;
	Thu,  2 Apr 2020 18:52:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D778CF80148; Thu,  2 Apr 2020 18:52:51 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 4178CF80141
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2020 18:52:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4178CF80141
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1585846364757230997-webhooks-bot@alsa-project.org>
References: <1585846364757230997-webhooks-bot@alsa-project.org>
Subject: sof-hda-dsp: microphone device named "Headphones2"
Message-Id: <20200402165251.D778CF80148@alsa1.perex.cz>
Date: Thu,  2 Apr 2020 18:52:51 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #19 was opened from tanuk:

I was looking at the sof-hda-dsp UCM config, and I noticed that it defines a device named "Headphones2" which seems to actually represent a microphone.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/19
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
