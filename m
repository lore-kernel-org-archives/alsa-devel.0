Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2969CD3423
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2026 18:22:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0868A601FA;
	Fri,  1 May 2026 20:22:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0868A601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777659778;
	bh=MAbJnHwOUkfRcZjPaekS8KWrMk9Me8jdeK/QsxXZJD0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=qR17DzvkO08HvcEHAKvWWdrqvaBFUKoGzAR/Hf84vMh0ii9SPZETWrNxyQREKb0j9
	 JDVwxz5Hb83UlUcxFYJ/iMFPFzkxamp7jPk8T+GJt1rT02cPPRbGpfzSXhtM1IAUKd
	 slGSK9f9Na4OykzMeGgP5+ofnlMQTGzUQhLOAbno=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D4D9CF805F5; Fri,  1 May 2026 20:22:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 27F5AF805ED;
	Fri,  1 May 2026 20:22:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55BFBF8055A; Fri,  1 May 2026 20:22:16 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B0C3CF80154
	for <alsa-devel@alsa-project.org>; Fri,  1 May 2026 20:22:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0C3CF80154
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ab841c13044e00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/754@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/754@alsa-project.org>
Subject: ucm2: Qualcomm: x1e80100: T14s-HiFi: switch DP outputs to dedicated
 MultiMedia5/6/7 streams
Date: Fri,  1 May 2026 20:22:16 +0200 (CEST)
Message-ID-Hash: 7OYTRGUYE6G67HQAKGQGZIRLUPDYBCJE
X-Message-ID-Hash: 7OYTRGUYE6G67HQAKGQGZIRLUPDYBCJE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7OYTRGUYE6G67HQAKGQGZIRLUPDYBCJE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #754 was edited from jglathe:

Align UCM with the topology change that added dedicated multimedia frontends for DisplayPort (commit c8d6762 "ASoC: qcom: x1e80100-LENOVO-Thinkpad-T14s: add dedicated multimedia frontend for DisplayPort").

- SectionVerb EnableSequence: enable DISPLAY_PORT_RX_0/1/2 on MultiMedia5/6/7 (remove the old MultiMedia1 "0" settings).
- Headphones: disable the DP mixers on the new dedicated streams.
- HDMI0/1/2 devices: route each DISPLAY_PORT_RX_* to its own MultiMedia frontend, use dedicated PlaybackPCM "hw:${CardId},4/5/6", add explicit PlaybackChannels 2, and keep the existing JackControl.

This gives independent DP audio streams and matches the [new topology](https://github.com/linux-msm/audioreach-topology/pull/59).

Tested on T14s G6 and ThinkBook 16 G7 QOY.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/754
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/754.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
