Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51234C6FD18
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Apr 2023 21:34:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D44BE8F;
	Tue, 18 Apr 2023 23:33:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D44BE8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681853682;
	bh=5nGUxLAMxwduDJ8V6T1Us4kNOepcY0bhHrnnqEQgYeg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=kO633JN2xZS+xRM2YmCBjDAk+4i6KyJzv51c4VTt8Wfoe52/RFSLACqwsvhXQy8Qi
	 eKQJ78N7edp6gtitbtVo+tqlY3u0tPxQTA+/Idb09NT9OthC1syCyKnJceeROz54D1
	 QSb+umLXPYKzGexkta5lPpNg+Amj9dN3KljjrhRk=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 949ECF800AC;
	Tue, 18 Apr 2023 23:33:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08F6DF80155; Tue, 18 Apr 2023 23:33:23 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id A9304F800D0
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2023 23:33:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9304F800D0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1681853599638764858-webhooks-bot@alsa-project.org>
References: <1681853599638764858-webhooks-bot@alsa-project.org>
Subject: USB Audio (SPDIF) broken after 810367c
Message-Id: <20230418213323.08F6DF80155@alsa1.perex.cz>
Date: Tue, 18 Apr 2023 23:33:23 +0200 (CEST)
Message-ID-Hash: T5ZTCQZNHHYITEXPDTFEEJUICSPF6FOL
X-Message-ID-Hash: T5ZTCQZNHHYITEXPDTFEEJUICSPF6FOL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T5ZTCQZNHHYITEXPDTFEEJUICSPF6FOL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #305 was opened from ZVNexus:

Device: [ROG STRIX X670E-E GAMING WIFI](https://rog.asus.com/motherboards/rog-strix/rog-strix-x670e-e-gaming-wifi-model/)
/proc/asound/card3/usbid: 0b05:1a52

Audio stopped working after this commit, not sure why.

https://github.com/alsa-project/alsa-ucm-conf/commit/810367c244bf2d3dc0c53587742c8ca4205ae067

Able to reproduce by deleting /usr/share/alsa/ucm*, copying from before this commit, and after this commit.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/305
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
