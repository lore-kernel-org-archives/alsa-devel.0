Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E1BC678D4
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Mar 2023 13:41:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20DD2110A;
	Mon,  6 Mar 2023 14:40:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20DD2110A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678110097;
	bh=1meHAk5JkmcN09XNU/5HFtbIzIzI7XKmhOlMn4e3u8c=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=TNZKxkvtMKvFrjjxjhMbIc1Obk+CYOKwIn+GJ/556dfZAIv1NcIANDphXFSicrPfY
	 fj4FdLXvDmUNPTEmtV90EeBMS2CJTaHrrh8jwlURkEz8I1Y8GyRoTLZfRJJ1FY+U+Z
	 N2mRBhpYQ2CorFbxcw2qqhcsRIncRKY94Q7B8FU4=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 74B14F8042F;
	Mon,  6 Mar 2023 14:40:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1C32EF8042F; Mon,  6 Mar 2023 14:40:21 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 015E0F800C9
	for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2023 14:40:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 015E0F800C9
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1678110017406239986-webhooks-bot@alsa-project.org>
References: <1678110017406239986-webhooks-bot@alsa-project.org>
Subject: sof-hda-dsp: Add speaker led support
Message-Id: <20230306134021.1C32EF8042F@alsa1.perex.cz>
Date: Mon,  6 Mar 2023 14:40:21 +0100 (CET)
Message-ID-Hash: DXM6HCLMSQQIHMCO3Y6GQJ6APBIKUPMV
X-Message-ID-Hash: DXM6HCLMSQQIHMCO3Y6GQJ6APBIKUPMV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DXM6HCLMSQQIHMCO3Y6GQJ6APBIKUPMV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #286 was opened from Kobatw:

There's a speaker led on Dell G16 and use sof-hda-dsp to control.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/286
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/286.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
