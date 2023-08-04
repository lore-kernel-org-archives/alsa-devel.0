Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F74C00528
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Aug 2023 12:06:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E05F83B;
	Fri,  4 Aug 2023 14:05:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E05F83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691150759;
	bh=4Ul5m5H/yk2TYm2UVBqE7N1cJJ4ESTVj1JNMYCxTpmc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=feTVGrEYgepjEd0yIi2D9y8VWq9OfVkkd4HfHJnZQOQURsq356gckQ8tR5OzSeZoI
	 EFD4mq+ceK/Evcr8f4xsL5lTEfrCYFfWu9iDXFOW40Te03QXRV4FkSZieULq5bYqiq
	 YaTGiPtDETkwb1vyoxUZ/rHR0Jr5E3Og1so5jiAA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69AEDF8057A; Fri,  4 Aug 2023 14:04:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BB7E8F80567;
	Fri,  4 Aug 2023 14:04:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 02366F8025A; Fri,  4 Aug 2023 13:02:54 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A36BCF8015B
	for <alsa-devel@alsa-project.org>; Fri,  4 Aug 2023 13:02:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A36BCF8015B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20221208 header.b=jXtQMM3l
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5216095a698so564640a12.0
        for <alsa-devel@alsa-project.org>;
 Fri, 04 Aug 2023 04:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691146945; x=1691751745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUD5hbyWC5PVi2AdsMEc5JXjXGKjisxD+lMbwsoTETQ=;
        b=jXtQMM3lrs2JcbJJZ/enJk0VMeiygqg9X8KuObw0dNSguygt04qJK4sOmydM99sTq2
         F+dDbviCNik6VMWtsgtnb/OgAXew8VtA5DGGmCF1iXWWrkvJCEjNsP4AT1eQzuGovQDs
         kiSJhzDaK8wi0sJYJWGzZTPWZZ1RpLpGL6GBJQzpis+bL83Hm7D9jU4lz7M9FJ/OBYri
         hOcT/EUTikzoGPFkGhaVB1NFteb+iI2ELH7JxDEC8FW8sSV3Uxp+XlvE1MPVjl2rQ5xi
         wXk6zfI1YFFmTL5yC07MB0xydIqFGL8wC/vby3QNa7ycajvoIg3k/+9kBoTkuBWRiU5E
         HAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691146945; x=1691751745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUD5hbyWC5PVi2AdsMEc5JXjXGKjisxD+lMbwsoTETQ=;
        b=CmaPe8XIbOJfQBqEn8XxiB4rXqN120csGm6Z/ED548/WxjZSAvEscgvMAp6KlwGNxz
         yj7Lzp0bpZVgRN73kY02mHGc/GU2jgQVLqGGwm0A6jiMS/z3gl1D3wcpAHprN2u0jmK6
         5mlvGrP7wGvPkZ24yrMqviIb4JHUlrcW3na0zMn775QkSAnG/oPim1CVIDVsy5RtiQJm
         A2sJZUasaD3Y3Vuo+uu2+BGWCQTPwHcQ8QsUFb1mAR4RPF+3tbTyAMBcHHDQV6OYMAO0
         apq4tkVH6FpQh5Ipd3mSp3h3SSXf080tRL9yLSFTPu0/4ugyRGk39VxFYY6XWcIPHhrS
         pcMA==
X-Gm-Message-State: ABy/qLa/Jjl2CwquERLt2SuUK+7N6+GG/OMeaeUAXW7kerU0lFW7uaso
	R1/bhnpn/GCCvO7TcJnjkJk=
X-Google-Smtp-Source: 
 APBJJlHc21FOa2c9RfVnuxEJguBDZ7h3LdPtKK/KVBHSIFLbmu3wERDXVFZgqZ7+UQ6eU2hAOuBS+Q==
X-Received: by 2002:a05:6402:2813:b0:514:971b:7f36 with SMTP id
 h19-20020a056402281300b00514971b7f36mr19962598ede.3.1691146944940;
        Fri, 04 Aug 2023 04:02:24 -0700 (PDT)
Received: from [10.10.19.213] ([178.160.196.94])
        by smtp.gmail.com with ESMTPSA id
 z22-20020aa7c656000000b0052302c27de2sm1087680edr.10.2023.08.04.04.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 04:02:24 -0700 (PDT)
Message-ID: <55220186-5dbe-6f44-45eb-10a00a1cf777@gmail.com>
Date: Fri, 4 Aug 2023 15:02:22 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ALSA: pcmtest: Move buffer iterator initialization to
 prepare callback
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20230803152824.7531-1-ivan.orlov0322@gmail.com>
 <87msz79jac.wl-tiwai@suse.de>
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <87msz79jac.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: ivan.orlov0322@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: YFG5F3JPCRCHZHELM6EHZVXHU2VINCJZ
X-Message-ID-Hash: YFG5F3JPCRCHZHELM6EHZVXHU2VINCJZ
X-Mailman-Approved-At: Fri, 04 Aug 2023 12:04:33 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YFG5F3JPCRCHZHELM6EHZVXHU2VINCJZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 8/4/23 14:46, Takashi Iwai wrote:
> A blank line removal is OK, but other changes are too much to fold
> into.  Please split.
> 

Hi Takashi,

Thank you for the review, I'll split the changes and send them as a 
patch series in a few minutes.

--
Kind regards,
Ivan Orlov

