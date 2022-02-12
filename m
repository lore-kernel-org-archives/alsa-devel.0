Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AC9C433F5
	for <alsa-devel@archiver.kernel.org>; Sat, 12 Feb 2022 17:22:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73323210;
	Sat, 12 Feb 2022 18:21:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73323210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644686545;
	bh=oWVo1UeE70tvgiVQ1y7GXCGncbJnvHrS6E1tUN/um5w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R0kqj+BgD8dji9xP4VUGAyewCe3CqPzUUNgqpeS3YFWfp2nZ1Ny1wZzLquyjYZ4o2
	 GtpFb9aV5R4hd1Lm1eAXpMyAhIu4Gw/P11VlTTGjGJtdRZvgCKvZdhO2PF8vE+y2fS
	 arBE+/0Wf2a9sdVRgLYMLHzD2Wt7+UwhcdMoQumU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1017EF80130;
	Sat, 12 Feb 2022 18:21:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9B9AF8014E; Sat, 12 Feb 2022 18:21:30 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1D15EF800B0
 for <alsa-devel@alsa-project.org>; Sat, 12 Feb 2022 18:21:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D15EF800B0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1644686486345132113-webhooks-bot@alsa-project.org>
References: <1644686486345132113-webhooks-bot@alsa-project.org>
Subject: Conflictuous devices name
Message-Id: <20220212172130.B9B9AF8014E@alsa1.perex.cz>
Date: Sat, 12 Feb 2022 18:21:30 +0100 (CET)
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

alsa-project/alsa-lib issue #212 was opened from nm2107:

Hello,

I'm using [mixxx](https://github.com/mixxxdj/mixxx) (which uses [portmidi](https://github.com/PortMidi/portmidi), which uses ALSA) with a pair of Denon SC3900 decks connected via USB MIDI.

However, I'm running into an issue where I cannot distinguish both SC3900 units anymore, as they are reported by alsa with the same name : 

```bash
$ amidi -l
Dir Device    Name
IO  hw:2,0,0  SC3900 MIDI 1
IO  hw:3,0,0  SC3900 MIDI 1
```
(they were previously differentiated by `SC3900 MIDI 1` and `SC3900 MIDI 2` names).

PortMIDI (and so mixxx) are relying on the device name to identify them, so I'm not able to distinguish the two plugged in units (only one device is listed in mixxx, as the name is common).

I'm using alsa-libs 1.2.6.1. I tried to downgrade to version 1.2.5.1, but is hasn't solved my issue. Along with this downgrade, I also tried to downgrade my linux kernel to v5.13 (I was on v5.16), but it hasn't shown any improvement.


Do you have an idea of what may cause this naming conflict ?

Thank you :)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/212
Repository URL: https://github.com/alsa-project/alsa-lib
