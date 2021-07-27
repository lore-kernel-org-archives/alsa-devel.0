Return-Path: <SRS0=TC80=MT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C80C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 11:04:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F612619E4
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 11:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F612619E4
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 504F71ED9;
	Tue, 27 Jul 2021 13:03:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 504F71ED9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627383884;
	bh=T8TbQzBd3fu42OpfPC1h9MDe5L3RhcM5YtHBVWBjby4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MoFE0p/oU588wIdwrEt1SFAXGCoG5iGi17SEHyf14+iVgzNROgo7EEhlPLXc7SHb4
	 8NUSKEe6nqkKdyp0JD43qw//9PN35ptZNH+dbQ/nyMRIK6y22adPr0wK6a6S/NFnNx
	 LrZdyKg7lZbZyfwNIR1bxNVIXB4Knn88ZzCgAONI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DFC40F80212;
	Tue, 27 Jul 2021 13:03:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B682BF8026C; Tue, 27 Jul 2021 13:03:51 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B89A5F8020D
 for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2021 13:03:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B89A5F8020D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1627383820290263891-webhooks-bot@alsa-project.org>
References: <1627383820290263891-webhooks-bot@alsa-project.org>
Subject: Pulseaudio craches on start with SegFault error
Message-Id: <20210727110351.B682BF8026C@alsa1.perex.cz>
Date: Tue, 27 Jul 2021 13:03:51 +0200 (CEST)
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

alsa-project/alsa-plugins issue #31 was opened from jmtrivial:

Dear alsa-project developers,

I am using a debian (testing) on my computer, together with deb-multimedia.org repository. As some other users with external USB audio devices, I recently discovered a segfault:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=991337
I discussed withe Christian Marillat (maintainer of the deb-multimedia repository) and we tried a couple of alsa versions, but the bug is still present if I'm using a recent libasound2-plugins such as this one:
https://www.deb-multimedia.org/tests/libasound2-plugins_1.2.2+git4219f4b-dmo1_amd64.deb
It does not crash with libasound2-plugins 1.2.2-2 from debian testing.

You will found attached the log file from pulseaudio -vvv.

[pulseaudio.log](https://github.com/alsa-project/alsa-plugins/files/6884875/pulseaudio.log)

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/31
Repository URL: https://github.com/alsa-project/alsa-plugins
