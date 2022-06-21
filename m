Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C155C43334
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jun 2022 19:47:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 903FA1F81;
	Tue, 21 Jun 2022 21:46:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 903FA1F81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655840855;
	bh=7+toqgDIxSi69lrf5T+lzTXlN3kncjH7AH4bxBswcwQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sobmYZ2SbDOusR8zUik8j0Tl87FKjJwuvakumlzsYyeLewMuRuKahKWtYUaqgFOEw
	 PbgvQbf41ZAWW2D+Rie+MuRAc5Dhh52kj48YQccpRSqE6Qjm3RmnUlrQEfaesViAZ+
	 ilzSlyFlLBrjD2xnG5Jw5hFVleqdcIfU3xceg+2A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27225F80152;
	Tue, 21 Jun 2022 21:46:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45AA3F80155; Tue, 21 Jun 2022 21:46:39 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 94D67F80152
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2022 21:46:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94D67F80152
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1655840793220015049-webhooks-bot@alsa-project.org>
References: <1655840793220015049-webhooks-bot@alsa-project.org>
Subject: No sound on AMD audio device
Message-Id: <20220621194639.45AA3F80155@alsa1.perex.cz>
Date: Tue, 21 Jun 2022 21:46:39 +0200 (CEST)
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

alsa-project/alsa-lib issue #241 was edited from chvmq:

I have a laptop huawei 14 amd 2021

I don't know where write about it. maybe there

I tried ubuntu | arch-linux and no sound at all

![image](https://user-images.githubusercontent.com/60788249/174885007-8eb96062-3753-47b6-9880-5a45b57071ac.png)
![image](https://user-images.githubusercontent.com/60788249/174885044-42b8c5c2-6c64-46df-ade6-6f5c8388a972.png)
![image](https://user-images.githubusercontent.com/60788249/174885077-b13fc2a4-18cb-4f20-84a7-3c611ebbecc3.png)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/241
Repository URL: https://github.com/alsa-project/alsa-lib
