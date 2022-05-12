Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B076C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 12 May 2022 10:34:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA7D8195A;
	Thu, 12 May 2022 12:33:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA7D8195A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652351649;
	bh=S8jSUNLTmmQCTwbVy6oKVvqkCP8SGD/g9VYA5/47exI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A0K3dKYypvFFvszynWjiKzXBK4Knu280DRbNZJ9r9pkb7I3zCCRps7+NTXSywt4Ol
	 EkUH/ydAmFT43qm6oI4isIGybO5E+0tGNODa3YMPsnl7pJ/6PubGsgC/3oHkszNe9i
	 nFN1vP8Wuc0VcQ014N2PSc5FS48V1TQIbAzZ0E8A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 814A9F8010B;
	Thu, 12 May 2022 12:33:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29911F8010B; Thu, 12 May 2022 12:33:18 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC552F8010B
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2022 12:33:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC552F8010B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="cInE4pzJ"
Received: by mail-ej1-x62f.google.com with SMTP id dk23so9289274ejb.8
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2022 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=1cXKpnTu/ZLXUfBczt5nbt9dexjJtFDU54PLSn0k7Lg=;
 b=cInE4pzJ40MvUmXYRlgjXJyoRL41LQ3yButhtEWGFZ7/8Zd06i5srjA1TH9OefEwgW
 sjq37wkE7jsBaKVh/jesKQeY2rrxD4nK7uylhVcSb7XGAmBCXSXwYFzeMgBP5kj0n9lF
 1nv02uY15D5juyGK8jJx633QgbhqKnw6QBh7BDSVoLV6EOTSzscsvTjatbXONURJCAxB
 tquSsQ5RhYnP0vCSEJeB1CnXLYkvfJTNdW4SJI9NYHfH5mEzHgj02Uh1XrpJsQ+I7XUL
 AyTR0uqMagN5HtlXFV6ud1YWKdOoIAiF+OMTI3yDY8mGyMGxVulg9BgArlT/jUHxAT4a
 b7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=1cXKpnTu/ZLXUfBczt5nbt9dexjJtFDU54PLSn0k7Lg=;
 b=rr/BDuFY3XX/HmcQH+sMqTNCGmLPWeKb5faC1qMG2IX4Omn9ubJghdvJonNs+wuaIw
 RH5ocD0VUQPbZfBVbMu6Eo3bajBQYbqzPoXJVwjgB1poAZzQD7xjtZZxBxsufVyEJhC7
 ANnbPcGhBj7rhp03OvjXYHvSqWokQvKj+Km6LYgro+8EYhjB/T4oooVWUfC9IHqfFNRd
 6M59iw7LYYvfF+FfbG5DAs+M/oKw43vfKaJ33ytId+kYDDyEfpR3Vv+aN/w8nIlsQdB+
 h/LJfldLNYNFCH5N45tTXfEZhWyRSU8FwWwZDmBmp81CWNhENNvtt+QxVdYwJjEn67wp
 Qx8Q==
X-Gm-Message-State: AOAM532cKTpiV9/vAfhKkpo3M6LgrBE0sUqpBynMva1jH3PzoeAZiOcr
 sN2ZtL6jwBQ++l/B8tlUPyiqISF7PmrEjMOy
X-Google-Smtp-Source: ABdhPJznRmMGMeNHo+cuaQf//fXNuvOGcK63Pv0Iq0mM3nOpz8Lcf1qQAMT/baMrFLmAsXXsbW0Dlw==
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr29025209ejc.132.1652351590726; 
 Thu, 12 May 2022 03:33:10 -0700 (PDT)
Received: from [192.168.0.158] (xdsl-188-155-176-92.adslplus.ch.
 [188.155.176.92]) by smtp.gmail.com with ESMTPSA id
 dx18-20020a170906a85200b006f3a8b81ff7sm2019506ejb.3.2022.05.12.03.33.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 May 2022 03:33:10 -0700 (PDT)
Message-ID: <eba74198-b78e-1577-846f-f58494fb09f1@linaro.org>
Date: Thu, 12 May 2022 12:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ASoC: samsung: Fix refcount leak in aries_audio_probe
Content-Language: en-US
To: Miaoqian Lin <linmq006@gmail.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jonathan Bakker <xc-racer2@live.ca>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20220512043828.496-1-linmq006@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512043828.496-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 12/05/2022 06:38, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> If extcon_find_edev_by_node() fails, it doesn't call of_node_put()
> Calling of_node_put() after extcon_find_edev_by_node() to fix this.
> 
> Fixes: 7a3a7671fa6c ("ASoC: samsung: Add driver for Aries boards")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
