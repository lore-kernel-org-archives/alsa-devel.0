Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6A2C5B572
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:00:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 483DD60250;
	Mon, 17 Aug 2026 19:00:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 483DD60250
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786986025;
	bh=ySjy65TPM2kNp1q7ryaPdkIhbkdqC+DpDrVF8bOxacY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DhLPLjPAVtavn8C4whyqtyy6eppNdBS7I/5lzeGL8HCCHxFWZRNDt1bX19uVk5lof
	 F4l5l77cfTQZ+Uby1qttabrmvDPe2jbIf24WMhtKtbL0uSOtuuFKGLTjUphWUaVRzE
	 768y+V2XQkDljrmCxzEgFkxYpAlxDAhyJ64JnxKw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 44088F8062F; Mon, 17 Aug 2026 18:59:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BC509F80624;
	Mon, 17 Aug 2026 18:59:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55EC1F8047D; Mon, 17 Aug 2026 05:13:27 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786936406;
	b=bUZxvQiDbbk40O5TTZ/qnDLvDEOpI4TE3zvEVRJg8a8ckDZuCzxnlVmcJu7YF/0LUvoY
	 dH11u67PsEhDjMVsBaq0ENFPKWN3KfmZzdEjuyzSWGowjNAVlJmumMGIdiVqyd4pPgUO/
	 t6uNe9LRgEg32yN6cV6yqIVcSHD9/0dvd0tdbyD6A6Cj2umzMbLDH80h5IvTZtuogjPgY
	 vObDJXiXdWG/re5DvdgubyCNaO47k1KZylRdHX/A1ANSbDFbLXac5H/UHK3qchetZMrcX
	 MCyHORBNDwQ7RNWyxOl2Ah3+vwC/zvWGMxh3yG3AdbuJjZPDMnrUfMtyTx2U5zRMWzw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786936406;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=ySjy65TPM2kNp1q7ryaPdkIhbkdqC+DpDrVF8bOxacY=;
	b=N0no79Yjcx6hHzCjFuO9fjpLhXF9ha4r9Z5eNov3JQ3b1TEHshct6dI5eO3OsH6f9v2n
	 nyCKHCf9COz0+Pp6IVeEQ8CDpqB2FC8fdUqXz31KtNVcpdPckwF2+IG8H93TBiXcqym5d
	 IfCK4ODFq3zfIKeTILzHJIIXBnf0jd4LPQfeCNle4fsGOVjYvp2jthxRPFsykQ0oOYBLE
	 3mfQ9agZO5iYB1WVsx+GB3/hosXB/2+SztOUCHgGY11X4D4j+GfDRbRq9DJs744eGyE+f
	 gkVClQjhJrtGTsKMUk2ceTM9p/m/42tvSX63ixJvDLp8JUIW5Q6/lVihUHIsfwPgr5A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nvbrV2yI;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 42BAAF8011B
	for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2026 05:13:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42BAAF8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nvbrV2yI
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2d032846c95so42333355ad.1
        for <alsa-devel@alsa-project.org>;
 Sun, 16 Aug 2026 20:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786936403; x=1787541203;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fIFCFL/FzLVixG6UIbo2y72gPYEoT51ibOB2HZxvDXU=;
        b=nvbrV2yIjweajWm+AXB3rTWfSEMSyh6Au9x0xDKoPomtp3JswPz6Pq++G1pb5dxFNr
         ftoda/mOsfzsHJhxdK+ayqRblALoJnG3B6S+rIsjFUpOqKbXdRLJraRYDsW7Dbzn868r
         ZDCbguAyowSyABNvQjgwIrTF4G5ZqLfwwmmLFFyLcOrVyD98U9mv9zQBxJFzenwDn8ES
         Jt1EmxTn1FJ2eQW0rYpQeAyOENze3MTjmcmaRpSkgIyaZFNjXzGQjqvsVFOTjtF+bWpl
         i8x+GkiaPr9o2e5zkOEI29zRiTptBh4EkjLsBkH9tYxUo3F8vivmz5fXB4Z9xPKgHb69
         U8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786936403; x=1787541203;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fIFCFL/FzLVixG6UIbo2y72gPYEoT51ibOB2HZxvDXU=;
        b=k6jZlYjcWCE9NvcVQApMZ4NlqmhenekUkI7j1y8cTP7aikSy3fYhN4HnGqcEgBvIhU
         gUuE1OwPWrf/hntF2qJBqryn4onH03MdX4JdzYz9rUITizlMvC+cus0Af5RETIdSr0FQ
         IGuTjWy/CJx5SyErKTo+w+RK5LUqbwZIFGrYpQKR4pcuexmsTS0KIhWNUPXhKMZruNRa
         HopgtI5RdSUc1wdN3XLZEIdCtwHuAaMHNzbXI23CvEl2JAeGypp2Z67ELBrNj37Ba2GT
         z5Av8cU72u+vGWxIRZxmBM4xeM7qEF9mU3xJeQzAnMhFvQFt9ovYt7yCDmIrx7MLPZl+
         oEig==
