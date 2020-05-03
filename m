Return-Path: <SRS0=UCdw=6R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73563C28CBC
	for <alsa-devel@archiver.kernel.org>; Sun,  3 May 2020 07:39:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E6B207DD
	for <alsa-devel@archiver.kernel.org>; Sun,  3 May 2020 07:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VzrQl2om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E6B207DD
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F71416BB;
	Sun,  3 May 2020 09:38:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F71416BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588491567;
	bh=6s5A76BTLuqbVeAubUYmvvxJI1NF4P2flFoLKvafZE8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VzrQl2omjlLjwNKxV1Gz25OnLttnFdfWnZ1G5EvDmmQmOgyWC3bbWirwKGnBqs3Jx
	 c5/WFnMFB2HYwC/WoGvAfnzEsseb0iaJ96iR9sUImlkWx1ztdo1MOp3KKDJ5OB9jpF
	 MXDGnKstaQJuGatdu0qt4IxIOlNXD24w5Ba//AMs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D30FDF8015B;
	Sun,  3 May 2020 09:38:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0259DF8015F; Sun,  3 May 2020 09:38:30 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id F2C29F800EE
 for <alsa-devel@alsa-project.org>; Sun,  3 May 2020 09:38:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2C29F800EE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1588491501909075022-webhooks-bot@alsa-project.org>
References: <1588491501909075022-webhooks-bot@alsa-project.org>
Subject: helem (MIXER, 'Master Playback Volume', 0, 1,
 0) appears twice or more cannot load mixer controls: Invalid argument
Message-Id: <20200503073830.0259DF8015F@alsa1.perex.cz>
Date: Sun,  3 May 2020 09:38:30 +0200 (CEST)
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

alsa-project/alsa-lib issue #47 was opened from igrekster:

I have a PCIE Asus Sound Card  (Asus Xonar AE) that uses USB interface:
```
Bus 003 Device 002: ID 0b05:180f ASUSTek Computer, Inc.
```
It's been working fine on earlier versions of  kernel/alsa-lib but at some point the volume control stopped working (the playback still works fine):

```
$ alsamixer -c 1
ALSA lib /var/tmp/portage/media-libs/alsa-lib-1.2.2-r1/work/alsa-lib-1.2.2/src/mixer/simple_none.c:1544:(simple_add1) helem (MIXER,'Master Playback Volume',0,1,0) appears twice or more
cannot load mixer controls: Invalid argument
```
This is on kernel 5.4.37/alsa 1.2.2. Unfortunately I cannot downgrade to the point when it was working to pinpoint the issue. I tried kernels 5.3.11 and alsa 1.1.8.
I've tried building the latest alsa-lib, and it is still showing the error.
I'm happy to try patches to alsa or kernel modules to help debug this.

A few more details:

[alsa-info.txt](https://github.com/alsa-project/alsa-lib/files/4569764/alsa-info.txt)
[proc-asound.txt](https://github.com/alsa-project/alsa-lib/files/4569766/proc-asound.txt)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/47
Repository URL: https://github.com/alsa-project/alsa-lib
