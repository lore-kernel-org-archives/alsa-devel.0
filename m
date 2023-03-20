Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4510AC7618A
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Mar 2023 00:26:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3210E20F;
	Mon, 20 Mar 2023 01:25:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3210E20F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679271962;
	bh=jcSfYb8Vmv/lkfGg4kv3r8XFFliuGTIM0otHv7U1hi0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=sZCOMkKDayfKKsgYcmuVh2jqvgvpqUeFJ1Jv+VfBYBk6ZnjQI3/Zf8LuURB97qcla
	 /oomo9FOxjiQcV82tM0HWY/KdnbL9THhuElY2tub93AespWqt9AwJro3mKW4SgwJUA
	 aGa6BTvPLHilXellWcmQnHqpuzIwHCIZp/yq5C7g=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ABB05F8027B;
	Mon, 20 Mar 2023 01:24:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7B83F8027B; Mon, 20 Mar 2023 01:24:44 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A5C0F80093
	for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2023 01:24:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A5C0F80093
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1679271879593404531-webhooks-bot@alsa-project.org>
References: <1679271879593404531-webhooks-bot@alsa-project.org>
Subject: USB-Audio: ALC4080, add MSI MPG Z590 Gaming Force
Message-Id: <20230320002444.D7B83F8027B@alsa1.perex.cz>
Date: Mon, 20 Mar 2023 01:24:44 +0100 (CET)
Message-ID-Hash: VZB5PEQWEYTCRIQBEH7OQQ5VZBE3OMCT
X-Message-ID-Hash: VZB5PEQWEYTCRIQBEH7OQQ5VZBE3OMCT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VZB5PEQWEYTCRIQBEH7OQQ5VZBE3OMCT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #292 was opened from Paris17:

USB ID: 0db0:8af7

Adds support for the MSI MPG Z590 GAMING FORCE motherboard front & back 3.5mm jacks.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/292
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/292.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
