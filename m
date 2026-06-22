Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3BFCDB471
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:45:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6969B60272;
	Mon, 22 Jun 2026 09:45:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6969B60272
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782114328;
	bh=eDoh/ddr71tTiTAsz9lGWJznKwWwsbZubmQFSPqALL8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Hj2PmlK8k45eQv+1nVoH0HSkZmVslI6zDArzbr7Abk7x9gmQbcijb9sT9OKJOQQHp
	 doWp+Ls/Qt+MxnqZ7kNkudmnkAYIGJtGnp5M/CG7799Jzicz0fqOBwGdRyNUL2n+rZ
	 3zJlqvIrYO6TDm4jzvYfa87ByZOguH6CnhhiQ+Uc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 31C24F806EC; Mon, 22 Jun 2026 09:43:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9582DF806FC;
	Mon, 22 Jun 2026 09:43:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC560F805D3; Mon, 22 Jun 2026 08:13:03 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782108781;
	b=AFDiZPIlTCT7Pa3Gd2Q6qjQkF4JBulcsuzynIMkGzrVWd+r7FfVyQ4AP6Qayp+E30ED/
	 Upm1/izSIr/S86jJhr3DKvH7b0GJkWQppfYOyXPYMXAI1LXzKI/VoubdnJPtrOfa812tx
	 195d+LVhYQkIL1zEqHA4R4/+XUyHpxlutVF+O/sc/sD+Coc49evTgSQLF4Xbq+fM0836N
	 DABkC3eLKlSMhsim7+yRAaXdtXA2bkrkXmymh0K8mTVz5RSgcCq6TjzFglc/2BNQg5IPM
	 79aBvCBu06YA4Y8KW9TKI+XAV5vTBRScZAYv+rVu7Y8D/SH03csoJHABu04Ocuc7gRA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782108781;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=eDoh/ddr71tTiTAsz9lGWJznKwWwsbZubmQFSPqALL8=;
	b=LqGYLeP22zsuH5UIztCTzmtxelwhpfxg5b7qDoQ2Ww1ENoM6B1h58/hOIkG0FUizJDUo
	 B++Oe1nxbJi3kPb2oUauvetfKgPQ6Xuz+66u9/E7vyo3ouRJYgrArB07XEk+gyQyNLSQK
	 sRrlcXqI5EnzSPBtXizhaYT9cnj5GUTjI4icOciYjUA1SITJGRxA4ylhMIWkvir6yS9Jl
	 IsNP4li+xazKB2HgCdz4Ugt34wIecpX6LXRF+TPlhO9JH+sAgMgxbAtKrLoPOo/RjvXx8
	 vLj/C/ZazL7ZhefhpouXH4CEmOoUJjL3xJy7Wn2Mrd/yiecY6uaOk+fShy/L8lItg1w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Hg8BK2iP;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6A822F805C4
	for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2026 08:13:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A822F805C4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Hg8BK2iP
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2c68190ade4so35288725ad.0
        for <alsa-devel@alsa-project.org>;
 Sun, 21 Jun 2026 23:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782108778; x=1782713578;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RjZ6ir0ehE41+u9OZdoJp7dueeLzNjdukrB7MYQcffE=;
        b=Hg8BK2iPnfDncd5sB35F7GFrE8WvYkqJkm1aYtMNyt52vg+wnooh63vovBnsozHnu8
         i01y2rBfhIDY5TRpkT5saGwCv0HrcapPsZdPixkCScL53P7pxyd1D8ZUQxJkkdkxPfuL
         NBeGAXoGr3Tch5LccHclWjr0++nHOJj9OqIiO2ss7YLPdi3ePs2c5tnoGLkHHncmRpRe
         td6np8q9RjUR+gcXA3YnbO95NiennbCj3dXxyF/JUudaxXMgrIP7jIi6ccSyFUW0cZzP
         mrZJ8BlHMj6E3+8HvUeFraL9X1PO2u+GIGjvi6hJ0mwL/IR9E5dJStntkGchUMMqt0mv
         n0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782108778; x=1782713578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjZ6ir0ehE41+u9OZdoJp7dueeLzNjdukrB7MYQcffE=;
        b=Yi66QU3XXlc4CxPCrVnLelKHkoj4OrDn2D1DTfMmHFitlgmt/wdM0x/LYcVBC6gGAp
         ABQ9e2lbXitSt4+nvXve2z+zIUv30GDDfFnD6809trSINKmZeTPjCjJsTFjEt9ZlAciS
         rjs7RB7fmlMIclNx7x9Mc4L0Tsy5qz8YQ6pp1if6+hhG6vcYLSqqKHDEFS5hRdJqbsif
         BnTGaT/FDG57B1cvMzSY4nP1wC84JnxCh1VFnHGZ3RpWukUj6iZgDc+GDp/3cxQflynA
         0R0RoAwltmJ9eLOIbE4q5xmC0RE9sDNv9u7CpASVZuIXtAZ/zolkGcR/ApS1xxvdosl9
         UCmA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcpmMsfhPSbjCHeE/QunaxOOio4pmDI00X3cNy3GaGYdGVv3TlOxsjZyrYxZODnG6+MSa4WkTRRCY1@alsa-project.org
