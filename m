Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEF0F9EDC9
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:28:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89F9D60209;
	Wed, 22 Apr 2026 15:28:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89F9D60209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776864506;
	bh=mBad4N72hR4/FpMjMoJ713n5bXGb1FWx2e13RiEWFjk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=PGcHouo6zO4UZPQ6g0rRaV8aaUvI409tbLDin+kdtv0khyEjtioaa52aaCke1ouJB
	 qT1NhRdsmbGO1Dkyl+ps1zkkZcM/4t8u6q+Yuq80hWvAAHlfkhzmgyC/yozEQc3TfV
	 AAc6DwZzuB8pG7UHPHPkKIb1lXvhQslUAthCojgw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A525CF805F6; Wed, 22 Apr 2026 15:27:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B5E32F805EF;
	Wed, 22 Apr 2026 15:27:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C5F3F80526; Wed, 22 Apr 2026 15:27:42 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id BC458F800AE
	for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2026 15:27:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC458F800AE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a8b0cff79dd300-webhooks-bot@alsa-project.org>
In-Reply-To: <18a8b0cff77a9800-webhooks-bot@alsa-project.org>
References: <18a8b0cff77a9800-webhooks-bot@alsa-project.org>
Subject: Video playback from Instagram stalls on Firefox when selecting a USB
 DAC via pavucontrol
Date: Wed, 22 Apr 2026 15:27:42 +0200 (CEST)
Message-ID-Hash: LKGMSHKTPUCCGUYCQMIJWJ2WFHHI3AKQ
X-Message-ID-Hash: LKGMSHKTPUCCGUYCQMIJWJ2WFHHI3AKQ
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LKGMSHKTPUCCGUYCQMIJWJ2WFHHI3AKQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #503 was opened from RJVB:

This is a very weird one, and I'm not certain where the actual bug is but hope that the devs here might have an idea. The context is "retro-computing" though...

'm setting up a refurb G3 Elitebook (6th Gen i7 with HD520 GPU) with a retro install based on a self-updated "FrankUbuntu" 14.04LTS. 5.15.95 xanmod kernel, mesa v21.3.9, recent intel-media and intel-vaapi libraries, pulseaudio 17 and current alsa-libs. I'm hesitant to update libc so that has remained on 2.19 .
Video works and uses the HD driver from the intel-media package, but there is an issue with playback of Instagram videos. As soon as I select a USB DAC (e.g. via pavucontrol), playback halts but resumes as soon as switch back to the internal audio interface. Or to a USB audio->bluetooth dongle (= an audio interface that probably contains neither DAC nor amp but sends the incoming PCM data to a BT radio). The issue disappears when I boot an older (5.6) kernel but also when I boot a newer distro (Devuan "Chimaera") with the same kernel (but earlier Alsa and pulseaudio versions and a newer libc).

The only thing hinting at the possible error that I get appears in the syslog, from pulseaudio:
```
[ [alsa-sink-USB Audio] alsa-sink.c: Resume failed, couldn't restore original fragment settings. (Old: 576000/288000, New 529200/264600)]
```
That suggests something goes wrong in `pa_alsa_set_hw_params()` but could that explain the video halting too?

Fun fact: with alsa 1.2.15.2 the issue only affected IG "stories"; with 1.2.15.3 all videos are affected.

Video playback is fine on all other sites I tested (YT, Prime Video) and also in my standalone multimedia player (QMPlay2), all routed directly via PulseAudio or via ALSA's pulseaudio plugin.
Sadly there are no recent enough Chromium builds that I can test (other than via flatpak).

I'm aware that this could be a bug in PulseAudio or even Firefox, but given the intricate dependencies on hardware, kernel and possibly ALSA versions I thought I'd ask here first as I expect there'll be more devs who might be able to (guide me) put a finger on the underlying issue.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/503
Repository URL: https://github.com/alsa-project/alsa-lib
