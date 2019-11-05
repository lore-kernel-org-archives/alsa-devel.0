Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E858C010A2
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 12:14:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ACC7222C4
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 12:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SaGLeRpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACC7222C4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD98216BB;
	Tue,  5 Nov 2019 13:13:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD98216BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572956060;
	bh=ub7XexSWzwOcrjXMqM6QE3QYe/joikyHpCUQcBve/xk=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SaGLeRpwgHEpRsQTz3J2y9G6dUkp4xmF3xkU+FbamruiMqNQSObfp3ideJuoQjEX9
	 HLg+1mAMnkKfCr+OF/GMxQuoD4XIMkKjlKynmkjaAlGjBSxqOex+mkIg+cdGzioFoh
	 ER+lKro8KWfjlWmmJkhFJ387OrTQuz+UD6OD3U3Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74C7FF80446;
	Tue,  5 Nov 2019 13:13:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04A6AF8049B; Tue,  5 Nov 2019 13:13:29 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 95053F8015B
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 13:13:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95053F8015B
MIME-Version: 1.0
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1572956005914402962-webhooks-bot@alsa-project.org>
References: <1572956005914402962-webhooks-bot@alsa-project.org>
Message-Id: <20191105121329.04A6AF8049B@alsa1.perex.cz>
Date: Tue,  5 Nov 2019 13:13:29 +0100 (CET)
Subject: [alsa-devel] amixer: "5%-" or "5%+" doesn't work with cset
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

alsa-project/alsa-utils issue #32 was opened from MarioMey:

I want to raise and low volume with keys. This works, this rise the volume 20%:

`amixer set Master 20%+`

And every time I run this command, it rise 20% more. But, when I want to use the card (because I need to do this):

`amixer -c 0 cset name='Master Playback Volume' 20%+`

It doesn't work. It seems that amixer takes only "20%" value and doesn't care about "+" or "-".

I have Debian Buster, Mate desktop.

```
mario@debian:~/$ apt-cache showpkg alsa-tools
Package: alsa-tools
Versions: 
1.1.7-1 (/var/lib/apt/lists/ftp.us.debian.org_debian_dists_buster_main_binary-amd64_Packages)
 Description Language: 
                 File: /var/lib/apt/lists/ftp.us.debian.org_debian_dists_buster_main_binary-amd64_Packages
                  MD5: 4d64eace7e51fb1fc1a18ed780ee5e62
 Description Language: en
                 File: /var/lib/apt/lists/ftp.us.debian.org_debian_dists_buster_main_i18n_Translation-en
                  MD5: 4d64eace7e51fb1fc1a18ed780ee5e62


Reverse Depends: 
  ld10k1,alsa-tools
  multimedia-jack,alsa-tools
Dependencies: 
1.1.7-1 - libasound2 (2 1.0.16) libc6 (2 2.7) libgcc1 (2 1:3.0) libglib2.0-0 (2 2.12.0) libstdc++6 (2 5) as10k1 (0 (null)) as10k1 (0 (null)) 
Provides: 
1.1.7-1 - as10k1 (= ) 
Reverse Provides: 

```

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/32
Repository URL: https://github.com/alsa-project/alsa-utils
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
