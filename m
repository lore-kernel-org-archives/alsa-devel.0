Return-Path: <SRS0=AHG6=N4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4C0C433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Sep 2021 07:18:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B94D6054E
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Sep 2021 07:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B94D6054E
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE5FE1769;
	Mon,  6 Sep 2021 09:17:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE5FE1769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630912677;
	bh=Q06ncvJq5bfgG58Wk4h8g0wWqfyLBl+2YLS2W7ulKLI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bjIkN35LmdFk15afFUdd40C+eiwny2J2VlZXfRKw0IwKmC90pJvA8HTpyN61LnGvV
	 R26FncVdd3Wc2OYDJnHpeggEhhniJJewbsk11In3/A7vlVHUZtp3rwHySGH/p10nCg
	 tpLvCvTXfOSrmRzJybc2AEfh4X908o2P5lsXrcG8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6765FF8026C;
	Mon,  6 Sep 2021 09:17:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3FD92F802E7; Mon,  6 Sep 2021 09:17:06 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C31FFF800C7
 for <alsa-devel@alsa-project.org>; Mon,  6 Sep 2021 09:17:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C31FFF800C7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1630912623498121023-webhooks-bot@alsa-project.org>
References: <1630912623498121023-webhooks-bot@alsa-project.org>
Subject: hdajackretask doesn't check for script's exit code
Message-Id: <20210906071706.3FD92F802E7@alsa1.perex.cz>
Date: Mon,  6 Sep 2021 09:17:06 +0200 (CEST)
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

alsa-project/alsa-tools issue #8 was edited from kroq-gar78:

`hdajackretask` creates a script in `/tmp` before executing it. When `/tmp` is mounted with `noexec`, running that script will fail, but the GUI gives no indication that it failed.

I'm on Ubuntu 18.04.5 with `alsa-tools-gui` package version `1.1.3-1`.

The GUI should check for the exit code of the script, and notify the user appropriately if the script failed to execute.

Also, if this isn't the appropriate place to report a bug, please let me know!

Issue URL     : https://github.com/alsa-project/alsa-tools/issues/8
Repository URL: https://github.com/alsa-project/alsa-tools
