Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5725EE77188
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2025 05:50:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BECDB60272;
	Tue, 14 Jan 2025 06:50:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BECDB60272
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1736833855;
	bh=eusuI1XYMDmv7RJDYyvY/5DqoWtXDDufOuKdOpo1Q3Q=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=isCA4EefM3nWMqFWnZ7ertLjtGk2SgaOMOl+xz3PL1uwTZm5+catp8WfPbwsqqf9Y
	 9m6UOpCixrOHFs92jovmXqAk7dyQsW4BnkaxpAyrIdmIDTyg8Pcs+LEIanvBG8IyAx
	 wZv83eIuYYX62TnXojooK2LfXtP+wT82IZqcft/M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7E167F805BA; Tue, 14 Jan 2025 06:50:24 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 42727F805C6;
	Tue, 14 Jan 2025 06:50:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B8E39F80169; Tue, 14 Jan 2025 06:49:55 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DFFCF800B8
	for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2025 06:49:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2DFFCF800B8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1736833787075868130-webhooks-bot@alsa-project.org>
References: <1736833787075868130-webhooks-bot@alsa-project.org>
Subject: rt722: change output volume of headphone to 0dB
Message-Id: <20250114054955.B8E39F80169@alsa1.perex.cz>
Date: Tue, 14 Jan 2025 06:49:55 +0100 (CET)
Message-ID-Hash: VNJLWV4FUOMRDMSL6TPYSKWD7SVAF3DM
X-Message-ID-Hash: VNJLWV4FUOMRDMSL6TPYSKWD7SVAF3DM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VNJLWV4FUOMRDMSL6TPYSKWD7SVAF3DM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #496 was opened from shumingfan:

rt722: change output volume of headphone to 0dB

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/496
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/496.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
