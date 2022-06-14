Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86177C43334
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jun 2022 20:25:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA29A18F8;
	Tue, 14 Jun 2022 22:24:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA29A18F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655238338;
	bh=byPpJFnPvwYnpMhqT8m9tmLeEnBMPU8s0XBqbNUJrNA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fD6RaUDNAr/rEn0oVhAQxkCwB0+/Gv36DQnsFVeTXrS8cEsBsnvhd8EloPVuVzOwY
	 L1cihkSAqq6hwt3cuBYkcroO21FIrQPZ6NRiYQ641JXZzlPucdR4g8zv16yW1qhzcP
	 JoUKdeLm7PyskiBVgAOw24mtVnB9jnDMCAjsjYjk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 58AAEF80137;
	Tue, 14 Jun 2022 22:24:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76C14F80139; Tue, 14 Jun 2022 22:24:46 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id AB4A1F800E1
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2022 22:24:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB4A1F800E1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1655238282893857002-webhooks-bot@alsa-project.org>
References: <1655238282893857002-webhooks-bot@alsa-project.org>
Subject: Any way to fuse static libasound with alsa-plugins so no dlopens are
 performed?
Message-Id: <20220614202446.76C14F80139@alsa1.perex.cz>
Date: Tue, 14 Jun 2022 22:24:46 +0200 (CEST)
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

alsa-project/alsa-plugins issue #45 was opened from MIvanchev:

See title. I have a project that might benefit from such a mix.

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/45
Repository URL: https://github.com/alsa-project/alsa-plugins
