Return-Path: <SRS0=/CfY=BB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233A8C433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 18:25:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3BB52068F
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 18:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fx3nnM07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BB52068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 148CE1607;
	Wed, 22 Jul 2020 20:24:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 148CE1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595442329;
	bh=y5yOqychhYvhyyyMpxyKSEJTCfjS6GWAw01311CmG4k=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fx3nnM07Z0fc3QlJMWlwYlt2+WAFgA81jZRvAa+p0qbBDoXLnhxj+3kdQsMd6jc9i
	 sUEcJnizsuJlgzbekHtBeIRG2EFAHOMAawnpMeyXXeTmA2Bf2vzGh+Mtu3t8hYi2pU
	 fQh6Qd9zwyoG8L+e0fAXMZiMqbfcnqUXiJnWkYRw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D806F80150;
	Wed, 22 Jul 2020 20:24:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3FBA8F8015A; Wed, 22 Jul 2020 20:24:35 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E251CF80139
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 20:24:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E251CF80139
IronPort-SDR: UCCN2iq4uEvsu+0xV4TslPIaW5liq905l4qh0UNe5TQFN5Bx2ASiF5XgHFkDSfXkxj53B7Sdw0
 efg4u2xcGAKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="211946784"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; d="scan'208";a="211946784"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 11:24:21 -0700
IronPort-SDR: zwb4b0wp2rt4IU3/L9NxmP8T3C8Zmk5nzMNHGx1OKcJIZTknrLpDjgF828hbk0yAQrNJ17rrc2
 3li1XETA1jHg==
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; d="scan'208";a="462553943"
Received: from aadl-mobl.amr.corp.intel.com (HELO [10.254.77.197])
 ([10.254.77.197])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 11:24:20 -0700
Subject: Re: [PATCH] ASoC: Intel: skl_hda_dsp_generic: Fix NULLptr dereference
 in autosuspend delay
To: Mateusz Gorski <mateusz.gorski@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200722173524.30161-1-mateusz.gorski@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2674621e-1546-3048-3ba2-f8fe1265d6e1@linux.intel.com>
Date: Wed, 22 Jul 2020 13:24:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722173524.30161-1-mateusz.gorski@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: cezary.rojewski@intel.com, broonie@kernel.org, tiwai@suse.com
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



On 7/22/20 12:35 PM, Mateusz Gorski wrote:
> Different modules for HDMI codec are used depending on the
> "hda_codec_use_common_hdmi" option being enabled or not. Driver private
> context for both of them is different.
> This leads to null-pointer dereference error when driver tries to set
> autosuspend delay for HDMI codec while the option is off (hdac_hdmi
> module is used for HDMI).
> 
> Change the string in conditional statement to "ehdaudio0D0" to ensure
> that only the HDAudio codec is handled by this function.

I am not sure this is correct.

I may be wrong, but my understanding is the following:

Before 5bf73b1b1dec, the driver would use the first dailink of the card, 
and in the case of devices without an HDaudio codec (e.g. Up2 board) it 
would set the auto suspend delay using that first dailink. See the code 
in skl_hda_fill_card_info(), it reorders the dailinks when HDaudio 
codecs are not present so if you test for 'edhaudio00' you no longer 
allow for this HDMI-only case to be handled with autosuspend.

Kai would need to review this, so this will have to wait I am afraid.

> 
> Fixes: 5bf73b1b1dec ("ASoC: intel/skl/hda - fix oops on systems without i915 audio codec")
> Signed-off-by: Mateusz Gorski <mateusz.gorski@linux.intel.com>
> ---
>   sound/soc/intel/boards/skl_hda_dsp_generic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
> index ca4900036ead..bc50eda297ab 100644
> --- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
> +++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
> @@ -181,7 +181,7 @@ static void skl_set_hda_codec_autosuspend_delay(struct snd_soc_card *card)
>   	struct snd_soc_dai *dai;
>   
>   	for_each_card_rtds(card, rtd) {
> -		if (!strstr(rtd->dai_link->codecs->name, "ehdaudio"))
> +		if (!strstr(rtd->dai_link->codecs->name, "ehdaudio0D0"))
>   			continue;
>   		dai = asoc_rtd_to_codec(rtd, 0);
>   		hda_pvt = snd_soc_component_get_drvdata(dai->component);
> 
