Return-Path: <SRS0=BIX5=5Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA69C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:43:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E902071A
	for <alsa-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="n3X/OolH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZ77ieis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E902071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E49D83D;
	Tue, 31 Mar 2020 16:42:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E49D83D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585665801;
	bh=kgfPsKTOwHF7VxJBuKVKSJ8KerKaeX18AEjmkBO5GlY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n3X/OolH+9QVuXR3Igiivp7WDdHpnmLkVRILXGByJyI2FVbP6OEV2NVIqBd7hPi3c
	 LadeVhKlLRFljT7noyFudQERSmg9oCt3fvrsEaVKk9I31A0ccWEcgN8gylSli0wDGS
	 Ao33+H2d6hFCXsXdg3haqMvpIryDluedbA4QPshE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EA65F80140;
	Tue, 31 Mar 2020 16:42:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A68EDF80146; Tue, 31 Mar 2020 16:42:28 +0200 (CEST)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB6E8F8010C
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2020 16:42:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB6E8F8010C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="ZZ77ieis"
Received: by mail-wm1-x343.google.com with SMTP id z7so110618wmk.1
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2020 07:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5g7s8Y/QbyTrczmdL0xJgnMvV0X/wbyaxiTT7UArzmw=;
 b=ZZ77ieisFs1JIf3OKYTI2swBk8fZ4WleLCJdGkVaLjWpUFdpVA6FnVW42q/iN488zk
 Ct8TmwxVh2HO5/wvTB3OBbQD0QzACHrFgkDD80fDoMZeRnUE6hLibOmEGaONcCrHjHKP
 LEwqMSvFI66pY068eZSbBRQeF7rfNmyl3QG5hPQjPC1KXunLD1Vvx19SB7/uQ2vz2vUG
 KtsakT/QuYAOzvoeIeNYBbaS7KsRicB3YAIewvQmBDbvnfXpkZo6TTlPXbpUqBWB/KGO
 6Zu1EjSQZyLYDiMfnhTI8meo40Iqbz4J4mr76zNtDu2YOYZjhGk5g8niefskabhsNQYA
 sR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5g7s8Y/QbyTrczmdL0xJgnMvV0X/wbyaxiTT7UArzmw=;
 b=BTkpclxdtws/UHQGgNi73km5QVq97VCFyrYuM4YJUemF14nYtNZDwslK7kdbWxwDBy
 nr+kgwNijY7nR1IZklitrckDRsfCLVJ4HU9v8XN2E1pkKHnq9vKYQFCgoq1Zrym6DWDE
 6rSptifFq7y5E5yQWh5hZ8IGOxYxCDoikfuSBysDhu8OOGico8evOWYT+IHrngtU/dOf
 Dfncqv7TgePluBIacLEDp/U7uTwo4L+Pt1ymGvfuH7oIbf3IcI5c0Z6F6n5Q0AZFDNx8
 FgusvVtY+glxXv5Bcc3d005cIHeWOoXeE+bjLJAylvNMBmLssrnmLQHgeYW2NOAHY/ml
 WbpQ==
X-Gm-Message-State: ANhLgQ1lFhwAWwtd12PusT9OvQd9r3Y/YneS1uqAkZlY6wUnrkBplE1e
 EUSBT8vv9RBZ7Cz+BEIMkmYglHZPqMw=
X-Google-Smtp-Source: ADFU+vvFixhQLsLzrwRDnxTk6EuEEOxtOxlYGmi0mgIvIgXJLeMZYwON6TN/ECgYBcjxgk540/rKcQ==
X-Received: by 2002:a1c:5a43:: with SMTP id o64mr3931894wmb.95.1585665742967; 
 Tue, 31 Mar 2020 07:42:22 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id b26sm3926986wmj.21.2020.03.31.07.42.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 07:42:21 -0700 (PDT)
Subject: Re: [PATCH] ASoC: qcom: q6asm-dai: Add SNDRV_PCM_INFO_BATCH flag
To: Stephan Gerhold <stephan@gerhold.net>, Mark Brown <broonie@kernel.org>
References: <20200330175210.47518-1-stephan@gerhold.net>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <26354eb7-5eb3-ee3b-5fe7-d489a3933942@linaro.org>
Date: Tue, 31 Mar 2020 15:42:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200330175210.47518-1-stephan@gerhold.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, ~postmarketos/upstreaming@lists.sr.ht
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

Thanks Stephan for finding this flag!

On 30/03/2020 18:52, Stephan Gerhold wrote:
> At the moment, playing audio with PulseAudio with the qdsp6 driver
> results in distorted sound. It seems like its timer-based scheduling
> does not work properly with qdsp6 since setting tsched=0 in
> the PulseAudio configuration avoids the issue.
> 
> Apparently this happens when the pointer() callback is not accurate
> enough. There is a SNDRV_PCM_INFO_BATCH flag that can be used to stop
> PulseAudio from using timer-based scheduling by default.
> 
> According to https://www.alsa-project.org/pipermail/alsa-devel/2014-March/073816.html:
> 
>      The flag is being used in the sense explained in the previous audio
>      meeting -- the data transfer granularity isn't fine enough but aligned
>      to the period size (or less).
> 
> q6asm-dai reports the position as multiple of
> 
>      prtd->pcm_count = snd_pcm_lib_period_bytes(substream)
> 
> so it indeed just a multiple of the period size.
> 
> Therefore adding the flag here seems appropriate and makes audio
> work out of the box.
> 
> Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


