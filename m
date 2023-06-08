Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A8CC7EE2E
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Jun 2023 14:51:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95943827;
	Fri,  9 Jun 2023 16:50:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95943827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686322301;
	bh=2z814zoPTbRkZrmzrRalQmyIcVEFXvZJ7A+jVAOnL/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mh7TueD3roI57X1S24d5PMFmskKtL5pSPzO98oLb2ECRoUHzE0Tn9n/VEc/yLoJaZ
	 T3RUzoDnA+QH9iahFPm2xgQqKi2sfQjFNLYxDMP/C0UFYMAUJIvOnqLigyXpVROjTo
	 wB9utf4vuWSSrbSLQT+XR4aBcd2u0FY9uyPwZ8FY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1C08BF80607; Fri,  9 Jun 2023 16:47:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 183ACF80605;
	Fri,  9 Jun 2023 16:47:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8B664F80199; Thu,  8 Jun 2023 11:33:37 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EC657F80130
	for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2023 11:33:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC657F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=baylibre-com.20221208.gappssmtp.com
 header.i=@baylibre-com.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=Laz1RwxG
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30e57e0a0c7so267260f8f.2
        for <alsa-devel@alsa-project.org>;
 Thu, 08 Jun 2023 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686216812;
 x=1688808812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cOj98+SP3A7ue8uJEiHbklaDi2wbfbIhAir4uuSrLHU=;
        b=Laz1RwxGIXm70TgzRDCLNkCjouhFptZ6gdr6yztXF1zDimdNhFWFzEGo6BPIMxK2yG
         qhUi7PZ5Pj/IIFnP7F/khg/w29O0p+iS/mDwDLmD+GsIg92naL8tetlwmvWgNZnr4Vmm
         LVos3YWwVd21ZDWTGdrN2b4ips7bQLckATt4+dtyw7YzTiIYGYj/Et+6JfvPv6BfTcAf
         EKzbqPH4jMtezbOAUCtX+FVxOBbQakai1lzurb8RqhMwqguCXmeeBAnbfjBUbjdACBU5
         YiG/df/4i2ihDgFBEmWEwE6ZzPdrx4qcmwRSiBx1RYEGZ3jv2M/x0J/No3yZV9O0jf6d
         VG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686216812; x=1688808812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOj98+SP3A7ue8uJEiHbklaDi2wbfbIhAir4uuSrLHU=;
        b=Qh8HPCoVg/Zd7ZXfijtpNrHHuEpct0oItV77EYX0IEHfjLnEmN+TbjfFBdSXqt7h+o
         CtEy+lRshoFot0eypYC1NbPTlETJBdu26ZV2oSwBMu7TmoL3qpLXqfak1W/uq8KOwtWD
         OUC94G5EzoQw3z9TCAtP4U3DwdZtB9OCSkZYqP80VJW7QOFfwKZTcr8zSPz/796ZQcRk
         jjgECOUPdj5HuXwWOwMNyHpiWw8oGHpJyb+3aVtvcNpp8QXuswoOruByq//C2IGR/smZ
         FBkBAIOOFUas3WWmEIaYstwQbBReosJ2D1tzMxAGAoGqET0jRClF0XRnk6FzDVcay+Bh
         e/Zg==
X-Gm-Message-State: AC+VfDzOBbMjNtza07rUkZj71DYYi0JTLN4t1IOw7eQRXPysriJ5AkU1
	HbndjElZHi5jS76LxlnLMr4POw==
X-Google-Smtp-Source: 
 ACHHUZ7P8OxpxQTjiKrorLWZywqz5NMirJO0K4lefJ+9XIYZYERDkbTiMsX/D53AhUJjyGH6f3r1lA==
X-Received: by 2002:adf:fccf:0:b0:309:5068:9ebe with SMTP id
 f15-20020adffccf000000b0030950689ebemr5857679wrs.50.1686216812642;
        Thu, 08 Jun 2023 02:33:32 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id
 b14-20020a056000054e00b0030c2e3c7fb3sm986359wrf.101.2023.06.08.02.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 02:33:32 -0700 (PDT)
Message-ID: <bc366bde-95f6-1ddd-9528-a9c1dd30c04c@baylibre.com>
Date: Thu, 8 Jun 2023 11:33:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/5] ASoC: mediatek: mt8188-mt6359: Cleanup return 0
 disguised as return ret
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 matthias.bgg@gmail.com, trevor.wu@mediatek.com, dan.carpenter@linaro.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
 <20230608084727.74403-4-angelogioacchino.delregno@collabora.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230608084727.74403-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: amergnat@baylibre.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: HB2PRVSW6MZZSH4IXCVCVF5UQCCYPDV4
X-Message-ID-Hash: HB2PRVSW6MZZSH4IXCVCVF5UQCCYPDV4
X-Mailman-Approved-At: Fri, 09 Jun 2023 14:47:09 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HB2PRVSW6MZZSH4IXCVCVF5UQCCYPDV4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 08/06/2023 10:47, AngeloGioacchino Del Regno wrote:
> Change all instances of `return ret` to `return 0` at the end of
> functions where ret is always zero and also change functions
> mt8188_{hdmi,dptx}_codec_init to be consistent with how other
> functions are returning errors

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

