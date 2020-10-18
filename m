Return-Path: <SRS0=oKMh=DZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6790C433E7
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:46:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA97722277
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aPOEopG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA97722277
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38FAD17B0;
	Sun, 18 Oct 2020 22:45:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38FAD17B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603053977;
	bh=fhQP3oxzlc8cxsStVmVBMp283jcmxG/9GiToOB0j2OQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aPOEopG5Wqmb97ubZgBMu02KfPd6oUZVmMWBAWGCS3iyxDydd78swzFuNsllX9YK5
	 sgEF9wFV5inyK5YDUzchN1bq/cqgnMsHourAa3RXaCeGmnK/UBtF7NFUU9fOeHYew8
	 yaHlUELXTwf87WswZ648iWs6h/Hondg1Gsk6dp+0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98D13F8014D;
	Sun, 18 Oct 2020 22:45:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B242F801F2; Sun, 18 Oct 2020 22:45:24 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id DD67AF80111
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2020 22:45:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD67AF80111
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1603053920555689096-webhooks-bot@alsa-project.org>
References: <1603053920555689096-webhooks-bot@alsa-project.org>
Subject: 1.2.4: symlinks in /lib/firmware/turtlebeach pointing to nowhere
Message-Id: <20201018204524.6B242F801F2@alsa1.perex.cz>
Date: Sun, 18 Oct 2020 22:45:24 +0200 (CEST)
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

alsa-project/alsa-firmware issue #2 was opened from kloczek:

```
drwxr-xr-x    2 root     root                        0 Oct 18 21:38 /lib/firmware/turtlebeach
lrwxrwxrwx    1 root     root                       23 Oct 18 21:38 /lib/firmware/turtlebeach/msndinit.bin -> /etc/sound/msndinit.bin
lrwxrwxrwx    1 root     root                       23 Oct 18 21:38 /lib/firmware/turtlebeach/msndperm.bin -> /etc/sound/msndperm.bin
lrwxrwxrwx    1 root     root                       23 Oct 18 21:38 /lib/firmware/turtlebeach/pndsperm.bin -> /etc/sound/pndsperm.bin
lrwxrwxrwx    1 root     root                       23 Oct 18 21:38 /lib/firmware/turtlebeach/pndspini.bin -> /etc/sound/pndspini.bin
```
Looks like thoose symlinks are pointing to nowhere.

Issue URL     : https://github.com/alsa-project/alsa-firmware/issues/2
Repository URL: https://github.com/alsa-project/alsa-firmware
