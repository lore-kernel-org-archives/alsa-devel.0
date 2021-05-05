Return-Path: <SRS0=SRJ/=KA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3928CC433B4
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 15:32:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C295F610E9
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 15:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C295F610E9
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A68F16BC;
	Wed,  5 May 2021 17:31:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A68F16BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620228745;
	bh=5aC4wYVDJudJLOHdVXacbyXvul1gIrrkT6xMXCQTt0c=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o6tSzrOABB2l52kAqFlvpALnyGRVb3xw3K0tYok/jmaKBzm9g2MmFCON4e48hSROw
	 ZhOfs6w3l2cVQ80cclHbna0NovczUxvmpBElO/2GgEfepSFKa1Pbt3e/t4rcz20mC9
	 tN15xye9kan+qv9T0DaoL3P0h8YyINzL6ij4OFiw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E0D3EF80268;
	Wed,  5 May 2021 17:31:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F09E9F8026A; Wed,  5 May 2021 17:31:33 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 203F0F80108
 for <alsa-devel@alsa-project.org>; Wed,  5 May 2021 17:31:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 203F0F80108
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1620228686927253962-webhooks-bot@alsa-project.org>
References: <1620228686927253962-webhooks-bot@alsa-project.org>
Subject: Setting volume of headphones seems to apply to Speakers as well
Message-Id: <20210505153133.F09E9F8026A@alsa1.perex.cz>
Date: Wed,  5 May 2021 17:31:33 +0200 (CEST)
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

alsa-project/alsa-utils issue #87 was edited from roboknight:

When using amixer in the following way:

amixer -c 1 set Headphone 0% mute

I receive the following partial output from scontents:

Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 87
  Mono:
  Front Left: Playback 0 [0%] [-65.25dB] [off]
  Front Right: Playback 0 [0%] [-65.25dB] [off]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 87
  Mono:
  Front Left: Playback 87 [100%] [0.00dB] [on]
  Front Right: Playback 87 [100%] [0.00dB] [on]

which looks good.  However, it appears that the volume is applied across both the Headphone control and Speaker control (or maybe even just the Master volume) as there is no output from the speakers after this even though it would appear they should have full volume and are not muted.

I am using the Ubuntu Groovy Gorilla update, so Linux kernel 5.11.  The default installation uses pulseaudio, but I've switched things to pipewire and both cause the same issue presumably because both use ALSA.  I started here because amixer seems to at least allow me to identify the problem.  When I change the Volume for the Headphones to 100% using the following:

amixer -c 1 set Headphone 100% mute

the audio from the speakers is then fine.  amixer appears to be showing the correct information (as per above) according to the audio, but the Headphone volume seems to be applying to the Speakers as well.  Maybe someone can point me in a direction that I can find a solution to this, as it would appear that anytime headphones are plugged in, removing the headphones causes the same situation: no sound.  I suspect amixer is working fine, but wherever the volume from amixer is applied, it does not appear to be set appropriately.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/87
Repository URL: https://github.com/alsa-project/alsa-utils
