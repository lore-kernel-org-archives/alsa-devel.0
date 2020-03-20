Return-Path: <SRS0=HX6w=5I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0ACC4332B
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:50:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064832074D
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XGONMA3M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbnB4www"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064832074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 286611664;
	Mon, 23 Mar 2020 14:49:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 286611664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584971411;
	bh=9ncUxRvHf0FPXNscLgmmsmMq2h5YMOZH6dHTjucibVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XGONMA3M+ZQMGYQ4/YwsO/+HA6+XFCinQXovYt2G/p6tb0w/A9d9k9SvQ4kWsXAqA
	 kR3nD8GiqBeHJiCqmCFJrL1b0/LXolorlQ6SZMVYU0CSHowHaxCqnmcvm7UjymgQZ7
	 6TSAQWZSpqRe096Yv5XQVtr2myy2hZnPTHpKawuA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E0C51F80268;
	Mon, 23 Mar 2020 14:47:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 47A5BF8015B; Fri, 20 Mar 2020 15:31:55 +0100 (CET)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EBE43F800DD
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 15:31:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBE43F800DD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="AbnB4www"
Received: by mail-pg1-x544.google.com with SMTP id k191so2015206pgc.13
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 07:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6c+JSVCxP0/exR74ChVM1yt+TIcfNUXUTN2EWov9Law=;
 b=AbnB4wwwyxJU822g6/gWFpEQ4P3sPvgEIZgPVxj0ueTSXGScHWIdqu8Bfum8A4f6/t
 2cDmx+mRDs0d1aBYc9kuZWhUGlZQopNmfAxvsBGjJ2W8LGR85UU6GLrxxvJOy3kJTSkt
 JE2nO9goUQjnpdlunQj2qxtw4FlMydNhnNhEBXWivBv1tMzUcJQVSsDGBYU36GYVMp8q
 bKTQBBUmTNmI+aPH3SFqG5lItDWQRccn1+Dg8YPYsBTJRjVLTIQ2IzJKGId0vHuwsZiT
 VE+EXhUwgiTuaSOm8mlyq4iFfyyT5oKb3cv24fO6Y63UPc6pY5TFkmuaGyR5BMx2pRpy
 uzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6c+JSVCxP0/exR74ChVM1yt+TIcfNUXUTN2EWov9Law=;
 b=ponX/IZAtY7Aolx7Xia5YS04MomIwdqmhoo6JptLh0HBK0I3miwSxZKKb5BFpLM1RW
 a02xILTeRcUPC2Y8pICRrTdpuKSxBofO2o2kOkdg/rpxKKhBBMU0Y17Z5nM2W68s59rr
 bw1AM9/vDI/auU4GV+LDAXC/P/SK22W1r5E52WOXpLgu5+hQUAMHn+OHk2H77yJJYEXI
 /HmYCyaxZS83WOaN+ZMJuHmkIYw8ydHipy6axgh9eXJZjQXhwGctalrKlwcwW3TL36uZ
 ADxsivs04cuhxrUI0yujFTU3ZZPz2t18EG5LbDtX/B3Kp8OAbxsocQ+4gnnK4GmzqOv/
 8WLg==
X-Gm-Message-State: ANhLgQ2XhD+ZrNBaqbAM/15zdVbRiK5arPDGYIfp8jdhPuDa4pKnN5jP
 HQw3BICjTkuG3hZE4Y9NwoncN20/pm5/GIj4PUA=
X-Google-Smtp-Source: ADFU+vup5g2RU5zzwiEF27K/7Facn+zu9j1qO5AF3IVfdl5lu3UZTrDLOmtE7bcC/STD/7WybqqCoP0QLrfa0c2hinA=
X-Received: by 2002:a63:798a:: with SMTP id u132mr9271382pgc.203.1584714709588; 
 Fri, 20 Mar 2020 07:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200320131345.635023594@linutronix.de>
In-Reply-To: <20200320131345.635023594@linutronix.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 20 Mar 2020 16:31:42 +0200
Message-ID: <CAHp75Vffg5jm5knwuAKwkDZ16=kDujT1LCpzGU8mUV9NrXkSag@mail.gmail.com>
Subject: Re: [patch 00/22] x86/treewide: Consolidate CPU match macro maze and
 get rid of C89 (sic!) initializers
To: Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 23 Mar 2020 14:47:37 +0100
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Amit Kucheria <amit.kucheria@verdurent.com>,
 Mark Gross <mgross@linux.intel.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org,
 Darren Hart <dvhart@infradead.org>, Zhang Rui <rui.zhang@intel.com>,
 Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Linux PM <linux-pm@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Takashi Iwai <tiwai@suse.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>,
 linux-crypto <linux-crypto@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Andy Shevchenko <andy@infradead.org>
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

On Fri, Mar 20, 2020 at 3:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The x86 CPU matching based on struct x86_cpu_id:
>
>   - is using an inconsistent macro mess with pointlessly duplicated and
>     slightly different local macros. Finding the places is an art as there
>     is no consistent name space at all.
>
>   - is still mostly based on C89 struct initializers which rely on the
>     ordering of the struct members. That's proliferated forever as every
>     new driver just copies the mess from some exising one.
>
> A recent offlist conversation about adding more match criteria to the CPU
> matching logic instead of creating yet another set of horrors, reminded me
> of a pile of scripts and patches which I hacked on a few years ago when I
> tried to add something to struct x86_cpu_id.
>
> That stuff was finally not needed and ended up in my ever growing todo list
> and collected dust and cobwebs, but (un)surprisingly enough most of it
> still worked out of the box. The copy & paste machinery still works as it
> did years ago.
>
> There are a few places which needed extra care due to new creative macros,
> new check combinations etc. and surprisingly ONE open coded proper C99
> initializer.
>
> It was reasonably simple to make it at least compile and pass a quick
> binary equivalence check.
>
> The result is a X86_MATCH prefix based set of macros which are reflecting
> the needs of the usage sites and shorten the base macro which takes all
> possible parameters (vendor, family, model, feature, data) and uses proper
> C99 initializers.
>
> So extensions of the match logic are trivial after that.
>

Thank you, Thomas!

Briefly looking to the code, I like the idea. I'll do (minor) comments
on individual patches.

I see it incorporates my previous attempts to extend this, but now it
looks better.

> The patch set is against Linus tree and has trivial conflicts against
> linux-next.
>
> The diffstat is:
>  71 files changed, 525 insertions(+), 472 deletions(-)
>
> but the extra lines are pretty much kernel-doc documentation which I added
> to each of the new macros. The usage sites diffstat is:
>
>  70 files changed, 393 insertions(+), 471 deletions(-)
>
> Thoughts?
>
> Thanks,
>
>         tglx
>
>


-- 
With Best Regards,
Andy Shevchenko
