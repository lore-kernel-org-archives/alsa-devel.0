Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68111EB64DA
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Jul 2023 06:24:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 986FE1F3;
	Wed, 19 Jul 2023 08:23:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 986FE1F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689747870;
	bh=/xKTE6XfwdWM2bbNnIkqvk9JLaQ075xXUt4gqb1KQyk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=a/EoSotsaz+hsmYWiloyhFFNiNDHcKgags9nyzp52nUHn2IdOEz7bqpZsvCf1Wu9Z
	 sXQJ3G5rPGeqTGbGyuHGEaxIACUfEMlD0hyMQtatQifL5fkONX+mVks+atesuPkzr9
	 sa4rxp2w5fyfckTU0kjgMm5Hnjq8J/M/9ZxO3Y5g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3DF8BF80520; Wed, 19 Jul 2023 08:23:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BD166F8047D;
	Wed, 19 Jul 2023 08:23:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8173DF8047D; Wed, 19 Jul 2023 08:23:33 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 26933F80153
	for <alsa-devel@alsa-project.org>; Wed, 19 Jul 2023 08:23:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26933F80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=voWti/7a
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-992acf67388so798460066b.1
        for <alsa-devel@alsa-project.org>;
 Tue, 18 Jul 2023 23:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689747806; x=1692339806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIa0Hkz4zg5vgRvGLwOuJtJFIr5nGFfRCpnkZR03fTc=;
        b=voWti/7atLoFZWFQegJqLCU9w61gHPdnyLVig2A/dgRT3tR02XF6g7s5rvo8miv864
         aR6P4vqeytQXWziZhuF8+mH1GP3xBugbEVed1Ih8yrBBiMS4CWkn933gWgmzGlYVeVJY
         bRttEMDb68diMN6ReN0iD+XYLCcuKFVnoGTfa4YoEmikhgyGRK4eBnikIZILkL+RRemy
         NlD7ZL9kh1hCK8U3IDxO2hXEzXtEsMsswLg0dh5+v327OZt6jmTTlOmBRXzjjj0Pw7W7
         fzkmao4Yxs6UDkjpQNfBbb/DMTzcg0pqTpWj3b4uMwFfgDX5Fava5XmS9E0fOjd1XMSq
         MbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689747806; x=1692339806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIa0Hkz4zg5vgRvGLwOuJtJFIr5nGFfRCpnkZR03fTc=;
        b=NEebicd5kYD9nQ32HMO3Vw4lOy8NN+HgWWALHybuMQM1eZdtHi1UlERJYZV8pLSyYq
         BNdzCtZexJNK9nkVUdTr9i77Sj/DJXEGxAZopJNDqGa0+Xn3/E013HiUNO0eW6DIS+gh
         f+D88usrHU6Mg7hheW85CIr51rnbAZKJANrqJWrGbIihICiS0MbnPI3o5qjZGl1iFDO6
         UWIk2CQBYPJFK0awYX0InKzoFInLnxhLPQnt9CKBry5jIceBGqu2X61w9DbtjW1iOqUb
         eWr6QHUFL8t7MbpExdfBwBXHmTTfbxLWevnPVMYnitmFaADCaNuTXId+XJ09maIw7sFS
         wmFA==
X-Gm-Message-State: ABy/qLZXOe6jjA19p46D1EFtqtSrndqDm13hb1PGbcw7joRxgx+3IIc3
	/RntpRbWm47GmfYJ5q9fRZ1Wjw==
X-Google-Smtp-Source: 
 APBJJlG7cCiluAgY4jExllMOrTl4i8ynGNChlKio+c2e78qOjAQfmMHRg70ShDHjrVGM4r+Y/yAHlw==
X-Received: by 2002:a17:906:d9dc:b0:969:f433:9b54 with SMTP id
 qk28-20020a170906d9dc00b00969f4339b54mr1488849ejb.39.1689747806501;
        Tue, 18 Jul 2023 23:23:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id
 r22-20020a170906351600b00992f8110a2bsm1851382eja.150.2023.07.18.23.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 23:23:26 -0700 (PDT)
Message-ID: <0ffec87a-976d-5a7e-bdce-418dbe817ed9@linaro.org>
Date: Wed, 19 Jul 2023 08:23:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V1 3/5] ASoC: codecs: ACF bin parsing and check library
 file for aw88261
Content-Language: en-US
To: wangweidong.a@awinic.com
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 ckeepax@opensource.cirrus.com, colin.i.king@gmail.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, doug@schmorgal.com, fido_max@inbox.ru,
 flatmax@flatmax.com, herve.codina@bootlin.com, kiseok.jo@irondevice.com,
 krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, liweilei@awinic.com, perex@perex.cz,
 pierre-louis.bossart@linux.intel.com, rf@opensource.cirrus.com,
 robh+dt@kernel.org, shumingf@realtek.com, tiwai@suse.com, trix@redhat.com,
 yijiangtao@awinic.com, zhangjianming@awinic.com
References: <98292541-8435-53cb-22d9-716ed6541485@linaro.org>
 <20230719031237.41530-1-wangweidong.a@awinic.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719031237.41530-1-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: DRQT4UNNFEA6SBGZQUILERBVPEJOPJJU
X-Message-ID-Hash: DRQT4UNNFEA6SBGZQUILERBVPEJOPJJU
X-MailFrom: krzysztof.kozlowski@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DRQT4UNNFEA6SBGZQUILERBVPEJOPJJU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 19/07/2023 05:12, wangweidong.a@awinic.com wrote:
> ...
> 
>>> +EXPORT_SYMBOL_GPL(aw88261_dev_load_acf_check);
> 
>> Why?
> 
> This function is also called in the aw88261.c file

Is aw88261.c a different module? If yes, then why?

Best regards,
Krzysztof

