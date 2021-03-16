Return-Path: <SRS0=ENK7=IO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD005C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 14:32:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C836504A
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 14:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C836504A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6AD018B2;
	Tue, 16 Mar 2021 15:31:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6AD018B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615905165;
	bh=MYhWvx3whbeB2So2R56UKaTZLArI0MUMf1KD5UBnTw8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XOAlaiB5LOow4JijCUxgaFTnjfr64QjtJahmg02q0wbjgkl+WTIJi4l5r/IL85Omx
	 G//7J50kvYUj0mnUwLWu5yLGJbgVKA2KFlolxTCHdOovXlW+uyU6TOY7LoPXnhGKPZ
	 qCf0B0b3zjtMBIc7BaA69LEigsyTPerPBAMKJGzA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 072CDF80156;
	Tue, 16 Mar 2021 15:31:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C13F2F80163; Tue, 16 Mar 2021 15:31:51 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 41161F80137
 for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2021 15:31:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41161F80137
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1615905098045881987-webhooks-bot@alsa-project.org>
References: <1615905098045881987-webhooks-bot@alsa-project.org>
Subject: aaf plugin xrun:1711 error
Message-Id: <20210316143151.C13F2F80163@alsa1.perex.cz>
Date: Tue, 16 Mar 2021 15:31:51 +0100 (CET)
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

alsa-project/alsa-plugins issue #19 was opened from elabbing:

Hello, 
I set 2 host to use aaf plugin for TSN test. I followed TSN-doc guidelines and `aaf.txt` doc.
Simply, after hosts is ready and syncing though `ptp4l, phc3sys, qdisc,`
then I try to run a basic test, no switch between, back to back linked hosts,
obtaining the following error.

```
#Talker
sudo speaker-test -p 12500 -F S16_BE -c 2 -r 48000 -D aaf0

#Listener
sudo arecord -F 25000 -t raw -f S16_BE -c 2 -r 48000 -D aaf0 | \
>         aplay -F 25000 -t raw -f S16_BE -c 2 -r 48000 -D default
Playing raw data 'stdin' : Signed 16 bit Big Endian, Rate 48000 Hz, Stereo
Recording raw data 'stdin' : Signed 16 bit Big Endian, Rate 48000 Hz, Stereo
underrun!!! (at least 24,460 ms long)
arecord: xrun:1711: read/write error, state = RUNNING
```

This error happens after a random period, tipically less than 60sec.
I followed TSN doc settings, but I noticed that value in aaf plugin configuration and cbs qdisc are suggested differrently between aaf.txt doc and TSN doc.

Any prompt to get out of this? 
Many thanks

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/19
Repository URL: https://github.com/alsa-project/alsa-plugins
