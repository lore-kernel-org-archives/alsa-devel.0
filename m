Return-Path: <SRS0=Fseo=P4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E0AC433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 06:58:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145AA61159
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 06:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 145AA61159
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E71484D;
	Tue,  9 Nov 2021 07:57:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E71484D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636441119;
	bh=oeo1PSu+lSLdhrm7Pz+G8io/MKP55D+vex8RJtX/2YE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l2HNLKTT5R8UICYkvb1gIArHMhwINs9xIRQFuqrsA4DE8cNKcJ2B8KBQWxzpaRxt6
	 ECHw7+YL4KtWSlkTJUNsudssm6j204/JRNgtlIWHFVRoDadW/GDuVL8H+Y6keoiJ2v
	 PtpFTbkJkMAzTgUIvegnWBH6uwB73FyqPk+gGLsY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 237ECF802E3;
	Tue,  9 Nov 2021 07:57:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6272F8049E; Mon,  8 Nov 2021 17:12:36 +0100 (CET)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7E80F801D8
 for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2021 17:12:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7E80F801D8
Received: by mail-vk1-f169.google.com with SMTP id n201so8489212vkn.12
 for <alsa-devel@alsa-project.org>; Mon, 08 Nov 2021 08:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hEQQmRj7LTpJogPgt2xRVOX7N+txus6iMmGepIZghfU=;
 b=Hb1C4/jDe0bZwKz9Yv5+DU0l/+7FbBNLNQqlU69VQQYJ0KIh+lJcshhzrMHn5nMbPo
 9KXpfjlxcA7hmF3JMowg/ECikbWJSP2JNXqXWrYI10dXjAcT8ct/RZrUqo4kYTxAKX3U
 5NBgLtb2nti31HVt0B23KYr46BZ070kw1msisIz4zvZ4izrDVnWpsJfrZDeRoJUFCNRO
 TYq0H1DGQiCeckHKoTMs6zSGbAxwWZAUtM5a+6Kr1ODWuc2Rafz8PEI2rPjaSqp3y88A
 r6uI3xDORF+yieVvmsi4JOFmPTzgl7w9xaHiU9RPuJ2nNAtdCpiLV+UEbtg4wiKxUlh0
 p2og==
X-Gm-Message-State: AOAM533z7SoeOail9IAm92mKCyL7w7HoO/pK168cnWIQP4GyJgFdfgHD
 ZRmdU9Eyg+h67ti+RqhnbHDK8QkhL4W/6Ooa
X-Google-Smtp-Source: ABdhPJwZ1T/0ep/gtUbWOfFY1PX4m5jGjq4gxOUZuDNSlWnoq6lAZf6fHo2hbQPRGba4iUs6x7/8AA==
X-Received: by 2002:a05:6122:130d:: with SMTP id
 e13mr15528382vkp.6.1636387948847; 
 Mon, 08 Nov 2021 08:12:28 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com.
 [209.85.221.170])
 by smtp.gmail.com with ESMTPSA id d16sm1575435vko.29.2021.11.08.08.12.27
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Nov 2021 08:12:27 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id bc10so8483957vkb.1
 for <alsa-devel@alsa-project.org>; Mon, 08 Nov 2021 08:12:27 -0800 (PST)
X-Received: by 2002:a1f:f24f:: with SMTP id q76mr347755vkh.11.1636387947335;
 Mon, 08 Nov 2021 08:12:27 -0800 (PST)
MIME-Version: 1.0
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-43-bp@alien8.de>
 <CAMuHMdWH+txiSP_d7Jc4f_bU8Lf9iWpT4E3o5o7BJr-YdA6-VA@mail.gmail.com>
 <YYkyUEqcsOwQMb1S@zn.tnic>
 <CAMuHMdXiBEQyEXJagSfpH44hxVA2t0sDH7B7YubLGHrb2MJLLA@mail.gmail.com>
 <YYlJQYLiIrhjwOmT@zn.tnic>
In-Reply-To: <YYlJQYLiIrhjwOmT@zn.tnic>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Nov 2021 17:12:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXHikGrmUzuq0WG5JRHUUE=5zsaVCTF+e4TiHpM5tc5kA@mail.gmail.com>
Message-ID: <CAMuHMdXHikGrmUzuq0WG5JRHUUE=5zsaVCTF+e4TiHpM5tc5kA@mail.gmail.com>
Subject: Re: [PATCH v0 42/42] notifier: Return an error when callback is
 already registered
To: Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 09 Nov 2021 07:57:03 +0100
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>, linux-iio@vger.kernel.org,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, linux-hyperv@vger.kernel.org,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>, Ayush Sawal <ayush.sawal@chelsio.com>,
 sparclinux <sparclinux@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
 linux-leds <linux-leds@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>,
 Rohit Maheshwari <rohitm@chelsio.com>, linux-staging@lists.linux.dev,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 openipmi-developer@lists.sourceforge.net, xen-devel@lists.xenproject.org,
 "open list:TENSILICA XTENSA PORT \(xtensa\)" <linux-xtensa@linux-xtensa.org>,
 Arnd Bergmann <arnd@arndb.de>, Linux PM list <linux-pm@vger.kernel.org>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
 linux-um <linux-um@lists.infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 rcu@vger.kernel.org,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 linux-tegra <linux-tegra@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, intel-gvt-dev@lists.freedesktop.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-edac@vger.kernel.org,
 Parisc List <linux-parisc@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

Hi Borislav,

On Mon, Nov 8, 2021 at 4:59 PM Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Nov 08, 2021 at 04:25:47PM +0100, Geert Uytterhoeven wrote:
> > I'm not against returning proper errors codes.  I'm against forcing
> > callers to check things that cannot fail and to add individual error
> > printing to each and every caller.
>
> If you're against checking things at the callers, then the registration
> function should be void. IOW, those APIs are not optimally designed atm.

Returning void is the other extreme ;-)

There are 3 levels (ignoring BUG_ON()/panic () inside the callee):
  1. Return void: no one can check success or failure,
  2. Return an error code: up to the caller to decide,
  3. Return a __must_check error code: every caller must check.

I'm in favor of 2, as there are several places where it cannot fail.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
