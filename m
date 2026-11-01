Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63707606A326
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=FiMrpYt0;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TckODi8E
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 356D06020E;
	Mon,  2 Nov 2026 22:14:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 356D06020E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793654054;
	bh=emt4OjL+/LipNW4IZBhyCSOLLno50wg5Z9yLtDcIYpw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FiMrpYt0fjDV4R7BahNvWTg0PSQm7otmU1uPcGyjglJP9kx0//DhteTE2kfmgcQHf
	 L1voMi0er+ySgBtkibzsj1FnKsWx7X5VG4ROgc/Dkh2ZtgJyOtmJ5X9rEl6Pgj87VD
	 3p/EHltWAPz6cbpndPhEu7gB4/AmCg+uLLYsTaNg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 657B9F805F4; Mon,  2 Nov 2026 22:13:41 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BBE97F80603;
	Mon,  2 Nov 2026 22:13:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A76B6F80272; Mon,  2 Nov 2026 16:12:26 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.215.58.134
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793632345;
	b=FXce40DfLXQZ+yIHb7Bw3m9t3g98Qp6nuBFgaHRvkiURQJ/u2Em4IR6tMPuZdOOVY4Tx
	 LMqmWqxVuvWVM5MHEJjOnMhTntQz29xw3qihv54TPyQSW/AZ8jOUXCzmiXIoRC1Q/KDbg
	 tTW6IGPwOshtbXZxaEf1keOYrGBMpjj421+A6bN2fwv+tRKu3h014sHSk/nj+T7d6ygC1
	 SdJ0flHVokEsG4QW+lT0I9N/B9juRpbOoUstruYbY61cpYm7zqcz95olPRTvg/WjhHjF1
	 GwJiuwGnsEXA5b/YAT922IMmkuPMg7PIR26sKaP+30FH7aE8UlnC7SgTMRghAAFwEow==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793632345;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=emt4OjL+/LipNW4IZBhyCSOLLno50wg5Z9yLtDcIYpw=;
	b=dDdUH+GAd3RxuvfeneIAJWRH28DCLe5TPVY1DIxXk/s+mqbr9H+K146wQOsD27J+4mfk
	 lnJMnPohLfIXJPeARlY2qabF6POiVjuykk5SWn/d47s4CFDUvt92D4H/OlWKU/qEJs/92
	 aE/UQ5IPtoTWaYOZwSu+RLZYNHIcH9BCKITHlQueb9r5YSDmlMReTP2ZtQqksRMK2vW9V
	 7gvlNEcEQobVR8aZZCBBjtEppWF9iRGgyF0n5ZHGGOvU3LvEzBksRJPN/wdPabzf8zKbW
	 r2ie+6xbQ0g2AdATtV0yoJX3J3hlJ8+u9PNa/6PrApiY16edNP559Zbk/3uanAjkgpg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=TckODi8E;
	arc=none smtp.remote-ip=95.215.58.134
Received: from mta1.migadu.com (out-134.mta1.migadu.com [95.215.58.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 662B8F80095
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2026 16:12:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 662B8F80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=TckODi8E
X-Envelope-To: alsa-devel@alsa-project.org
DKIM-Signature: a=rsa-sha256; bh=emt4OjL+/LipNW4IZBhyCSOLLno50wg5Z9yLtDcIYpw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793632343; v=1; x=1794237143;
 b=TckODi8E4HdSAuBbhwPfv6N+H3yyfUqZfh3WOp66Xmv2GJjeTvQmHhyXfCV904jzIyTY7ZYX
 vG9eKiTQh+FuY9G0dLUASK9iN6d0DLV46PuKoLkKRel2O5y87hl1xF2uWKYQ6zP3qPRKaqoWSRn
 F0xuakpuIh//5TvXOa51gMmc=
X-Envelope-To: alsa-devel@alsa-project.org
Received: by smtp.migadu.com with ESMTPS id 9dbb22a9bc9b35b4;
	Sun, 01 Nov 2026 18:34:36 +0000
X-Mizu-Trace-ID: 9dbb22a9bc9b35b4
X-Migadu-Flow: FLOW_OUT
Message-ID: <fe3eecdc-eb7f-4b1a-947c-fa05c4602fd1@linux.dev>
Date: Sun, 1 Nov 2026 19:24:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/16] ASoC: amd: acp: add ACPI machine tables for
 ACP7.F SoundWire
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, yung-chuan.liao@linux.intel.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
 Mario.Limonciello@amd.com, Richard.Gong@amd.com, Poojitha.N@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 sound-open-firmware@alsa-project.org
References: <20261030094714.1123396-1-Vijendar.Mukunda@amd.com>
 <20261030094714.1123396-14-Vijendar.Mukunda@amd.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20261030094714.1123396-14-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-MailFrom: pierre-louis.bossart@linux.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: L3JSESNSFSQOKJFLOUTZZ437ONP5FC67
X-Message-ID-Hash: L3JSESNSFSQOKJFLOUTZZ437ONP5FC67
X-Mailman-Approved-At: Mon, 02 Nov 2026 21:13:36 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/L3JSESNSFSQOKJFLOUTZZ437ONP5FC67/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On 10/30/26 10:45, Vijendar Mukunda wrote:
> Add amd-acp7x-acpi-match.c with four snd_soc_acpi_mach entries for
> ACP7.F SoundWire configurations:
> - RT721 + RT1320 on SoundWire links L0+L3
>   (jack+dmic on RT721, spk on RT1320)
> - RT721 + RT1320 on SoundWire links L0+L1
>   (jack+dmic on RT721, spk on RT1320)
> - Standalone RT721 on L0 (jack, amp and dmic endpoints)
> - Standalone RT722 on L0 (jack, amp and dmic endpoints)
> 
> RT721+RT1320 combo configurations use jack_dmic_endpoints for RT721,
> skipping the internal amp since RT1320 provides amplification on a
> dedicated SoundWire link.

[...]

> +static const struct snd_soc_acpi_adr_device rt721_l0_single_adr[] = {
> +	{
> +		.adr = 0x000030025d072101ull,
> +		.num_endpoints = ARRAY_SIZE(jack_dmic_endpoints),
> +		.endpoints = jack_dmic_endpoints,
> +		.name_prefix = "rt721"
> +	}
> +};
> +
> +static const struct snd_soc_acpi_adr_device rt721_l0_only[] = {
> +	{
> +		.adr = 0x000030025d072101ull,
> +		.num_endpoints = ARRAY_SIZE(jack_amp_dmic_endpoints),
> +		.endpoints = jack_amp_dmic_endpoints,
> +		.name_prefix = "rt721"
> +	}
> +};

nit-pick: The naming conventions aren't self-explanatory and don't match
the explanations above. The difference between l0_single_adr and l0_only
are related to the endpoints used, and they don't match what's used for
rt722 below.

[...]> +static const struct snd_soc_acpi_adr_device
rt722_l0_single_adr[] = {
> +	{
> +		.adr = 0x000030025d072201ull,
> +		.num_endpoints = ARRAY_SIZE(jack_amp_dmic_endpoints),
> +		.endpoints = jack_amp_dmic_endpoints,
> +		.name_prefix = "rt722"
> +	}
> +};
