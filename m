Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB62C4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Nov 2022 10:18:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89711167B;
	Tue, 15 Nov 2022 11:17:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89711167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668507493;
	bh=glXhaNYRQ8wQD3+4AwkWhYxyu8OCnQUZIjELGHC9cTQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nd2fAvmGISmBuSl4hRlEbNcYC2U3cBXLGe6JB1NicCvgznWuUqfuhZKH0I5Mb8Pxc
	 km+usBc+fHa4/mWqiz0qEq9sZb8519zn3ycRQVlHQgUHFQlfrFhHg1AD1+U1X5ECPf
	 6ScyDQhs3QBatEOnIbYJm+sgtqLI7Nnc5Krh3qvU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46381F80171;
	Tue, 15 Nov 2022 11:17:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE38EF8047C; Tue, 15 Nov 2022 11:17:21 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9AEA2F800B5
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2022 11:17:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9AEA2F800B5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1668507434658152103-webhooks-bot@alsa-project.org>
References: <1668507434658152103-webhooks-bot@alsa-project.org>
Subject: =?utf-8?q?S/PDIF_no_output_=28Realtek=C2=AE_ALC4080=29?=
Message-Id: <20221115101721.EE38EF8047C@alsa1.perex.cz>
Date: Tue, 15 Nov 2022 11:17:21 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-ucm-conf issue #241 was opened from uragan1987:

http://alsa-project.org/db/?f=2f67942734d0a5123454a73ae0dcfabf508dd7f5

Bus 001 Device 003: ID 0db0:6cc9 Micro Star International USB Audio

MPG-Z590-GAMING-PLUS

No output on S/PDIF

Is there a easy fix?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/241
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
