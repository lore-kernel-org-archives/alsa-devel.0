Return-Path: <SRS0=Fseo=P4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA1BC433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 06:58:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F0C61151
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 06:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 49F0C61151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A90F1167E;
	Tue,  9 Nov 2021 07:57:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A90F1167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636441127;
	bh=M58R6z8lSnGhZfNCfeB6TvClmOoyOVejsl9xoWPOXEo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Duq/qQ/mV9gOgzwiHWMX56CLqfvI6WOpBg9EMyZmkpMbXm6jGpWgWNtxfQyoOfC8S
	 t3PG3D5NGczM72X+Eu2IHn4biiaWtzankeittsEitB72ZVv3FyQFyuUvQVo12kfcvW
	 OERJkvqcdeWi/WkXatAxrMG+mrymNwl4DOCI0YWw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E38EDF801D8;
	Tue,  9 Nov 2021 07:57:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E45DEF8049E; Mon,  8 Nov 2021 17:21:55 +0100 (CET)
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD422F801D8
 for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2021 17:21:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD422F801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de
 header.b="PwrrR1/9"
Received: from zn.tnic (p200300ec2f331100181cb4ce2fe9e1de.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f33:1100:181c:b4ce:2fe9:e1de])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 071501EC0503;
 Mon,  8 Nov 2021 17:21:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1636388511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=BmhP/O36y2kgWhY9wVesOsCT3VZHRN0l2HSALpf1H38=;
 b=PwrrR1/9r0PtkEkx8l94Lq5o8cthN3NxILevAwj1LoIRoN/B58W84rM+iyPPtwIBmVMRtG
 8jlUd2DAmGqQe7+sK0xny6az8RzdndQG0jeU2pdwyReIQXuaywQhQg+JKE/uRG6ku5v9jN
 K5y81X7+5Pp2iJVW5AZDozV+KOdqQTY=
Date: Mon, 8 Nov 2021 17:21:45 +0100
From: Borislav Petkov <bp@alien8.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v0 42/42] notifier: Return an error when callback is
 already registered
Message-ID: <YYlOmd0AeA8DSluD@zn.tnic>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-43-bp@alien8.de>
 <CAMuHMdWH+txiSP_d7Jc4f_bU8Lf9iWpT4E3o5o7BJr-YdA6-VA@mail.gmail.com>
 <YYkyUEqcsOwQMb1S@zn.tnic>
 <CAMuHMdXiBEQyEXJagSfpH44hxVA2t0sDH7B7YubLGHrb2MJLLA@mail.gmail.com>
 <YYlJQYLiIrhjwOmT@zn.tnic>
 <CAMuHMdXHikGrmUzuq0WG5JRHUUE=5zsaVCTF+e4TiHpM5tc5kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdXHikGrmUzuq0WG5JRHUUE=5zsaVCTF+e4TiHpM5tc5kA@mail.gmail.com>
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

On Mon, Nov 08, 2021 at 05:12:16PM +0100, Geert Uytterhoeven wrote:
> Returning void is the other extreme ;-)
> 
> There are 3 levels (ignoring BUG_ON()/panic () inside the callee):
>   1. Return void: no one can check success or failure,
>   2. Return an error code: up to the caller to decide,
>   3. Return a __must_check error code: every caller must check.
> 
> I'm in favor of 2, as there are several places where it cannot fail.

Makes sense to me. I'll do that in the next iteration.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
