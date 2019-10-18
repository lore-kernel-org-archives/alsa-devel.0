Return-Path: <SRS0=bEgE=YL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA69CA9EA9
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 20:40:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567382054F
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 20:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uDoDaEXi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DN5MEvFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567382054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BCDB984F;
	Fri, 18 Oct 2019 22:39:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BCDB984F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571431202;
	bh=//7VVA+oTHJAXKNrFeL60X5m6WxRJdbFjBO06lHIHOI=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uDoDaEXie5M1RvqHE7FsEZbINO7lqLH/ER3vQqKC3PgGpbfhBSIFdODmw/3ONv21l
	 /3i3adsWddQJC9/68azgI/3DUOMLibiOUNCcIkAV9UaFYfEw3IWbVHevA5KdUtk8dv
	 K6Vk6IkBEs7piT5QYHwg3sOi8Vk1smWJBrquMj5Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 512F4F800D0;
	Fri, 18 Oct 2019 22:39:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EC300F80362; Fri, 18 Oct 2019 22:39:10 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3EF60F800D0
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2019 22:39:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EF60F800D0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="DN5MEvFg"
Received: by mail-pl1-x644.google.com with SMTP id q24so3378418plr.13
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2019 13:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=sA9QYMiGhI7MttA/PLlqrtMzG0s83akjTEVC2Hk0Y0Y=;
 b=DN5MEvFgVMu4M4/XCLw9BRIhFBFz5/fxRslD8rf+iBz/h2hn6x8mBLdHOrnXuEO4cf
 vCZZ3UVlc1wh7a40ehAmlIXKkUx76Z/vfG+pIworaMVo9p1R2FuXCucWWS84hmof1jfX
 hBEPTm5IBCXfvNU9ZsmPS3MVRpbXxmym8TAwhZ7tHD9vtpbt99ui/Qb+DwxKB69ExLRQ
 S8dDorBNDNK51e8KQpVTnyU1cXa/9sijPaH20LMzhui9CVrfHwVpiDXjMsMciohHfbMu
 eHVms76z/2lQhmX9raIBDs5TQGc1rIGb2eMvJS1W8RDwF9Oe8fWetD//OkFfRZ9eV/2E
 boRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=sA9QYMiGhI7MttA/PLlqrtMzG0s83akjTEVC2Hk0Y0Y=;
 b=U/rXq4whU1aQ+Ol1YtRZnt4TYBq11p7LeGAquvGiuuhxYmTXfeaMKfG+pdNa5UF3tu
 0Em0XppWfIAiLSm8FSLDESrrUw9D9mmIFvufIqAXy8bpazGK32+X0P65yKJ4DyrImULB
 TUpvojJ9lf0pJFHql5uOjWn3WjBzEOu9D3s0HpJkN0vCrT8ZE+E8GMJ5wH/fq3zuYBKP
 nYBtF32LWdWg21N8+HwsJN5c1QE8VbIBaD48UHXojSYEO+OtqtgkrBSqMQMlL4zeMLRx
 GL4/66LtHaOv2qN7cUedU10oKkIZkjz65bFOe5bfQ02fG/E6H07P0v43NeMIus/ZkXIc
 z3Hg==
X-Gm-Message-State: APjAAAX0VX25XAGdhIL5Gu82X4bIiArgSL79pIEOEaZi3I6G0lpL/4ta
 txPPch6xSMn+CJcpAuw/e2A=
X-Google-Smtp-Source: APXvYqyIxdE8kbIPAupy1VRv2Z5sSpuL6L3+Lx1OQzb/YVFns+e38GVIZHMuR66stuh9mPN8FKSWQA==
X-Received: by 2002:a17:902:ff14:: with SMTP id
 f20mr1803901plj.216.1571431145094; 
 Fri, 18 Oct 2019 13:39:05 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
 by smtp.gmail.com with ESMTPSA id 196sm7859249pfz.99.2019.10.18.13.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 13:39:04 -0700 (PDT)
Date: Fri, 18 Oct 2019 13:39:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191018203902.GQ35946@dtor-ws>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-29-arnd@arndb.de>
 <20191018184815.GP35946@dtor-ws>
 <CAK8P3a27==9TeS-RWEvrpnxh+6McqRF-xeb8WPj9pHOn+0zbOQ@mail.gmail.com>
 <CAK8P3a0AP8q9Hk1DB+E=xFGV5RqXnkjkcZRobgU1NRDFMH00AA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a0AP8q9Hk1DB+E=xFGV5RqXnkjkcZRobgU1NRDFMH00AA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>,
 "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] Fwd: [PATCH 29/46] Input: touchscreen: use wrapper
 for pxa2xx ac97 registers
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

On Fri, Oct 18, 2019 at 09:39:31PM +0200, Arnd Bergmann wrote:
> On Fri, Oct 18, 2019 at 8:48 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Fri, Oct 18, 2019 at 05:41:44PM +0200, Arnd Bergmann wrote:
> > > To avoid a dependency on the pxa platform header files with
> > > hardcoded registers, change the driver to call a wrapper
> > > in the pxa2xx-ac97-lib that encapsulates all the other
> > > ac97 stuff.
> >
> > Not supper happy about adding module dependencies. Can we include
> > mach/regs-ac97.h from include/sound/pxa2xx-lib.h and use static inlines?
> > Someone needs to include mach/regs-ac97.h in the end...
> >
> > Or there is something later in the series that needs it?
> 
> One of the goals of the series is to completely remove all mach/*.h headers
> and place them somewhere else, ideally inaccessible to device drivers.
> 
> In case of mach/regs-ac97.h, the later patch "ASoC: pxa: ac97: use normal
> MMIO accessors" passes the physical register base address as a platform
> device resource that gets ioremapped in the ac97 driver, rather than
> hardcoding the virtual address in a global header.
> 
> I agree that the exported function is still ugly, but I hope it's enough of
> an improvement over the previous state that we can do it anyway.
> 
> If you have any better ideas though, I can give that a try, too.
> One possibility would be a higher-level interface exported on top
> of 'struct snd_ac97', but I could not figure out how to do this.

No, I do mot really have better ideas given your stated goals and I
guess there is not really much benefit on spending too much effort
polishing essentially one driver.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
