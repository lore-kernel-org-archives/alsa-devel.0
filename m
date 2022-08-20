Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEA1C25B08
	for <alsa-devel@archiver.kernel.org>; Sat, 20 Aug 2022 12:27:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 611B6167E;
	Sat, 20 Aug 2022 14:27:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 611B6167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660998473;
	bh=eMndh6idLL+dXVqDXEyc7RFaLe9K2rBz2Y4vPnd/sPA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kU3H4H4fPi0LOMsvpoUVp7ftQFqH/ajafiXYVb5ygTaCJguPj3qlGUpcBFgmQ/MAU
	 n146YFuh6FPCmg4R3uiXc5lKi33TgqlWvORJ4EOuq7HfIPdRuxeVwv8XRFjz/Kwdmx
	 mAUtvdxJu1U6z4QTJbGM0OgXVgneRfNEmb0IdTXI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E71CFF80162;
	Sat, 20 Aug 2022 14:27:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8DC6F800EE; Sat, 20 Aug 2022 14:27:00 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id BBB84F800EE
 for <alsa-devel@alsa-project.org>; Sat, 20 Aug 2022 14:26:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBB84F800EE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1660998413413997889-webhooks-bot@alsa-project.org>
References: <1660998413413997889-webhooks-bot@alsa-project.org>
Subject: Rockchip/rk3399-gru-sound: Use 48KHz sample rate for all devices
Message-Id: <20220820122700.E8DC6F800EE@alsa1.perex.cz>
Date: Sat, 20 Aug 2022 14:27:00 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #201 was opened from alpernebbi:

The rk3399-gru-kevin board has problems when trying to simultaneously playback and record audio with the default PulseAudio sample rate of 44.1KHz. When the following command is run, the playback starts a few seconds after the recording finishes.

    arecord -vvv -d 4 /dev/null & sleep 0.2; speaker-test -l 1 -p 100000 -t sine

When the sample rates are set to 48KHz either with PA configuration or in the UCM, playback and recording both start immediately. Another example is when a music player is running and we start `arecord`, the music starts stuttering but `arecord` can't record anything either.

Apparently, this is a hardware limitation due to the I2S lines being shared between the devices. Set all the device rates to 48KHz like Chrome OS does to make things work smoothly.

[1] https://chromium-review.googlesource.com/389695
[2] https://chromium-review.googlesource.com/898682

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/201
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/201.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
