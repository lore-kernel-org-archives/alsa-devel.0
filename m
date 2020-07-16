Return-Path: <SRS0=SelE=A3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6265AC433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:44:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A2A20787
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sfrLWLhp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cRbax8BT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A2A20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7111F1612;
	Thu, 16 Jul 2020 17:43:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7111F1612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594914267;
	bh=nHKrOWYpvdxK07LHx7ls938wZIzyqSgiFTZfS9n5LaQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sfrLWLhpUy10W8Grpd3v7lfZz9+gDKoF5FVKCzzC/7raZJumfhDPbUx+LKqhPsvkV
	 6FpA+31gOy0wURWMgy7rZD5OyCZ2DLj2vkTufH88EfmrQuFX2XTTG4lol6oAjyx34I
	 l+sP+nw1t1XymSCh4TIrIHiUYuHeHKmn2+L4Un8k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D73EDF802E0;
	Thu, 16 Jul 2020 17:40:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52A24F801EC; Thu, 16 Jul 2020 13:31:46 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2CAADF8014E
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 13:31:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2CAADF8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="cRbax8BT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=kCBscy4ICmY9v1gZK6PYqPDzXfgn2dK6Smw6OZ6pwbU=; b=cRbax8BTeNpQ2tEZPMz++wHfoA
 YY9T8+65ROJBAdBZ7H8FzaY/KSeuSeoYlwNsCGmLP8mDevULQFXYgV781OyBKYpkpkWeq0Slxsu41
 EVIi5ybC98tuKjfgKsxKaDjZbeJDht1Recazoo7KeQuuxBxH+4aXVOmjx2RPn95gB5VEUNiMr4J3k
 MXflrKeV66Kc8r72b7/yQBgRCpSetCin1QZz9VjOlZsGG1eKVdFOyiJOEYD/MF3uEup1kOMDFOlI1
 j+MqVHQuoR5capmxrlF8mTZDWBljT+SXL6D8dERmtywfxxQfBTKjZFrNsVs4CnAkuWWd9HVhR0HuD
 wYPT/vcw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jw24g-0001wq-AS; Thu, 16 Jul 2020 11:29:14 +0000
Date: Thu, 16 Jul 2020 12:29:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 2/3] treewide: Replace DECLARE_TASKLET() with
 DECLARE_TASKLET_OLD()
Message-ID: <20200716112914.GK12769@casper.infradead.org>
References: <20200716030847.1564131-1-keescook@chromium.org>
 <20200716030847.1564131-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716030847.1564131-3-keescook@chromium.org>
X-Mailman-Approved-At: Thu, 16 Jul 2020 17:40:15 +0200
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Oscar Carter <oscar.carter@gmx.com>, Mitchell Blank Jr <mitch@sfgoth.com>,
 kernel-hardening@lists.openwall.com, Peter Zijlstra <peterz@infradead.org>,
 kgdb-bugreport@lists.sourceforge.net,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, alsa-devel@alsa-project.org,
 Allen Pais <allen.lkml@gmail.com>, netdev@vger.kernel.org,
 Christian Gromm <christian.gromm@microchip.com>, Will Deacon <will@kernel.org>,
 devel@driverdev.osuosl.org, Jonathan Corbet <corbet@lwn.net>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 "David S. Miller" <davem@davemloft.net>,
 Masahiro Yamada <masahiroy@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Julian Wiedmann <jwi@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Nishka Dasgupta <nishkadg.linux@gmail.com>, Jiri Slaby <jslaby@suse.com>,
 Jakub Kicinski <kuba@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Wambui Karuga <wambui.karugax@gmail.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 Heiko Carstens <hca@linux.ibm.com>, linux-input@vger.kernel.org,
 Ursula Braun <ubraun@linux.ibm.com>, Stephen Boyd <swboyd@chromium.org>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <balbi@kernel.org>,
 Kyungtae Kim <kt0755@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Douglas Anderson <dianders@chromium.org>,
 Kevin Curtis <kevin.curtis@farsite.co.uk>, linux-usb@vger.kernel.org,
 Jason Wessel <jason.wessel@windriver.com>,
 Romain Perier <romain.perier@gmail.com>, Karsten Graul <kgraul@linux.ibm.com>
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

On Wed, Jul 15, 2020 at 08:08:46PM -0700, Kees Cook wrote:
> This converts all the existing DECLARE_TASKLET() (and ...DISABLED)
> macros with DECLARE_TASKLET_OLD() in preparation for refactoring the
> tasklet callback type. All existing DECLARE_TASKLET() users had a "0"
> data argument, it has been removed here as well.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
[...]
>  16 files changed, 26 insertions(+), 21 deletions(-)

This is about 5% of what needs to change.  There are 350 callers of
tasklet_init(), and that still takes a 'data' argument.
