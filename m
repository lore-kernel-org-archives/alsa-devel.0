Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EC3C2BA1A
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:20:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 805FD20724
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RzAHHAco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805FD20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2E4216A1;
	Fri, 24 Apr 2020 11:19:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2E4216A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587720031;
	bh=NQi76UET0+2KjWHyouJq0LD5wbhFXBMYjW9q6xHFQLI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RzAHHAcoU1d7fHSHmbPQXDMQr2rFAsSoipxFrZ5xFrgSrUGOJl4+yumVC0zEiUcBi
	 wqzsW2dUyMqkPmWkredFRe3R5QZHmmwzxmYKUwbcl/T0OMXHSYbuxIQXs+AAMm33hk
	 tJfFtOfy9zvP3kUTavApHT+9KCWPCPu3U+r4q1y0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F0DFF80121;
	Fri, 24 Apr 2020 11:19:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F96AF80142; Fri, 24 Apr 2020 11:19:40 +0200 (CEST)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43339F800BE
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 11:19:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43339F800BE
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id 4D613A1F2BCEB;
 Fri, 24 Apr 2020 11:19:32 +0200 (CEST)
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id llDg2Xjk1p1J; Fri, 24 Apr 2020 11:19:26 +0200 (CEST)
Received: from [192.168.105.191] (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id 9A144A1F2A44D;
 Fri, 24 Apr 2020 11:19:26 +0200 (CEST)
Subject: Re: [PATCH 1/2] ALSA: usb-audio: Improve frames size computation
To: Alexander Tsoy <alexander@tsoy.me>, alsa-devel@alsa-project.org
References: <20200424022449.14972-1-alexander@tsoy.me>
From: Pavel Hofman <pavel.hofman@ivitera.com>
Message-ID: <11dca14b-39a7-635a-a62f-ea10f21aa697@ivitera.com>
Date: Fri, 24 Apr 2020 11:19:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200424022449.14972-1-alexander@tsoy.me>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>, Gregor Pintar <grpintar@gmail.com>,
 Roope Salmi <rpsalmi@gmail.com>
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


Dne 24. 04. 20 v 4:24 Alexander Tsoy napsal(a):
> For computation of the the next frame size current value of fs/fps and
> accumulated fractional parts of fs/fps are used, where values are stored
> in Q16.16 format. This is quite natural for computing frame size for
> asynchronous endpoints driven by explicit feedback, since in this case
> fs/fps is a value provided by the feedback endpoint and it's already in
> the Q format. If an error is accumulated over time, the device can
> adjust fs/fps value to prevent buffer overruns/underruns.
> 
> But for synchronous endpoints the accuracy provided by these computations
> is not enough. Due to accumulated error the driver periodically produces
> frames with incorrect size (+/- 1 audio sample).
> 
> This patch fixes this issue by implementing a different algorithm for
> frame size computation. It is based on accumulating of the remainders
> from division fs/fps and it doesn't accumulate errors over time. This
> new method is enabled for synchronous and adaptive playback endpoints.
> 
> Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
> ---
>  sound/usb/card.h     |  4 ++++
>  sound/usb/endpoint.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>  sound/usb/endpoint.h |  1 +
>  sound/usb/pcm.c      |  2 ++
>  4 files changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/usb/card.h b/sound/usb/card.h
> index 395403a2d33f..820e564656ed 100644
> --- a/sound/usb/card.h
> +++ b/sound/usb/card.h
> @@ -84,6 +84,10 @@ struct snd_usb_endpoint {
>  	dma_addr_t sync_dma;		/* DMA address of syncbuf */
>  
>  	unsigned int pipe;		/* the data i/o pipe */
> +	unsigned int framesize[2];	/* small/large frame sizes in samples */
> +	unsigned int sample_rem;	/* remainder from division fs/fps */
> +	unsigned int sample_accum;	/* sample accumulator */
> +	unsigned int fps;		/* frames per second */
>  	unsigned int freqn;		/* nominal sampling rate in fs/fps in Q16.16 format */
>  	unsigned int freqm;		/* momentary sampling rate in fs/fps in Q16.16 format */
>  	int	   freqshift;		/* how much to shift the feedback value to get Q16.16 */
> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
> index 4a9a2f6ef5a4..d8dc7cb56d43 100644
> --- a/sound/usb/endpoint.c
> +++ b/sound/usb/endpoint.c
> @@ -124,12 +124,12 @@ int snd_usb_endpoint_implicit_feedback_sink(struct snd_usb_endpoint *ep)
>  
>  /*
>   * For streaming based on information derived from sync endpoints,
> - * prepare_outbound_urb_sizes() will call next_packet_size() to
> + * prepare_outbound_urb_sizes() will call slave_next_packet_size() to
>   * determine the number of samples to be sent in the next packet.

Please should not this read

"For streaming based on information derived from async endpoints,"

or

"For streaming based on information derived from sync-master endpoints,"?

Because the next method says:

For adaptive and synchronous endpoints, prepare_outbound_urb_sizes()...

Thanks for the great patch,

Pavel.
