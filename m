Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C909606A333
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Odfrk2jU;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fnzIIwsg
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BB9C6022A;
	Mon,  2 Nov 2026 22:14:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BB9C6022A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793654068;
	bh=Mx5lXE61FEtyxVjZYvYVCCXsLI55yMipYdYQ5PE+OQ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Odfrk2jUcBmvJhyWj+Ch6nMFnF6sHDRsUjQMfYiJ56+1aE995Ssk6P3N3TrKjAeQO
	 lLExdlBf+DMxTS8fXfGTYPHomp+NLn4QbZoNbb17iEGEiV+hA8+PZGIZbdfIm+iNkO
	 zDNzl004iz/cHdEUeBTFaabXgEfSZbbEHGQb15Fk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4644EF80619; Mon,  2 Nov 2026 22:13:45 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A78B4F8061B;
	Mon,  2 Nov 2026 22:13:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F82FF80038; Mon,  2 Nov 2026 16:12:28 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.215.58.135
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793632346;
	b=AZ43lYCCxK1GX3oiRlGTxsH5JrrPJqHyOG0Ccfo/1J6Go5mWCa4r02APLLWzEjdHrlWv
	 qRSkCYR7lVsWu0IewyJY8KfohLy450sxsOr4Jl+2SnsG1MrVAVl9F8SHTChFsQtnZBLAg
	 7U87yn3yv4SZ4mGKmZiM3yBjHM5jA6j9nYqR8HHrjaIf1Bfj2GZnljLXcsJL3+xD3VWj9
	 LhX21yjnPKst3MLpGD3CdFUB4UHiBuavbIHsTXiil9aBPyjkm0VZ2FQ2cPrNkLdla79lS
	 f+5UD3XkkkZKvwLscZEuCJdGQPku3AlSu+Jqr6YwJ7FTPHVG+SpH2rd3vSgJHWX7oIA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793632346;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=Mx5lXE61FEtyxVjZYvYVCCXsLI55yMipYdYQ5PE+OQ8=;
	b=ndEFUVjiRugQeF2Md80l8cx7gZol/5f0lTWM7mDj8uSCm81fHxYJIQBZx43aQSqHrFto
	 t+1wlIUMx511VxHJoTGuMQU67eWfBfyu2rbczB/k5P8PNQQ0XJUfvosYf1UERttyXmymV
	 d+SFTSmXyCkS7922L6JJCLlSsqG2E40CjBmbLVWrc0PEA+DBLArROnCRGc5TaySgLeNh3
	 RSmMX0bLY9sgoz9+/idlUJ2lJA/UFNz+zVd9BS4vdAokGSVriiLGkurdfZCRcSa9/OkY2
	 CpL6uTtKZvhMsYwNxvGy/kKkNwANk87Ciiu1sAsY0Lm1GeLdScr2hhHs/dhbGbGO66A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=fnzIIwsg;
	arc=none smtp.remote-ip=95.215.58.135