X-Gm-Message-State: AOJu0YwveVl54kZ0/kToRqJIzyI9lf4VQwTpanvpaxyfc/W+GsALQ9V2
	sVyQi8Z7z9j+jJ1NdAVx1smmUcCIi3J/7KjT19AbE39OOqbGmYyowJ5W
X-Gm-Gg: AfdE7cmLFZaRlUfHrOsp5HykH3UAm4MPTAab+tpty/p8/7E0ZXU6WePuxcjtgn9bHsd
	nVrSpIGsdHwLpEqyFXzJE4jh13Da0RSqfNBFyeicBQS6lcHVIKinMsILxB+NAXtCdp1nbralwBF
	XZp6EKnlegvswWzsFWxLj14pKN1aAVOZQbgzNIA6KDQOiVYsQBJsDdjarB4NFmXdHahsLvgFxYH
	lELJ+I9zqjCsHefChPf+4oQbdgF26WNl/GACXDaDQ2cgBVXl0v3prlKFB5LBTYj5TFOY9c3Er4o
	FqL+YcDwUvUnt/gPnCYl3KgI3cc7MOHLf4E1zz7AmNvjERd7BLeYZomNuipDc7OVleMhIaG+5GU
	6n8NenjneBK80appRmvWlXtr75TwBrfFCSw2SQzuX6GFNaZQFrMhpMbz/k6n3/d+m/D3/wKrZ4/
	IxMJcDZ8CLXoeZiTtsAU/WgAGGuf0kpj4BXCoJSFdZFtVN
X-Received: by 2002:a17:902:e945:b0:2c0:b31b:b19 with SMTP id
 d9443c01a7336-2c7195f3973mr110771195ad.21.1782108778242;
        Sun, 21 Jun 2026 23:12:58 -0700 (PDT)
Received: from [172.20.10.3] (42-79-6-161.emome-ip.hinet.net. [42.79.6.161])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7439f8e81sm64842865ad.52.2026.06.21.23.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2026 23:12:57 -0700 (PDT)
Message-ID: <8c45d9eb-6267-0333-ab49-aaf55d9611c8@gmail.com>
Date: Mon, 22 Jun 2026 14:12:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Content-Language: en-US
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org, krzk+dt@kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, sjlin0@nuvoton.com,
 Mark Brown <broonie@kernel.org>
References: <20260609024128.585938-1-YLCHANG2@nuvoton.com>
 <20260609024128.585938-3-YLCHANG2@nuvoton.com>
 <329cf637-786d-4fee-9c63-b8e73827b330@intel.com>
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <329cf637-786d-4fee-9c63-b8e73827b330@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 5FAETEAPY43KLBC3SMXHJPY54BMGT36Q
X-Message-ID-Hash: 5FAETEAPY43KLBC3SMXHJPY54BMGT36Q
X-Mailman-Approved-At: Mon, 22 Jun 2026 07:43:22 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5FAETEAPY43KLBC3SMXHJPY54BMGT36Q/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 6/9/26 17:49, Cezary Rojewski wrote:
> On 6/9/2026 4:41 AM, Neo Chang wrote:
>> Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
>> stereo 30W+30W smart amplifier with an integrated low-latency
>> Advanced Audio DSP.
>
> Hi Neo,
>
> I've provided a number of possible improvements and nitpicks which 
> scale for the entire file - not just the occurrences I've 
> highlighted.  In general, it's hard to follow the code.  A lot of 
> arithmetics bundled together with limited 
> spacing/comments/self-explanatory names.  Sheer number of 
> if-statements and brackets does not help either.
>
> There seem to be quite a bit of defensive programming here too - 
> checks just to print a message.  I'd suggest to enlist event tracing 
> and log the TX/RX communication unconditionally.  Would eliminate the 
> need for many of prints found here.
Hi Cezary,
Thank you for the detailed review and the valuable suggestions regarding 
the code structure, readability, and coding style.
I will apply these suggestions in v5 to make the code easier to follow. 
Regarding the defensive programming, I will drop those redundant print 
checks.
If necessary, I will consider adding event tracing for TX/RX in a future 
patch.

