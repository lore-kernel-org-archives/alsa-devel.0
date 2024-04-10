Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD37C4345F
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Apr 2024 15:50:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B08D14DC;
	Thu, 18 Apr 2024 17:50:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B08D14DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1713455428;
	bh=ZQv+Cv6FtAbS0T/V0OLwICdE4U3tkVtKCw2XykvAM6E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kjDR4ZF1IwmCmV1Ft0kev8i+MIWU3GM2q5Os7mGjYqrILP1F0pzn57bu1qfNwGqgr
	 07O6PHqPHpFMY6nfQKJpV/bUp7nuKuNUBhj2x2IPqSUvtSbvBRBJEfaP1jULXMtI+b
	 g/FuorH9Ply+LuD1bGINRzgzFNrloCqd7Kvtt6XQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7F6BBF80CAD; Thu, 18 Apr 2024 17:46:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 710F1F80718;
	Thu, 18 Apr 2024 17:46:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 293A9F8026D; Wed, 10 Apr 2024 16:27:14 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2AE60F80130
	for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2024 16:27:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2AE60F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=baylibre-com.20230601.gappssmtp.com
 header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=SEd4wzC3
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3462178fbf9so866472f8f.1
        for <alsa-devel@alsa-project.org>;
 Wed, 10 Apr 2024 07:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712759228;
 x=1713364028; darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFeYAr3tgWzelp4Qc502/jt9QrT83vOai+OT7e3SF3I=;
        b=SEd4wzC3lLxRvtirdM3YyhtOCNrKPqKlC59+MBXvtSOrwfrDS9r908ec+qlKT9fT2D
         iLb2nb5ITwbSOOVhdF5/rowf58MluURoCmRTfx91vHYDwaHLmSkKYEREFAsSQFw1+2Fx
         /a2wm+j1QKwC5KbtV9bMzCqQkoBn+dV2/ekvH0l6Y+F3pohtF7fo/Pqq+1ifw/Hr0qt5
         no1LdBjmZ9GbDTgtU4iJEZkKoBb7AHgW/4FaVlgZGSKe+U2E6sop0kZ1CfFweXYQahcm
         00Enay+xg1QPa1N3CvcKfSQoFt5mdMeSrPiC+9jOeLuiokNu+ZUEu6Zlv7FS5cOcowqx
         LnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712759228; x=1713364028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFeYAr3tgWzelp4Qc502/jt9QrT83vOai+OT7e3SF3I=;
        b=r7sEdtYdZ6HAN8jBbDnHBbA7DQ1kNCe0uZkvFmv08uE0D7fpe4LgGVo1l6kPAsyOaq
         CTKaNz67U33+ki/H1Me8iriqGxMH01X5Ir4eKqRxLQ8+PQSJx3FCyqI52DddDBeeApBZ
         WTNXjC9PC9cnaidClAdcm/nNnUanIClkX5d6i4cskVoEbR8PSINgKnN9l5Jn2QHdLXSu
         uLVOxAmQ+k3eMnqLjtnxJWYjLNFHN5G4QSxCk1DqXLbC2KtF//Xt7tVuB2V5r2tBmyTv
         0Hdv73vF1Nyj375lirSrcJe2LyZZdt6I1AoZ0dYsmtKIyq81ftcoEmyjAsVIUt7WMBA5
         2Rlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLtsyRw7FiGgn0KVOBuFBkWHpXXfwaNwnVKvYf5aE0RH7WTuoZ8AvQzlIzd1ce4auTHka9/6UDFhwtNFF4VLROgNjUAs6LfbWfttU=
X-Gm-Message-State: AOJu0Yx92NuAJxdLTWsNiEH1+FjuzMC9OQ4XJsCxkBksfj0u1kPmAM+A
	xzT9wNMscdnALwtq0+sGD9wHWNrkQrbfFkoL+JBzlFoTLNqW99lS1VZFysp2YCQ=
X-Google-Smtp-Source: 
 AGHT+IGSvVBdvyjiYeq1pMtO732y4Er6q/giXpAXAVvEFvGgI0ZjYjMZMlOGyJUSQFXanGM+QGMBOw==
X-Received: by 2002:a05:6000:188a:b0:344:4bcc:ed28 with SMTP id
 a10-20020a056000188a00b003444bcced28mr3345746wri.32.1712759228609;
        Wed, 10 Apr 2024 07:27:08 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id
 b17-20020a5d40d1000000b00343cad2a4d3sm13846851wrq.18.2024.04.10.07.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 07:27:08 -0700 (PDT)
Message-ID: <d334ddc4-3c8e-49d7-8940-30f78bff823f@baylibre.com>
Date: Wed, 10 Apr 2024 16:27:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/18] ASoC: mediatek: Add common snd_soc_ops
 .startup() callback
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 broonie@kernel.org
Cc: wenst@chromium.org, lgirdwood@gmail.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com,
 trevor.wu@mediatek.com, maso.huang@mediatek.com,
 xiazhengqiao@huaqin.corp-partner.google.com, arnd@arndb.de,
 kuninori.morimoto.gx@renesas.com, shraash@google.com,
 nicolas.ferre@microchip.com, u.kleine-koenig@pengutronix.de,
 dianders@chromium.org, frank.li@vivo.com, allen-kh.cheng@mediatek.com,
 eugen.hristev@collabora.com, claudiu.beznea@tuxon.dev,
 jarkko.nikula@bitmer.com, jiaxin.yu@mediatek.com, alpernebiyasak@gmail.com,
 ckeepax@opensource.cirrus.com, zhourui@huaqin.corp-partner.google.com,
 nfraprado@collabora.com, alsa-devel@alsa-project.org,
 shane.chien@mediatek.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20240409113310.303261-1-angelogioacchino.delregno@collabora.com>
 <20240409113310.303261-8-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240409113310.303261-8-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: amergnat@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: N3FXUBJPACUTYMYAWQGNAIZGIJH5QWQW
X-Message-ID-Hash: N3FXUBJPACUTYMYAWQGNAIZGIJH5QWQW
X-Mailman-Approved-At: Thu, 18 Apr 2024 15:46:02 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N3FXUBJPACUTYMYAWQGNAIZGIJH5QWQW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 09/04/2024 13:32, AngeloGioacchino Del Regno wrote:
> MediaTek platforms are typically setting PCM rate and channels
> constraints for playback, capture and HDMI/DisplayPort playback:
> commonize the startup callback by adding the PCM constraints data
> to the mtk_platform_card_data structure and by reusing the common
> mtk_soundcard_startup() function for all of them by getting back
> the parameters from the aforementioned struct.

-- 
Regards,
Alexandre
