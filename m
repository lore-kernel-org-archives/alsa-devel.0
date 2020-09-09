Return-Path: <SRS0=lIjM=CS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F75BC43461
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:13:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3982120708
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ev6V9ZJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3982120708
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B87816F5;
	Wed,  9 Sep 2020 11:12:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B87816F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599642808;
	bh=anpuKVZHlvdX7oFnqwE/ZDGiAO7aIafnPIHc9oBEKUM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ev6V9ZJVdYSJxBqXeUqRNY1BQqs6YB2eL8jZSGmTnxGceOx2Ae3df8nb4pkIAGnW4
	 YixqiP/ZTE2cHAVy4IFuw6SpZ7fCdw36vbbNOFraIOBIF5uNPxN6Elec0i5OzH4kPE
	 5LkUihKLJtvaANM/7kDimPt3d96yHncugUQUGqKM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E4CD8F8021C;
	Wed,  9 Sep 2020 11:12:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC3BCF80227; Wed,  9 Sep 2020 11:12:36 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id D2844F8015F
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2020 11:12:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D2844F8015F
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1599642750133460999-webhooks-bot@alsa-project.org>
References: <1599642750133460999-webhooks-bot@alsa-project.org>
Subject: ucm2: USB-Audio: Add support for Lenovo ThinkStation P620 Rear Audio
Message-Id: <20200909091236.CC3BCF80227@alsa1.perex.cz>
Date: Wed,  9 Sep 2020 11:12:36 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #50 was opened from khfeng:

Add proper PCM assignment to Lenovo ThinkStation P620 Rear Audio.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/50
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/50.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
