Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16166C54EBD
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Jan 2023 14:21:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E9FDB98B;
	Mon,  9 Jan 2023 15:20:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E9FDB98B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673274092;
	bh=XnTtyqBr0ltgIFHRcHPLDcB6R5wc8LyXvcP+agBY2p8=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=PYVJdtgNkrUEcIWK9jJsmxj7H7eTI8Alhek1YvAPzjKVHgAwlJrrgiXTzoms8CvJi
	 y5X7H21UEd43t7SKCKojEkYLcTi8ahJwNoEpr2cDflqssIMMcw5dL2hMj5eIyxtDBE
	 ieZ6WDRyZJkdKz+yypPx/PAHEk2hXrMsObKZxdog=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F4DDF802BE;
	Mon,  9 Jan 2023 15:20:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7D9ECF8030F; Mon,  9 Jan 2023 15:20:40 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F959F800C7
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2023 15:20:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F959F800C7
Authentication-Results: alsa1.perex.cz; dkim=pass (1024-bit key,
 secure) header.d=perex.cz header.i=@perex.cz header.a=rsa-sha256
 header.s=default header.b=JMGL/zCe
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 900FBA0040;
 Mon,  9 Jan 2023 15:20:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 900FBA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1673274037; bh=FeXGv93VfD0caihlk1l39zUzZ2YZLQ1o92V77UhKLP4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JMGL/zCeEEZYWTQ8GJOyhuQo9tbua/+QvJCb83OUr2iqy4o4mCt2jMgjlflLNZVEn
 SfRNeTsNWhGYKuXydRuitqwgBHvgH89lRHD1ig8zc9HzcgZZn+EVpZQbsif+b4loNu
 pjdyiU92TKzzOM9jrO/BG1ipuEFtZd0PvRetibfI=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon,  9 Jan 2023 15:20:35 +0100 (CET)
Message-ID: <bd607e2f-66ee-8c8a-30b2-5c041ecc5bfd@perex.cz>
Date: Mon, 9 Jan 2023 15:20:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [bug report] ALSA: usb-audio: Add new quirk FIXED_RATE for JBL
 Quantum810 Wireless
Content-Language: en-US
To: Dan Carpenter <error27@gmail.com>
References: <Y7frf3N/xzvESEsN@kili>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <Y7frf3N/xzvESEsN@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 06. 01. 23 10:35, Dan Carpenter wrote:
> Hello Jaroslav Kysela,
> 
> The patch fd28941cff1c: "ALSA: usb-audio: Add new quirk FIXED_RATE
> for JBL Quantum810 Wireless" from Dec 15, 2022, leads to the
> following Smatch static checker warning:
> 
> 	sound/usb/pcm.c:543 snd_usb_hw_params()
> 	error: uninitialized symbol 'sync_fixed_rate'.

...

>      496         if (fmt->implicit_fb) {
>      497                 sync_fmt = snd_usb_find_implicit_fb_sync_format(chip, fmt,
>      498                                                                 hw_params,
>      499                                                                 !substream->stream,
>      500                                                                 &sync_fixed_rate);
> 
> "sync_fixed_rate" is uninitialized when we "Use the original audioformat
> as fallback for the shared altset" and find_matching_substream() returns
> NULL.

Thanks. The fix was sent:

https://lore.kernel.org/alsa-devel/20230109141133.335543-1-perex@perex.cz/

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
