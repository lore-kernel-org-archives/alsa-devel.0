Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AED4C32793
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Aug 2022 11:58:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 760601675;
	Mon, 22 Aug 2022 13:58:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 760601675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661169533;
	bh=VWd9A60zBbbh6pYPx80JeA8Z304WyGJtlNBPcLhmfIs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o/mPGYECt4AtGlGYY0sv2S3Lix+6GOy6E5hNK+ddhzkw8DqQZJNSX9Yzy3U3BP0eA
	 EP3WiLazzGzG3bGMvpGjIEPxy9LpYd4a0afJeun4EEFcxP8P+dD7KD8tGq3FRaOA9C
	 GSrlS0wkO+jjxQ9cs03dE4tn7cIJqPlR3GOZCArM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 018C3F80154;
	Mon, 22 Aug 2022 13:58:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 907A2F8026A; Mon, 22 Aug 2022 13:58:01 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E30C5F80152
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2022 13:57:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E30C5F80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="OqjC6r//"
Received: by mail-vs1-xe30.google.com with SMTP id q67so2097975vsa.1
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2022 04:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc;
 bh=WeIqQCEG+BhOdh82gtyUhC50zktWVEd6O5k6r//SDgA=;
 b=OqjC6r//FIRdwERu7zRVjbbD3fns+6MntFIJTPVpTWLYidddEFvCJf6P4yn8JH/To+
 BZie8gS6VldMVW2slqCjQWpGY2gXceZd/uITK8Z9iNVg07Ob2uBaG2rIaDO809zXxwgJ
 74aNmJK2S4cvaiLW0R566axfuJGGeMFkjDVs/2WkVd5f5rjltoc4m0gVUKE3Mfl6AJUC
 3sx+WGFtep86JoR6c8SAZUoHB3WiLQn0speIuBMu4ItoV5fLqgaVX4YlosQFwwFhnQiY
 m8Y6SVejJ+DPUcgmBBuTZVv0GE7FHSZtLrnTG80Oykdii8nw3s+7MArdbTV8aIbbCfru
 Ok1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=WeIqQCEG+BhOdh82gtyUhC50zktWVEd6O5k6r//SDgA=;
 b=NhSNpQ7KrwaDlLriJfh17yC7jgmLqhzxNS+8/t40HHS3/7qzMpazg+sjA6+hOXVCsP
 TBPwh9lk/KAsOYOp4aHir1GWPGhGnO77aiOz9FjlhmnnG0XA1X+P0fcLnauUQGL3iM7p
 joJBDzm59ogdx5SBKS2ALIJdTdvB4yw4XofaZQdsEZETzuQ6f8uG/sRLqiNaVJ7eWO9Y
 NLRIhS+V/qcihOViqHfGDPPxm5YIY04yC9Gu/7fbDiO1KNDSKGcMixhB6W4Awzi9G+1F
 pgjW2sRlJ0NDxqDskZWdHxgFAp6lDIGmu0hoLdW31pXo2aiW8Tfc9Ty+sfbZM0yE2bJR
 YxfQ==
X-Gm-Message-State: ACgBeo0mVoIsoKowNDr1or+8UoJQwCS+SgYJYFBDc8jddXUjzftSaw0E
 +tZBzkwIqy6AdU5AkXDjnRw=
X-Google-Smtp-Source: AA6agR7jX2yjyre+CAqEusw1wHNDzSDqOoTyVjLFTPBeTjMm83auu6jIJ9KutfWQTX3chvako5u/tw==
X-Received: by 2002:a67:a64a:0:b0:357:5efb:c1ff with SMTP id
 r10-20020a67a64a000000b003575efbc1ffmr7447377vsh.83.1661169476753; 
 Mon, 22 Aug 2022 04:57:56 -0700 (PDT)
Received: from geday ([2804:7f2:8006:f71:a581:5947:7302:d05f])
 by smtp.gmail.com with ESMTPSA id
 128-20020a670886000000b00388d3be20bfsm8573865vsi.28.2022.08.22.04.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Aug 2022 04:57:56 -0700 (PDT)
Date: Mon, 22 Aug 2022 08:57:53 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: chihhao chen <chihhao.chen@mediatek.com>
Subject: Re: missing sound on kernel-5.15
Message-ID: <YwNvQaNNIKB8ELhR@geday>
References: <87e6d6ae69d68dc588ac9acc8c0f24d6188375c3.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87e6d6ae69d68dc588ac9acc8c0f24d6188375c3.camel@mediatek.com>
Cc: alsa-devel@alsa-project.org
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

On Mon, Aug 22, 2022 at 04:06:58PM +0800, chihhao chen wrote:
> I am testing many headsets on Android platform with different kernel
> versions.
> 
> On kernel-5.10, calling sequence for playback is
> 1. snd_usb_hw_params -> set highest sampling rate, no
> SAMPLING_FREQ_CONTROL USB request sent in this stage
> 2. snd_pcm_release
> 3. snd_usb_hw_params -> set proper sampling rate, still no
> SAMPLING_FREQ_CONTROL USB request 
> 4. snd_usb_pcm_parepare -> in configure_endpoint SAMPLING_FREQ_CONTROL
> USB request was sent on USB bus
> 
> With the same calling sequence, a slightly behavior change on kernel-
> 5.15 is
> 1. snd_usb_hw_params -> set highest sampling rate,
> SAMPLING_FREQ_CONTROL USB request  was sent on USB bus
> 2. snd_pcm_release
> 3. snd_usb_hw_params -> set proper sampling rate, SAMPLING_FREQ_CONTROL
> USB request  was sent too
> (because configure_endpoint was moved to snd_usb_hw_params function)
> 4. snd_usb_pcm_parepare -> no SAMPLING_FREQ_CONTROL USB
> request  because of USB EP flag check
> 
> I checked all USB packets and confirmed audio data output was correct.
> But there may be missing sound problem for the first sound with many
> headsets (for example Samsung headset).
> I found this issue is related to two-times sampling rate set request.
> (I tried to forcibly skip first USB request, everything became okay.)
> So do you guys know why configure_endpoint was moved to
> snd_usb_hw_params?

Hi Chihhao,

the commit you're looking for is bf6313a0ff766925462e97b4e733d5952de02367
("ALSA: usb-audio: Refactor endpoint management")

Good luck,
Geraldo Nascimento

> Or could you provide patch for this problem?
> 
> Many thanks
> Chihhao
> 
