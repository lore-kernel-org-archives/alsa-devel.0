Return-Path: <SRS0=SelE=A3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5ADC433E3
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:41:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318442076D
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="elTQ96GJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ci71ZpD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318442076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A1AAD84A;
	Thu, 16 Jul 2020 17:40:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A1AAD84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594914069;
	bh=SYcdFaf5HdYrp6/CLmW/0Fkwx9KixuSorUJatgNzvIA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=elTQ96GJ0ouWcV1f0+oAefEPw+Jb4IIdfXV4A3dYu81PGRKRQlYbxA7kFHlvvct0R
	 QKt23QLh/gH0WrK4jUdnMVS+s//9Pzp0/xtxM26fTfH39/gBw+p1HhSh5nGRfx3cDW
	 u3c00KrYxdyXOGCTDFwxtvpaOLVFB1nJBxW4UWc8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30EA4F8014E;
	Thu, 16 Jul 2020 17:40:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6876CF801EC; Thu, 16 Jul 2020 09:28:38 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B1EFF8014C
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 09:28:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B1EFF8014C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Ci71ZpD5"
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B91CC206C1;
 Thu, 16 Jul 2020 07:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594884509;
 bh=SYcdFaf5HdYrp6/CLmW/0Fkwx9KixuSorUJatgNzvIA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ci71ZpD5S3+QhU/29ZLHmt6sx6CHBBFOvDFGEc8Idi+NVP4ztq8BTut8v79F9OD0a
 UNWgcmqvc5YkyJIBSmdbiNaQ0EhtbhDfD/Du94wgViUkTHqT2jJuQZITVXgcpgrtnT
 5bChNpquKrkCX06aKWC/AAixLbvSh2ng4sGsm3aI=
Date: Thu, 16 Jul 2020 09:28:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/3] usb: gadget: udc: Avoid tasklet passing a global
Message-ID: <20200716072823.GA971895@kroah.com>
References: <20200716030847.1564131-1-keescook@chromium.org>
 <20200716030847.1564131-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716030847.1564131-2-keescook@chromium.org>
X-Mailman-Approved-At: Thu, 16 Jul 2020 17:40:14 +0200
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

On Wed, Jul 15, 2020 at 08:08:45PM -0700, Kees Cook wrote:
> There's no reason for the tasklet callback to set an argument since it
> always uses a global. Instead, use the global directly, in preparation
> for converting the tasklet subsystem to modern callback conventions.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/usb/gadget/udc/snps_udc_core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/snps_udc_core.c b/drivers/usb/gadget/udc/snps_udc_core.c
> index 3fcded31405a..afdd28f332ce 100644
> --- a/drivers/usb/gadget/udc/snps_udc_core.c
> +++ b/drivers/usb/gadget/udc/snps_udc_core.c
> @@ -96,9 +96,7 @@ static int stop_pollstall_timer;
>  static DECLARE_COMPLETION(on_pollstall_exit);
>  
>  /* tasklet for usb disconnect */
> -static DECLARE_TASKLET(disconnect_tasklet, udc_tasklet_disconnect,
> -		(unsigned long) &udc);
> -
> +static DECLARE_TASKLET(disconnect_tasklet, udc_tasklet_disconnect, 0);
>  
>  /* endpoint names used for print */
>  static const char ep0_string[] = "ep0in";
> @@ -1661,7 +1659,7 @@ static void usb_disconnect(struct udc *dev)
>  /* Tasklet for disconnect to be outside of interrupt context */
>  static void udc_tasklet_disconnect(unsigned long par)
>  {
> -	struct udc *dev = (struct udc *)(*((struct udc **) par));
> +	struct udc *dev = udc;
>  	u32 tmp;
>  
>  	DBG(dev, "Tasklet disconnect\n");

Feel free to just take this in your tree, no need to wait for the USB
stuff to land.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
