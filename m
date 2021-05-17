Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC8FC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 08:02:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8251B61285
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 08:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8251B61285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF42F166E;
	Tue, 18 May 2021 10:01:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF42F166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621324922;
	bh=Gxr/z//2XIUPZNNo5l6CXDAUJ3KXPYypKG2fuPEgcFo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mc2FwuXNtItwQCgZz+XlbHKytVLWb5mMtDD4WWrJlfo6H+ZO85XD34G7x+Kl84VBb
	 F/rdCnOSgeVYc3oO4oiF0EWBlZn3CWp3ewooPG54ZPezdlTV9LaYy+nNjajmulXxSW
	 HeN+1FEhpejrM+NBlvlHjw6o+HndAOB818rHz3co=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F405F80424;
	Tue, 18 May 2021 10:00:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 762E6F8020B; Mon, 17 May 2021 16:48:25 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 236E1F80169
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 16:48:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 236E1F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="WVotFD6K"
Received: by mail-pj1-x1034.google.com with SMTP id gm21so3797578pjb.5
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=kdeSQM6n6ehpxt42Ss8k8UZyemLNVXlBn2/V/96APY4=;
 b=WVotFD6KFq7FKYZUVMZr4WZBVObM0/yy+5GOpB78HbjC+HRel8qTTi23kLZAFV5YpL
 8Le7N3FuVQ++shWQdW8GQFDeZy85GynYsH5DUnnyBHc4mk9j1A4sWUafeEY26uFvrHKE
 ZI6U7h4WaKiXvtCQws6l8+G1QBHV3UUBdgKj2kADT/H6BiLEOM3fXeBb/z7Yl5PUUC36
 RNHtkC3sU8VBTLkx1mfiYpMKMcV9t+tvhILPiqJi68boLB6IoHTJ+GkkYTuj4rcA8aRQ
 XWSPY0qYpBoWeVZyM4aI+EB/uyfIArlZogL1IgyzD42ocD6yc/vN5x+Eimyr0cDn9bBT
 yDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kdeSQM6n6ehpxt42Ss8k8UZyemLNVXlBn2/V/96APY4=;
 b=JJq6UNTfjL4jbfW6bYPDOy5Z6CvP6mtXUYbC9nnsGuwkMK8WR1PYTikxMfXYqbRoUD
 o62JAW53BnCSShsmRUHH4jImQnu1URQzvEXPuY0QV2LqbqKqkwivWEbIi9jx2xDlCzz5
 uLFlSsuEoE9k9wFsGwvZS0vlYoxCWMVrXfUq0qBITrkDPMidWib1fVxdawfl/GdsOsQC
 1ouDOp1SetC/SzU9vb3x6+p+ooFDEASTcciD/iyme3WbHMCyrjAW0CHL+SwpFvyZ9q1+
 dR7vqJ728jmgwOrUjPR65U65GGrOtbyNMNnboI50q4Bxz3uBXU4xefJNdNn8hGfbsq5K
 SD4A==
X-Gm-Message-State: AOAM533Oyv/GYNN7zlZkKsyHtxBBlHAEoQCxSqjYDnPbdNWP8PQ0+YQj
 A0lAwRkfZePYyem17IUR1q8=
X-Google-Smtp-Source: ABdhPJy/hLq9Wg9UD+0N/OJ47bWBmXA9uT4lXWcLYM/B9K+IiAWbeYfHp7+Q4tvdTBQoTSXOfK14Yg==
X-Received: by 2002:a17:90a:a2b:: with SMTP id
 o40mr302170pjo.214.1621262896743; 
 Mon, 17 May 2021 07:48:16 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
 by smtp.gmail.com with ESMTPSA id h1sm10449494pfh.72.2021.05.17.07.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 07:48:16 -0700 (PDT)
Date: Mon, 17 May 2021 23:48:11 +0900
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [RFC PATCH] sound: line6: Fix race condition in line6_probe
Message-ID: <20210517144811.GA54892@hyeyoo>
References: <20210517132725.GA50495@hyeyoo>
 <s5hk0nxo4qr.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hk0nxo4qr.wl-tiwai@suse.de>
X-Mailman-Approved-At: Tue, 18 May 2021 10:00:15 +0200
Cc: alsa-devel@alsa-project.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver Neukum <oneukum@suse.com>, Takashi Iwai <tiwai@suse.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, linux-kernel@vger.kernel.org
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

On Mon, May 17, 2021 at 03:43:24PM +0200, Takashi Iwai wrote:
> The actually needed initialization is
> line6_init_mid() call, and this can be fixed by moving to the
> appropriate place instead of inside each private_init callback.

Oh, I missed it! there was another caller of line6_init_midi.
your fix seems promising to me. it's putting line6_init_midi
to the right place.

by the way looking at code, I think this driver needs some
refactoring... it doesn't handle exceptions well.

Thanks,

Hyeonggon
> ---
> diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
> index a030dd65eb28..9602929b7de9 100644
> --- a/sound/usb/line6/driver.c
> +++ b/sound/usb/line6/driver.c
> @@ -699,6 +699,10 @@ static int line6_init_cap_control(struct usb_line6 *line6)
>  		line6->buffer_message = kmalloc(LINE6_MIDI_MESSAGE_MAXLEN, GFP_KERNEL);
>  		if (!line6->buffer_message)
>  			return -ENOMEM;
> +
> +		ret = line6_init_midi(line6);
> +		if (ret < 0)
> +			return ret;
>  	} else {
>  		ret = line6_hwdep_init(line6);
>  		if (ret < 0)
> diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
> index cd44cb5f1310..16e644330c4d 100644
> --- a/sound/usb/line6/pod.c
> +++ b/sound/usb/line6/pod.c
> @@ -376,11 +376,6 @@ static int pod_init(struct usb_line6 *line6,
>  	if (err < 0)
>  		return err;
>  
> -	/* initialize MIDI subsystem: */
> -	err = line6_init_midi(line6);
> -	if (err < 0)
> -		return err;
> -
>  	/* initialize PCM subsystem: */
>  	err = line6_init_pcm(line6, &pod_pcm_properties);
>  	if (err < 0)
> diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
> index ed158f04de80..1376fc405c7f 100644
> --- a/sound/usb/line6/variax.c
> +++ b/sound/usb/line6/variax.c
> @@ -172,11 +172,6 @@ static int variax_init(struct usb_line6 *line6,
>  	if (variax->buffer_activate == NULL)
>  		return -ENOMEM;
>  
> -	/* initialize MIDI subsystem: */
> -	err = line6_init_midi(&variax->line6);
> -	if (err < 0)
> -		return err;
> -
>  	/* initiate startup procedure: */
>  	schedule_delayed_work(&line6->startup_work,
>  			      msecs_to_jiffies(VARIAX_STARTUP_DELAY1));
