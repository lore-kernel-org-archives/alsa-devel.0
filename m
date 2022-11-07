Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A983DC433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Nov 2022 16:42:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFA6C100;
	Mon,  7 Nov 2022 17:41:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFA6C100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667839324;
	bh=rV0FEWDWEX3pw5xk/P6Od1hD9YTelKAB+AEHNXGucGw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uc1N9kN1cC9kM7jl3AsXtky+3KuL5q28wvb2lF53y8ApwvGvOJz4V5ns11e41BIlD
	 yRHY2O2LhiMJ3eIdcHYJVx8rU1l5GW66gvhlC5awkl/EPsngQwAuV/2WyhqJDjRHve
	 3F+0CTni8lrRWO+BU0vZ4wZbyyPlzQTvvL8VR9ZU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90FD5F8024C;
	Mon,  7 Nov 2022 17:41:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AAB2CF8025A; Mon,  7 Nov 2022 17:41:11 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 294B9F800AE
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2022 17:41:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 294B9F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="1kLSFg96"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2C650611C2;
 Mon,  7 Nov 2022 16:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A72FC433C1;
 Mon,  7 Nov 2022 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1667839261;
 bh=rV0FEWDWEX3pw5xk/P6Od1hD9YTelKAB+AEHNXGucGw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1kLSFg96R6WxIT17jCcSOuD/8/wkolVtUWEQLk7do6PfaB0tcc8Z/ROW20FqiK0sw
 f2obEh4jVYXdqaw0uJVhOCpE622woq5+3NfNZgYoKNEwrsGTwQgMiZrVeTrceqhG2h
 uiuxY1uV/hm6jjzPPcaE4Mykre3OyPJ5gJspyUqA=
Date: Mon, 7 Nov 2022 17:40:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: John Veness <john-linux@pelago.org.uk>
Subject: Re: [PATCH] ALSA: usb-audio: Add quirks for MacroSilicon
 MS2100/MS2106 devices (4.9-5.4)
Message-ID: <Y2k1GvrY8WrX/g4+@kroah.com>
References: <20221107160536.27565-1-john-linux@pelago.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107160536.27565-1-john-linux@pelago.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 stable@vger.kernel.org
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

On Mon, Nov 07, 2022 at 04:05:36PM +0000, John Veness wrote:
> commit 6e2c9105e0b743c92a157389d40f00b81bdd09fe upstream.
> 
> Treat the claimed 96kHz 1ch in the descriptors as 48kHz 2ch, so that
> the audio stream doesn't sound mono. Also fix initial stream
> alignment, so that left and right channels are in the correct order.
> 
> Signed-off-by: John Veness <john-linux@pelago.org.uk>
> Link: https://lore.kernel.org/r/20220624140757.28758-1-john-linux@pelago.org.uk
> Cc: <stable@vger.kernel.org> # 5.4
> Cc: <stable@vger.kernel.org> # 4.19
> Cc: <stable@vger.kernel.org> # 4.14
> Cc: <stable@vger.kernel.org> # 4.9
> 
> ---
> Backported to 4.9-5.4.

Now queued up, thanks.

greg k-h
