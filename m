Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF26CD4F54
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2026 16:57:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA1596025B;
	Wed, 27 May 2026 18:57:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA1596025B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779901064;
	bh=o9wBqFIjM5kMTOilq2AinPaZKsFLROvfg9gcaaUQKp0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Qt+hUGYyrYT2FsxZbG3Gzl84+X/uNvQ5c2ekOgrYJFQmm0UpF+2NEZ6bcOqDFEil3
	 jp+X656iFFO4pP90iIgOHgTzM/PHJFdkwAWYgmIPArkMjqkl6I2JbgytazudQTWVNK
	 589sCMCsVW8ctueDwRIUGHLu8vk5cDrlAT4g5nU4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 19961F805F5; Wed, 27 May 2026 18:57:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D578FF805F3;
	Wed, 27 May 2026 18:57:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5E6EAF804FF; Wed, 27 May 2026 18:57:03 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 266DDF80246
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2026 18:56:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 266DDF80246
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b37a8b96d9a700-webhooks-bot@alsa-project.org>
In-Reply-To: <18b37a8b96cddb00-webhooks-bot@alsa-project.org>
References: <18b37a8b96cddb00-webhooks-bot@alsa-project.org>
Subject: Speaker LED Stopped Working After Upgrade
Date: Wed, 27 May 2026 18:57:03 +0200 (CEST)
Message-ID-Hash: 3BCRW5PK2UMLG35GT6OZOKYHYN26BIOS
X-Message-ID-Hash: 3BCRW5PK2UMLG35GT6OZOKYHYN26BIOS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3BCRW5PK2UMLG35GT6OZOKYHYN26BIOS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #770 was opened from alexaryn:

`alsa-info.sh` output: https://alsa-project.org/db/?f=e74874770f91860edde30f1d42e33c106f2a1c32

I recently updated the software on my gentoo laptop, including the kernel.  `speaker-test` demonstrates that I have audio output and that the mute button properly toggles the sound.  However, the speaker mute LED, which used to work, just stays off.

I think this is related to the empty list in `/sys/class/sound/ctl-led/speaker/card0/list`.  I think it should hold the value `10` for the Master Playback Switch.

My current ALSA is 1.2.15.  Previous was 1.2.14.

My kernel is 6.18.32.  Previous was 6.12.58.

The microphone mute LED works fine.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/770
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
