Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D350C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:03:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41AA206E2
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="k1kq0SIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41AA206E2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9157D16D1;
	Mon, 22 Jun 2020 16:02:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9157D16D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592834580;
	bh=QVYOE05UI3ROUXQ4x2sQS2Vnr8OCpENCT86X+aPhDYI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k1kq0SILYNNsRUIOvbpTJ11k0YbDOL09Ixha7Q7ndeH5F+K7zKTbISYbeHmCVuGv0
	 +K4gg/BqugR1vlPYMcQAVVCEqlElYVp94thzzo1cjTJ9WEIUGqDdnb+rlGx5Pfju7s
	 YJXzg1mrePQ9M/ihtLDrcDHFtLmqjQvFA1KfjQz4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1401DF8015A;
	Mon, 22 Jun 2020 16:02:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 809E2F801DB; Mon, 22 Jun 2020 16:01:46 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 6F101F80157
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 16:01:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F101F80157
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1592834499550574064-webhooks-bot@alsa-project.org>
References: <1592834499550574064-webhooks-bot@alsa-project.org>
Subject: GQuark is not exported.
Message-Id: <20200622140146.809E2F801DB@alsa1.perex.cz>
Date: Mon, 22 Jun 2020 16:01:46 +0200 (CEST)
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

alsa-project/alsa-gobject issue #47 was edited from takaswie:

Although each library in alsa-gobject uses GQuark to propagate error information, the symbol of GQuark is not exported yet by symbol mapping file of each library:

 * src/ctl/alsactl.map
 * src/timer/alsatimer.map
 * src/seq/alsaseq.map
 * src/hwdep/alsahwdep.map
 * src/rawmidi/alsarawmidi.map

This issue brings inconvenience for [Rust bindings](https://github.com/alsa-project/alsa-gobject-rs) to implement [glib::error::ErrorDomain](https://gtk-rs.org/docs/glib/error/trait.ErrorDomain.html) for each GQuark. The glib::error::ErrorDomain trait requires domain function implementation to return GQuark itself, however it's not exported and unable to access.

Issue URL     : https://github.com/alsa-project/alsa-gobject/issues/47
Repository URL: https://github.com/alsa-project/alsa-gobject
