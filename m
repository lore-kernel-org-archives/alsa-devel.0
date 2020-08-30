Return-Path: <SRS0=QqOT=CI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE52C433E2
	for <alsa-devel@archiver.kernel.org>; Sun, 30 Aug 2020 22:28:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4FF4206F0
	for <alsa-devel@archiver.kernel.org>; Sun, 30 Aug 2020 22:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dIqRdjwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FF4206F0
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4AEFF1688;
	Mon, 31 Aug 2020 00:27:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4AEFF1688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598826512;
	bh=i2qhYu+H+xIy5AbyQYaa/AFgHs9hQMYQdAMIw1vQolE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dIqRdjwFwLKnswuubkx160ftMM7hEd4SizjyztDXv4j44DMK0LJZwxtrDmcKTkGvo
	 uVQgg8QK4uqurMhLB+vlnmYfNJ5le+iPIgOjkTNRC3z/76FEMAEAwQURsqh2FIBLSF
	 dvt73EBNPP5SEKZUNtcR243KDs2nLFt6jDMyC5uQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94F64F801EB;
	Mon, 31 Aug 2020 00:27:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7030F8020D; Mon, 31 Aug 2020 00:27:37 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id DA3CEF8012E
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2020 00:27:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA3CEF8012E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1598826454145714045-webhooks-bot@alsa-project.org>
References: <1598826454145714045-webhooks-bot@alsa-project.org>
Subject: Crash when trying to capture vdownmix
Message-Id: <20200830222737.C7030F8020D@alsa1.perex.cz>
Date: Mon, 31 Aug 2020 00:27:37 +0200 (CEST)
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

alsa-project/alsa-plugins issue #13 was opened from s09bQ5:

Our game captures audio from microphones and tests the available devices on startup. For some reason PortAudio tells us that vdownmix is a 6 channel capture device. When the game tries to test that device, the plugin crashes inside vdownmix_transfer because the src_areas array contained only two valid pointers while mix->channels is  6. I assume the plugin is not prepared to handle the swapped roles of input and output during capture.

A simple way to cause the crash is to execute `arecord -D vdownmix -f dat -c 6`.

The expected behavior is that the plugin either enforces 2 channel capture with a 4/5/6 channel slave pcm or completely rejects capture. In any case, it should not crash with a SIGSEGV.

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/13
Repository URL: https://github.com/alsa-project/alsa-plugins
