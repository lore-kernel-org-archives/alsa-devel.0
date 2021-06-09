Return-Path: <SRS0=8Lk6=LD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2CCC48BCF
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Jun 2021 14:01:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E03613AD
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Jun 2021 14:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E03613AD
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B612116BD;
	Wed,  9 Jun 2021 16:00:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B612116BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623247262;
	bh=Ixw3e4PTjyYf7RBfGd45vjE3u02Bo05TKOjfbZZf9Rs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XiiLWOgSfa7E15H9aIjNakaKRksnqOr3EcDhH0ex4XbgBrzW5iTeEfEkHs0GeFaUW
	 79rFdB12WMy3jRuflG0zIWxzMX2LFvnUVqHerhnvFBsJB/jxYCwfgwxSosEGYvz+Lc
	 FZKi7wFplzZb/3KhtrWonKZp0BNg519P+zYrRYJU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B246F80212;
	Wed,  9 Jun 2021 16:00:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4E0BF8026C; Wed,  9 Jun 2021 16:00:10 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 6278AF800F4
 for <alsa-devel@alsa-project.org>; Wed,  9 Jun 2021 16:00:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6278AF800F4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623247200455168009-webhooks-bot@alsa-project.org>
References: <1623247200455168009-webhooks-bot@alsa-project.org>
Subject: opensuse tumbleweed no sound after alsa lib update (tumbleweed
 2010605)
Message-Id: <20210609140010.B4E0BF8026C@alsa1.perex.cz>
Date: Wed,  9 Jun 2021 16:00:10 +0200 (CEST)
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

alsa-project/alsa-lib issue #149 was opened from pawanyadav:

sound is not working alsa (never installed pipewire and pulseaudio)

asound.conf
defaults.pcm.card 1
defaults.pcm.device 1



aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: HDMI [HDA ATI HDMI], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Generic [HD-Audio Generic], device 0: ALC887-VD Analog [ALC887-VD Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Generic [HD-Audio Generic], device 1: ALC887-VD Digital [ALC887-VD Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

cat /proc/asound/cards
 0 [HDMI           ]: HDA-Intel - HDA ATI HDMI
                      HDA ATI HDMI at 0xfcf40000 irq 67
 1 [Generic        ]: HDA-Intel - HD-Audio Generic
                      HD-Audio Generic at 0xfce00000 irq 69



speaker-test 1.2.4

Playback device is default
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
ALSA lib confmisc.c:855:(parse_card) cannot find card '1dmix:1'
ALSA lib conf.c:5091:(_snd_config_evaluate) function snd_func_card_id returned error: No such device
ALSA lib confmisc.c:422:(snd_func_concat) error evaluating strings
ALSA lib conf.c:5091:(_snd_config_evaluate) function snd_func_concat returned error: No such device
ALSA lib confmisc.c:1334:(snd_func_refer) error evaluating name
ALSA lib conf.c:5091:(_snd_config_evaluate) function snd_func_refer returned error: No such device
ALSA lib conf.c:5579:(snd_config_expand) Evaluate error: No such device
ALSA lib pcm.c:2660:(snd_pcm_open_noupdate) Unknown PCM dmix:1dmix:1
Playback open error: -19,No such device

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/149
Repository URL: https://github.com/alsa-project/alsa-lib
