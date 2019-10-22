Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086D6CA9EA0
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:15:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0584C20700
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aITYDt7X";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="x6tiKJE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0584C20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0235E1607;
	Tue, 22 Oct 2019 16:14:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0235E1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571753747;
	bh=UffJCjwxosE2yJ4Eix4LAVRGyGDFqJ50lkEFWTBbZEA=;
	h=References:From:To:In-reply-to:Date:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aITYDt7Xvo6uzLrQrmcLro6uVRltO2CTXdcIA/TOniFBM0rlVUPsB3K4QF2NWC518
	 HGzbw3+3fuULvGRzktZgBvf8dJkZIoV1J0ba5h+1PIQ8fLfhGU8AH7Ym/bPRSiifMA
	 hoHyFi7mAjr+aSzlxvBIneq7xkduzxYB/sbw+V0w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 708EFF802FB;
	Tue, 22 Oct 2019 16:14:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6B70F8031A; Tue, 22 Oct 2019 16:14:54 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D6B1F800C0
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 16:14:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D6B1F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="x6tiKJE+"
Received: by mail-wr1-x443.google.com with SMTP id n15so7475141wrw.13
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version;
 bh=av9Lmdhi8HEzunJvmg7m5eskrFelzv+meUwkZppXraQ=;
 b=x6tiKJE++7mD1b6Oe/mqVgUoHvEcblk4mnGKKA09p9vow8GyRyQJiDplWBbL2SaiSf
 /58yiYgNP+ArFyMlRYtPBSFWa5YayyvP7TKjr7KZ2eDcN5AlbLFQQsx45mcdA8ZnAMqR
 b3bDP+Dz8K7oa3l/HAamV+szrW7Glz4lrDc0zjKVr/2ZHbfA2txPvU24HlWqiasefooN
 zmNP3ffp9z+M2bq1BrcxM1xJLRSoGA36U/0vn7L1mb6YvYqwaEeDwwlwNb1No7+hUVp6
 4MDgWeu1ON3j6FeDhg8C+9GY4BG4vAgQQ/sqDZExogx/9I4AeIRfc9DqQ6/fJcALI2X8
 H20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=av9Lmdhi8HEzunJvmg7m5eskrFelzv+meUwkZppXraQ=;
 b=A+9QyD+VAf1Czl+QOlesyc479YSgBbGEHFEeh2opVCO3SwlS/inEtiCk2iGuMFovU/
 TIAQ6vpeEi/vi+qnRO0sGfy5ozVM6Wfa5mEdcNh/o7UDE9szAuGcmW3p5JjEAXWcDFsE
 ctTupUTipvNqWkm7xWEDobEfbTXSCaMfvhEbrWsftcKUH/tFkEZeVUvpY4ntYkeOznXM
 ZDhJk8++/61w8Ycc9+K5T/0TI3PvVilqJm0P0OhUnzB4bPOcuA+p501TdLd7mP2vgjWE
 ROxpu/12CGB/RRhcqW6bPp/vVyvbH5W8dQYL+4z1F7fU4KMtcJh7DWQ3EXN4apCGFGe0
 cBjQ==
X-Gm-Message-State: APjAAAWsBjCv/3m+pbB+tPGInF0TN4k/DvpvHR71TqH91lEtzWBT0WHT
 VeILV/ruWeynK67ouhwl0oq8iw==
X-Google-Smtp-Source: APXvYqz/tkq/qI3xQPMDaWURZP3hE9uVUHEeq+EnpFyHQXuOOjtw7A7jqEBhzq9D2mkH0+Vf5xSP2Q==
X-Received: by 2002:a5d:4612:: with SMTP id t18mr3561417wrq.255.1571753690930; 
 Tue, 22 Oct 2019 07:14:50 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id o15sm953973wrv.76.2019.10.22.07.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 07:14:50 -0700 (PDT)
References: <20191022135702.GU25745@shell.armlinux.org.uk>
User-agent: mu4e 1.3.3; emacs 26.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 Mark Brown <broonie@kernel.org>
In-reply-to: <20191022135702.GU25745@shell.armlinux.org.uk>
Date: Tue, 22 Oct 2019 16:14:49 +0200
Message-ID: <1jpnioc1eu.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [REGRESSION 5.3] WARNING: pulseaudio/1297 still
	has locks held!
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


On Tue 22 Oct 2019 at 15:57, Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:

> When upgrading from 5.2 to 5.3, I now encounter this error after boot:
>
> ====================================
> WARNING: pulseaudio/1297 still has locks held!
> 5.3.0+ #1826 Not tainted
> ------------------------------------
> 1 lock held by pulseaudio/1297:
>  #0: ee815308 (&hcp->lock){....}, at: hdmi_codec_startup+0x20/0x130
>
> stack backtrace:
> CPU: 0 PID: 1297 Comm: pulseaudio Not tainted 5.3.0+ #1826
> Hardware name: Marvell Dove (Cubox)
> [<c0017b4c>] (unwind_backtrace) from [<c0014d10>] (show_stack+0x10/0x14)
> [<c0014d10>] (show_stack) from [<c00a2d18>] (futex_wait_queue_me+0x13c/0x19c)
> [<c00a2d18>] (futex_wait_queue_me) from [<c00a3630>] (futex_wait+0x184/0x24c)
> [<c00a3630>] (futex_wait) from [<c00a5e1c>] (do_futex+0x334/0x598)
> [<c00a5e1c>] (do_futex) from [<c00a62e8>] (sys_futex_time32+0x118/0x180)
> [<c00a62e8>] (sys_futex_time32) from [<c0009000>] (ret_fast_syscall+0x0/0x54)
> Exception stack(0xebd31fa8 to 0xebd31ff0)
> 1fa0:                   00000000 ffffffff 000c8748 00000189 00000001 00000000
> 1fc0: 00000000 ffffffff 00000000 000000f0 00000000 00000000 00000000 00056200
> 1fe0: 000000f0 beac03a8 b6d6c835 b6d6f456
>
> This seems to be caused by:
>
>   eb1ecadb7f67 ("ASoC: hdmi-codec: re-introduce mutex locking")
>
> which holds a mutex and returns to userspace.  Meanwhile, userspace
> issues a futex operation, which ends up in futex_wait_queue_me().
>
> futex_wait_queue_me() can wait, and if the system will be hibernating,
> is a potential hibernation point.  One of the requirements there is
> that no locks shall be held, and the freezer code verifies that by
> calling debug_check_no_locks_held().  With lockdep enabled, it reveals
> that hdmi-codec is indeed holding a lock.
>
> Reverting this commit solves the problem.

Hi Mark,

Just before this patch, I had reworked the hdmi-codec to use an atomic
variable to track if the codec is busy. This was done to solve some
other locking issue.

When you asked me to move back to a mutex, I have probably been a bit
brutal about it. The mutex is indeed held as long as the mutex is busy,
on purpose.

AFAIK, the revert is safe. We can keep the codec this way if it is ok
with you. IMO, it is simpler that way

I can also submit a follow-up to use a mutex in a safer/cleaner way (mutex
+ busy flag) if you prefer.

Let me know how you wish to proceed.
Regards

Jerome
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
