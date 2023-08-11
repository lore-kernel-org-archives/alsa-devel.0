Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9B0C0015E
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Aug 2023 19:11:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFE3D1DA;
	Fri, 11 Aug 2023 21:10:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFE3D1DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691781065;
	bh=OOnMjxTA+NW+7/2jqxbn6oT9VT7Wdc65m/E+tYofWqM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=CIf4c8vRVITKG3ulw8CsDOYvlQnA/Wy3+nh8Wu8nqgyW+/VobflOmcjPghLMv4WCE
	 WAohXWhH6ZFG5BboK40/8EGKzAN8HDcpkucJuyPdO7+PznyMWTM5GmPbNljZzXirwu
	 s9Bplb0MVtaOuvqdQJ2K0qV8Zt9J8ukVFv3+HRg0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5203AF80551; Fri, 11 Aug 2023 21:10:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 05979F80166;
	Fri, 11 Aug 2023 21:10:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 87C0AF80166; Fri, 11 Aug 2023 21:10:10 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 6430CF800EE
	for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2023 21:10:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6430CF800EE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1691781006590857506-webhooks-bot@alsa-project.org>
References: <1691781006590857506-webhooks-bot@alsa-project.org>
Subject: MSI x570s Carbon Max WiFi ALC 4080
Message-Id: <20230811191010.87C0AF80166@alsa1.perex.cz>
Date: Fri, 11 Aug 2023 21:10:10 +0200 (CEST)
Message-ID-Hash: JZZ2H2H2VKK5FUBWEO7MRN4MOCJYL2VE
X-Message-ID-Hash: JZZ2H2H2VKK5FUBWEO7MRN4MOCJYL2VE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JZZ2H2H2VKK5FUBWEO7MRN4MOCJYL2VE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #338 was opened from zpackrat:

Fedora 38 patched to current, issue has existed for months. Rear output jacks for Center/Sub and Rear Speakers are reversed. I use a 5.1 speaker setup. When I run sound tests in the gnome audio settings the issue is verifiable. Also audio that requires center channel for dialogue has issues.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/338
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
