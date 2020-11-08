Return-Path: <SRS0=lJrV=EO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E427CC388F2
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:12:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A864B206ED
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fKbCY+CE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1qbwCiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A864B206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0950315F2;
	Sun,  8 Nov 2020 10:11:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0950315F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604826765;
	bh=nDNxAtrBPS2tDV2KcZN06hO/zTzru/CpsYng1FbwwRw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fKbCY+CE/XZBN240/98LioMmvdooUWvMiye4AoFrVK8SmpQRqPF17AatTEA17Yds8
	 jE10szTQz5P8EPCM/kYQ4PIHc2XQG/Kc1HUg1QjX4AEfUifLSE9ZLI0AV6P2HjNJ7y
	 bXy/Lm0LdB4ioyLJ8bjM1FOSJ8mfhD6QIjdheyVY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 82C6DF800BE;
	Sun,  8 Nov 2020 10:11:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF174F801D5; Sun,  8 Nov 2020 10:11:50 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C71A3F800BE
 for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2020 10:11:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C71A3F800BE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="W1qbwCiw"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 985A0206E3;
 Sun,  8 Nov 2020 09:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604826700;
 bh=nDNxAtrBPS2tDV2KcZN06hO/zTzru/CpsYng1FbwwRw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W1qbwCiwryQXHg0VNixMzP7l5h1ADzhIGn40eIMUumw3En1K8pt93yb3GQ87A5Swy
 27/2khEHlFy+RXWyMPxycBUr0GfK97xa5irjI1x3vAYOwJZHrlVLgzwVMfxZeIDwAq
 nJBBK5U6xJgzJ9XcVvwqeJ/SdUchnxitX/qz3+H0=
Date: Sun, 8 Nov 2020 10:11:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Atul <leoatul12@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix coding style problems
Message-ID: <20201108091136.GA44749@kroah.com>
References: <20201108083515.5256-1-leoatul12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108083515.5256-1-leoatul12@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com
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

On Sun, Nov 08, 2020 at 02:05:16PM +0530, Atul wrote:
> From: Atul Gopinathan <leoatul12@gmail.com>
> 
> Hi,

No need for this to be in the changelog.

> 
> This patch fixes some coding style warnings and errors that were
> generated using scripts/checkpatch.pl.

You should be explicit about _what_ warnings and errors.  And probably
break them out into individual patches, one per warning/error type.

But more importantly, always run your patch through checkpatch.pl when
you are done, as you just _ADDED_ warnings to the kernel with this
change:

> @@ -895,9 +896,10 @@ static int snd_usb_nativeinstruments_boot_quirk(struct usb_device *dev)
>  	usb_reset_device(dev);
>  
>  	/* return -EAGAIN, so the creation of an audio interface for this
> -	 * temporary device is aborted. The device will reconnect with a
> -	 * new product ID */
> -	return -EAGAIN;
> +     * temporary device is aborted. The device will reconnect with a
> +     * new product ID
> +     */
> +    return -EAGAIN;
>  }
>  
>  static void mbox2_setup_48_24_magic(struct usb_device *dev)

You turned tabs into spaces, not allowed, sorry.

If you want to do basic checkpatch cleanups, try starting in the
drivers/staging/ area of the kernel, which is much more forgiving and
set up just for this type of thing, instead of trying to do this in the
"core" kernel portions, where you have to deal with other real code
changing happening at the same time.

good luck!

greg k-h
