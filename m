Return-Path: <SRS0=quTn=OE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752A9C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Sep 2021 16:01:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D2C60F9F
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Sep 2021 16:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 59D2C60F9F
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5976E17E9;
	Tue, 14 Sep 2021 18:01:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5976E17E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631635310;
	bh=l5Db7HQ0DAvUtyXX+asPMsFmn8d30NpCQF9caMrig0w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TNeeqtr6e+sRSlXAjSyMScpLYSbtTm5EtQG0u7LeAqKzp9diO/WvTLkcZa84k02Ju
	 PEBIQGPZnDLCIirQ8Is4X/w8pIEDj/z7rxvmpZoqu3gr/KQTE5Pkf6TJj4bPP7tZcK
	 jmGGOpq15lYtbaTHk49BPVFTl3h0fDPV+NxaO7jM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0406F8025A;
	Tue, 14 Sep 2021 18:00:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D124EF8025E; Tue, 14 Sep 2021 18:00:57 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 3C675F80169
 for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2021 18:00:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C675F80169
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1631635249309595108-webhooks-bot@alsa-project.org>
References: <1631635249309595108-webhooks-bot@alsa-project.org>
Subject: git clone failed
Message-Id: <20210914160057.D124EF8025E@alsa1.perex.cz>
Date: Tue, 14 Sep 2021 18:00:57 +0200 (CEST)
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

alsa-project/tinycompress issue #12 was edited from BalajiMalar:

i was building yocto image which uses tinycomrpess as part of NXP's recipe-multimedia. the yocto build failed since it wasnt able to clone the package.
i tried to clone from CLI using the command "**git clone git://git.alsa-project.org/tinycompress.git**" and still it failed

Issue URL     : https://github.com/alsa-project/tinycompress/issues/12
Repository URL: https://github.com/alsa-project/tinycompress
