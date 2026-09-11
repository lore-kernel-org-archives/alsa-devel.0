Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F992C88E5C
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:29:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51C8960214;
	Wed, 16 Sep 2026 08:29:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51C8960214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789540164;
	bh=aGG9GySrHo3aT729lj4kupW+yah0H41IU1upRHxXT6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FS0PXWpqGD3pncm+IvXBEfBlbN4q4fZw3kFfzJI5TdG5tLOpaXIFcw47q32F6BUis
	 Pj6W/Q4F+nkhed2GI6kX25lgEkQXfuJg0H3WGpN/O+bMQcZ8k3s3QTJIKPzgt6QCjk
	 3yZihHkkurjLIdL3AJFjH5FZU2cWXNpFpHpmnIOI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 129FBF80524; Wed, 16 Sep 2026 08:28:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0DB10F8067A;
	Wed, 16 Sep 2026 08:28:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 38885F80038; Fri, 11 Sep 2026 04:36:02 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789094161;
	b=OmIqjaPhbBaKTu6FekHQAt67rHLZAWxRGc36MdufW/KwAEet1+5D5sRmyZES/Qj3MXMp
	 rv8KyJwhG0GgngJjzE/x9UFroK3AoRzbYYVKXR3fpOu8uxCyHe+CVprr/K8Xb8kU4FwwE
	 +iLUFNKC8P0agRM8gjUCbEWlcE+fjYEmLDL8fhJscaOejCnupkY4puyEyLGEkVFwC62ze
	 f2VX0CEveQ29QCeO+dk5nPGpFCvc4bq9ZWeSUTIXFIfEQZTSQ2/PWl14iYUwDBb6WtO1s
	 NDCWdvlVMK/BTZHhZLvDtAiREp5oLM5ngT84wPjxD25y3fFYK8vSUrDb0Pj5w748pCg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789094161;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=aGG9GySrHo3aT729lj4kupW+yah0H41IU1upRHxXT6I=;
	b=ickpib0tZmDVawZbhvDPCe8TCQUaoomACOaS/WDCKY4gC9ceA/FeaosZaxFhXC15WGvc
	 5Rtk7vM3JfwJ9dZKnFTpMz/xuIuK0vKdEvrp8RrMrJjqq1pvkaNDEj8ogT6Bgh2Oiv1bR
	 MgJx8yUY6qeQMXFtrJruhUqEwuMkqgbzbePl4O5NZWf2xcezqBVAoyahU3Z3E48VgJh0V
	 N5Jcf6kPvkaXerBs/R6znt25BluDMGxKv/BWkUHlgUxDNaKbMEjIbtlScRVbOWnuih7j4
	 ii7iJoSFtVLWmZiQL3R63X3c0Xqy5EZJ6fBFPutjMXKsb1E9G0Xt7ejpS2l6ALBWr/Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Q6WJVb+z;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2F3F0F80038
	for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2026 04:35:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F3F0F80038
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Q6WJVb+z
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2d6efd73032so16342835ad.0
        for <alsa-devel@alsa-project.org>;
 Thu, 10 Sep 2026 19:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789094158; x=1789698958;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MBqtsP/CWLSVd4X3g+IUHWQOXUwsfrAeb1YA314853Q=;
        b=Q6WJVb+zJifH3PXuFKmOHzzPoQdvXVXo5v9sL6FfBOCmmpT4D7LR0j91v9m0MfMwcl
         E+XLqVyQVzr91lSzIdr8Y48dl2pIoxGLOGF2Q2n9H67fzGE6PYgBuDJ4e0veCC63tDoX
         MJiuJvV2B/Rrb3rtz/yN/Zy9vN3drKsxAvORHQpZa9Lzujeww8HGfTSEiqxeDMVRkRxJ
         Q2x0SNgvaRLtLLq6iTtbKWfhUPD5AauCOFj6JewYXoptYXLPS8C9FAjPG37Xnnw83MOY
         nrVxSIzCh1+O12rKs2xP3Ml9hyNKTrfJDHtDxM5gejaaq4s/vqQsI6qyabTajPfqqIAg
         Hdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789094158; x=1789698958;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MBqtsP/CWLSVd4X3g+IUHWQOXUwsfrAeb1YA314853Q=;
        b=fpazu+879HmjulvlXWMN8uS1o9s17OYanlXQPxfjFvZTkWTV3kzu38EREXiB4mk5J5
         xs0cr3U4OXhJ/jUS1ugeBWYavWlww6AxOWVlrdz/a1/zND70+klVlAYh+bPYZxT9yMyM
         Cs9wydjQ5vLuRgWJTT9mm/qy5MmNut0GuymGEpOxDdzi7lGHdD3tJuCxby6n8o4fpG3U
         yZH460TNSaQuaoVrgCdOIQxadQ+3ZLbpE1QbyQB5sgYLLpd4B4ARJJzTUDz4RI1DH1cO
         5LVATsLCfEdQK7+LjsBdDM8hJ8kYT2wxIWuc4PGcyYNBDXdDCkOYjYx241CWbhvtsP5D
         nPjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxM1YyLY/JaR65E1wW4/44wlD7d1MOxcsKF0WvC4v2fsA9vRYFgO8x5fcSgw08OMSiCcyDyflP1xXdE@alsa-project.org
