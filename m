Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82DFC43334
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jun 2022 09:12:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6E5F1B46;
	Sun, 19 Jun 2022 11:11:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6E5F1B46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655629922;
	bh=FQsgfIjuKEcetV99ANoRil9FsjvrjOOtFSxiKL7rFFY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iLsjkupPIOQfeC8GfmIrxCClVphs7aDvJ4UT5D3Ajr3YA7cNz10LXvQwU9sDBmEHW
	 dz283jRe5CDXx/BJOLKAFK8/DOpELBMh6YLmlOOmF2cnPmOpuxYS2keXqEX+TDhiT3
	 NXIv9LUOhYxkenh/BHhRpbz3YliMZON/YMXkL1Wo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C0DCF80158;
	Sun, 19 Jun 2022 11:11:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 755BAF8020D; Sun, 19 Jun 2022 11:11:09 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 55891F800E4
 for <alsa-devel@alsa-project.org>; Sun, 19 Jun 2022 11:11:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55891F800E4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1655629862636706114-webhooks-bot@alsa-project.org>
References: <1655629862636706114-webhooks-bot@alsa-project.org>
Subject: Alsa-to-Jack bridge broken in alsa* 1.2.7.x
Message-Id: <20220619091109.755BAF8020D@alsa1.perex.cz>
Date: Sun, 19 Jun 2022 11:11:09 +0200 (CEST)
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

alsa-project/alsa-lib issue #243 was opened from hlekin:

I am using a setup according to https://alsa.opensrc.org/Jack_and_Loopback_device_as_Alsa-to-Jack_bridge

Since the upgrade of alsa-lib, alsa-ucm-conf, and alsa-utils to version 1.2.7, my alsa-to-jack-bridge setup is broken:
$ jack_connect system:capture_1 ploop:playback_1
ERROR ploop:playback_1 not a valid port
A downgrade to versions 1.2.6 resolves the issue. Versions 1.2.7.1 result in the same error.

The relevant output of qjackctl 0.9.7-2 > Messages is:
Cannot write socket fd = 25 err = Broken pipe
CheckRes error
Could not write notification
ClientNotify fails name = cloop notification = 0 val1 = 0 val2 = 0
NotifyAddClient old_client fails name = ploop
Cannot write socket fd = 28 err = Broken pipe
CheckRes error
Could not write notification
ClientNotify fails name = ploop notification = 1 val1 = 0 val2 = 0
ERROR ploop:playback_1 not a valid port
ERROR ploop:playback_2 not a valid port
ERROR cloop:capture_1 not a valid port
ERROR cloop:capture_2 not a valid port

Please find attached alsa-info.sh output for alsa-versions 1.2.7.1 and 1.2.6
[alsa-info.sh-output-220619.zip](https://github.com/alsa-project/alsa-lib/files/8935020/alsa-info.sh-output-220619.zip)
.
I am aware, that this is a very poor bug report. Please ask for any information you need!

By the way, many thanks for all your programs and the effort you put in to them.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/243
Repository URL: https://github.com/alsa-project/alsa-lib
