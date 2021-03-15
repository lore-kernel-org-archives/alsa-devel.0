Return-Path: <SRS0=ty8W=IN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5FCC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Mar 2021 15:32:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9ABE64E6B
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Mar 2021 15:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9ABE64E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD28C170E;
	Mon, 15 Mar 2021 16:31:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD28C170E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615822317;
	bh=SlzmyhusTxiHixkOa5GEbGg3XdtqSn7tIYZNMRPKn7U=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OEsnfcnwUC0H3symFr9fOFha/a/1kCGl7GMltW1xVZ70quOku5D+P14lZiVkPsxHv
	 lwNiFWmRumHmCVnJJgT1WSQ6cO/Q1x1aMr7IX/XUldQMzyR7vtUU3r20eHb4dHK0ke
	 dZuJlMh8XTFDkKa1HaJw5Ksn3JvfjJvjNOIX9fFM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36ACEF80163;
	Mon, 15 Mar 2021 16:31:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4206CF80171; Mon, 15 Mar 2021 16:31:06 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1B89F80100
 for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2021 16:30:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1B89F80100
IronPort-SDR: hlTKqxfnTD+vnzNbZ5SASlyS3QGtMb4vfXkMvisBK1EA6WNxQesp8aAJKZoIbJRXdP4UcOJUOV
 wpl5OfArBZtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="176701175"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; d="scan'208";a="176701175"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2021 08:30:56 -0700
IronPort-SDR: ksQMXxgBd1/KPGFHSWoFnZ+Jw1Vfoft0O4FYpHstsLrpcB1q0foW7/ElsiFD2O2rxyC8nKnRON
 yQQaQ+Y46+tg==
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; d="scan'208";a="449399290"
Received: from gbean-mobl.amr.corp.intel.com (HELO [10.212.247.133])
 ([10.212.247.133])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2021 08:30:55 -0700
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: Add rt1015p speaker amp support
To: Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
References: <20210313134038.5577-1-brent.lu@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7ec5763b-29cb-4846-6ff8-3899c2ff1248@linux.intel.com>
Date: Mon, 15 Mar 2021 09:26:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210313134038.5577-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Oder Chiou <oder_chiou@realtek.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Dharageswari R <dharageswari.r@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Fred Oh <fred.oh@linux.intel.com>, Tzung-Bi Shih <tzungbi@google.com>,
 Mark Brown <broonie@kernel.org>,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Libin Yang <libin.yang@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>, Yong Zhi <yong.zhi@intel.com>
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

I am not a big fan of the code partition you've selected.

> +void sof_rt1015p_set_share_en_spk(void)
> +{
> +	/* Two amps share one en pin so there is only one device in acpi
> +	 * table
> +	 */
> +	rt1015p_quirk |= RT1015P_SHARE_EN_SPK;
> +}

This is a function now used in the machine driver, see below [1]
This adds a new interface between machine and realtek common code, which 
we are trying to move to a module with well-defined APIs.

> +void sof_rt1015p_dai_link(struct snd_soc_dai_link *link)
> +{
> +	link->codecs = rt1015p_dai_link_components;
> +	if (rt1015p_quirk & RT1015P_SHARE_EN_SPK)
> +		link->num_codecs = 1;
> +	else
> +		link->num_codecs = ARRAY_SIZE(rt1015p_dai_link_components);
> +	link->init = rt1015p_init;
> +	link->ops = &rt1015p_ops;
> +}
> +
> +void sof_rt1015p_codec_conf(struct snd_soc_card *card)
> +{
> +	if (rt1015p_quirk & RT1015P_SHARE_EN_SPK)
> +		return;
> +
> +	card->codec_conf = rt1015p_codec_confs;
> +	card->num_configs = ARRAY_SIZE(rt1015p_codec_confs);
> +}

could we not handle this quirk inside one of the two dai_link or 
codec_conf functions above?
The machine driver does not care about this RT1015P_SHARE_EN_SPK quirk, 
it's only used in those two functions so should be set in this scope. 
There's no need to make it visible to the machine driver, is there?

> +	/* setup amp quirk if any */
> +	if (sof_rt5682_quirk & SOF_RT1015P_SPEAKER_AMP_PRESENT) {
> +		/* There may be only one device instance if two amps
> +		 * sharing one en pin
> +		 */
> +		if (!acpi_dev_present("RTL1015", "1", -1)) {
> +			dev_dbg(&pdev->dev, "Device %s not exist\n",
> +				RT1015P_DEV1_NAME);
> +			sof_rt1015p_set_share_en_spk();
> +		}
> +	}
> +

[1]

I see no problem using the _UID (Unique ID) to check if a second 
amplifier is present or not. This seems to follow the ACPI spec Section 
6.1.12, as long as "the _UID must be unique across all devices with 
either a common _HID or _CID"


> +	else if (sof_rt5682_quirk & SOF_RT1015P_SPEAKER_AMP_PRESENT)
> +		sof_rt1015p_codec_conf(&sof_audio_card_rt5682);
