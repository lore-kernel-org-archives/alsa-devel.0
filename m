Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3EBC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jul 2022 21:59:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41AF51868;
	Thu, 14 Jul 2022 23:58:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41AF51868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657835983;
	bh=jSheNs3Mi1DhhVPEtuULv9B1Wy2ZeF1A69PIdyIqx10=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YaPomeqBTDTJJxZKy36Mlw+fdlp3J//WNlO4NLRJVp4FzmaxUxpBWDEACjLENFiSa
	 yp+9hwzuH7kMOYYQHFTmvGJbfREYGJ15eFqjDSeGXVkF+XfkrYDwA9Id0BGQMRK2eQ
	 mfiifd3dzvNA901VFilEIeL1Qotz5KavywCkbgmk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5259F8014E;
	Thu, 14 Jul 2022 23:58:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3E14BF800AA; Thu, 14 Jul 2022 23:58:51 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B984AF800AA
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2022 23:58:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B984AF800AA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1657835927749377012-webhooks-bot@alsa-project.org>
References: <1657835927749377012-webhooks-bot@alsa-project.org>
Subject: No Audio: MAG Z690 TOMAHAWK WIFI DDR4 & how to build info request
Message-Id: <20220714215851.3E14BF800AA@alsa1.perex.cz>
Date: Thu, 14 Jul 2022 23:58:51 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #189 was opened from Dave--G:

My MAG Z690 TOMAHAWK WIFI DDR4 motherboard has no alsa audio support.

It looks like the realtek-alc4080 audio chip is supported, just not on this motherboard due to a missing entry in `USB-Audio.conf`.
The USB audio device id is `0db0:b202`.
Currently it just displays as `USB Audio` and doesn't function at all.
This device works under windows so the hardware is functioning but no linux distro I've tried.

I attempted to address this myself, by downloading `https://github.com/alsa-project/alsa-ucm-conf/releases/tag/v1.2.7.2`, copying it to `/usr/share/alsa` (preserving simlinks of course) and editing `ucm2/USB-Audio/USB-Audio.conf`, changing line 46 to read `		Regex "USB((0b05:(1996|1a2[07]))|(0db0:(1feb|419c|a073|b202)))"`.
However, when I execute `sudo alsa force-reload` it generates parsing errors and `pactl list sinks` does not show any changes to the device properties as expected.

Can someone please explain what I need to do to get this device working?  Am I on the right track?  Do I need to rebuild alsa from github?  It's not clear and I'm not seeing build instructions.  I've been struggling with this for quite some time so any help would be appreciated.

I will PR the fix back to this repo once its working.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/189
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
