Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B2AC352A3
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 05:56:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F2D20708
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 05:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VXuRDP/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F2D20708
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 56FED165D;
	Tue, 11 Feb 2020 06:55:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 56FED165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581400608;
	bh=SQHiSxAYy1klSA1wy2OR2loyTmC6XOmKMUgNebIjxIA=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VXuRDP/U798oHFN1dhVoL+EjPBS3KYyBuj7CUhv6mxCTRHNbqaI5b9L1QHiWriMtD
	 uvmSxe44Zz+EybFeWEgp7Zzhn9YrNv/Hqbjv2OaXh/iOWM6zZ+uE+BDt/0ABzC+GyR
	 9RTgtdewSCLZbWb5zEoNBzWZBn2ZF0B416QAjtGE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B97CBF8013E;
	Tue, 11 Feb 2020 06:55:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA652F80145; Tue, 11 Feb 2020 06:55:54 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id AE7A6F8013D
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 06:55:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE7A6F8013D
MIME-Version: 1.0
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1581400550813920975-webhooks-bot@alsa-project.org>
References: <1581400550813920975-webhooks-bot@alsa-project.org>
Message-Id: <20200211055554.EA652F80145@alsa1.perex.cz>
Date: Tue, 11 Feb 2020 06:55:54 +0100 (CET)
Subject: [alsa-devel] alsa-gobject: GSource optimization
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

alsa-project/alsa-gobject pull request #8 was opened from takaswie:

As long as using the created Gsource with GMainContext, the call of poll(2)
system call with infinite timeout surely returns when quit() method is
called for the context. All of GMainContext implements GWakeup with eventfd
and the call of quit() emits event via the file descriptor of eventfd. This
brings wakeup from blocking when poll(2) is called with inifinite timeout.

In current implementation of alsactl/alsatimer, open(2) is called with O_NONBLOCK
and GSource includes explicit timeout to avoid the infinite blocking. However,
they are not necessarily required for GMainContext.

This patchset obsoletes these points and adds options as the alternatives.

Request URL   : https://github.com/alsa-project/alsa-gobject/pull/8
Patch URL     : https://github.com/alsa-project/alsa-gobject/pull/8.patch
Repository URL: https://github.com/alsa-project/alsa-gobject
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
