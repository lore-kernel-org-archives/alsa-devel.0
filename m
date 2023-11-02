Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D09C4332F
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Nov 2023 10:20:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46945827;
	Thu,  2 Nov 2023 11:19:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46945827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698920439;
	bh=c5A6e384V0dc4DP0+0sDW91fp2XhVmmdBi01YG6i5Ww=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=UeA2cQJ/klHnUpnB/1eMrcnx8GdD5u2DFnzocZfcsjD3e06kaXBFxdZ2LfZvI57Oa
	 O3aflgAQohKsZ7G9i31JrjuMtPfDDOJdh2QDxwdol6OP6LFUZS0UCPoYq5XLnwZ8tq
	 6DoTuyRqjIKgX5NbbtR7aQ/KhGC0DXwfj/KVZ6Mo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D9640F8055B; Thu,  2 Nov 2023 11:19:46 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 57143F80290;
	Thu,  2 Nov 2023 11:19:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C0F7F80290; Thu,  2 Nov 2023 11:18:28 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 0CF21F8014B
	for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2023 11:18:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CF21F8014B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1698920304734942913-webhooks-bot@alsa-project.org>
References: <1698920304734942913-webhooks-bot@alsa-project.org>
Subject: hdajackretask info window takes up all screens
Message-Id: <20231102101828.9C0F7F80290@alsa1.perex.cz>
Date: Thu,  2 Nov 2023 11:18:28 +0100 (CET)
Message-ID-Hash: 775LOVKPLET5SBKN3DJV3WSYBJEWV6AO
X-Message-ID-Hash: 775LOVKPLET5SBKN3DJV3WSYBJEWV6AO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/775LOVKPLET5SBKN3DJV3WSYBJEWV6AO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-tools issue #20 was opened from francisdb:

For a multi-monitor setup you get a very large screen.

The code below should probably be removed

https://github.com/alsa-project/alsa-tools/blob/8c8d6941f21ea68894ce7fd13e92b3ac9f16dc8a/hdajackretask/main-gtk.c#L517-L523

Issue URL     : https://github.com/alsa-project/alsa-tools/issues/20
Repository URL: https://github.com/alsa-project/alsa-tools
