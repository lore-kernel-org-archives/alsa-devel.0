Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5EDC43331
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:31:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5315D214E0
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="A7dy5E8l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="skgBHY/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5315D214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8796C166C;
	Mon, 11 Nov 2019 16:30:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8796C166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573486294;
	bh=hXW/AD4YThQtAdx3pxBeF/imF+PPeYRE2mqN2/LU8fI=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A7dy5E8lDEHHIq1dpxP7alt1K/ZL20RgSC0UMaLoOOu+97KDJ4N31aaYg3VJTRoGN
	 kgZgfLyYcKdnS7xAufL79lJ9ivcmYQtmePV3tTAUslqcMSpx9o0Vq8bEvo0NoK/q0o
	 NL0oLR5YA09hHiooxZ3YUtSu5ikeFfmCrdK3tgdY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BF62F8045D;
	Mon, 11 Nov 2019 16:30:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 402C6F804FF; Mon, 11 Nov 2019 16:30:42 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08686F8015C
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 16:30:35 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 00543A003F;
 Mon, 11 Nov 2019 16:30:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 00543A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1573486235; bh=uJC6gLvkeYjY5qQ6D3A9mvf8n4VGYsXEbZUNFh1E0Hs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=skgBHY/LVAa5mTMMi30SqSvGiIIt4KxQFDmq+XUelg2jSGkXecY8S9jAqUg+jHVDw
 9OAdOu1TluXFzwGRaFr5JY1/arp5RZ+ssDwvVWv38/uIeEwl4Kc3EmUc7Yy/2XFAtS
 nOsUK/zUuYp+THPkLGosMdOGffuhJK4HoYKvTY4E=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 11 Nov 2019 16:30:31 +0100 (CET)
To: Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org
References: <20191107015808.26844-1-cujomalainey@chromium.org>
 <20191107015808.26844-7-cujomalainey@chromium.org>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <ba0fb03e-8085-d2c2-ecda-af454001c835@perex.cz>
Date: Mon, 11 Nov 2019 16:30:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191107015808.26844-7-cujomalainey@chromium.org>
Content-Language: en-US
Cc: broonie@kernel.org
Subject: Re: [alsa-devel] [PATCH 07/11] ucm: docs: Add CaptureChannelMap
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dne 07. 11. 19 v 2:58 Curtis Malainey napsal(a):
> Add ucm value to tell userspace to remap channels. This is useful for
> systems with DMICs where there may be more channels than active
> channels.
> 
> Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
> ---
>   include/use-case.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/use-case.h b/include/use-case.h
> index 1aeaf9d4..31f9e4be 100644
> --- a/include/use-case.h
> +++ b/include/use-case.h
> @@ -301,6 +301,10 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
>    *      - name of capture mixer
>    *   - CaptureMixerID
>    *      - mixer capture ID
> + *   - CaptureChannelMap
> + *      - Remap channels using ALSA PCM channel mapping API notation
> + *        E.g. "2 3 0 1 -1 -1 -1 -1 -1 -1 -1" means, FL takes channel 2,
> + *        FR takes channel 3, RL takes channel 0, RL takes channel 1.
>    *   - EDIDFile
>    *      - Path to EDID file for HDMI devices
>    *   - JackControl, JackDev, JackHWMute
> 

I see a room for the improvement to have a better and complete mapping 
description like:

CaptureChannelMap "FR=0 RL=1 TC=2"

The location names should follow SND_CHMAP defines.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
