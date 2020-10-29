Return-Path: <SRS0=XEtc=EE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292B3C4363A
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 05:55:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8D12151B
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 05:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oBLZ6cyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8D12151B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C20E011C;
	Thu, 29 Oct 2020 06:54:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C20E011C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603950920;
	bh=5GBkczd+ZTuAjq4J9AWbcoD1614GRgj+jLYvDRZ78a4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oBLZ6cyuPqGQ5pS11m1lQCRLiNzNMSl1UhY8Vql0knSX8CaJ2PgaU+vm1Tdn0mo0R
	 xPG8UeLfXFu4sZcTPIMFlbS9NA/fajQWkib+pJJGZVItbEVr220TqvTfra1+ojPizz
	 yXz7RQEfUZg7SBiwafyhG7uPM73fTC0TbKHn3+d0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 155CFF800FF;
	Thu, 29 Oct 2020 06:54:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2E1BF8020D; Thu, 29 Oct 2020 06:54:27 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 3479AF800FF
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 06:54:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3479AF800FF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1603950863071362972-webhooks-bot@alsa-project.org>
References: <1603950863071362972-webhooks-bot@alsa-project.org>
Subject: Fix initsetting
Message-Id: <20201029055427.E2E1BF8020D@alsa1.perex.cz>
Date: Thu, 29 Oct 2020 06:54:27 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #57 was opened from jason77-wang:

This issue was found when we prepared ubuntu 20.10. When users install the OS to a machine with HDA codec and use sof driver, the audio output is muted after installation. And even we set the master playback switch to on, the output volume from speaker is too low.

This issue could be easily reproduced by:
sudo rm /var/lib/asla/*
rm ~/.config/pulse/* (optional)
sudo /usr/sbin/alsactl -E HOME=/run/alsa -E XDG_RUNTIME_DIR=/run/alsa/runtime restore

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/57
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/57.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
