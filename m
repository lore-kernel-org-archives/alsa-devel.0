Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210FCCC6B1A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:31:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAB92601DF;
	Wed, 14 Oct 2026 18:30:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAB92601DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791995466;
	bh=XgV2yCnOsdrT+9UMW1Hsv7mRDss7nR3ioyStBSiEA7c=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=GcSQnYx1QoWA6CDZhzXKsM4EmnXv8Z98MhaRjpX6UrZdNe2WjtDSw3j3/LKktLMA5
	 yqPMpeKx3KXX65ViYfd4LfHGNHgIw7wMBSa/KmdEec4RRbz9dNmGrZZQTj9Kkm8CPE
	 YBUaGUh+/PXgoOlNrXRG9ynDPuf+8RzqH9SwvuY8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D6B6BF805FE; Wed, 14 Oct 2026 18:30:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6ECFAF805F6;
	Wed, 14 Oct 2026 18:30:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 17360F80448; Wed, 14 Oct 2026 18:30:27 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791995426;
	b=QSoB5JGNONsdV5J3PvSAWRL2jK5BZ97wmtYaikHcTaE1fQkaIaKe6tYBrN2OawUtGOst
	 gQdE7zek+muhkgzCLgVwrKyvAWhcPdscraImvMYAcvJTNMUkxR94sk089PcFuLAwy0q05
	 A5GVaBZf6QWL0LANoIWz+RMWxULWtPo+m6FBX9lk3FYKwnNsJ1p/n0MyaOjHKe7fQVy95
	 M5xTsC6jgD2xM38dS0rgfysFE0Ii6dKwbPeI6K/jKys7e0HulmPvJ+yC450X6GqTFROxD
	 +4Ikboi8zp4FZzPTJeuE7EsFEG9LXCJ/rDsg/bn2izZLpB+lB5bbzMfnXLQNJ54SsDA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791995426;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=XgV2yCnOsdrT+9UMW1Hsv7mRDss7nR3ioyStBSiEA7c=;
	b=e8DqCOMhdgJm9nhE53V5JuZ43NSZmBd1GWYw2lSVGHDfwHKWxc6mV4I02m7nCDuAkOnU
	 BOLAuqmPnpdAdxKCe5dnzX/+rft9q1469q2TghP/NeAkxKN+8wlT/4MMk01G0/kpFRqWD
	 B5ahcTZAQqPufNEmkNY95zJJiR3mS1QgbwWms3Luzb9HDNCmg1sVjGFb/XP/i6uiACvVp
	 oaAVmku0OC98FEOKc8vH5GTuRkA07U8z1iSeTFUC44KU8ehESQCcYSJwN1Yw5hrrt2Rkw
	 TxptF3CKacVA3VD06oXbr+IzjRmgYyGvm7ixhgDmGsowKYi1vlK0saA3UsEMs/vEFhg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 583A5F80038
	for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2026 18:30:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 583A5F80038
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18de7258316f0600-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/880@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/880@alsa-project.org>
Subject: ucm2: Qualcomm: Thinkpad T14s speaker mute LED support
Date: Wed, 14 Oct 2026 18:30:27 +0200 (CEST)
Message-ID-Hash: 53EYVJR46TQXF2WOACWD7ZIY4LI4JDYQ
X-Message-ID-Hash: 53EYVJR46TQXF2WOACWD7ZIY4LI4JDYQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/53EYVJR46TQXF2WOACWD7ZIY4LI4JDYQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #880 was opened from sre:

The T14s Gen6 Snapdragon has an LED in the mute button to signal that the speaker is muted. The kernel driver for the embedded controller exposes it as `/sys/class/leds/platform::mute` with trigger set to `audio-mute`. At the same time the hardware toggles the LED state when the mute key is pressed (independent of the real audio state) giving a fake suggestion of things working correctly.

This series properly attaches the speaker mute state to this LED. To be functional, it depends on a kernel driver change for the speaker amplifier exposing a mute control knob. All handling has been implemented in a way, that using a kernel without this feature will continue to work as before.

I will update the PR description with a link to the kernel patch, once it has been send out.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/880
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/880.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