>
>> +static int nau8360_reply_from_dsp(struct snd_soc_component *component,
>> +    const struct nau8360_cmd_info *cmd_info, int data_size,
>> +    void *data, unsigned short dsp_addr)
>> +{
>> +    struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
>> +    struct device *dev = component->dev;
>> +    unsigned int payload, *data_buf;
>> +    int i, j, ret, frag_len, frag_payload_len, len_pos, pad_len, 
>> pad_len_exp;
>> +    int data_count = 0;
>
> 13 local variables.  Does not look good.  I'd try to refactor this 
> one. Ask yourself - what's the (one) goal this function shall 
> achieve.  It's clear that currently it does more than one thing e.g.: 
> performs validation of the payload.  The validation could be moved 
> into a separate function.
I will refactor this function and extract the logic into a separate 
helper function to simplify this and reduce the number of local 
variables in v5.
>
>> +
>> +    if (!cmd_info->reply_data) {
>> +        dsp_dbg(dev, "The cmd without reply data!!");
>> +        ret = nau8360_dsp_replied(nau8360, &frag_len, dsp_addr);
>> +        if (ret)
>> +            goto err;
>> +        else if (!frag_len)
>> +            goto done;
>
> No need for 'else if', 'if' suffices.
I will change this to a simple 'if' in v5.
>
>> +    }
>> +
>> +    if (!data) {
>> +        ret = -EINVAL;
>> +        goto err;
>> +    }
>> +    data_buf = (unsigned int *)data;
>> +
>> +    ret = nau8360_dsp_replied(nau8360, &frag_len, dsp_addr);
>> +    if (ret)
>> +        goto err;
>> +    else if (!frag_len)
>> +        goto done;
>
> Ditto.
Ditto, will update to a simple 'if' in v5.
>
>> +
>> +    frag_payload_len = frag_len - 1;
>> +    if (cmd_info->msg_param)
>> +        data_count = data_size;
>> +    for (i = 0; i < frag_payload_len; i++) {
>> +        ret = regmap_read(nau8360->regmap, dsp_addr, &payload);
>> +        if (ret) {
>> +            dev_err(dev, "failed to read payload of dsp");
>> +            goto err;
>> +        }
>> +        if (cmd_info->msg_param) {
>> +            if (data_count >= NAU8360_DSP_DATA_BYTE) {
>> +                *data_buf++ = payload;
>> +                data_count -= NAU8360_DSP_DATA_BYTE;
>> +                payload_read(dev, payload);
>> +            } else {
>> +                for (j = 0; j < NAU8360_DSP_DATA_BYTE; j++) {
>> +                    if (data_count <= 0)
>> +                        break;
>> +
>> +                    ((u8 *)data_buf)[j] = (payload >> (j * 8)) & 0xff;
>> +                    data_count--;
>> +                }
>> +                payload_read(dev, payload);
>> +                break;
>> +            }
>> +        } else {
>> +            *data_buf = payload;
>> +            payload_read(dev, payload);
>> +        }
>> +    }
>> +
>> +    /* check the reply length same as request */
>> +    if (data_count && (cmd_info->cmd_id == 
>> NAU8360_DSP_CMD_GET_KCS_RSLTS ||
>> +            cmd_info->cmd_id == NAU8360_DSP_CMD_GET_KCS_SETUP)) {
>> +        dev_warn(dev, "payload_len %d, expected %d",
>> +            data_size - data_count, data_size);
>> +    }
>> +    dsp_dbg(dev, "reading trailing fragment");
>> +    ret = regmap_read(nau8360->regmap, dsp_addr, &payload);
>> +    if (ret) {
>> +        dev_err(dev, "failed to read trailing fragment");
>> +        goto err;
>> +    }
>> +
>> +    len_pos = payload & 0xff;
>> +    len_pos |= ((payload >> 8) & 0xc0) << 2;
>> +    if (len_pos != frag_len) {
>> +        dev_err(dev, "LEN_POST %02X, expect %02X", len_pos, frag_len);
>> +        ret = -EPROTO;
>> +        goto err;
>> +    }
>> +
>> +    pad_len = ((payload >> 8) & 0x30) >> 4;
>> +    if (cmd_info->msg_param)
>> +        pad_len_exp = frag_payload_len * NAU8360_DSP_DATA_BYTE -
>> +            (data_size - data_count);
>> +    else
>> +        pad_len_exp = 0;
>> +    if (pad_len != pad_len_exp) {
>> +        dev_err(dev, "PAD_LEN %02X, expect %02X", pad_len, 
>> pad_len_exp);
>> +        ret = -EPROTO;
>> +        goto err;
>> +    }
>> +    dsp_dbg(dev, "LEN_POST 0x%x, PAD_LEN 0x%x", len_pos, pad_len);
>> +    payload_read(dev, payload);
>> +done:
>> +    return 0;
>> +err:
>> +    dev_err(dev, "DSP reply error %d !!!", ret);
>> +    return ret;
>> +}
>
> ...
>
>> +int nau8360_dsp_init(struct snd_soc_component *component)
>> +{
>> +    dev_info(component->dev, "DSP initializing...");
>> +    return nau8360_dsp_set_kcs_setup(component);
>> +}
>
> Do we need a function that just inlines to nau8360_dsp_set_kcs_setup() 
> except for a single print?  Doubt so.
I will repurpose this function in v5. nau8360_dsp_init() will now handle 
the core DSP initialization logic and
wait for the firmware loading to complete.
>
> ...
>
>> +static int nau8360_adacl_event(struct snd_soc_dapm_widget *w,
>> +    struct snd_kcontrol *kcontrol, int event)
>> +{
>> +    struct snd_soc_component *component = 
>> snd_soc_dapm_to_component(w->dapm);
>> +
>> +    if (SND_SOC_DAPM_EVENT_ON(event))
>> +        snd_soc_component_update_bits(component, NAU8360_R6E_DAC_CFG0,
>> +            NAU8360_PD_DACL_DIS, 0);
>> +
>> +    return 0;
>> +}
>> +
>> +static int nau8360_adacr_event(struct snd_soc_dapm_widget *w,
>> +    struct snd_kcontrol *kcontrol, int event)
>> +{
>> +    struct snd_soc_component *component = 
>> snd_soc_dapm_to_component(w->dapm);
>> +
>> +    if (SND_SOC_DAPM_EVENT_ON(event))
>> +        snd_soc_component_update_bits(component, NAU8360_R6E_DAC_CFG0,
>> +            NAU8360_PD_DACR_DIS, 0);
>> +
>> +    return 0;
>> +}
>> +
>> +static int nau8360_dacl_event(struct snd_soc_dapm_widget *w,
>> +    struct snd_kcontrol *kcontrol, int event)
>> +{
>> +    struct snd_soc_component *component = 
>> snd_soc_dapm_to_component(w->dapm);
>> +
>> +    if (SND_SOC_DAPM_EVENT_OFF(event))
>> +        snd_soc_component_update_bits(component, NAU8360_R6E_DAC_CFG0,
>> +            NAU8360_PD_DACL_DIS, NAU8360_PD_DACL_DIS);
>> +
>> +    return 0;
>> +}
>> +
>> +static int nau8360_dacr_event(struct snd_soc_dapm_widget *w,
>> +    struct snd_kcontrol *kcontrol, int event)
>> +{
>> +    struct snd_soc_component *component = 
>> snd_soc_dapm_to_component(w->dapm);
>> +
>> +    if (SND_SOC_DAPM_EVENT_OFF(event))
>> +        snd_soc_component_update_bits(component, NAU8360_R6E_DAC_CFG0,
>> +            NAU8360_PD_DACR_DIS, NAU8360_PD_DACR_DIS);
>> +
>> +    return 0;
>> +}
>
> Refactor the above four functions - you could create a wrapper to 
> lower LOCs without huring the readability.  If you prefer, instead of 
> a one-for-four, you could have one "positive" wrapper (handles 
> EVENT_ON cases) and a "negative" one (handles EVENT_OFF cases).
I will refactor these into a common function to reduce LOC in v5.
>
> ...
>
>> +static int nau8360_codec_probe(struct snd_soc_component *component)
>> +{
>> +    struct snd_soc_dapm_context *dapm = 
>> snd_soc_component_to_dapm(component);
>> +    struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
>> +    struct regmap *regmap = nau8360->regmap;
>> +    struct device *dev = nau8360->dev;
>> +    int ret, vbat, vsaw_level, vsaw_slope;
>> +
>> +    nau8360->dapm = dapm;
>> +    nau8360_coeff_set_def(nau8360);
>> +    ret = nau8360_dsp_setup(component);
>> +    if (ret)
>> +        goto err;
>> +
>> +    ret = nau8360_dsp_setup_controls(component);
>> +    if (ret) {
>> +        nau8360_dsp_enable(regmap, false);
>> +        dev_err(dev, "DSP setup controls failed(%d)", ret);
>> +        goto err;
>> +    }
>> +
>> +    /* default disable Sense signal after booting */
>> +    snd_soc_dapm_disable_pin(nau8360->dapm, "Sense");
>> +    snd_soc_dapm_sync(nau8360->dapm);
>> +
>> +    /* VBAT is sensed by chip. */
>> +    ret = nau8360_vbat_level(regmap, &vbat);
>> +    if (ret) {
>> +        dev_err(dev, "Failed to get valid VBAT level: %d\n", ret);
>> +        goto err;
>> +    }
>> +    dev_dbg(dev, "VBAT %dV for nau8360", vbat);
>> +
>> +    /* Config sawtooth clock according to VBAT. Class D modulator 
>> input short setting
>> +     * for mute and de-pop purpose. Restore normal after initiation.
>> +     */
>> +    ret = nau8360_sawtooth_params(vbat, &vsaw_level, &vsaw_slope);
>> +    if (ret) {
>> +        dev_err(dev, "can't get sawtooth clock parameters (%d)", ret);
>> +        goto err;
>> +    }
>> +    regmap_update_bits(regmap, NAU8360_RA5_ANA_REG_1, 
>> NAU8360_VSAW_LV_MASK |
>> +        NAU8360_KVCO_SAW_MASK, (vsaw_level << NAU8360_VSAW_LV_SFT) |
>> +        (vsaw_slope << NAU8360_KVCO_SAW_SFT));
>> +
>> +    return 0;
>> +err:
>> +    return ret;
>
> Why are we using the goto here if there is no unwinding found within 
> the error path?  Either you've forgotten to add the unwinding or the 
> goto is redundant.
>
> Repeat for all the functions with similar behavior found in this file.
I will drop the redundant 'goto err' and return the error code directly 
across the entire file in v5.
>
>> +}
>> +
>> +static int __maybe_unused nau8360_suspend(struct snd_soc_component 
>> *component)
>> +{
>> +    struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
>> +
>> +    regmap_update_bits(nau8360->regmap, NAU8360_R90_HW2_CTL0, 
>> NAU8360_HW2_STALL,
>> +        NAU8360_HW2_STALL);
>> +    nau8360_dsp_enable(nau8360->regmap, false);
>> +    regcache_cache_only(nau8360->regmap, true);
>> +    regcache_mark_dirty(nau8360->regmap);
>> +
>> +    return 0;
>> +}
>> +
>> +static int __maybe_unused nau8360_resume(struct snd_soc_component 
>> *component)
>> +{
>> +    struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
>> +    struct regmap *regmap = nau8360->regmap;
>> +    int ret;
>> +
>> +    regcache_cache_only(regmap, false);
>> +    nau8360_peq_mem_enable(regmap, true);
>> +    regcache_sync(regmap);
>> +    nau8360_peq_mem_enable(regmap, false);
>> +
>> +    /* disable Sense at standby */
>> +    snd_soc_dapm_disable_pin(nau8360->dapm, "Sense");
>> +    snd_soc_dapm_sync(nau8360->dapm);
>> +
>> +    ret = nau8360_dsp_setup(component);
>> +    if (ret)
>> +        goto err;
>
> Drop the goto, no error handling here.
I will drop the redundant goto here in v5.
>
>> +
>> +    return 0;
>> +err:
>> +    return ret;
>> +}
>
> ...
>
>> +static int nau8360_reg_write(void *context, unsigned int reg, 
>> unsigned int value)
>> +{
>> +    struct i2c_client *client = context;
>> +    int ret, count = 0;
>> +    u8 buf[6];
>> +
>> +    buf[count++] = reg >> 8;
>> +    buf[count++] = reg & 0xff;
>> +    if (reg != NAU8360_RF000_DSP_COMM && reg != 
>> NAU8360_RF002_DSP_COMM) {
>
> Refactor to positive a check.  Positive checks are easier to follow 
> and as long as there is no major impact on complexity of the code that 
> follows, there is no reason to hurt readability.
I will refactor this to a positive check for better readability in v5.
>
>> +        /* format for Codec, 2 bytes value and endian big */
>> +        buf[count++] = value >> 8;
>> +        buf[count++] = value & 0xff;
>> +        dev_dbg(&client->dev, " %x <= %x", reg, value);
>> +    } else {
>> +        /* format for DSP, 4 bytes value and native */
>> +        buf[count++] = value & 0xff;
>> +        buf[count++] = (value >> 8) & 0xff;
>> +        buf[count++] = (value >> 16) & 0xff;
>> +        buf[count++] = (value >> 24) & 0xff;
>> +    }
>> +
>> +    ret = i2c_master_send(client, buf, count);
>> +    if (ret == count)
>> +        return 0;
>> +    else if (ret < 0)
>> +        return ret;
>> +    else
>> +        return -EIO;
>
> No need for 'else if', 'if' suffices.  And the 'else' can be dropped.
I will change 'else if' to 'if' and drop the 'else' branches in v5.
>
>> +}
>
> ...
>
>> +static struct reg_default *nau8360_alloc_defaults(struct device 
>> *dev, int *total_regs)
>> +{
>> +    struct reg_default *dyn_defaults;
>> +    int reg_num = ARRAY_SIZE(nau8360_reg_defaults);
>> +    int total = reg_num + (2 * NAU8360_TOT_BAND_PER_CH * 
>> NAU8360_TOT_BAND_COE);
>> +    int i, j, idx;
>> +
>> +    dyn_defaults = devm_kzalloc(dev, total * sizeof(*dyn_defaults), 
>> GFP_KERNEL);
>> +    if (!dyn_defaults)
>> +        return NULL;
>> +
>> +    memcpy(dyn_defaults, nau8360_reg_defaults, sizeof(*dyn_defaults) 
>> * reg_num);
>> +    idx = reg_num;
>> +
>> +    for (i = 0; i < NAU8360_TOT_BAND_PER_CH; i++) {
>> +        unsigned int l_base = NAU8360_R100_LEFT_BIQ0_COE +
>> +                    (i * NAU8360_TOT_BAND_COE_RANGE);
>> +        unsigned int r_base = NAU8360_R200_RIGHT_BIQ0_COE +
>> +                    (i * NAU8360_TOT_BAND_COE_RANGE);
>
> Just add a local:
>     unsigned int range = i * NAU8360_TOT_BAND_COE_RANGE;
> to simplify the code.
I will add this local variable to simplify duplicated arithmetic in v5.
>
>> +
>> +        for (j = 0; j < NAU8360_TOT_BAND_COE; j++) {
>> +            dyn_defaults[idx++].reg = l_base + j;
>> +            dyn_defaults[idx++].reg = r_base + j;
>> +        }
>> +    }
>> +
>> +    *total_regs = total;
>> +
>> +    return dyn_defaults;
>> +}
>> +
>> +static int nau8360_i2c_probe(struct i2c_client *i2c)
>> +{
>> +    struct device *dev = &i2c->dev;
>> +    struct nau8360 *nau8360 = dev_get_platdata(dev);
>> +    struct regmap_config regmap_cfg = nau8360_regmap_config;
>> +    struct reg_default *dyn_defaults;
>> +    int num_total_regs;
>> +    int i, ret, value;
>> +
>> +    if (!nau8360) {
>
> What?  This seems redundant.
I will drop the dev_get_platdata() check in v5.
>
>> +        nau8360 = devm_kzalloc(dev, sizeof(*nau8360), GFP_KERNEL);
>> +        if (!nau8360)
>> +            return -ENOMEM;
>> +    }
>> +    i2c_set_clientdata(i2c, nau8360);
>> +    mutex_init(&nau8360->lock);
>> +
>> +    dyn_defaults = nau8360_alloc_defaults(dev, &num_total_regs);
>> +    if (!dyn_defaults)
>> +        return -ENOMEM;
>> +
>> +    regmap_cfg.reg_defaults = dyn_defaults;
>> +    regmap_cfg.num_reg_defaults = num_total_regs;
>> +
>> +    nau8360->regmap = devm_regmap_init(dev, NULL, i2c, &regmap_cfg);
>> +    if (IS_ERR(nau8360->regmap))
>> +        return PTR_ERR(nau8360->regmap);
>> +    nau8360->dev = dev;
>> +
>> +    nau8360_reset_chip(nau8360->regmap);
>> +    ret = regmap_read(nau8360->regmap, NAU8360_R46_I2C_DEVICE_ID, 
>> &value);
>> +    if (ret) {
>> +        dev_err(dev, "Failed to read NAU83G60 device id %d",
>> +            ret);
>
> No need for a new line here, you won't exceed the recommended char limit.
I will format this into a single line in v5.
>
>> +        return ret;
>> +    }
>> +
>> +    for (i = 0; i < NAU8360_TDM_TXN; i++)
>> +        nau8360->tdm_tx_func_slot[i] = TDM_SLOT_NONE;
>> +    for (i = 0; i < NAU8360_TDM_RXN; i++)
>> +        nau8360->tdm_rx_func_slot[i] = TDM_SLOT_NONE;
>> +    nau8360->tdm_chan_len = 32;
>
> Either use constant or comment any use of hardcodes.
I will define a macro constant for this value in v5.
>
>> +    ret = nau8360_read_device_properties(nau8360);
>> +    if (ret)
>> +        return ret;
>> +
>> +    nau8360_print_device_properties(nau8360);
>> +    nau8360_init_regs(nau8360);
>> +
>> +    return devm_snd_soc_register_component(dev, 
>> &soc_comp_dev_nau8360, &nau8360_dai, 1);
>> +}
>> +
>> +static const struct i2c_device_id nau8360_i2c_ids[] = {
>> +    { "nau8360", 0 },
>> +    { }
>
> Please match the style of existing entires.  Checkout Mark's for-next 
> to be up-to-date with recommended style or see commit 910714d4e79b 
> ("ASoC: Use named initializers for arrays of i2c_device_data").
>
> [1]: 
> https://patch.msgid.link/ae2ff4898eb340bd8bcafb7b75443eb4a0ce3e76.1778692164.git.u.kleine-koenig@b
> aylibre.com
I will update the array to use named initializers to match the current 
standard in v5.
>
>> +};
>> +MODULE_DEVICE_TABLE(i2c, nau8360_i2c_ids);
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id nau8360_of_ids[] = {
>> +    { .compatible = "nuvoton,nau8360", },
>> +    {}
>
> Ditto.  Sidenote: you've used a different style then for the i2c table.
  I will fix the style to be consistent in v5.
>
>> +};
>> +MODULE_DEVICE_TABLE(of, nau8360_of_ids);
>> +#endif
>> +
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id nau8360_acpi_match[] = {
>
> struct acpi_device_id is available even if CONFIG_ACPI is disabled.  
> Not sure if we even need preproc #ifdef here.  Remove it and do some 
> compilation checks.
I will remove the #ifdef wrapper and verify the build works with and 
without CONFIG_ACPI in v5.
>
>> +    {"NVTN2002", 0,},
>> +    {},
>
> Ditto.  Sidenote: you've used a different style then for the i2c and 
> the of table.
I will fix the style to be consistent in v5.
>
>> +};
>> +MODULE_DEVICE_TABLE(acpi, nau8360_acpi_match);
>> +#endif
>> +
>> +static struct i2c_driver nau8360_i2c_driver = {
>> +    .driver = {
>> +        .name = "nau8360",
>> +        .of_match_table = of_match_ptr(nau8360_of_ids),
>> +        .acpi_match_table = ACPI_PTR(nau8360_acpi_match),
>
> Does this compile if I disable e.g.: CONFIG_ACPI ?
I will confirm the build works successfully with CONFIG_ACPI disabled in v5.
>
>> +    },
>> +    .probe = nau8360_i2c_probe,
>> +    .id_table = nau8360_i2c_ids,
>> +};
>> +module_i2c_driver(nau8360_i2c_driver);
