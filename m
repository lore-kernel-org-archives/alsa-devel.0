Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40594C00144
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jul 2022 06:57:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 992061652;
	Fri, 29 Jul 2022 08:56:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 992061652
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659077852;
	bh=pLmbe28GxkzFqVHDl+cg97UQBXMzwVNEYR8q1t7iiJw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BZcjxDFXOnhAnBzKVh7G2fld8SvQF4xUEBUDA5zOZn5h/r7O+i/3kyup/cHgw/8EU
	 KPOltYuYqQoJitU5JkRfsPW+1FRz9eLZPTG+5miqDIBu/RbTh4eKyEfzwXYpZER1Uv
	 N3PVCiWXYvwB3HUCUfX/6G4fwVYHlRiNqdN8FRTk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D93C6F80430;
	Fri, 29 Jul 2022 08:56:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 278EFF8049C; Fri, 29 Jul 2022 08:56:40 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id EFD6BF8015B
 for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2022 08:56:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFD6BF8015B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1659077796309905052-webhooks-bot@alsa-project.org>
References: <1659077796309905052-webhooks-bot@alsa-project.org>
Subject: Mega r1.1
Message-Id: <20220729065640.278EFF8049C@alsa1.perex.cz>
Date: Fri, 29 Jul 2022 08:56:40 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #195 was opened from 13r0ck:

requires https://github.com/pop-os/linux/pull/167

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/195
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/195.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
