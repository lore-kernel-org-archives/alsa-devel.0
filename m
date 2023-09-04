Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6A3C71153
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Sep 2023 02:11:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD1E2832;
	Mon,  4 Sep 2023 04:10:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD1E2832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693793479;
	bh=uk0peNdroEHun7AF5ycrtiWzAYSQmUhfWuXhBHcs4eY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=emC/dUIBB97gzBvknN0MpoP7CUlcTeR6SnbBn6wjNzR6fVSIO25fY3SiXM4bd19zU
	 cOp05UvTMunzfKFbmfi9oKyFEGFTSAl//Wu8cmoNyLHSeMS/C8OEVe1d7Uxg/YBtzg
	 ZUSvUGmHmcX+hoqcgcrnlhe7oe1c0bWxKHYtA91I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C3C9F80558; Mon,  4 Sep 2023 04:10:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 122F9F80558;
	Mon,  4 Sep 2023 04:10:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ADD66F80558; Mon,  4 Sep 2023 04:10:24 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 83A4FF80141
	for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2023 04:10:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83A4FF80141
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1693793413935459614-webhooks-bot@alsa-project.org>
References: <1693793413935459614-webhooks-bot@alsa-project.org>
Subject: Alsa Lib segfaults when built statically
Message-Id: <20230904021024.ADD66F80558@alsa1.perex.cz>
Date: Mon,  4 Sep 2023 04:10:24 +0200 (CEST)
Message-ID-Hash: GMIQBGC3LJW2M3SI5COOGOWBJ4PQG6FT
X-Message-ID-Hash: GMIQBGC3LJW2M3SI5COOGOWBJ4PQG6FT
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GMIQBGC3LJW2M3SI5COOGOWBJ4PQG6FT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #349 was edited from cybersoulK:

I am building a game that uses alsa. All of my linux players segfault. This has been going for over 1 year.
Alsa-lib is built statically on a ubuntu machine with the following commands:

```
git clone https://github.com/alsa-project/alsa-lib
cd alsa-lib

apt-get update
apt-get install libtool
apt-get install make
apt install autoconf

autoreconf -i
./configure --disable-shared
make
```

Then i use libasound.a to build my Rust executable (On my mac machine).

I do the same process to build openssl for linux and it works great.


So There definitely is an issue when building alsa lib statically.

One of my players was able to provide me with a core dump that might be helpful to track the fault:

<img width="770" alt="image" src="https://github.com/alsa-project/alsa-lib/assets/102260392/7390b851-47a1-4e50-a33b-e33254dddabc">

[coredump.txt](https://github.com/alsa-project/alsa-lib/files/12508784/coredump.txt)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/349
Repository URL: https://github.com/alsa-project/alsa-lib
