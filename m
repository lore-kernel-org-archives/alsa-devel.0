Return-Path: <SRS0=xZai=75=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1135EC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:00:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3AE208B3
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 18:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cNurdAep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3AE208B3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BA381614;
	Tue, 16 Jun 2020 19:59:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BA381614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592330405;
	bh=xLW/ZPe8/KSEyrZEORA3/XLVhEA73ZUXcukUnWuwTc0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cNurdAepckmCQGuCC+HtwO5LzUkZ3UBYitTqWxS9T7QHeZyQ/Ocs5B/WmCDb/8x73
	 WHgw2L6NA0CAYTdntc8UqcOLCAcUpbxE/3T+zZbxLwUdeD/ruUc5uH/G/X2039RFD5
	 5LEkloXzGRctFBpnUs+1R+gJWgdK6Sjagf5sDS+I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A21BEF800EF;
	Tue, 16 Jun 2020 19:59:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD7ECF8022B; Tue, 16 Jun 2020 19:59:13 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id BF0BFF800EF
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 19:59:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF0BFF800EF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1592330346106980085-webhooks-bot@alsa-project.org>
References: <1592330346106980085-webhooks-bot@alsa-project.org>
Subject: pcm: dmic: assembly: add x32 support.
Message-Id: <20200616175913.DD7ECF8022B@alsa1.perex.cz>
Date: Tue, 16 Jun 2020 19:59:13 +0200 (CEST)
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

alsa-project/alsa-lib pull request #61 was opened from hvdijk:

x32 is the x86_64 ABI that uses 32-bit pointers, so requires loading addresses into edi/esi/ebx rather than rdi/rsi/rbx.

Note that instructions such as movl %eax, (%rdi) do not require updating, as loading an address into %edi zeroes the high bits, causing the full %rdi register to hold a valid address.

Signed-off-by: Harald van Dijk <harald@gigawatt.nl>

Without this, even aplay segfaults when building with `-mx32`.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/61
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/61.patch
Repository URL: https://github.com/alsa-project/alsa-lib
