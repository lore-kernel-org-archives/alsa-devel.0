Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059CDC433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Oct 2022 14:28:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 472752C1F;
	Mon, 10 Oct 2022 16:27:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 472752C1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665412125;
	bh=srOZEpKNfBkpV64Mv/cC2+4PpGaURlkJNyh/54BSsZs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HG+AHATx3IDZoHCOb1VXALrOfqHgi+ywPh5uJHaSvKnNDwN3qzaHn0ktWfQlAW8Jl
	 Mk8NIgeUU4JB5j5R7o7UbOBs37qJ6bjEQiULMROhRA+gW0xg0rNmHmFeFAHP+gU04H
	 AO+UGt1vjaoM0F+fgEyFrDuHPfJnnD3bj9//d4v8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E0830F80155;
	Mon, 10 Oct 2022 16:27:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 650F3F80256; Mon, 10 Oct 2022 16:27:53 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 2A6C6F80155
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2022 16:27:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A6C6F80155
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1665412066717397928-webhooks-bot@alsa-project.org>
References: <1665412066717397928-webhooks-bot@alsa-project.org>
Subject: unable to install alsa-utils with newest pulseaudio
Message-Id: <20221010142753.650F3F80256@alsa1.perex.cz>
Date: Mon, 10 Oct 2022 16:27:53 +0200 (CEST)
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

alsa-project/alsa-utils issue #173 was opened from voncloft:

I installed and upgraded pulse audio to version 16.1

I keep receiving the following error when trying to upgrade alsa-utils (the latest version):

`/bin/sh ../libtool  --tag=CC   --mode=link gcc -Wall -g   -D_REENTRANT  -D_GNU_SOURCE -g -O2 -module -avoid-version -export-dynamic -no-undefined -Wl,-z,defs  -o libasound_module_conf_pulse.la -rpath /usr/lib/alsa-lib conf_pulse.lo -lasound   -lpulse -pthread  -lasound
/bin/grep: /usr/lib/pulseaudio/libpulsecommon-13.0.la: No such file or directory
/bin/sed: can't read /usr/lib/pulseaudio/libpulsecommon-13.0.la: No such file or directory
libtool:   error: '/usr/lib/pulseaudio/libpulsecommon-13.0.la' is not a valid libtool archive
make[2]: *** [Makefile:535: libasound_module_conf_pulse.la] Error 1
make[2]: Leaving directory '/sources/alsa-plugins/pulse'
make[1]: *** [Makefile:444: all-recursive] Error 1
make[1]: Leaving directory '/sources/alsa-plugins'
make: *** [Makefile:376: all] Error 2`

What exactly is going on here?

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/173
Repository URL: https://github.com/alsa-project/alsa-utils
