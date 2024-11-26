Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736CED59D9D
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2024 11:03:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDDE41945;
	Tue, 26 Nov 2024 12:03:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDDE41945
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732619000;
	bh=Krl+0qSBteurZs2xlfMBdXpeXhACO5841G4SZNj/+ag=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Y3Xs3FvK9gBUrYhYW7eDj76kwHBHrAUqlBwkj/4ooyy8vXAvkvukSoSwQueyTLfzI
	 Lw/1gwK6qerSpovCQ+FA8HmzhqWnMgdt+bcSrM539jc9SXybh5PSHRU1Tx8T/k4zmu
	 E0phbyW3LzABzbXY74zivZKlwUg64pciIw8dig00=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 638C5F805C0; Tue, 26 Nov 2024 12:02:48 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CFC4F805B5;
	Tue, 26 Nov 2024 12:02:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7F2DCF80496; Tue, 26 Nov 2024 12:02:41 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id A2080F800F0
	for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2024 12:02:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2080F800F0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1732618959199579716-webhooks-bot@alsa-project.org>
References: <1732618959199579716-webhooks-bot@alsa-project.org>
Subject: No built-in microphone in Thinkpad X1 Carbon (Gen 12) after update to
 v1.2.13
Message-Id: <20241126110241.7F2DCF80496@alsa1.perex.cz>
Date: Tue, 26 Nov 2024 12:02:41 +0100 (CET)
Message-ID-Hash: K6SGMNODEPMXIEL3XKSBGHWKIADEVSZR
X-Message-ID-Hash: K6SGMNODEPMXIEL3XKSBGHWKIADEVSZR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K6SGMNODEPMXIEL3XKSBGHWKIADEVSZR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #476 was opened from iyanmv:

I think the title is self-explanatory. After updating from v1.2.12 to v1.2.13 in Arch Linux, the built-in microphone on my laptop is not working. Downgrading to previous versions fixes the issue.

In addition, I also noticed that when attached to an external monitor using a docking station, the speakers of the monitor are not listed as before, and only the laptop's built-in speaker appears.

I'm running linux 6.12.1 and KDE Plasma 6.2.3.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/476
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