X-Forwarded-Encrypted: i=1;
 AHgh+RoS2MRZ9KkHlzS3ltyZFmQ94ukkTyfH2DCE2P5imhs419SxB96iLxlC83AcpL59bHJTAxYMsCWQikhY@alsa-project.org
X-Gm-Message-State: AOJu0YxbztGi+bDw4xWLATBo/CnJlouMIEs3YwoQiIew9YPeS0O8/dfB
	6wl0+Gc9Jtq6hI0Q/6P7qvN7FcBjhuVfjTMsZ61i0vYsy8JUiuoMpT/w
X-Gm-Gg: AR+sD13mQqoDt9PN+8kvIzk9sNDjsgZRuGgUR7BYDYqQa7x0AX1YX9KjugNqm6q/2WA
	8ek2XlmzGNx7EcIFMbmgTM2bkkmXKW5Oow6g+BU2r2FCQUViEXez86bT75MwN8YVOn7az/t6jfw
	ib1ADU6T/3HDxf3Z+s+3tMmKRYxUfqY6n82AhHJw8cBKhurDlWTM4FbfX3aznYXXKjt9Gi92Zpl
	J58XmSfw/jc9/VbSJY5JhtobV2qLNCL1/2VSpoSqKRY0wR+rVipIQl6iU6DCKt9lL0YT8f5g/+M
	1kfGx+Q4TedvNYyjv8k9Bq7IRzafxkj1Hbqd7o+COYTDqxAxrcRhPrTmpZGoNNwOxQRnTpPIDH/
	iz4BfZBjkzYJckzKJktyvLDCBaY4jJixXYwRKNdnoz//S9tLh8FD9zttud0QwLnEDhENS2LpohX
	jEiUZM00Y1D3haQX8Md5d3fCq3SVNwIyTEHDy/iUtK0f0mi+M6/VqGcZXe/zUpEV1pQau0s0/pV
	f47NbOFq7Dm7BQ4CcWnBEjxbhlw1nCnvy2H
X-Received: by 2002:a17:902:c94a:b0:2ca:53e1:b915 with SMTP id
 d9443c01a7336-2d3b0c48633mr217526625ad.14.1786936402761;
        Sun, 16 Aug 2026 20:13:22 -0700 (PDT)
Received: from [172.20.10.2] (111-71-66-151.emome-ip.hinet.net.
 [111.71.66.151])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae50bef1sm28371735ad.0.2026.08.16.20.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2026 20:13:22 -0700 (PDT)
