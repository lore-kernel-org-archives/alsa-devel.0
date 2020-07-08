Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF07C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 09:45:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86452206E2
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 09:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bzmKBCTX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mO2Z3EWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86452206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0553E1614;
	Wed,  8 Jul 2020 11:44:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0553E1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594201525;
	bh=+woQMTT63TYre4WqZ+iSxvnIy5nA1RW9K4IszOf3OsQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bzmKBCTXMR9rP1xw/BFPi7SuoNaSINkd93+zAWBiWRxAcFsxYie/kTftp7FEGiPg7
	 pZHoAZ26Lhi3GcB2H2gIu7HMHXWr1AyWoDGd4dECe+Jij1qYc/vTp5pErncG2+sntR
	 8CBeYsvM9bTOLDDbVOenjmcN7sCVZE2PBjnzMLLI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 972D3F80150;
	Wed,  8 Jul 2020 11:44:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F10A2F8011F; Wed,  8 Jul 2020 11:44:32 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D64CBF80115
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 11:44:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D64CBF80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="mO2Z3EWx"
Received: by mail-wr1-x443.google.com with SMTP id o11so48197004wrv.9
 for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2020 02:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CU3teNK4ks5V+nQ8QE1n/8I+d2JYVjp3ohi8QaUE2+A=;
 b=mO2Z3EWxs2SyDUrComTdddyIotT1xafU+QNTaEs96rLfhca1Nbi6y1EnOhWbf75ms+
 c1srnsfalQGDoomtkmtiY5uMJuMRU9ba5pPkAgvgvoOJORvy2Rsu6ckijDb2Ze7FPfNM
 AtE044uKQmWu/ZMcRp1dg6ueVYGXaHg5Zx9aFXiyDuaJof+z6X7QfhDVJe1LHRdTUvm9
 v2dRFC3afRT7GWBAYY2S/wT0Tb07Pt2Yy5Df6VmWKtMgemyXzGAP8EvPgrUPDaIYcB+2
 JPuS/OCJnWCYAFfi3SyW0oFY6w+ku3pDOzJeHRpL5syBxYUrFTO22mEZXUBkyz4EljDa
 TxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CU3teNK4ks5V+nQ8QE1n/8I+d2JYVjp3ohi8QaUE2+A=;
 b=U45xnlmhKVeibvacEkOSW3DoW7JcNHFiYSoO5+l9RAQtAKTs8ve2pjthY+6ELJNCQm
 nO1FvjD+3UidAYUo8wuvFloRUicP0IMdMyjWTFelkea9hD45WbqCylZt9f9AKrCa9KIA
 2BnNMKVPPijKU0wAjFniDvA+T/NVWwTW56kqAi8LqlLtks3R2eh/cLDzKIeyhHYn6XCd
 ga9h+BR6tp5UhF79lKkLtI3B6c7d9VE1rz4GWzvdCNWOQzHqlHtj6iQnRGNXvnbQE1+F
 K1osHkM1cin8fNWPVwFV6kMKFVi4X+NadjT1VybNHRJtQ5/4EbdNmabbG6vSZLogbeVa
 D6lA==
X-Gm-Message-State: AOAM531nrgE9fSvRNtCDliyRBSkgGZ5hpZ8UX7e45Y6fLQAwgCAq6Msj
 hlqR8mCAbLxDrCtlWg4EHpXFVw==
X-Google-Smtp-Source: ABdhPJzoQSbQ3K7dl6+kZu9qeVvMuXnB1kvnRfVepdCezPHL5RgNw0zEqV1nz8vpJGK+tGX3m7noOA==
X-Received: by 2002:a5d:6b08:: with SMTP id v8mr59916781wrw.2.1594201465666;
 Wed, 08 Jul 2020 02:44:25 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id t4sm5443551wmf.4.2020.07.08.02.44.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jul 2020 02:44:25 -0700 (PDT)
Subject: Re: [PATCH 06/11] ASoC: q6asm: add support to remove intial and
 trailing silence
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-7-srinivas.kandagatla@linaro.org>
 <dd0d970e-109f-9a41-f2b9-a970e4d20caa@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <08d9598d-2ae7-3da8-752e-b588c8ebdd61@linaro.org>
Date: Wed, 8 Jul 2020 10:44:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dd0d970e-109f-9a41-f2b9-a970e4d20caa@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
 vkoul@kernel.org
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

Thanks Pierre for review,

On 07/07/2020 17:55, Pierre-Louis Bossart wrote:
> 
> 
> 
>> +int q6asm_stream_remove_initial_silence(struct audio_client *ac,
>> +                    uint32_t stream_id,
>> +                    uint32_t initial_samples)
>> +{
>> +    return q6asm_stream_remove_silence(ac, stream_id,
>> +                       ASM_DATA_CMD_REMOVE_INITIAL_SILENCE,
>> +                       initial_samples);
>> +}
>> +EXPORT_SYMBOL_GPL(q6asm_stream_remove_initial_silence);
>> +
>> +int q6asm_stream_remove_trailing_silence(struct audio_client *ac, 
>> uint32_t stream_id,
>> +                     uint32_t trailing_samples)
>> +{
>> +    return q6asm_stream_remove_silence(ac, stream_id,
>> +                   ASM_DATA_CMD_REMOVE_TRAILING_SILENCE,
>> +                   trailing_samples);
>> +}
>> +EXPORT_SYMBOL_GPL(q6asm_stream_remove_trailing_silence);
> 
> do you need those wrappers? Might as well call the _remove_silence() 
> function with the right parameters, no?

Intention is to abstract out the CMDs within dsp specific wrappers.
This is how rest of the apis are also done! Also its possible that in 
future these IDs could potentially upgraded on different versions of DSP fw.
Making a single call would mean that either CMD IDs or some kinda of 
other intermediate flags.

So I would like to keep it as it is for now!

Thanks,
srini

