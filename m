Return-Path: <SRS0=1fsy=7W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15089C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:39:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B917320737
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uEI2m+4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B917320737
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 470501675;
	Tue,  9 Jun 2020 23:38:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 470501675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591738782;
	bh=QDTNEtggN41xP+LmoLxU/wcpPGRHzho8UU/lOXt6YFw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uEI2m+4wU0TagdecBLWpjl2PP02LG0YHTco1yddYDVtveL4AIKmmVkKLtySWWUWQG
	 jvhE7B95ZButxOh95FtMOoRyUsT/fdoEuju34V/AiayriqkNrPvxwxeEtM31BunOfr
	 LFlX4gMDrnH5Z9Mu8NmgHAodH4ITR9Wxc6Xhj+i4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90BF6F80299;
	Tue,  9 Jun 2020 23:38:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8B5EF8029A; Tue,  9 Jun 2020 23:38:12 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9D5A5F80124
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2020 23:38:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D5A5F80124
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1591738690470786095-webhooks-bot@alsa-project.org>
References: <1591738690470786095-webhooks-bot@alsa-project.org>
Subject: ALSA journalctl error.
Message-Id: <20200609213812.E8B5EF8029A@alsa1.perex.cz>
Date: Tue,  9 Jun 2020 23:38:12 +0200 (CEST)
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

alsa-project/alsa-lib issue #57 was edited from danieloppenlander:

I ran across an error in my journalctl on Ubuntu 20.04. It said to report a bug. Here is my alsa-info.sh output: http://alsa-project.org/db/?f=6b505aa5138f2a974037ab5c3a89e1605807df97
Here is the journalctl message:

```
We were woken up with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or another value < min_avail. Jun 09 14:31:33 elrond pulseaudio[11933]: Most likely this is a bug in the ALSA driver 'snd_usb_audio'. Please report this issue to the ALSA developers. Jun 09 14:31:33 elrond pulseaudio[11933]: ALSA woke us up to write new data to the device, but there was actually nothing to write.
```

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/57
Repository URL: https://github.com/alsa-project/alsa-lib
