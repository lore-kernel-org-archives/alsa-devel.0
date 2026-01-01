Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E83EF9002
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:25:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B456560297;
	Wed,  4 Mar 2026 17:25:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B456560297
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772641527;
	bh=xBz7ZJiU8jyQG2ac7XN6Phhv4CMfX8jeIZ17EmezRHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=CQkFiAXxvNtA9dK7RFYxokmouipNVH9boSxGvMe6lx+U6aS5r7iyRVxB6Gd6TnDn8
	 Ig1WbViqzXRe9/Xq8BkiwS3fmOtUHpeKNBaz+SuCmc2T3Me87OslpiEX43CN7IgmDN
	 8EA0xBTdWVhkaHVlL18PTkP5K9hZRpIPN2nEsjSE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D413BF805EA; Wed,  4 Mar 2026 17:24:54 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C605F805EA;
	Wed,  4 Mar 2026 17:24:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2CAE7F80086; Thu,  1 Jan 2026 04:34:11 +0100 (CET)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DFE0BF80086
	for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2026 04:34:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFE0BF80086
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=Ew23h3mp
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-8ba3ffd54dbso1602132285a.1
        for <alsa-devel@alsa-project.org>;
 Wed, 31 Dec 2025 19:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767238445; x=1767843245;
 darn=alsa-project.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hDzS8lF/ihFnEf+YS8BsD45TGWc1V+jxA3EyRuuNvk0=;
        b=Ew23h3mpLuys7NUK1+Ypxz/ZQABuYb0NDE77kYkty+OhEG2dMI2c7iRTsXPyhhHRFI
         sTJo350W0s1bI2YAETug02JUxXNOWXZZ0o6rBklSxB26A/BEVMvWFjqoW/DLFfSLEkwt
         s4cXEUhlqEjD+J5pWJ9lG6Ta9pynowhfaqUdvp7z0tecgGdUYP2zwfgK8GsI5rFrP7/D
         UYUJWCJRwBBNSJXpS9+VEIApxCxeXe3eFqweknU6UjNmLh2TB/vmZCFRPyhnfCeFVtt5
         bJV47oNIKdh0ijzGgjV3ZlTieYdiU2WCt8Dikwae9qp+pSCpl3J80PaU1CqeBN7nZXXI
         MtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767238445; x=1767843245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDzS8lF/ihFnEf+YS8BsD45TGWc1V+jxA3EyRuuNvk0=;
        b=uJWx1ApZ+58s/4j+Vgh/TV8FRZ+bWLeBv/khC2HktqB5l2/0Qu69tlMi5S+C9fFE+n
         nfDs83D9wUhcprIpeCIhsMC8p8aaUrR5ZUPakFJEVjudRAOLRCGcKAG1qdOyjEeLHAvG
         Y3mTXH4xwhbm5XE/ws1lKJqzTj/PuOXzcGQvLOQdHdElpI4pbUXFrLxsev/LO1Xcgozh
         HZYfyaM9czVAek3QL4PVOcP5iTdOXYZwioqpON5Qp3vvEgv6FFcrooOPiwhdPHL2l+hK
         zl74tpI2QPwmK2Q6nalgp6umsGq77RUtewqISIktYYwdbcEcpVVUSRCoDipMUAW8fAd2
         HPig==
X-Gm-Message-State: AOJu0YwvgnGnBoFSus8W7CqTetSCGXEseOUoWuSV9FDX0I1SupV9pzks
	aaYiFT/ZAPLIQbcOz2mIeDlV7L6MrkBlWwsIA5j2O0ONRDFzGjH6mone
