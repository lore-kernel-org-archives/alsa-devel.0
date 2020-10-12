Return-Path: <SRS0=KIty=DT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A22C433E7
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 08:38:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A54F2074F
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2020 08:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="P7pKXaWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A54F2074F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D595B1673;
	Mon, 12 Oct 2020 10:37:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D595B1673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602491915;
	bh=pisuaYDy/Gn02amLmf7Xbb3GoeCg2iX6ywsGSmVO8hQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P7pKXaWbMVOA4ZRBT8b6QkV1pnChf/Jw5SdH80FS/QZr8XM0dcimhZl/wsyJcPmP6
	 qOnPcjM3KQA5TvpDPhRG1RFsuCHrY2eKmHRUl3QRRMVKjOpWlPzH2ZMgYi7oLAWB2H
	 vWL681kQnac2b/qXiFc0rdwhvoILyo6bC5vVaId0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55A95F8020D;
	Mon, 12 Oct 2020 10:37:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66F7EF80217; Mon, 12 Oct 2020 10:37:44 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id D50EEF800D8
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2020 10:37:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D50EEF800D8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1602491860368252039-webhooks-bot@alsa-project.org>
References: <1602491860368252039-webhooks-bot@alsa-project.org>
Subject: Can't aplay/arecord simultaneously inside and outside of linux
 container
Message-Id: <20201012083744.66F7EF80217@alsa1.perex.cz>
Date: Mon, 12 Oct 2020 10:37:44 +0200 (CEST)
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

alsa-project/alsa-utils issue #62 was opened from fearless-fan:

Hi,
I run into a problem that can't aplay/arecord simultaneously inside and outside of linux container. 

Steps to reproduce:
1. go into container's shell and exec a record command. 

~ # lxc-attach -n Default -P /tmp/run/lxc
/ # arecord -d 60 /tmp/test.wav &
/ # Recording WAVE '/tmp/test.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
/ # ps
PID   USER     TIME   COMMAND
      1 root       0:00 /sbin/init
      3 root       0:00 /bin/sh
1519 root       0:00 arecord -d 60 /tmp/test.wav
1520 root       0:00 /bin/ash
1521 root       0:00 ps

2. exit and exec another record command outside of container

/ # exit
~ # arecord -d 60 /tmp/test.wav &
~ # ALSA lib pcm_dsnoop.c:641:(snd_pcm_dsnoop_open) unable to open slave
arecord: main:830: audio open error: Device or resource busy

[1]+  Done(1)                    arecord -d 60 /tmp/test.wav

3. playback has same problem as below

ALSA lib pcm_dmix.c:1089:(snd_pcm_dmix_open) unable to open slave
aplay: main:830: audio open error: Device or resource busy

Expect:
It should be allowed to play/record simultaneously inside and outside of linux container.

Here's my asound.conf:

~ # cat etc/asound.conf
pcm.asymed {
    type asym
    playback.pcm "dmix:0,0"
    capture.pcm "dsnoop:0,0"
}

pcm.!default {
    type plug
    slave.pcm "asymed"
}

ctl.!default {
        type hw
        card 0
}

Is there anyone has experience of how to address it? Thank you.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/62
Repository URL: https://github.com/alsa-project/alsa-utils
