Return-Path: <SRS0=+StP=ZM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55F8C432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:46:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC642088F
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FVpePAYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC642088F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C248616BB;
	Wed, 20 Nov 2019 17:45:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C248616BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574268397;
	bh=cvJ4P3SiB5R1Izlp44E44u3dOv1gnplu6TOQ/pEl1Mc=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FVpePAYuMD9TBOfiqmY0l+c6XgRln5UTQERyE1cmnw4LX86FAkuRxwPOlcneCqtqU
	 ZV7Eh3vimuQ8ZR11cZ1zRRmBISPrNJOUqscL26xAcDDlUpfth+4z6TM45Ktt/wg76S
	 ZCIXqQxGI3bAoqrn5LuZQbJwnSEFnEo7vvLBZ02c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DDD0F8013C;
	Wed, 20 Nov 2019 17:45:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16517F8013D; Wed, 20 Nov 2019 17:45:46 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id EF66FF800F0
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 17:45:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF66FF800F0
MIME-Version: 1.0
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1574268341798404932-webhooks-bot@alsa-project.org>
References: <1574268341798404932-webhooks-bot@alsa-project.org>
Message-Id: <20191120164546.16517F8013D@alsa1.perex.cz>
Date: Wed, 20 Nov 2019 17:45:46 +0100 (CET)
Subject: [alsa-devel] cp: upmix: code formatting and cleanup,
	generalize format
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

alsa-project/alsa-plugins pull request #2 was opened from bku-sue:

The main purpose of this change is to be able to change the format to e.g. S32 instead of S16 by changing only two lines on the top of the source. So a new symbol `UPMIX_PCM_FORMAT` is added to hide the actual format, and a special type `upmix_sample_t` marks the sample type, instead of fixed `short`.

I fixed the `average_copy` function as well, which was actually expecting the `nchns` parameter to be 2, otherwise its local arrays would be overindexed.

The rest is just better naming for `i` as it denotes the channel index in every case, and applying consistent whitespace.

The behavior of the plugin remains identical though.

Request URL   : https://github.com/alsa-project/alsa-plugins/pull/2
Patch URL     : https://github.com/alsa-project/alsa-plugins/pull/2.patch
Repository URL: https://github.com/alsa-project/alsa-plugins
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
