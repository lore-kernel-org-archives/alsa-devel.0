Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC8CC04A6A
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Aug 2023 20:52:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03AB1827;
	Fri, 11 Aug 2023 22:51:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03AB1827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691787140;
	bh=Qh7EYEMMNQBkYsz190OBnrAZiw7KEwsyZzH2DwW8co0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=pnREvX2BUF853dr4ksy3MlEdZv4KByP1AoVdtt/0tR1QshUkY9cUVg91ul0SyNhsu
	 ao/vPqg5UJIouJaD3jZSoNED2EKllywHV4sRV6L40+9L8/yxlRlPm6NabYugJmmen0
	 KX958btSAd3+ACM3XjA8LmrDPWjD/gLy6tJXP95g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ADDB6F8016E; Fri, 11 Aug 2023 22:51:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E096F800F4;
	Fri, 11 Aug 2023 22:51:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6CFDEF80166; Fri, 11 Aug 2023 22:51:02 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BA85F800F4
	for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2023 22:50:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BA85F800F4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1691787059715125084-webhooks-bot@alsa-project.org>
References: <1691787059715125084-webhooks-bot@alsa-project.org>
Subject: MSI x570s Carbon Max WiFi ALC 4080
Message-Id: <20230811205102.6CFDEF80166@alsa1.perex.cz>
Date: Fri, 11 Aug 2023 22:51:02 +0200 (CEST)
Message-ID-Hash: Z52MTMYFXSFQLAWWNJNJVD6XTDV53H5Y
X-Message-ID-Hash: Z52MTMYFXSFQLAWWNJNJVD6XTDV53H5Y
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z52MTMYFXSFQLAWWNJNJVD6XTDV53H5Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #338 was edited from zpackrat:

Fedora 38 patched to current, issue has existed for months. Rear output jacks for Center/Sub and Rear Speakers are reversed. I use a 5.1 speaker setup. When I run sound tests in the gnome audio settings the issue is verifiable. Also audio that requires center channel for dialogue has issues. This is specifically the rear audio I/O ports.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/338
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
