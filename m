Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E40EE645E
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Sep 2023 14:27:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0522F820;
	Fri, 15 Sep 2023 16:26:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0522F820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694788050;
	bh=SI33/K4RrjlnLjnhABeY3eg0yjTVWQ+U6ixDVw2fe5U=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=mWOLFktpthPA8qVy41KWsK2FEzxkJ492VDP+btiYigMvgHkpr3abbl6Ci42v8SCN+
	 RPu7B8mNO2KozlbwtcRQ3VyH2oTpLyq4xvjYmH90auLtgB+b0lYK7I/cv/0giswDjn
	 iMjuET3A63+jIRYFT+tyClo+UViI4IcWW9ktq5jI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CBD5BF80551; Fri, 15 Sep 2023 16:26:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D35CF80425;
	Fri, 15 Sep 2023 16:26:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E228F80425; Fri, 15 Sep 2023 16:26:15 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A1C1F80141
	for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2023 16:26:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A1C1F80141
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1694787970584296465-webhooks-bot@alsa-project.org>
References: <1694787970584296465-webhooks-bot@alsa-project.org>
Subject: ucm2: Add intial Amlogic GXL support - v2
Message-Id: <20230915142615.3E228F80425@alsa1.perex.cz>
Date: Fri, 15 Sep 2023 16:26:15 +0200 (CEST)
Message-ID-Hash: CPUATZJX4ZMT6RSEAPOZCVWPN3HTNT2Z
X-Message-ID-Hash: CPUATZJX4ZMT6RSEAPOZCVWPN3HTNT2Z
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CPUATZJX4ZMT6RSEAPOZCVWPN3HTNT2Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #355 was opened from jeromebrunet:

This PR adds initial support for the Amlogic P241 (S905x ref design) and the Libretech-CC based on the same chip.
This is a v2 of PR #137 

* s/Meson/Amlogic
* PCM  has been move to the device section (Dropping empty verb section)
* Priority are different between the 2 devices (HDMI is more commonly used so it has higher prio)

Tested both outputs (port) with pulseaudio.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/355
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/355.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
