Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EBFC433EF
	for <alsa-devel@archiver.kernel.org>; Sat,  1 Jan 2022 17:01:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C457B18BE;
	Sat,  1 Jan 2022 18:00:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C457B18BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641056492;
	bh=fG5AG83tIrWTMWMEiuWifcHlkpaQZEepadlWb9QRNlc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=my+jVbPBZKTGZw6xhR0mms9Sb4jtuSGTLyFaVHLtATTaZyEfhcN3XvATu+QB3MoFj
	 U/mFM8rJp4T2vm+IErQLkOfgg5jQS181p/yTYEJOexrC9NDt9djWkxrSJqsBWN5iLY
	 qnxF4HNgmBeMAFlwsMrMK9A+6OthF+A0IUTP+hCE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B331F80109;
	Sat,  1 Jan 2022 18:00:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4CCB1F800C0; Sat,  1 Jan 2022 18:00:41 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 084C0F800C0
 for <alsa-devel@alsa-project.org>; Sat,  1 Jan 2022 18:00:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 084C0F800C0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1641056433545911074-webhooks-bot@alsa-project.org>
References: <1641056433545911074-webhooks-bot@alsa-project.org>
Subject: src/topology/parser.c: drop duplicate safe_strtol_base
Message-Id: <20220101170041.4CCB1F800C0@alsa1.perex.cz>
Date: Sat,  1 Jan 2022 18:00:41 +0100 (CET)
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

alsa-project/alsa-lib pull request #208 was opened from ffontaine:

`safe_strtol_base` is defined twice since https://github.com/alsa-project/alsa-lib/commit/f547b2e35f71e89397e8b29cd0b9083bb68b00a6 and https://github.com/alsa-project/alsa-lib/commit/5fab157a593180525607b7d26263bee127f6be36 resulting in the following build failure when alsa-utils is built statically:

```
checking for snd_tplg_new in -latopology... no
configure: error: No linkable libatopology was found.

```
because `safe_strtol_base` is defined twice:

```
configure:7776: checking for snd_tplg_new in -latopology
configure:7801: /home/buildroot/autobuild/instance-2/output-1/host/bin/arm-linux-gcc -o conftest -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -Os -g0  -static -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -static conftest.c -latopology  -lasound  -lasound -lm  -lpthread  >&5
/home/buildroot/autobuild/instance-2/output-1/host/opt/ext-toolchain/bin/../lib/gcc/arm-buildroot-linux-uclibcgnueabi/9.3.0/../../../../arm-buildroot-linux-uclibcgnueabi/bin/ld: /home/buildroot/autobuild/instance-2/output-1/host/arm-buildroot-linux-uclibcgnueabi/sysroot/usr/lib/libasound.a(conf.o): in function `safe_strtol_base':
conf.c:(.text+0x1600): multiple definition of `safe_strtol_base'; /home/buildroot/autobuild/instance-2/output-1/host/arm-buildroot-linux-uclibcgnueabi/sysroot/usr/lib/libatopology.a(parser.o):parser.c:(.text+0x130): first defined here
```

Fixes:
 - http://autobuild.buildroot.org/results/08d028004090b2a8292f03910cb9bf80a73ac804

Request URL   : https://github.com/alsa-project/alsa-lib/pull/208
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/208.patch
Repository URL: https://github.com/alsa-project/alsa-lib
