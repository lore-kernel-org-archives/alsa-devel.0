Return-Path: <SRS0=uLsF=D5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E2FC4363A
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 17:05:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8B0223C7
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 17:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H/NxjFSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8B0223C7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D3C9017EA;
	Thu, 22 Oct 2020 19:04:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D3C9017EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603386304;
	bh=aNGQXRwVQLf6ZSMHW5sMo+LzGxwp04HuMDk39AbkHT4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H/NxjFSYJ99pwAsxY0/RZB1r0ImlFZHP0Q61Xk4IYDC3xEWtASyWnQ+rc7q4Yb/qL
	 ygOOoRG3qBB1RRNF2zbiQcnvuewhII6vqhMGnJSrZRIG0hLHO8YLovAQ0KeA0kpEFx
	 ue5BBprHJBx/7Pt55lVzREsk89XGRAuI79rsBLrE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 604A5F8025A;
	Thu, 22 Oct 2020 19:04:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5853F804A9; Thu, 22 Oct 2020 19:04:10 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 6C78CF8025A
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2020 19:04:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C78CF8025A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1603386243967147112-webhooks-bot@alsa-project.org>
References: <1603386243967147112-webhooks-bot@alsa-project.org>
Subject: src/dlmisc.c:snd_dlpath_unlock() doesn't build if DL_ORIGIN_AVAILABLE
 is not defined
Message-Id: <20201022170410.D5853F804A9@alsa1.perex.cz>
Date: Thu, 22 Oct 2020 19:04:10 +0200 (CEST)
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

alsa-project/alsa-lib issue #91 was opened from ollieparanoid:

Hey all, thanks for maintaining alsa.

In musl libc based Alpine Linux, the build of v1.2.4 fails with:
```
dlmisc.c:95:7: error: 'snd_plugin_dir_set' undeclared (first use in this function)
   95 |  if (!snd_plugin_dir_set) {
      |       ^~~~~~~~~~~~~~~~~~
dlmisc.c:95:7: note: each undeclared identifier is reported only once for each function it appears in
dlmisc.c:98:4: error: 'snd_plugin_dir' undeclared (first use in this function)
   98 |    snd_plugin_dir = strdup(env);
      |
```

This is a regression from https://github.com/alsa-project/alsa-lib/commit/8580c081c25678d11278efcb61bd15cf44d0a225, where the #ifdef...#else...#endif was removed.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/91
Repository URL: https://github.com/alsa-project/alsa-lib
