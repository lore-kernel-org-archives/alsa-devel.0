Return-Path: <SRS0=7kYh=DW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5296C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:31:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949E622255
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hn44actW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949E622255
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F036B177F;
	Thu, 15 Oct 2020 18:30:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F036B177F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602779470;
	bh=Q2cf0XC/8ROG8dd34lFk9HUkYjzSXdHMC6Ecpa3d3uo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hn44actWef34o0Db8uIBtbvTAr3TahfXOJNS7nHrgDEOsrkxhq528JdBZuideR6uW
	 YURB+P8Mm9YtDwNoASRiJSVccbTSUDHJ+RocJ6S3lS5OBmm9KqAXpmAxXAOn0DZCfU
	 6DYGqn8Nh0lt4jJnlaqMxR2PHNT05cBi7DRzG2Ms=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85041F80255;
	Thu, 15 Oct 2020 18:30:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48810F80268; Thu, 15 Oct 2020 18:30:18 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A8259F80247
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2020 18:30:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8259F80247
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1602779409508788109-webhooks-bot@alsa-project.org>
References: <1602779409508788109-webhooks-bot@alsa-project.org>
Subject: Release change info in release [atom feed] messages?
Message-Id: <20201015163018.48810F80268@alsa1.perex.cz>
Date: Thu, 15 Oct 2020 18:30:18 +0200 (CEST)
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

alsa-project/alsa-lib issue #86 was opened from mxmilkiib:

I'm currently working on an software update aggregation system - https://libreav.org/updates - and I'd like to add ALSA itself, but I don't think there is a feed for this other than https://github.com/alsa-project/alsa-lib/releases.atom.

However, the releases.atom entries do not contain the Changes summary that is used on [the wiki](https://www.alsa-project.org/wiki/Changes_v1.2.3.1_v1.2.3.2).

Might it be possible for the release messages to contain those texts?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/86
Repository URL: https://github.com/alsa-project/alsa-lib
