Return-Path: <SRS0=OCx8=ZZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A1DC432C0
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 19:39:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B3920803
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 19:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lhi3c9ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B3920803
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD0CB1615;
	Tue,  3 Dec 2019 20:38:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD0CB1615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575401956;
	bh=549bxElXvOlmlFTMkEV2JKMbvBHH3NsKq5IoKqOpnQM=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lhi3c9akcYVrN47rka2y0jH/GtxUihW78pMOb8oikpXzQBhk8FyQ0kyCDwPh0s+qe
	 KcAGPmkUkzRDGnpBN+RDFU3vaRe13XhYVwqCzaOL31n+NPT6NuNixCiQKDp0w4+E1S
	 7w7K5NkZ7NO7Be5FL2WudMZRBeXjcicGn0+E7f1A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55E8CF8015A;
	Tue,  3 Dec 2019 20:38:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 129BDF80227; Tue,  3 Dec 2019 20:38:25 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C0ECBF800F0
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2019 20:38:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0ECBF800F0
MIME-Version: 1.0
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1575401900181029081-webhooks-bot@alsa-project.org>
References: <1575401900181029081-webhooks-bot@alsa-project.org>
Message-Id: <20191203193825.129BDF80227@alsa1.perex.cz>
Date: Tue,  3 Dec 2019 20:38:25 +0100 (CET)
Subject: [alsa-devel] Build failure without alsa-topology
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-utils issue #33 was opened from ffontaine:

Commit c8fdd38c74de2e8b7b2b5a4576787d5e9b4ae807 breaks build of alsa-utils on buildroot because $(ALSA_TOPOLOGY_LIBS) is set to an empty value by https://github.com/alsa-project/alsa-lib/commits/master/utils/alsa.m4 if --enable-alsa-topology is not passed:
```
/home/br-user/autobuild/run/instance-0/output/host/bin/arm-linux-gnueabihf-gcc  -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -O2     -o alsatplg topology.o  -lasound -lm -ldl -lpthread
topology.o: In function `main':
topology.c:(.text.startup+0x184): undefined reference to `snd_tplg_new'
topology.c:(.text.startup+0x194): undefined reference to `snd_tplg_verbose'
topology.c:(.text.startup+0x1a4): undefined reference to `snd_tplg_build_file'
topology.c:(.text.startup+0x1b4): undefined reference to `snd_tplg_free'
topology.c:(.text.startup+0x218): undefined reference to `snd_tplg_free'
```

More information can be found here: http://autobuild.buildroot.org/results/d0f/d0fb760669b02b813115af04adcf24530d35f4e1/build-end.log

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/33
Repository URL: https://github.com/alsa-project/alsa-utils
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
