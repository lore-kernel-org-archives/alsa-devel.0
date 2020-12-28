Return-Path: <SRS0=H50z=GA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3B7C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 14:40:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DC6820715
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 14:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC6820715
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3D24E170A;
	Mon, 28 Dec 2020 15:39:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3D24E170A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609166437;
	bh=PgVbTPC8sYqamM0VckPICkb8n4JZMK40VB90Js3aVds=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c5WJFlkK7FjxQ5YdmzZJRPxjNJ+0rTYcMLDV1Nx/7e+Ii6vennEUzCNkqC3iNoM9+
	 fvBC9FrGjEv0tPj5dimC41Ifc3sl1DvbT90KILdtlz7gzZQico8WmmUB7CdbcdGTLl
	 FShPIyG2M1FHTYmA14M+DYyTjyxLZc6kS10cbFvk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C315AF80143;
	Mon, 28 Dec 2020 15:39:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A30AF801F5; Mon, 28 Dec 2020 15:39:45 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 0D096F80143
 for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2020 15:39:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D096F80143
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1609166380279328108-webhooks-bot@alsa-project.org>
References: <1609166380279328108-webhooks-bot@alsa-project.org>
Subject: cross-compilation broken since
 cf09b6742a507555bb712101aff9e919009f0683
Message-Id: <20201228143945.5A30AF801F5@alsa1.perex.cz>
Date: Mon, 28 Dec 2020 15:39:45 +0100 (CET)
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

alsa-project/alsa-firmware issue #3 was opened from flokli:

I was excited to see c9e5b369919a956cf56d50a6f0be076e364f7820 getting merged, but realized this broke immediately afterwards in cf09b6742a507555bb712101aff9e919009f0683:

```
git bisect start
# good: [c9e5b369919a956cf56d50a6f0be076e364f7820] Get cross compilation to work
git bisect good c9e5b369919a956cf56d50a6f0be076e364f7820
# bad: [3ab9711ae106851b4185da42d5873702a3008744] Release v1.2.4
git bisect bad 3ab9711ae106851b4185da42d5873702a3008744
# bad: [41008541de9bd2b184058ec2204f172e3c9f64fe] introduce Makefile.hotplug
git bisect bad 41008541de9bd2b184058ec2204f172e3c9f64fe
# bad: [546aa5b30694889b00b424a6e9de2c5f34ce5da2] introduce Makefile.fw_writer
git bisect bad 546aa5b30694889b00b424a6e9de2c5f34ce5da2
# bad: [cf09b6742a507555bb712101aff9e919009f0683] upgrade ax_prog_cc_for_build.m4 to serial 18
git bisect bad cf09b6742a507555bb712101aff9e919009f0683
# first bad commit: [cf09b6742a507555bb712101aff9e919009f0683] upgrade ax_prog_cc_for_build.m4 to serial 18
```

cc @perexg

Issue URL     : https://github.com/alsa-project/alsa-firmware/issues/3
Repository URL: https://github.com/alsa-project/alsa-firmware