X-Gm-Message-State: AFuF++n2qy5Yab7F2hsCVcZDX5GEyVsYuWw7DMoHZHi9x8XumYeQ3Eul
	5K+GkROlSA/9vmL9fBOvk0L+rHCyMy6LVJy0B1eN5GgHTLZmois44KGV
X-Gm-Gg: AYBFou2Qj//is3i3Kh7nksmRfloqiDdgZTwakb2R+sHkiDQnzVfCsj0M00ZY8H8TLP9
	WI6MpZ0YD2Dehc2vzG3LfhyDf50URcllvgaZNhM8G8UK3aIw0HyvkULqlACRg5Z9e4J1lmB7Rnz
	b9vYpueowWESkbI/But9GaNFPxHgCWZH1vEZYhJqhnlFENmT/0rkkxaDcUgNU675sLrnv55X+xN
	uYUhdmMaCVWAI4JYRpUFTtOhM4Cw+XmWJgo5SDxlImTRQEctWJXJwHPXOY1D4DpV5lLfnxkGqW0
	mPQoMoTj7M85QCqJH0JFubG/cRyAs90VbFbQIZ6fJZFB25r04j0v5PaaaB1ODx7cL8Qwh+mvHRY
	Y5xubnB9bDqmAOv/F8ZmE03Kg8aRTv2QGx1PvjuP9YxAKw+cdVtQZFbsyb4vIUuxuOhTh7bLsjJ
	9LVR65kUKeLp/N8HQ+JWVszYFR7PR8wA72IUaIoEsKNbrmEeXgtZaYqBvefA4+Ka5804xTEqdyj
	ts8gfzVuNQNORB7j9I13nYJeUXKgxO9VBQ=
X-Received: by 2002:a17:903:388c:b0:2d9:14e8:bcb7 with SMTP id
 d9443c01a7336-2dd0e8a213dmr85013585ad.3.1789094157678;
        Thu, 10 Sep 2026 19:35:57 -0700 (PDT)
Received: from [172.20.10.2] (114-137-148-9.emome-ip.hinet.net.
 [114.137.148.9])
        by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc4c6550bbasm397520a12.17.2026.09.10.19.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 19:35:56 -0700 (PDT)
Message-ID: <cc7de691-0b64-462d-9fba-9d8ed000a222@gmail.com>
Date: Fri, 11 Sep 2026 10:33:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
To: Dan Carpenter <error27@gmail.com>, Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
 krzk+dt@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, sjlin0@nuvoton.com
References: <20260825021644.1203076-1-YLCHANG2@nuvoton.com>
 <20260825021644.1203076-3-YLCHANG2@nuvoton.com>
 <aqK_oOpMAXVhxkHJ@stanley.mountain>
Content-Language: en-US
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <aqK_oOpMAXVhxkHJ@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: PRZFM7AXMZPYBKLLU4L5Q3EURP3OF3KO
X-Message-ID-Hash: PRZFM7AXMZPYBKLLU4L5Q3EURP3OF3KO
X-Mailman-Approved-At: Wed, 16 Sep 2026 06:28:11 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PRZFM7AXMZPYBKLLU4L5Q3EURP3OF3KO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 9/10/26 22:33, Dan Carpenter wrote:
> On Tue, Aug 25, 2026 at 10:16:44AM +0800, Neo Chang wrote:
>> +static int nau8360_dac_mux_put_enum(struct snd_kcontrol *kcontrol,
>> +	struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_to_dapm(kcontrol);
>> +	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
>> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
>> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
>> +	unsigned int *item = ucontrol->value.enumerated.item;
>> +	int ret = 0;
>> +
>> +	if (snd_soc_dapm_get_bias_level(dapm) > SND_SOC_BIAS_STANDBY) {
>> +		dev_warn(nau8360->dev, "changing path is not allowed during playback");
>> +		return ret;
> This is another case where I would prefer return 0 or return -EINVAL.
>
>> +	}
>> +
>> +	mutex_lock(&nau8360->lock);
>> +
>> +	ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
> Not related to your patch but the comments to snd_soc_dapm_put_enum_double()
> say "Returns 0 for success." when really it returns true/false on success
> where true means it changed something and false means nothing changed.
>
> regards,
> dan carpenter
Hi Dan,

Got it. I will change return ret; to return -EBUSY; for the playback 
check condition in the next patch.
Also, thanks for the heads-up regarding snd_soc_dapm_put_enum_double(). 
I'll keep that in mind.
>
>> +	if (ret <= 0)
>> +		goto unlock;
>> +
>> +	nau8360_dsp_switch(component, snd_soc_enum_item_to_val(e, item[0]));
>> +
>> +unlock:
>> +	mutex_unlock(&nau8360->lock);
>> +
>> +	return ret;
>> +}
