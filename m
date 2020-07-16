Return-Path: <SRS0=vkql=A4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AACFC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 07:08:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B659220734
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 07:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KnvRlpdz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fr2pMUFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B659220734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4EAAA1662;
	Fri, 17 Jul 2020 09:07:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4EAAA1662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594969678;
	bh=/bOMJnWG5VQvFMqIENinQwhAfZNzwA4R0tJTK48dzEc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KnvRlpdzrVYsH2ZdbbjPJ4qcMczpDI2o/DIwVKfQ5+jDcEzl8fOnCKgmUkkiMaxql
	 S4TMTp1qv8kVNXDU6+vT2eIDf3CHpS9NK8bHbxLTLuwPJt28a14ywvSMN6t3iq01pH
	 N9NXUGz1CjSPZZRUEneJ8HcvWfjcCeR6tdvjQ6dk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2960FF802E1;
	Fri, 17 Jul 2020 09:05:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 413CBF801EC; Thu, 16 Jul 2020 21:41:54 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0D60F8014C
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 21:41:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0D60F8014C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="Fr2pMUFu"
Received: by mail-pj1-x1043.google.com with SMTP id f16so5164066pjt.0
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3gOxjYioleYNPMJFOYuFriXJ1YWGB4fcC91h6vBo3AM=;
 b=Fr2pMUFudxKVbymBQqlGxui5jPhioRVxbJPrydkQ5elV1iKym/58d4sNFYGtty3uRp
 ppQt1KX9e/iTFclG5XD8YE50MucJPCYqheHk4WCaco8MBAvjPQqzFnbKFDy8R/MWo2Hy
 sg4MwHJ75FbB5KhjWajQt52DC+O4j6U0z5B7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3gOxjYioleYNPMJFOYuFriXJ1YWGB4fcC91h6vBo3AM=;
 b=kwHA+wqPi3Btaavy5+/kRsKCFRxmT4aZ/RnuUxKUbJUrqCNXtQHKINIhh7jlE91PVa
 Ibc/g8csxW00JoVt0oq81vmASi8ecOMtdyMAlS/2xTbbQgt6dHAlm9Ayj1ME4bchQ2zK
 OMUklfHDEvdN62R6B/JcDzBnCGsj1OfjJ8UUKDhb9JCBRJX8xtL4bX7mowmkcmm5+PZP
 XeIgqLWVVOhH42MXGar/5euQi29ZQ0UXzr5vdC19fyq09G1hFhejLtTqetEyAsnvLQjF
 05wENlmAqE1CpE+ysK07SduhiKlk1n8pnungLidxT9QoScRdDma604P5GFP/BBKzdrh+
 QCXA==
X-Gm-Message-State: AOAM531yIZPpXIAhMMXrKX13LWTZHrCGsbyg9JjUa5E/vlMkI4RRmXlV
 BLlJ6mjYOHRPuGsU/X7A7LOLng==
X-Google-Smtp-Source: ABdhPJxOpv1P54xTLFHMOCkbV36YgtJta4Xy1e3mGKWxQZVIYwZy7MSHr7Sn/WN5zPxdQ5Dy/Lrr9w==
X-Received: by 2002:a17:902:b60e:: with SMTP id
 b14mr4854255pls.81.1594928500423; 
 Thu, 16 Jul 2020 12:41:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id j13sm754883pjz.8.2020.07.16.12.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 12:41:39 -0700 (PDT)
Date: Thu, 16 Jul 2020 12:41:38 -0700
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] usb: gadget: udc: Avoid tasklet passing a global
Message-ID: <202007161240.B58F7FE@keescook>
References: <20200716030847.1564131-1-keescook@chromium.org>
 <20200716030847.1564131-2-keescook@chromium.org>
 <20200716072823.GA971895@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716072823.GA971895@kroah.com>
X-Mailman-Approved-At: Fri, 17 Jul 2020 09:05:03 +0200
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>, Oscar Carter <oscar.carter@gmx.com>,
 Mitchell Blank Jr <mitch@sfgoth.com>, kernel-hardening@lists.openwall.com,
 Peter Zijlstra <peterz@infradead.org>, kgdb-bugreport@lists.sourceforge.net,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Christian Gromm <christian.gromm@microchip.com>,
 Kevin Curtis <kevin.curtis@farsite.co.uk>, Will Deacon <will@kernel.org>,
 devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
 Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Masahiro Yamada <masahiroy@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Julian Wiedmann <jwi@linux.ibm.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Nishka Dasgupta <nishkadg.linux@gmail.com>, Jiri Slaby <jslaby@suse.com>,
 Jakub Kicinski <kuba@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Wambui Karuga <wambui.karugax@gmail.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, linux-input@vger.kernel.org,
 Ursula Braun <ubraun@linux.ibm.com>, Stephen Boyd <swboyd@chromium.org>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <balbi@kernel.org>,
 Kyungtae Kim <kt0755@gmail.com>, netdev@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Allen Pais <allen.lkml@gmail.com>,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 Jason Wessel <jason.wessel@windriver.com>,
 Karsten Graul <kgraul@linux.ibm.com>, Romain Perier <romain.perier@gmail.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Thu, Jul 16, 2020 at 09:28:23AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 15, 2020 at 08:08:45PM -0700, Kees Cook wrote:
> > There's no reason for the tasklet callback to set an argument since it
> > always uses a global. Instead, use the global directly, in preparation
> > for converting the tasklet subsystem to modern callback conventions.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/usb/gadget/udc/snps_udc_core.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/snps_udc_core.c b/drivers/usb/gadget/udc/snps_udc_core.c
> > index 3fcded31405a..afdd28f332ce 100644
> > --- a/drivers/usb/gadget/udc/snps_udc_core.c
> > +++ b/drivers/usb/gadget/udc/snps_udc_core.c
> > @@ -96,9 +96,7 @@ static int stop_pollstall_timer;
> >  static DECLARE_COMPLETION(on_pollstall_exit);
> >  
> >  /* tasklet for usb disconnect */
> > -static DECLARE_TASKLET(disconnect_tasklet, udc_tasklet_disconnect,
> > -		(unsigned long) &udc);
> > -
> > +static DECLARE_TASKLET(disconnect_tasklet, udc_tasklet_disconnect, 0);
> >  
> >  /* endpoint names used for print */
> >  static const char ep0_string[] = "ep0in";
> > @@ -1661,7 +1659,7 @@ static void usb_disconnect(struct udc *dev)
> >  /* Tasklet for disconnect to be outside of interrupt context */
> >  static void udc_tasklet_disconnect(unsigned long par)
> >  {
> > -	struct udc *dev = (struct udc *)(*((struct udc **) par));
> > +	struct udc *dev = udc;
> >  	u32 tmp;
> >  
> >  	DBG(dev, "Tasklet disconnect\n");
> 
> Feel free to just take this in your tree, no need to wait for the USB
> stuff to land.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Okay, thanks! I'll carry this series for v5.9, unless I hear otherwise
from Thomas. :)

-- 
Kees Cook
