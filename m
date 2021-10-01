Return-Path: <SRS0=FVIg=OV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927B7C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Oct 2021 08:55:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087E861A81
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Oct 2021 08:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 087E861A81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E823016CC;
	Fri,  1 Oct 2021 10:54:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E823016CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633078515;
	bh=o2HB66C3g4SzXN8zqp4zMkYQK6CIGBScoZD0qgX0XH8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gagecRvzYuJwi9CVcGpE41HGN6PQ3j5f6QfsdFvhMRZj+sSID/bavEsltRHz2UcC2
	 zoHV05ExSi4veur+TlyN6lr7s1LFO6WVs+hm0wVAHfCbL9K4oTLtmat3Cy/Ds5Kerv
	 EIzyy0Mn0SBSqIRgDZKgBnF14+iwD3gaORF7O424=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63B6EF80227;
	Fri,  1 Oct 2021 10:54:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72D7CF800F3; Fri,  1 Oct 2021 10:54:21 +0200 (CEST)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F4E5F800F3
 for <alsa-devel@alsa-project.org>; Fri,  1 Oct 2021 10:54:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F4E5F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com
 header.b="e1YK3l7a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1633078455;
 x=1664614455; h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=BYMzdOXdW8poC8ZYU2YOj/H9iLW7aISPiVVJ6ze7PwU=;
 b=e1YK3l7at5VZzVJkBSdlEm1QQKbDD3SvqGXLes9aqrVYRU433H+B0vhX
 N8tnKb8EkAjfX4D4SiuJaIUtxdgvGpJCEbuUPcWQB3cd8jNfJcbMWckVF
 ujZZkbug9eMD50ihOkpMJVTE8fngh+Sat8Ljn9KhpAcKCFUzgKxdxdJWQ
 O8sj76ry2LyRK25IL1VhBJ2yLSE6UF4UzbN3TLLmqIF6j/QcyRX5Chdja
 rcmJ1A4mXmGHmNWRx1H1qzCZsCfGe2SyzaJcnho/qQA6v5dFomarsSxPI
 39oP3Rylibbk/vqLgZeDsO1qvaTq0PkS4EKreE5oNFctxpl1UjEPkYoI8 g==;
Date: Fri, 1 Oct 2021 10:54:07 +0200
From: Ricard Wanderlof <ricardw@axis.com>
X-X-Sender: ricardw@lnxricardw1.se.axis.com
To: Ruben Safir <ruben@mrbrklyn.com>
Subject: Re: ALSA kernel projects - for academic purposes
In-Reply-To: <20210929150052.GB15841@www2.mrbrklyn.com>
Message-ID: <alpine.DEB.2.21.2110011046540.20945@lnxricardw1.se.axis.com>
References: <CAHhAz+i=3NDuxK2rZZY6N18=OTbkna3VMVpx4nNgF0vyq3JmQA@mail.gmail.com>
 <324112.1632501120@turing-police>
 <CAHhAz+jNCd=cw-bohcoiAA2UhNZYSFLX07qEV-T2p+KAsVHhAQ@mail.gmail.com>
 <CAJfuBxxAEXnPxY-nx4JEe+fzH7J+nLYzD9zLCSzgjViBHsQbPA@mail.gmail.com>
 <20210929150052.GB15841@www2.mrbrklyn.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail08w.axis.com (10.20.40.14) To se-mail07w.axis.com
 (10.20.40.13)
Cc: Muni Sekhar <munisekharrms@gmail.com>,
 alsa-devel <alsa-devel@alsa-project.org>,
 =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
 kernelnewbies <kernelnewbies@kernelnewbies.org>,
 "jim.cromie@gmail.com" <jim.cromie@gmail.com>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
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


On Wed, 29 Sep 2021, Ruben Safir wrote:

> > also, theres now pipewire, which is new, and all the buzz.
> > its apparently the future of linux audio
>
> BTW - we hear the BS every month, and yet, ALSA is still here and the
> backbone of Linux sound...

PipeWire is not really a replacement for ALSA, if by ALSA mean the Linux 
kernel audio subsystem, as it still needs to access audio hardware via 
ALSA kernel drivers.

If we include alsa-lib in ALSA, then, with proper configuration, not 
really out of the box, PipeWire can replace the plugin hierarchy that is 
normally set up in /etc/asound.conf etc.

But PipeWire is purely userspace, and is really more of a replacement for 
JACK and PulseAudio at the same time. It does seem to be the future in the 
sense that although it's still in development, it's here now, and it works 
out of the box at least in some distributions.

/Ricard
-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
