Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1FDC4706C
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jan 2024 08:45:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E01C3E9F;
	Fri, 12 Jan 2024 09:44:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E01C3E9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705049102;
	bh=V4MqTnXV27DwLr9teyLuCyaoVHp5VxEwCHehEiJrZ+A=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=LGL2kIveq4lD6eCBoHzxh/TDM5RhmMZ92TonEgg1dJCpnekU4VNYZ1hFSUZOSvfbN
	 6cNuCTDQE3tLFdZrmwrIucCtSn304aWylNgr3ceyZr6pshE70XwBFn230gqlzYNFsY
	 4rbyL7/eD5n6lQJEa86bgl6AZxHtl4o5yUKoOV9M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9DD65F80567; Fri, 12 Jan 2024 09:44:31 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E2D23F80568;
	Fri, 12 Jan 2024 09:44:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3BA74F80254; Fri, 12 Jan 2024 09:44:23 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 9AA57F80086
	for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2024 09:44:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9AA57F80086
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1705049059111652374-webhooks-bot@alsa-project.org>
References: <1705049059111652374-webhooks-bot@alsa-project.org>
Subject: ucm2: MediaTek: mt8370-evk: Add alsa-ucm support
Message-Id: <20240112084423.3BA74F80254@alsa1.perex.cz>
Date: Fri, 12 Jan 2024 09:44:23 +0100 (CET)
Message-ID-Hash: 2ULCVCFHQGWTJODYLBZIBM4PUVMUBXYE
X-Message-ID-Hash: 2ULCVCFHQGWTJODYLBZIBM4PUVMUBXYE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2ULCVCFHQGWTJODYLBZIBM4PUVMUBXYE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #380 was opened from zoran055:

Add alsa-ucm support for the MediaTek mt8370-evk platform.

MT8370 is a downgraded version of MT8390, but there isn't much difference in the Audio domain, so the content of the ucm conf is very similar to PR #321. However, due to different hardware and corresponding sound cards, the ucm conf is separated and a new commit is created.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/380
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/380.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
