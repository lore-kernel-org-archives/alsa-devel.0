Return-Path: <SRS0=Vkr5=LK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38D8C48BE5
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 10:31:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261376101B
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 10:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261376101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 442E8166F;
	Wed, 16 Jun 2021 12:30:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 442E8166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623839500;
	bh=mqqLnnrtOe1x+IQER3v/M1RZ1eEvzy87JkFegkes+cc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rn6P95C2+vxevbxVvURK5pXtD+/fmVYuY+BfYm1UveIfMQXR1d9hpTl6IIa2CzRyE
	 2XvveonPpD8sovKVCtLnGnxagddyaxkKeO54U9Fb3lr9SraatqxtpQ8A8HZRkGCiDj
	 LYprvtUQUZ6nBAahO44qs8ZuLyuP8rB4HSRo0VGw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3179F802E8;
	Wed, 16 Jun 2021 12:30:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DAE3F80423; Wed, 16 Jun 2021 12:30:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71644F8028B
 for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2021 12:30:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71644F8028B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="OnWsBphA"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D3F460FE6;
 Wed, 16 Jun 2021 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1623839432;
 bh=mqqLnnrtOe1x+IQER3v/M1RZ1eEvzy87JkFegkes+cc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OnWsBphAHVb2rg/ju/6Hmsj9CKJESH5L8S3YyKZMowlYIITokBtAacamo6ne6B4RJ
 xkyDkVC44/qaGqBTWAXtH/TaV1e/lcQ7RNlplQvYzisJOz4p/Dw9LrtsbDA8TOBvmH
 UBpffBaFYiJKlt50hNCdpZBmpU/RzF4RFEi/LMWg=
Date: Wed, 16 Jun 2021 12:30:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daehwan Jung <dh10.jung@samsung.com>
Subject: Re: ALSA: usb-audio: fix rate on Ozone Z90 USB headset
Message-ID: <YMnSxQx15C8xAq98@kroah.com>
References: <CGME20210616094912epcas2p38028df32b89b7cc79ba16c0215f8f664@epcas2p3.samsung.com>
 <1623836097-61918-1-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623836097-61918-1-git-send-email-dh10.jung@samsung.com>
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

On Wed, Jun 16, 2021 at 06:34:55PM +0900, Daehwan Jung wrote:
> It mislabels its 96 kHz altsetting and that's why it causes some noise
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I don't care about this.  But the stable tree probably does, please
read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

thanks,

greg k-h
