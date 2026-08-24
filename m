Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DADC5DF81
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:47:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2BE3B602AC;
	Mon, 24 Aug 2026 13:47:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2BE3B602AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787572066;
	bh=IcAntOh7IHjex268kpIeIclWRWwYpWZIiIuBC8ontzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nicSOgTrCyRJvmjW+WGA9bKZmeWaCu6Wbwxd3MLoopGxFl18cezFOG+CcYArtHEem
	 BZHQtGlEJmGizPN279FT5w6kWeKAsqdYXCpfvzNsgTPP7BdEq05aJ5SnPSuDVDanHu
	 sOJaENZ9z/YkyQmGkoAAoCLgddZa4aegxlCem6fE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CF20BF806DD; Mon, 24 Aug 2026 13:46:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 81F60F806DD;
	Mon, 24 Aug 2026 13:46:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F417F805A8; Mon, 24 Aug 2026 10:26:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787559992;
	b=UZkGw3gaMACFpfDSGNMotPlzEKtENVU1OVTJRJ/GbdCDA1pEX3CPMof0MN3piyiV5HiV
	 EnA4YEAEkfRE0/zAVkVvg8kGO3Y97Ox3ZkMMiEdOgwzNSqMMjQ4gwWa2KU6e9IaypAKea
	 I1rcUMMloaI5yMkvUmwIAVBTnPI/07KGTW1dYt+yME4gAVJGmxQptb7kYFD9kCbWzOIXt
	 8KLJNBFxvtyy+Eyid48CcaiFFaRgsHXV1WnLHmdgLluyzv7joikAHLAKYEiyuYemrdVWC
	 TCPLU+0xm5mYmtr8Qvt+FpTJMkvQSOkUxHIzTgmWziAuxhtGVV8vR6k/gW5MR+mMkEQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787559992;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=IcAntOh7IHjex268kpIeIclWRWwYpWZIiIuBC8ontzo=;
	b=TT3fvUfolo9YMvgkht7xcFWWwaIgAz2+xCdP4UFecLDS+UALrT9sMyPB1axS/JWOhhIe
	 B94/DyJHeL9O7SA7onWK7qcqI9lSwCPiIBdhvsH4mdr7L1rpGCMorlMPq8XsvJ4NdvzYY
	 gjZUobTZ5DZy+a6YMU8/I421amVoSWVdcabet0+8lMpAhiTHXT1kzb2RQo8C9VakHgPx0
	 WaBOjOWw9NKValONCEdy7F4N06JY+PhvPVG4QSPkGWCeRngGpu6/QfYL6w0+PwxCbxhEj
	 9VDm0yW/XN9PzwFlgTi5UpJKbsH5E6aTcqnN2z6xmve2asE3JOCVJ+AbatfwZB1FGOg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jIf3Pd08;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CD7D5F80075
	for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2026 10:26:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD7D5F80075
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jIf3Pd08
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3900e39d935so3192252a91.0
        for <alsa-devel@alsa-project.org>;
 Mon, 24 Aug 2026 01:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787559989; x=1788164789;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zpKY1Gh5ZlUDMT2T5S01JZglILnkty62PxyLVIepUZg=;
        b=jIf3Pd08XgTqDf/ze1fWVC1FEbbe7oSnLi0OFOi6Bqhz6n4fMz9aoIjXt7y4lP90j1
         KB1IqUksgHZC5548lDcW8mcSmuW2uFeiS5q8HKt7BJsy1a02X79Na1+lkfMC5ap4dLh0
         WwJSE6qX8nfuJtByQ2c8sD4o4U2uyP6Eibh9wiErXOIemDb8voyZlwgQDgKuvUkDWC5P
         vMSCdSEHN4e64hcONMCVV3RoKbB46dtDe7jCBkwfMCw4Ut1p5VkJVDHGTm+N319NHqDJ
         cBI/gEAFCakkram0091EI4UxqMUSHMDnuxqWPO+HfQy4L3W9bjUIgmDhRrPX6ViqhsVS
         Ab5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787559989; x=1788164789;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zpKY1Gh5ZlUDMT2T5S01JZglILnkty62PxyLVIepUZg=;
        b=j8n5N6ZFAT8fRMu4ggseFnE0fPHo+MbEeM2j7WOL51Ez1ZuxtIbrPwtNR2cDatwho0
         gDbNXVox2ze20S67N9zACGyd6Gs/k+n7OEa1FKmuRWUrjMu51OaK1ozTAjUEciaoyMNZ
         +fAABScj0Xc5u2aDBQyKMszj9/GzqB9dfnN2x1ixo2XYok2+G3RmtvyyM1WfA/Be0peZ
         g486tHpkEuRzHv9uqaNK08LutzOkxQ5cKZcfFFsjvOSbT3DGrufsVrip30WxEQZXkUSW
         lbKIQjj36F+6SEd/4L/IlBxn7u5/7VK0hZfO9+eeOfVMU36HtYu5D8McHLEGr0XjUzxf
         RKRA==
X-Forwarded-Encrypted: i=1;
 AHgh+RobAwdbB+t8hD4HY5T4PTIIbYoqY5rMDpAJ3NaO2jHl+pOep3eBwL3lnEwIt91UDuvG5QQ4qwoGcqXA@alsa-project.org
X-Gm-Message-State: AFuF++kQ5NnD889WZZU+AiQ8ElLfT79+gPXAsCK5azwR4/dsFHijak2Y
	ncsJuWdzTLi9Q8y9FSqphVzhhaB2RI9xafOfS5WrzojrS5jmlfgG5KBB
