Return-Path: <SRS0=RV9o=ZS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1329BC43215
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 13:14:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BCE220727
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 13:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nhgaDWpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCE220727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A92A1717;
	Tue, 26 Nov 2019 14:13:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A92A1717
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574774085;
	bh=CtXifgVfnYQoS/k5Ukybe2HG1ceIGKBO0LhKcuLjSt4=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nhgaDWpnhgy0vXibakkbQJ6gZZO/dmTMnNYYPqFuS5teJ4sDRSnek0nvyv8Uqr3lv
	 AYKtynZUEN+eLcj0FIPm4HSwK3x8GyaAAvh3c1mXebGgmB86yAAxi6s5zJaQ7ifaNP
	 7s0FLfY7AAlcrM1rqiwSC6n6TTGaNwUEBFsS4UNU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 903DDF80149;
	Tue, 26 Nov 2019 14:13:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E21D8F80159; Tue, 26 Nov 2019 14:13:52 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36B8EF800DD
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2019 14:13:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36B8EF800DD
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Nov 2019 05:13:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,245,1571727600"; d="scan'208";a="202714431"
Received: from kniimi-mobl.amr.corp.intel.com (HELO [10.255.228.174])
 ([10.255.228.174])
 by orsmga008.jf.intel.com with ESMTP; 26 Nov 2019 05:13:44 -0800
To: Jaroslav Kysela <perex@perex.cz>,
 ALSA development <alsa-devel@alsa-project.org>
References: <20191126103404.29534-1-perex@perex.cz>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <dd238740-f154-a660-2a80-0ada80183dd2@linux.intel.com>
Date: Tue, 26 Nov 2019 06:33:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191126103404.29534-1-perex@perex.cz>
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: intel/skl/hda - export number of
 digital microphones via control components
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 11/26/19 4:34 AM, Jaroslav Kysela wrote:
> It is required for the auto-detection in the user space (for UCM).
> 
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Mark Brown <broonie@kernel.org>

Thanks Jaroslav.
The changes are fine, but the code changes in hda.c will conflict with 
the cleanups done by Ranjani (which I was planning to send next week).

Any objections if we take this patch into the SOF tree (without changes 
to authorship) and provide it on alsa-devel next week with the cleanups, 
so that we don't have any conflicts?

> ---
>   sound/soc/intel/boards/skl_hda_dsp_generic.c | 8 ++++++++
>   sound/soc/sof/intel/hda.c                    | 3 ++-
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
> index 4e45901e3a2f..11eaee9ae41f 100644
> --- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
> +++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
> @@ -100,6 +100,8 @@ static struct snd_soc_card hda_soc_card = {
>   	.late_probe = skl_hda_card_late_probe,
>   };
>   
> +static char hda_soc_components[30];
> +
>   #define IDISP_DAI_COUNT		3
>   #define HDAC_DAI_COUNT		2
>   #define DMIC_DAI_COUNT		2
> @@ -183,6 +185,12 @@ static int skl_hda_audio_probe(struct platform_device *pdev)
>   	hda_soc_card.dev = &pdev->dev;
>   	snd_soc_card_set_drvdata(&hda_soc_card, ctx);
>   
> +	if (mach->mach_params.dmic_num > 0) {
> +		snprintf(hda_soc_components, sizeof(hda_soc_components),
> +				"cfg-dmics:%d", mach->mach_params.dmic_num);
> +		hda_soc_card.components = hda_soc_components;
> +	}
> +
>   	return devm_snd_soc_register_card(&pdev->dev, &hda_soc_card);
>   }
>   
> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
> index 7dc0018dc4c3..92fffca76af5 100644
> --- a/sound/soc/sof/intel/hda.c
> +++ b/sound/soc/sof/intel/hda.c
> @@ -351,7 +351,7 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
>   	const char *tplg_filename;
>   	const char *idisp_str;
>   	const char *dmic_str;
> -	int dmic_num;
> +	int dmic_num = 0;
>   	int codec_num = 0;
>   	int i;
>   #endif
> @@ -465,6 +465,7 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
>   		mach_params->codec_mask = bus->codec_mask;
>   		mach_params->platform = dev_name(sdev->dev);
>   		mach_params->common_hdmi_codec_drv = hda_codec_use_common_hdmi;
> +		mach_params->dmic_num = dmic_num;
>   	}
>   
>   	/* create codec instances */
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