Received: from mta1.migadu.com (out-135.mta1.migadu.com [95.215.58.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 10547F80038
	for <sound-open-firmware@alsa-project.org>;
 Mon,  2 Nov 2026 16:12:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10547F80038
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=fnzIIwsg
X-Envelope-To: sound-open-firmware@alsa-project.org
DKIM-Signature: a=rsa-sha256; bh=Mx5lXE61FEtyxVjZYvYVCCXsLI55yMipYdYQ5PE+OQ8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793632344; v=1; x=1794237144;
 b=fnzIIwsglttpvPIkgbQfH4k6VA/yhVcTNNggFrslYd4lrkUX3iQ3qiznrdoqx0hFasjhMa+u
 AZ7aWSJzKAZ4qSSCDqHJNq1t7KJFQcNW+uJdCk93Rzq6TPo8qorwxzAVgdqhBCzXApwvhsTPENg
 3Dc2yvxA1EJJJA21dkOzB0U0=
X-Envelope-To: sound-open-firmware@alsa-project.org
Received: by smtp.migadu.com with ESMTPS id be63853a791001dd;
	Sun, 01 Nov 2026 18:34:37 +0000
X-Mizu-Trace-ID: be63853a791001dd
X-Migadu-Flow: FLOW_OUT
Message-ID: <15653bef-65b0-486f-aecd-ad7618d99cbd@linux.dev>
Date: Sun, 1 Nov 2026 19:28:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/16] ASoC: amd: acp: add PDM controller selection for
 ACP7.B/7.F SoundWire machine driver
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, yung-chuan.liao@linux.intel.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
 Mario.Limonciello@amd.com, Richard.Gong@amd.com, Poojitha.N@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 sound-open-firmware@alsa-project.org
References: <20261030094714.1123396-1-Vijendar.Mukunda@amd.com>
 <20261030094714.1123396-7-Vijendar.Mukunda@amd.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20261030094714.1123396-7-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-MailFrom: pierre-louis.bossart@linux.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-sound-open-firmware.alsa-project.org-0;
 header-match-sound-open-firmware.alsa-project.org-1; emergency;
 member-moderation
Message-ID-Hash: IIRVXB4YUTYC5YQ3FQIRI2HSRKODOUNG
X-Message-ID-Hash: IIRVXB4YUTYC5YQ3FQIRI2HSRKODOUNG
X-Mailman-Approved-At: Mon, 02 Nov 2026 21:13:36 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IIRVXB4YUTYC5YQ3FQIRI2HSRKODOUNG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On 10/30/26 10:45, Vijendar Mukunda wrote:
> Add ASOC_SDW_ACP_DMIC1 quirk bit (BIT(6)) and pdm_sel field to
> amd_mc_ctx to support per-controller DMIC DAI selection on ACP7.B/7.F
> platforms.
> 
> In mc_probe(), read the active PDM controller from mach->pdata
> (populated via ACPI acp-audio-ep-port _DSD). When ACPI does not set
> pdm_sel, derive it from the quirk bits after dmi_check_system() and
> quirk_override are applied: ASOC_SDW_ACP_DMIC1 selects DMIC1;
> ASOC_SDW_ACP_DMIC selects DMIC0. Since only one PDM controller is
> active at a time, DMIC1 is checked first.

nit-pick: it'd be useful to explain the mapping between PDM controllers
and PDM microphones. Is this one controller:2mics?

Also does anything prevent DMIC and DMIC1 from being active simultaneously?

> 
> In create_dmic_dailinks(), select the SOF CPU DAI name based on
> pdm_sel: "acp-sof-dmic1" for ACP7X_PDM_DMIC1, "acp-sof-dmic0"
> otherwise on ACP7.B/7.F; all other platforms use "acp-sof-dmic".
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/acp/acp-sdw-sof-mach.c   | 44 +++++++++++++++++++++++++-
>  sound/soc/amd/acp/soc_amd_sdw_common.h |  3 ++
>  2 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
> index 97b2e224492f..34a71f7a8c54 100644
> --- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
> +++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
> @@ -265,11 +265,31 @@ static int create_dmic_dailinks(struct snd_soc_card *card,
>  				struct snd_soc_dai_link **dai_links, int *be_id, int no_pcm)
>  {
>  	struct device *dev = card->dev;
> +	struct asoc_sdw_mc_private *ctx = snd_soc_card_get_drvdata(card);
> +	struct amd_mc_ctx *amd_ctx = (struct amd_mc_ctx *)ctx->private;
> +	const char *cpu_dai_name;
>  	int ret;
>  
> +	/*
> +	 * For ACP7.B/7.F platforms the PDM controller is selected from ACPI
> +	 * acp-audio-ep-port and stored in amd_ctx->pdm_sel. Use the
> +	 * matching SOF DAI name ("acp-sof-dmic0" or "acp-sof-dmic1").
> +	 * All other platforms use the generic "acp-sof-dmic" DAI.
> +	 */
> +	switch (amd_ctx->acp_rev) {
> +	case ACP7B_PCI_REV:
> +	case ACP7F_PCI_REV:
> +		cpu_dai_name = (amd_ctx->pdm_sel == ACP7X_PDM_DMIC1) ?
> +				"acp-sof-dmic1" : "acp-sof-dmic0";
> +		break;
> +	default:
> +		cpu_dai_name = "acp-sof-dmic";
> +		break;
> +	}
> +
>  	ret = asoc_sdw_init_simple_dai_link(dev, *dai_links, be_id, "acp-dmic-codec",
>  					    0, 1, // DMIC only supports capture
> -					    "acp-sof-dmic", platform_component->name,
> +					    cpu_dai_name, platform_component->name,
>  					    "dmic-codec", "dmic-hifi", no_pcm,
>  					    asoc_sdw_dmic_init, NULL);
>  	if (ret)
> @@ -378,6 +398,7 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
>  static int mc_probe(struct platform_device *pdev)
>  {
>  	struct snd_soc_acpi_mach *mach = dev_get_platdata(&pdev->dev);
> +	struct amd_pdm_pdata *pdm_pdata;
>  	struct snd_soc_card *card;
>  	struct amd_mc_ctx *amd_ctx;
>  	struct asoc_sdw_mc_private *ctx;
> @@ -398,6 +419,10 @@ static int mc_probe(struct platform_device *pdev)
>  		amd_ctx->max_sdw_links = ACP63_SDW_MAX_LINKS;
>  		break;
>  	}
> +	if (mach->pdata) {
> +		pdm_pdata = mach->pdata;
> +		amd_ctx->pdm_sel = pdm_pdata->pdm_sel;
> +	}
>  	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
>  		return -ENOMEM;
> @@ -419,6 +444,23 @@ static int mc_probe(struct platform_device *pdev)
>  		sof_sdw_quirk = quirk_override;
>  	}
>  
> +	/*
> +	 * If ACPI did not set pdm_sel (no acp-audio-ep-port in _DSD), derive
> +	 * it from the quirk bits. ACPI takes priority: quirks are only
> +	 * consulted when pdm_sel is still zero. PDM controller selection is
> +	 * only meaningful on ACP7B/7F platforms.
> +	 * ASOC_SDW_ACP_DMIC selects DMIC0 (default); ASOC_SDW_ACP_DMIC1
> +	 * overrides to DMIC1.
> +	 */
> +	if (!amd_ctx->pdm_sel &&
> +	    (amd_ctx->acp_rev == ACP7B_PCI_REV ||
> +	     amd_ctx->acp_rev == ACP7F_PCI_REV)) {
> +		if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC1)
> +			amd_ctx->pdm_sel = ACP7X_PDM_DMIC1;
> +		else if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC)
> +			amd_ctx->pdm_sel = ACP7X_PDM_DMIC0;
> +	}
> +
>  	log_quirks(&pdev->dev);
>  
>  	ctx->mc_quirk = sof_sdw_quirk;
> diff --git a/sound/soc/amd/acp/soc_amd_sdw_common.h b/sound/soc/amd/acp/soc_amd_sdw_common.h
> index c979adf4e978..07837a2cfa54 100644
> --- a/sound/soc/amd/acp/soc_amd_sdw_common.h
> +++ b/sound/soc/amd/acp/soc_amd_sdw_common.h
> @@ -29,6 +29,7 @@
>  #define SOC_JACK_JDSRC(quirk)		((quirk) & GENMASK(3, 0))
>  #define ASOC_SDW_FOUR_SPK		BIT(4)
>  #define ASOC_SDW_ACP_DMIC		BIT(5)
> +#define ASOC_SDW_ACP_DMIC1		BIT(6)	/* select DMIC1 controller for ACP7.B/7.F */
>  #define ASOC_SDW_CODEC_SPKR		BIT(15)
>  
>  #define AMD_SDW0	0
> @@ -94,6 +95,8 @@
>  struct amd_mc_ctx {
>  	unsigned int acp_rev;
>  	unsigned int max_sdw_links;
> +	/* PDM controller selection, copied from amd_pdm_pdata at probe time */
> +	unsigned int pdm_sel;
>  };
>  
>  int get_acp63_cpu_pin_id(u32 sdw_link_id, int be_id, int *cpu_pin_id, struct device *dev);

