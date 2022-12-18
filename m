Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B48C4332F
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Dec 2022 02:13:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B8FC1F4D;
	Sun, 18 Dec 2022 03:12:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B8FC1F4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671329627;
	bh=DL0OYoMO5DnIJEWYrHz83UeMVg2Lwb4Mv34HKxnokUY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oiy+ECjaotEyPccAFEsdUfSNCahepv8qEu0Hxq5/Lww7jfsLNvuO+IfupGT9kY6ti
	 fnR9ivJnza/4H6R+otqkHIotdWL5qXzTjOJ7sLXJYo55FrX/I/L1X6nrzAQjDBktlR
	 GrHBc++M2Ho6/U2IL7DFMBzwwxiug33mG44LAk0U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD36EF804D7;
	Sun, 18 Dec 2022 03:12:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D30C9F804ED; Sun, 18 Dec 2022 03:12:55 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E1FE5F804CB
 for <alsa-devel@alsa-project.org>; Sun, 18 Dec 2022 03:12:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1FE5F804CB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1671329564117594957-webhooks-bot@alsa-project.org>
References: <1671329564117594957-webhooks-bot@alsa-project.org>
Subject: Dell XPS 9320: Mic-Mute LED not working
Message-Id: <20221218021255.D30C9F804ED@alsa1.perex.cz>
Date: Sun, 18 Dec 2022 03:12:55 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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

alsa-project/alsa-ucm-conf issue #251 was opened from heftig:

The mic-mute LED on my XPS 9320 does not work. Reading `/sys/class/sound/ctl-led/mic/card0/list` outputs `52 18`.

Control `18` is the expected `rt714 FU02 Capture Switch` set in `ucm2/codecs/rt715-sdca/init.conf`. Control `52` is:

```
numid=52,iface=MIXER,name='PGA5.0 5 Master Capture Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
```

In this state, the LED does turn on when both switches are off, but muting via PipeWire only toggles control 18.

Detaching the LED from `52` (so that only `18` remains) makes it work properly.

I've tried finding out how `52` gets attached, but couldn't find anything. Is this done in-kernel?

Linux 6.1
ALSA 1.2.8
Arch Linux

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/251
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