Message-ID: <934a4c11-99a6-2c97-5d12-6aa8da2e64f2@gmail.com>
Date: Mon, 17 Aug 2026 11:10:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org, krzk+dt@kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, sjlin0@nuvoton.com
References: <20260813064327.1127236-1-YLCHANG2@nuvoton.com>
 <20260813064327.1127236-3-YLCHANG2@nuvoton.com>
 <d57c05ce-929e-441f-b02a-2e1598a06ee7@sirena.org.uk>
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <d57c05ce-929e-441f-b02a-2e1598a06ee7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: GJVAVAWWMACHRLCUFYHVMFCX6AUYWWIY
X-Message-ID-Hash: GJVAVAWWMACHRLCUFYHVMFCX6AUYWWIY
X-Mailman-Approved-At: Mon, 17 Aug 2026 16:59:30 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GJVAVAWWMACHRLCUFYHVMFCX6AUYWWIY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 8/14/26 00:20, Mark Brown wrote:
> On Thu, Aug 13, 2026 at 02:43:27PM +0800, Neo Chang wrote:
>> Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
>> stereo 30W+30W smart amplifier with an integrated low-latency
>> Advanced Audio DSP.
>> +int nau8360_dsp_init(struct snd_soc_component *cp)
>> +{
>> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
>> +	int i, ret;
>> +
>> +	for (i = 0; i < NAU8360_DSP_FW_NUM; i++) {
>> +		ret = nau8360_dsp_chan_kcs_setup(cp, nau8360->dsp_firmware[i], nau8360_dsp_addr[i]);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
> Should this or the binding parsing code do something about PBTL mode,
> the binding says that the left DSP firmware is ignored in PBTL mode but
> this looks like it will still try to load the firmware.
In PBTL mode, both the left and right channels must load firmware.
However, the right channel will be the primary channel
(meaning the left channel also needs firmware, but its actual data 
content should be identical to the right channel).
I will update the yaml binding documentation in v9 to clarify that both 
firmware files must be provided and loaded in PBTL mode,
removing the statement that the left firmware is ignored.
>
>> +static int nau8360_peq_coeff_get(struct snd_kcontrol *kcontrol,
>> +	struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_to_dapm(kcontrol);
>> +	struct snd_soc_component *cp = snd_kcontrol_chip(kcontrol);
> This is registered as a regular kcontrol so should get the DAPM context
> with snd_soc_component_to_dapm().  Same for _put().
Thank you for pointing this out.
I will update both the _get() and _put() functions in v9 to properly 
retrieve the DAPM context using
snd_soc_component_get_dapm().
>
>> +	if (snd_soc_dapm_get_bias_level(dapm) > SND_SOC_BIAS_STANDBY) {
>> +		dev_dbg(nau8360->dev, "PEQ access is not allowed during playback");
>> +		return 0;
>> +	}
> What happens if something starts playback simultaneously with this?
> Nothing stops playback starting before we start accessing the registers.
> The check will also fail if we've got an active capture stream, IIUC
> we shouldn't have one without playback since it's an amplifier and
> that's presumably for DSP feedback but at least the docs should be
> clearer.
Due to a hardware limitation, the PEQ registers cannot be updated while 
audio is active.
To prevent playback from starting simultaneously, should we add a lock 
mechanism across the PEQ _put(), _get(), and PCM _startup()?
Also, I will add inline comments regarding the capture stream and update 
the debug message to 'while audio is active'.
>
>> +static int nau8360_hv_pre_event(struct snd_soc_dapm_widget *w,
>> +	struct snd_kcontrol *kcontrol, int event)
>> +{
>> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
>> +
>> +	if (SND_SOC_DAPM_EVENT_OFF(event)) {
>> +		snd_soc_component_update_bits(component, NAU8360_R9C_HW1_CTL2,
>> +			NAU8360_HW1_CH_MUTE, NAU8360_HW1_CH_MUTE);
>> +		snd_soc_component_update_bits(component, NAU8360_R99_HW2_CTL9,
>> +			NAU8360_HW2_CH_MUTE, NAU8360_HW2_CH_MUTE);
>> +	}
>> +
>> +	return 0;
>> +}
> This is registered as a SND_SOC_DAPM_PRE() so it'll run for capture
> streams too.  That's probably not the end of the world since IIUC that's
> only used for speaker protection data but it's still fun?
You are right. To avoid this unintended behavior during capture-only 
streams,
I will remove the global SND_SOC_DAPM_PRE and SND_SOC_DAPM_POST widgets 
in v9.
I will move the event_on/event_off logic directly into the 
nau8360_hv_event (Class D) widget
to ensure it is only executed during the playback path.
