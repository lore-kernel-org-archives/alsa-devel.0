Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CD2C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:33:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D9F214E0
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Cgzm7p93";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="GR6pznZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D9F214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD9E31678;
	Mon, 11 Nov 2019 16:32:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD9E31678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573486379;
	bh=X5YVAVaU9L1lFwo/+d67ydjp0wLeY1yL3Ye4DJIRJe4=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cgzm7p937gdgM4g2EIAUOAKr748i+sibHB66GUyaajPpIMfkaU6u0FjpvhfBtVnxr
	 NJk0JBbvmRQzEgDvEZSs+80d4JB71XAe8McP1Eekm92XGmMLhq/ucD7SGFXbecZDZu
	 Qqj+gJJhcsAd+4r582tUoLzez7SjhSwkyHpOYv/o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63A1FF8045D;
	Mon, 11 Nov 2019 16:32:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3F3C2F80518; Mon, 11 Nov 2019 16:32:07 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C66CF8045D
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 16:32:00 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 6503DA0040;
 Mon, 11 Nov 2019 16:32:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 6503DA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1573486320; bh=aVe9bKjIrmdqq6Vw0VJLd0ELMSioPkLHvQnN+0wX0iY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=GR6pznZsfzn1bsPs6bkWmJTUTB8sL7jJk3+NsZQtdThhXJ5HF14JIntvUHYblycj1
 3vl3Q0Tl5blazSKcUsXhyGXwXBE4sn3Ozys/GOyJUT9/A+KjsPJyKndyA6qru1XJUD
 nqeJDuhyPy+Meo9f9wPM40hB4B2oreCkq+ZmmfFc=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 11 Nov 2019 16:31:57 +0100 (CET)
To: Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org
References: <20191107015808.26844-1-cujomalainey@chromium.org>
 <20191107015808.26844-8-cujomalainey@chromium.org>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <8d37c722-978c-5323-0536-156e513bcc29@perex.cz>
Date: Mon, 11 Nov 2019 16:31:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191107015808.26844-8-cujomalainey@chromium.org>
Content-Language: en-US
Cc: broonie@kernel.org
Subject: Re: [alsa-devel] [PATCH 08/11] ucm: docs: Add CaptureChannelMap
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
> Explains to userspace how some channels may need to be rearranged. This
> is useful for systems that may have DMIC pcms with dead channels that
> will need remapping.
> 
> Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
> ---
>   include/use-case.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/use-case.h b/include/use-case.h
> index 31f9e4be..9a10f390 100644
> --- a/include/use-case.h
> +++ b/include/use-case.h
> @@ -305,6 +305,9 @@ int snd_use_case_get_list(snd_use_case_mgr_t *uc_mgr,
>    *      - Remap channels using ALSA PCM channel mapping API notation
>    *        E.g. "2 3 0 1 -1 -1 -1 -1 -1 -1 -1" means, FL takes channel 2,
>    *        FR takes channel 3, RL takes channel 0, RL takes channel 1.
> + *   - CoupledMixers
> + *      - Mixer controls that should be changed together.
> + *        E.g. "Left Master,Right Master".
>    *   - EDIDFile
>    *      - Path to EDID file for HDMI devices
>    *   - JackControl, JackDev, JackHWMute
> 

I do not see which names are referred by this. It's for the snd_ctl interface 
or for the simple mixer ?

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
