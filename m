Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D139FC5475B
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Mar 2024 09:03:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5966B71;
	Mon, 11 Mar 2024 10:03:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5966B71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710147794;
	bh=ev41DvWGaed5uUehQq6VmOA7zsN62+z9dfXHiRg+lRg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Pz3mmJP8kV60Siq3lnEJ/vYQXo63ceWwJX+1TSgVJGlSWnh/b9sOzcueL+VBrFqnX
	 6gFcaooW8xCJLdpsEgS+VEIuRPfAMBa4wkRv53fPPbX3hC1iaZZWIaZYs36fZ4rpSO
	 2+KKBImZOy0Y/29nGF2wsIBQLpbK81929BV6ZcJ0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7EF58F8059F; Mon, 11 Mar 2024 10:02:43 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BD861F805A8;
	Mon, 11 Mar 2024 10:02:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E441DF8028D; Mon, 11 Mar 2024 10:02:37 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id B9FACF8014B
	for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2024 10:02:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9FACF8014B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1710147751179359913-webhooks-bot@alsa-project.org>
References: <1710147751179359913-webhooks-bot@alsa-project.org>
Subject: sof-soundwire: rt1308: Fix single amp configuration
Message-Id: <20240311090237.E441DF8028D@alsa1.perex.cz>
Date: Mon, 11 Mar 2024 10:02:37 +0100 (CET)
Message-ID-Hash: 2WL5K4PA5XDGJ55NAOAPRQITJEGDNPNF
X-Message-ID-Hash: 2WL5K4PA5XDGJ55NAOAPRQITJEGDNPNF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2WL5K4PA5XDGJ55NAOAPRQITJEGDNPNF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #402 was opened from ujfalusi:

If the device have single rt1308 amp then the codec's Channel Select should be set to "LR" and not to "LL". "LL" is only valid if we have 2 amps, in that case one is the Left and the other is the Right channel.

This fixes for example Dell Latitude 9520 which only played on the Left speaker, Right is silent.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/402
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/402.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
