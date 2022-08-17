Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DA4C32789
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Aug 2022 21:47:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3D2C164E;
	Wed, 17 Aug 2022 23:46:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3D2C164E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660772858;
	bh=IUjrZ/K2njnD2+46RYP+SHuLgXys0VdU41M8I4rlKfI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hAfZblF8W7x26NLpW3cDnbk2jO0L9QxuQpMEfdYxu9fw0WL+dncKPDv2mM2CYKvNO
	 Zw6b48r474Vslq5hQHM/liW5qm48kRUn57LbMhaA1w0FZbW53xe6Zx5Wa7qiBgMZuu
	 G96LCkvzzNsgc3mjsQ7T90WBiFWYwBuX76CYgRF0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7319AF80088;
	Wed, 17 Aug 2022 23:46:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29F14F80130; Wed, 17 Aug 2022 23:46:46 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 366B7F80088
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2022 23:46:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 366B7F80088
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1660772802439182997-webhooks-bot@alsa-project.org>
References: <1660772802439182997-webhooks-bot@alsa-project.org>
Subject: snd_hda_intel: Woke up but no data
Message-Id: <20220817214646.29F14F80130@alsa1.perex.cz>
Date: Wed, 17 Aug 2022 23:46:46 +0200 (CEST)
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

alsa-project/alsa-lib issue #262 was opened from shmohawk:

```
Aug 17 01:11:23 hellokitty pulseaudio[12938]: [alsa-sink-CX20590 Analog] alsa-sink.c: ALSA woke us up to write new data to the device, but there was actually nothing to write.
Aug 17 01:11:23 hellokitty pulseaudio[12938]: [alsa-sink-CX20590 Analog] alsa-sink.c: Most likely this is a bug in the ALSA driver 'snd_hda_intel'. Please report this issue to the ALSA developers.
Aug 17 01:11:23 hellokitty pulseaudio[12938]: [alsa-sink-CX20590 Analog] alsa-sink.c: We were woken up with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or another value < min_avail.
```

It is symptomous with a crackling sound for ~5 seconds after any playback starts.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/262
Repository URL: https://github.com/alsa-project/alsa-lib