X-Gm-Gg: AY/fxX4bb4HmTZgQIIUgx/jhNXSVK0jSkIcnFPwl55SPp67t6xswnQGVMANrj/L5o2U
	wWE3bTz/5mz3KmE8i2zhlo0pu7DrvFkvBcTt1zvaSxjUpl8s3BxKml4ffgJCV//P2DkVdFUrWKm
	P/yrEHyofSPM4TSuvK6QlsewcjE4zdfloR9nA+nIO7Os13CCNPxHvOnDmfRmQC+WwCsHWJZuetT
	jfnlt2eUV5SMNvJCzUtgcVJl/MSlCUC4gcjFJlG8fW3C5UvcptZF2u189T6PmeKHmW4pcJ31mb/
	Vn7LPGhk8i2xw4RWVxXjLGkXg8gVp8D2Gdb69f6ZxUDhbB2jUJ+p1X8Nbr5CFM60v64Y7mi+jy6
	1KAo8RM2AQJTYJtZEpGzAYozvfDLZrAEvxSQDy1A7xd83hWEFY84tN9zYpx2YIMtnNIEEoiiBEH
	KDmaCK9hAYnw3Z6A==
X-Google-Smtp-Source: 
 AGHT+IG+1Sn4yUdqbJL36zzyhITYZUBTgKIKKV6qZ+NoS42s5aL+z2Bht9ZuCGPwJ6UIAqYINyivJQ==
X-Received: by 2002:a05:620a:1904:b0:8ba:419f:c79e with SMTP id
 af79cd13be357-8c08fa9c407mr5689949285a.55.1767238444932;
        Wed, 31 Dec 2025 19:34:04 -0800 (PST)
Received: from localhost ([184.144.58.243])
        by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096783657sm3336391285a.1.2025.12.31.19.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 19:34:03 -0800 (PST)
Date: Wed, 31 Dec 2025 22:34:23 -0500
From: Richard Acayan <mailingradian@gmail.com>
To: Niranjan H Y <niranjan.hy@ti.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
	tiwai@suse.com, yung-chuan.liao@linux.intel.com,
	cezary.rojewski@intel.com, peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev, navada@ti.com, shenghao-ding@ti.com,
	v-hampiholi@ti.com, baojun.xu@ti.com
Subject: Re: [PATCH v5 1/5] ASoC: ops: improve snd_soc_get_volsw
Message-ID: <aVXrPzG0hp47hA0Y@rdacayan>
References: <20250912083624.804-1-niranjan.hy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912083624.804-1-niranjan.hy@ti.com>
X-MailFrom: mailingradian@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: HYZAM5BG7B3SMQJGCC7UCVSYLRLIA3DY
X-Message-ID-Hash: HYZAM5BG7B3SMQJGCC7UCVSYLRLIA3DY
X-Mailman-Approved-At: Wed, 04 Mar 2026 16:24:48 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HYZAM5BG7B3SMQJGCC7UCVSYLRLIA3DY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Sep 12, 2025 at 02:06:20PM +0530, Niranjan H Y wrote:
> * add error handling in case register read fails
> * clamp the values if the register value read is
>   out of range
> 
> Signed-off-by: Niranjan H Y <niranjan.hy@ti.com>
> --
> v5:
>  - remove clamp parameter
>  - move the boundary check after sign-bit extension
> ---
>  sound/soc/soc-ops.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
> index a629e0eac..03f74c32d 100644
> --- a/sound/soc/soc-ops.c
> +++ b/sound/soc/soc-ops.c
> @@ -118,6 +118,7 @@ static int soc_mixer_reg_to_ctl(struct soc_mixer_control *mc, unsigned int reg_v
>  	if (mc->sign_bit)
>  		val = sign_extend32(val, mc->sign_bit);
>  
> +	val = clamp(val, mc->min, mc->max);

This code path is shared with SX controls, when the maximum would be
mc->min + mc->max. The max parameter to the function can be used to get
a more sensible maximum (otherwise there could be cases where min > max):

	mc->min + max

Also, the Digital PCM Volume in CS35L36 has some trouble with this. It
maps -102dB to 0x4D0 and -0.125dB to 0x7FF (mask 0x7FF). At +0dB,
it's supposed to wrap around to 0x000, then go up to +12dB at 0x060.
This clamping reads +0dB and above (0x000 to 0x060) as -102dB, since it
doesn't account for signed values.
