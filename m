Return-Path: <SRS0=fcCl=2X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002A6C2D0DC
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jan 2020 21:21:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4B120848
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jan 2020 21:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="U4HHNaMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4B120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC749169B;
	Thu,  2 Jan 2020 22:21:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC749169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578000113;
	bh=tZVi0bdawSYPv4+Frw/TuuTBDSFTG75zNEC2zHWx7zM=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U4HHNaMWjN3bxUmHSkdWAYiJu8/AfqAKB/24osS7qL2NoVPKW5RvZvUcLFeEx61Ov
	 OeEYVGB5TcKZUepqAj+5/aQCkp9RvGZ6kCQm7BX2aO1Sy5IYvlnZo7dop8x0qt5/kY
	 crJVnv8UHaX/JguhIsZnskbgg+kOhyuM7mCHi6I8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5DB3EF8028A;
	Thu,  2 Jan 2020 22:18:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B808FF8026A; Thu,  2 Jan 2020 22:18:38 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76FE3F8011E
 for <alsa-devel@alsa-project.org>; Thu,  2 Jan 2020 22:18:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76FE3F8011E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Jan 2020 13:18:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,388,1571727600"; d="scan'208";a="224819855"
Received: from ybabin-mobl1.amr.corp.intel.com (HELO [10.252.139.105])
 ([10.252.139.105])
 by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2020 13:18:31 -0800
To: Sam McNally <sammc@chromium.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200102112558.1.Ib87c4a7fbb3fc818ea12198e291b87dc2d5bc8c2@changeid>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a7ab606a-1e35-29aa-ea60-7c31374eb7b4@linux.intel.com>
Date: Thu, 2 Jan 2020 12:48:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102112558.1.Ib87c4a7fbb3fc818ea12198e291b87dc2d5bc8c2@changeid>
Content-Language: en-US
Cc: Xun Zhang <xun2.zhang@intel.com>, alsa-devel@alsa-project.org,
 Jairaj Arava <jairaj.arava@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 Sathya Prakash M R <sathya.prakash.m.r@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: sof_rt5682: Ignore the
 speaker amp when there isn't one.
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



On 1/1/20 6:28 PM, Sam McNally wrote:
> Some members of the Google_Hatch family include a rt5682, but not a
> speaker amp. When a speaker amp is also present, it matches MX98357A
> as well, resulting in the quirk_data field in the snd_soc_acpi_mach
> being non-null. When only the rt5682 is present, quirk_data is left
> null.

Sorry, I don't get this last sentence.

There is a single entry for 10EC5682 in sound-acpi-intel-glk-match.c and 
quirk_data is assigned - thus can never be NULL.

I wonder if your Chrome kernel has an extra entry in 
snd_soc_acpi_intel_glk_machines[] ? What I am missing?

> 
> The sof_rt5682 driver's DMI data matching identifies that a speaker amp
> is present for all Google_Hatch family devices. Detect cases where there
> is no speaker amp by checking for a null quirk_data in the
> snd_soc_acpi_mach and remove the speaker amp bit in that case.
> 
> Signed-off-by: Sam McNally <sammc@chromium.org>
> ---
> 
>   sound/soc/intel/boards/sof_rt5682.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index ad8a2b4bc709..8a13231dee15 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -603,6 +603,14 @@ static int sof_audio_probe(struct platform_device *pdev)
>   
>   	dmi_check_system(sof_rt5682_quirk_table);
>   
> +	mach = (&pdev->dev)->platform_data;
> +
> +	/* A speaker amp might not be present when the quirk claims one is.
> +	 * Detect this via whether the machine driver match includes quirk_data.
> +	 */
> +	if ((sof_rt5682_quirk & SOF_SPEAKER_AMP_PRESENT) && !mach->quirk_data)
> +		sof_rt5682_quirk &= ~SOF_SPEAKER_AMP_PRESENT;
> +
>   	if (soc_intel_is_byt() || soc_intel_is_cht()) {
>   		is_legacy_cpu = 1;
>   		dmic_be_num = 0;
> @@ -663,7 +671,6 @@ static int sof_audio_probe(struct platform_device *pdev)
>   	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
>   
>   	sof_audio_card_rt5682.dev = &pdev->dev;
> -	mach = (&pdev->dev)->platform_data;
>   
>   	/* set platform name for each dailink */
>   	ret = snd_soc_fixup_dai_links_platform_name(&sof_audio_card_rt5682,
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
