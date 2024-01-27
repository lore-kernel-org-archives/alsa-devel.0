Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F66EC46CD2
	for <alsa-devel@archiver.kernel.org>; Sat, 27 Jan 2024 20:01:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B6AA1828;
	Sat, 27 Jan 2024 21:01:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B6AA1828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706385688;
	bh=fql0THQLQzJrlR59Ws71lVEamRV+JCOPb2ys0yWk+f8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=c4D/7lx/dQsBDXrfGsmQ6DR8BKwyiJvJ0rWQ6iAWugQGdUaJ+lxK0GPGBaVNI+dcV
	 NfCPhaheo4lgk978LojbFo/C5haCFFFmk2gPasRP/W0giNhAcvIdyolYYz190lpwT4
	 RaCgAh74LEGJlRdlef/j4zPeSP6IV2kmY8cWiOTA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1C57F80520; Sat, 27 Jan 2024 21:00:57 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F3377F80580;
	Sat, 27 Jan 2024 21:00:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C754F8028D; Sat, 27 Jan 2024 21:00:45 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id C61D5F80149
	for <alsa-devel@alsa-project.org>; Sat, 27 Jan 2024 21:00:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C61D5F80149
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1706385637180726051-webhooks-bot@alsa-project.org>
References: <1706385637180726051-webhooks-bot@alsa-project.org>
Subject: ucm2: acp3x-es83xx: introduce UCM support for acp3x-es83xx sound card
Message-Id: <20240127200046.0C754F8028D@alsa1.perex.cz>
Date: Sat, 27 Jan 2024 21:00:45 +0100 (CET)
Message-ID-Hash: XHT57QXLAL7KI3M5WD77NBC3MJWOD5YO
X-Message-ID-Hash: XHT57QXLAL7KI3M5WD77NBC3MJWOD5YO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XHT57QXLAL7KI3M5WD77NBC3MJWOD5YO/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #391 was opened from codepayne:

Based on already existing UCM support in ucm2/Intel/sof-essx8336

This commit adds support for a line of Huawei laptops that use the AMD ACP controller and a es8336 codec.
The kernel machine driver is already upstream.  
The proposed settings are based on the intel es83xx support already present, but with the difference that
this line of laptops do not use an analog microphone that is connected to the codec.

[alsa-info.zip](https://github.com/alsa-project/alsa-ucm-conf/files/14073662/alsa-info.zip)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/391
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/391.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
