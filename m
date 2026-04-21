Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBD9F8FA98
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2026 15:54:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBBE6601D5;
	Tue, 21 Apr 2026 17:54:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBBE6601D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776786895;
	bh=Ai7G6g4LR8jk/dPJo46dKgJddURyP3UpZyFePTkOXh8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=jSBAsISyd29DRpUPq8WjA84piwGoTW4gfemFEr5m23ChcwsGt4EERY5WHgdC8CyVm
	 NT252p7SS0lxKPwxhaFDfzjt94auob6fpk6SpPe/Af2iyAwenfYuvWjaVzYWLIFi2Z
	 W/+/t0NYYN3vzEUefJqCfHQGDk9uQ7pf9UKfIl0A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B8506F805EA; Tue, 21 Apr 2026 17:54:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 84AB6F805EA;
	Tue, 21 Apr 2026 17:54:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D6030F8055A; Tue, 21 Apr 2026 17:54:14 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 786CEF800E4
	for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2026 17:54:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 786CEF800E4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a86a3a61006300-webhooks-bot@alsa-project.org>
In-Reply-To: <18a86a3a60f5d700-webhooks-bot@alsa-project.org>
References: <18a86a3a60f5d700-webhooks-bot@alsa-project.org>
Subject: Lenovo T14s G7 AMD MIC Mute LED Issue
Date: Tue, 21 Apr 2026 17:54:14 +0200 (CEST)
Message-ID-Hash: HRMY5RDZWUJQ2GBOPNFGCSMZNEBMNOOW
X-Message-ID-Hash: HRMY5RDZWUJQ2GBOPNFGCSMZNEBMNOOW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HRMY5RDZWUJQ2GBOPNFGCSMZNEBMNOOW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #752 was opened from saba-kareem:

After fixing this issue(https://github.com/alsa-project/alsa-ucm-conf/issues/726) mic mute state is getting reflected, but LED status is not being reflected based on mic mute status.

We are able to manually toggle the mic mute LED status by following commands 

echo 1 | sudo tee /sys/class/leds/platform::micmute/brightness
 - Mic Mute LED turns on

echo 0 | sudo tee /sys/class/leds/platform::micmute/brightness
- Mic Mute LED turns off

It seems mic mute LED trigger event is not functional as expected.

For the legacy stack(No DSP enabled) Soundwire + PDM IO combination, since the ACP PDM Mic Mute control is linked with the HDA UCM, As per our understanding LED event trigger needs to be checked from HDA UCM perspective. 

@perexg could you please share your inputs.
@mrhpearson please add if we miss any relevant information.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/752
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
