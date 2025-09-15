Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E171ACAC594
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Sep 2025 06:35:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03BEC601E0;
	Mon, 15 Sep 2025 08:35:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03BEC601E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1757918146;
	bh=OK0z73JlHK2Qei/ODIszEH7UIhvulAj1C+0+9vXGK7U=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Hlu1XJrcnH00zXsJkAQuLXaTyPjs1lp69u5NmD6Hh3ngz74diT3He3XnyqFtiXk9S
	 hXJpMtvw7tgcpSFdboUEou3NU1Wpdx/iOm3aP39uLMLZtEhfmJTNPdXGTZexwCmhAt
	 eHCwQChs1dNqg+au7u1jNihSGpNc80yTkIDeM7aU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2FE30F805BF; Mon, 15 Sep 2025 08:35:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 44ACFF805C5;
	Mon, 15 Sep 2025 08:35:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 986A3F8051F; Mon, 15 Sep 2025 08:34:19 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C318F80075
	for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2025 08:34:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C318F80075
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18656128a5b26e00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/478@alsa-project.org>
References: <alsa-project/alsa-lib/pr/478@alsa-project.org>
Subject: snd_tlv_convert_to_dB: Fix mute handling for MINMAX_MUTE type
Date: Mon, 15 Sep 2025 08:34:19 +0200 (CEST)
Message-ID-Hash: ERLPVSALQNZ6P22UA6GYCLQKLUSA63CM
X-Message-ID-Hash: ERLPVSALQNZ6P22UA6GYCLQKLUSA63CM
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ERLPVSALQNZ6P22UA6GYCLQKLUSA63CM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #478 was opened from qaqland:

Ensure the SND_CTL_TLV_DB_GAIN_MUTE value is returned when the calculated gain equals the minimum dB value for the SNDRV_CTL_TLVT_DB_MINMAX_MUTE type. The previous check based solely on the volume value could miss cases where the linear calculation resulted in the minimum gain.

The db range of some devices is very small

<img width="619" height="106" alt="17574693041385" src="https://github.com/user-attachments/assets/3461c643-284d-4ef0-8315-8fc682688442" />

Request URL   : https://github.com/alsa-project/alsa-lib/pull/478
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/478.patch
Repository URL: https://github.com/alsa-project/alsa-lib