X-Gm-Gg: AR+sD11u4IzWHlx/kzFVILHBQlUy3TBAgnSJgrdpHMHaU5PDfz4vqmcGpUwafej70cd
	aku4X5QeI06hcb2AfYI5mgrz+dFrf8nyTvCbHPMof473BjwNKPiuzwT7B+zi0IPAqWJNXISDTYI
	Vk+1lxzmTBup1dKI9fLs8xnMUKPIBG7H+DRXcZm+BATxKTDbPUfpYazeDiFG8gT/DODbX4AN82Y
	kykmO1i/NkGOrsFxoW9wTru4BympaYh33djAjEQbzOVb8dAWaOQUoEZTXfWJipVM0Wn952JGpnA
	y1ZN2vzMiDWnqkEoz8xbzaTvQUIQMUphx2WwDHuGKXGPYOdcNFpDQBVcxUhbiabSsz8qbKqc9zu
	UefHpavEJxPO1nrXEnPbTRZEsncH9gdIo6HOaVzi21X3Y5NQMZHBbDx1Gd9TQt4siqD4zUPm1ky
	Ze77zzExXYvk2mU12DHts9Reeau5stc/Sf0Tci5t8USWjoXnCHbIz5Kv7HYlxnWWOwgv2EKQzMj
	w1x20TReEiCyIVSDLZx/6BHZX3ZjNLXwi36l5KkxXsEcDmosG0nLDkrniO0GFrllUR85XzghxdX
	udfxDNT3SnspHED0sH+LeWHYfRZicA==
X-Received: by 2002:a17:90b:2cc3:b0:392:e5b1:d833 with SMTP id
 98e67ed59e1d1-395df29666cmr31573039a91.13.1787559989298;
        Mon, 24 Aug 2026 01:26:29 -0700 (PDT)
Received: from ?IPV6:2001:b400:e3ee:1d2:6c98:a08:2638:bfd9?
 (2001-b400-e3ee-01d2-6c98-0a08-2638-bfd9.emome-ip6.hinet.net.
 [2001:b400:e3ee:1d2:6c98:a08:2638:bfd9])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e49b4060sm9164143a91.6.2026.08.24.01.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 01:26:26 -0700 (PDT)
Message-ID: <ad5e618f-eff6-4b28-8c9c-456531e6632b@gmail.com>
Date: Mon, 24 Aug 2026 16:26:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
To: Mark Brown <broonie@kernel.org>, Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org, krzk+dt@kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, sjlin0@nuvoton.com
References: <20260820022925.1174132-1-YLCHANG2@nuvoton.com>
 <20260820022925.1174132-3-YLCHANG2@nuvoton.com>
 <7e7b8329-23d3-495d-ad48-9ea70189c46c@sirena.org.uk>
Content-Language: en-US
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <7e7b8329-23d3-495d-ad48-9ea70189c46c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: RZFXYYD562KLMRANVTF3Y7Z4PECLCSYX
X-Message-ID-Hash: RZFXYYD562KLMRANVTF3Y7Z4PECLCSYX
X-Mailman-Approved-At: Mon, 24 Aug 2026 11:45:57 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RZFXYYD562KLMRANVTF3Y7Z4PECLCSYX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 8/21/26 23:24, Mark Brown wrote:
> On Thu, Aug 20, 2026 at 10:29:25AM +0800, Neo Chang wrote:
>> Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
>> stereo 30W+30W smart amplifier with an integrated low-latency
>> Advanced Audio DSP.
> A couple of issues here, mostly this looks fine.
Hi Mark, Thanks for the review.
>
>> +static int nau8360_peq_coeff_put(struct snd_kcontrol *kcontrol,
>> +	struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *cp = snd_kcontrol_chip(kcontrol);
>> +	struct snd_soc_dapm_context *dapm = snd_soc_component_to_dapm(cp);
>> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
>> +	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
>> +	int i, reg, ret = 0;
>> +	__be16 *data = NULL;
>> +	bool changed = false;
>> +
>> +	/* Use the DAPM lock to prevent race conditions during DAPM power-up
>> +	 * state transitions, and check component active status to prohibit
>> +	 * PEQ access during active audio streams (playback and capture).
>> +	 */
>> +	snd_soc_dapm_mutex_lock(dapm);
>> +	if (snd_soc_component_active(cp)) {
>> +		dev_dbg(nau8360->dev,
>> +			"PEQ coefficient access is ignored during audio is active");
>> +		goto unlock_dapm;
> This should probably be -EBUSY or something, though that will upset
> mixer-test.  As things stand since the values change when a stream
> starts and stops there should be an event when that happens, and since
> we report success some value ought to be filled in for the read.
I will change the return value to -EBUSY in v10
>
>> +static void nau8360_dsp_fw_load(struct nau8360 *nau8360)
>> +{
>> +	nau8360->load_fw_done = false;
>> +	schedule_work(&nau8360->load_fw_work);
>> +}
>> +static int __maybe_unused nau8360_resume(struct snd_soc_component *component)
>> +{
>> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(component);
>> +	struct regmap *regmap = nau8360->regmap;
>> +	nau8360_dsp_fw_load(nau8360);
> This only kicks off the firmware load, it doesn't wait for it to
> complete.  That means that if a stream restarts quickly after resume we
> will run into issues - I see that the normal playback path just errors
> if we try to start without the firmware.  We should wait, either here or
> in the startup path.
I will add flush_work() in startup() to ensure the firmware loading is 
complete before the stream starts.
>
>> +	if (NAU8360_IS_DSP_REG(reg))
>> +		*value = nau8360->i2c_read_buf[0] |
>> +			(nau8360->i2c_read_buf[1] << 8) |
>> +			(nau8360->i2c_read_buf[2] << 16) |
>> +			(nau8360->i2c_read_buf[3] << 24);
> get_unaligned_le32()?
I will replace the manual bit shifts with the unaligned function in v10.
