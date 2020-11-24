Return-Path: <SRS0=dVJd=E6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CC2C2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 19:19:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC50206B5
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 19:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TnbDRpiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC50206B5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F6061750;
	Tue, 24 Nov 2020 20:18:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F6061750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606245574;
	bh=jJK2cBFkktXid99i8a+DL7xqR0lATWWtJhM/8XAMfRQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TnbDRpiYYJ/0qaXOyIVd7JDWWBrN6OyZqNxiWppX345gWPJxJwqoVu/el6cWr7LjL
	 ciNTegaVxHrOEyJqy3R9pOG6tU/Lkt4YpbZQqnSz0XePVt2d625QyzQfhuPYWqDADq
	 sFqKgppWuTKvd8ZgG8I8TEzQl+ovAzVHObF8BwK0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21426F800C1;
	Tue, 24 Nov 2020 20:18:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6BC6CF80165; Tue, 24 Nov 2020 20:18:42 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E9CA3F800C1
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2020 20:18:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9CA3F800C1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1606245517270976067-webhooks-bot@alsa-project.org>
References: <1606245517270976067-webhooks-bot@alsa-project.org>
Subject: SB Omni Surround 5.1
Message-Id: <20201124191842.6BC6CF80165@alsa1.perex.cz>
Date: Tue, 24 Nov 2020 20:18:42 +0100 (CET)
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

alsa-project/alsa-lib issue #101 was opened from witoldo7:

Hi,
SB Omni Surround 5.1 use default hw 1 for iec958.0 please update USB-Audio.conf, 0 is used for dac(jack connectors)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/101
Repository URL: https://github.com/alsa-project/alsa-lib
