Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98984C61DCB
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:40:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0B6C601FF;
	Fri, 28 Aug 2026 18:40:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0B6C601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787935238;
	bh=AHqgwRydb7WYhcRaysaN3+P+4YYOXTKI9kxwbffzPkU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Ti0dDhyc8D+XV1HcJoG/9Uq+ufLvVVPPTSgTYXuiUk8RM1nKNPTvSCkxwYgtc1DTU
	 BXt1fRCZAqmCTUyj0PSAUKkCSl1otuwhF/toeQaHfKQURpT4VSxcgREqeoJtg/e0Rp
	 sFnloIuXkhOKF54R/XenfdCIb08JSdPgfemWeT5A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B852F80601; Fri, 28 Aug 2026 18:40:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 13ED3F80601;
	Fri, 28 Aug 2026 18:40:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA3BAF8055C; Fri, 28 Aug 2026 18:39:56 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787935195;
	b=SuPSfM8mwlR0sJc7ciYLmzsZ/nKqxjkdkAVqN32rH/bPBBcfgmlWjY0z9nQrdNDc9Ael
	 esX4kSt4FlslHoPLuGLBgSkjbcgU4tvYhdbke71E9C8WAeW9QxU629+Z09mW/twPJQOhi
	 YXRwqklVHEe8wzDsKteRe64NKL7hkyxqadXD+Stpk98HLOwayByn5kz3W5WCdOWdG+UfM
	 FepodlAUiyuucd2XoIUIJCA8wKDS3OQKXhIKA246Ae/qkhbsMWjyLq/M/HlVY+sqYWasF
	 h0y/NtS/SdLpugO4tXC4vxcgpC7wFQaGpsYx6r/UoPNnScJWFBjxujhfoCfAiwtBEWw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787935195;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=AHqgwRydb7WYhcRaysaN3+P+4YYOXTKI9kxwbffzPkU=;
	b=UlaVx0TiYdwPYi8RxdR2fYr31+4TS++vuDTU20X/3t3PfuL0+TBVg2hpVh0DE9990i94
	 qyZYWGCKaDIVwkyD3lKyPsd8pRg9dOvEI0NktoyFjQG0tEv5UhRIlpsh9iN2jsQ5VVRsv
	 zjX9j2z99Pj2lQD+lFYVZ50sGMJGaDei78E81iMzPpQADp1rWmoJi+1/2bcicwSJmXq/F
	 LSBQ9rczJceMFpX5fYXSwsY/9Pty6pRvwu/KfU2UCxtOmn+mRuWhP2zw+bB0cAkjZJKVt
	 0BDGT+/VUDPaxSEBH1271K2ra0OvxB/JvMdXDFIfxXogAfnUswTsZrixRCQGYWk1aPg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id CE8D3F800FA
	for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2026 18:39:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE8D3F800FA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d00595a73abf00-webhooks-bot@alsa-project.org>
In-Reply-To: <18d00595a7166c00-webhooks-bot@alsa-project.org>
References: <18d00595a7166c00-webhooks-bot@alsa-project.org>
Subject: alsamixer: segfault in display_controls()
Date: Fri, 28 Aug 2026 18:39:56 +0200 (CEST)
Message-ID-Hash: XMBKGYN6JRGCNLOBIVWQ6HL5W32M5WRB
X-Message-ID-Hash: XMBKGYN6JRGCNLOBIVWQ6HL5W32M5WRB
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XMBKGYN6JRGCNLOBIVWQ6HL5W32M5WRB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #335 was opened from fenugrec:

I think I know what sequence triggers this.

*** steps to reproduce
1-  connect a device that has no Capture controls (unclear if this is the crucial difference). Here this is a Presonus Studio 1824c
2- run alsamixer; F6 to select that Card
3- Go the Capture view (F4)
4- arrow right
5- go to All view (F5) -> segfault


*** backtrace
```
#0  display_control (control_index=0xffffffff) at /usr/src/debug/alsa-utils/alsa-utils-1.2.16/alsamixer/mixer_display.c:421
        control = 0x55855558ff60
        col = 0x0
        i = <optimized out>
        c = <optimized out>
        left = 0x2
        frame_left = 0xb
        bar_height = <optimized out>
        volumes = {0, 6.9531436082559572e-310}
        switches = {0x0, 0x0}
        index = 0x555a0710
        s = <optimized out>
        buf = "\360\030_UUU\000\000\003\000\000\000UU", '\000' <repeats 11 times>, "\230z\021\003\000\000\000\b\000\000\000\a\000\000\000\003\000\000\000UU\000\000\2352VUUU\000\000\2462VUUU\000"
        err = <optimized out>
#1  display_controls () at /usr/src/debug/alsa-utils/alsa-utils-1.2.16/alsamixer/mixer_display.c:674
        i = 0x0
#2  0x00005555555585dc in mainloop () at /usr/src/debug/alsa-utils/alsa-utils-1.2.16/alsamixer/mainloop.c:146
        pollfds = 0x55555560e790
        nfds = 0x2
        n = <optimized out>
        active_widget = 0x5555555676e0 <mixer_widget>
        revents = 0x1
        key = <optimized out>
        err = <optimized out>
#3  main (argc=<optimized out>, argv=<optimized out>) at /usr/src/debug/alsa-utils/alsa-utils-1.2.16/alsamixer/cli.c:176
No locals.
```

The problem is the argument `control_index=0xffffffff` which comes from display_controls() around lines 660-670 ; in this debug run (after the segfault) I observe the following values

```
(gdb) p first_visible_control_index
$1 = 0xffffffff
(gdb) p controls_count
$2 = 0x5
(gdb) p visible_controls
$3 = 0x5
(gdb) p focus_control_index
$4 = 0x0
```

not sure why `first_visible_control_index` has that value...

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/335
Repository URL: https://github.com/alsa-project/alsa-utils
