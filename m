Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BE7FF885E
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Apr 2026 18:39:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5283E601F9;
	Sun, 26 Apr 2026 20:39:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5283E601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777228756;
	bh=QNDipXg168GP5KpFCFSkLbyHAYP3IGN9y7LSKZ2M+sM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=bu4XEYOzyAXYfpAQf2Fq5yldkTjbkb7GgFr121nw8GibJk1JMF6BEa1WA8DUboShB
	 OXjtWF3YVq8FtfyHfZBGRS4+KEx0zNfsQMIOuHQ9YWxOylAqiSkmFy3Nc61K8baXPX
	 A46nJ+pT30dCStus+QfJHxfege3qg1ylqHtnm1Pw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F160F805F6; Sun, 26 Apr 2026 20:38:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B364DF805F4;
	Sun, 26 Apr 2026 20:38:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B3301F8014E; Sun, 26 Apr 2026 20:38:34 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F920F800BA
	for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2026 20:38:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F920F800BA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a9fc18e08ad000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/754@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/754@alsa-project.org>
Subject: ucm2: Qualcomm: x1e80100: T14s-HiFi: switch DP outputs to dedicated
 MultiMedia5/6/7 streams
Date: Sun, 26 Apr 2026 20:38:34 +0200 (CEST)
Message-ID-Hash: PYV6SNE7XS7M5P6NT2SA6GUOV5TZYZIV
X-Message-ID-Hash: PYV6SNE7XS7M5P6NT2SA6GUOV5TZYZIV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PYV6SNE7XS7M5P6NT2SA6GUOV5TZYZIV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #754 was opened from jglathe:

Align UCM with the topology change that added dedicated multimedia frontends for DisplayPort (commit c8d6762 "ASoC: qcom: x1e80100-LENOVO-Thinkpad-T14s: add dedicated multimedia frontend for DisplayPort").

- SectionVerb EnableSequence: enable DISPLAY_PORT_RX_0/1/2 on MultiMedia5/6/7 (remove the old MultiMedia1 "0" settings).
- Headphones: disable the DP mixers on the new dedicated streams.
- HDMI0/1/2 devices: route each DISPLAY_PORT_RX_* to its own MultiMedia frontend, use dedicated PlaybackPCM "hw:${CardId},4/5/6", add explicit PlaybackChannels 2, and keep the existing JackControl.

This gives independent DP audio streams and matches the new topology.

Tested on T14s G6 and ThinkBook 16 G7 QOY.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/754
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/754.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
