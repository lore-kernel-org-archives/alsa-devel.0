Return-Path: <SRS0=Vkr5=LK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED861C48BE5
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 09:31:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F736611CA
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 09:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F736611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E5E01671;
	Wed, 16 Jun 2021 11:30:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E5E01671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623835878;
	bh=nrfbYjfulZoAPaUf06R8qWjrWQRQRK0shPKxqFHChZ8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u+vOemadbmrxafBbFU841oV9TAyKyB5tDmWN7aec0a9bMugNQSMoSTqLtGtetPcD+
	 dx98a/yxOYaW34HEJfKpkIgtvwUU8IxOwKldx0PqbgBctvmfMndvvnCu6fpgj2Yg9Q
	 SQWL+mSD0Ofl9o9J/9vT2YdwS/7Q3UORBRNPNtZg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE70AF8028B;
	Wed, 16 Jun 2021 11:30:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11C56F80423; Wed, 16 Jun 2021 11:30:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF541F8028B
 for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2021 11:30:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF541F8028B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="xudoE7cL"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59F67611CA;
 Wed, 16 Jun 2021 09:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1623835814;
 bh=nrfbYjfulZoAPaUf06R8qWjrWQRQRK0shPKxqFHChZ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xudoE7cLEMoRRo8mEPJY4STJdULAnwguMtuX0NnvGBLS1tcFa+wPRebbUhss7HUbw
 d0XrmG+sDITKRKitnXl2DpdsxQUjL5LzAQQMT0iukeVWr9xsQNmnGZGPPWItIJzMbs
 x5zyIwgdrISLtZXL8+poI0pkDG3M1ZNtmiRRfJpY=
Date: Wed, 16 Jun 2021 11:30:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daehwan Jung <dh10.jung@samsung.com>
Subject: Re: ALSA: usb-audio: Fix rate on Ozone Z90 USB headset
Message-ID: <YMnEo73bQt+mvEXn@kroah.com>
References: <CGME20210616091516epcas2p2111c9b941d0e60fb0a6ae9646fb80d26@epcas2p2.samsung.com>
 <1623834063-108482-1-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623834063-108482-1-git-send-email-dh10.jung@samsung.com>
Cc: Lukasz Halman <lukasz.halman@gmail.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Johan Hovold <johan@kernel.org>,
 linux-kernel@vger.kernel.org
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

On Wed, Jun 16, 2021 at 06:01:01PM +0900, Daehwan Jung wrote:
> It mislabels its 96 kHz altsetting and that's why it causes some noise
> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  sound/usb/format.c | 2 ++
>  1 file changed, 2 insertions(+)

I am not the sound/usb/ maintainer, so I do not know why you sent this
"To:" me.

Also, can you resend and add a cc: stable to the signed-off-by: area to
let this get backported properly?

thanks,

greg k-h
