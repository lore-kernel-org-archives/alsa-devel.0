Return-Path: <SRS0=R5RK=XF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D847C49ED9
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Sep 2019 20:55:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62E42168B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Sep 2019 20:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZU/jtLAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62E42168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2731616E8;
	Tue, 10 Sep 2019 22:54:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2731616E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568148948;
	bh=C6+keOyRdr8ovJv7WKQvvfZtyY0Cdota4WF7xwh9cf8=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZU/jtLAdtch3cpP6ffGNhbtkWhlV4slnixnW7pCrGIWHc8FqesnfjJKI1oAhD0ppO
	 Wx3QVT5+eeuA5ePj3mzZPjDSwKGChbs0GcUr7azDLwknsnM+CdbWh+SJd61Fs6rLsD
	 Ca8vLXziTvVQ5wccGCpWRsJpTJERXVgPyDhGAiuU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EAA57F8060D;
	Tue, 10 Sep 2019 22:52:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04F59F805F6; Tue, 10 Sep 2019 22:52:24 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 351B5F80393
 for <alsa-devel@alsa-project.org>; Tue, 10 Sep 2019 22:52:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 351B5F80393
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Sep 2019 13:52:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,490,1559545200"; d="scan'208";a="214439794"
Received: from rmarszew-mobl1.ger.corp.intel.com (HELO [10.251.24.188])
 ([10.251.24.188])
 by fmsmga002.fm.intel.com with ESMTP; 10 Sep 2019 13:52:15 -0700
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org, 
 tiwai@suse.de
References: <20190910182916.29693-1-kai.vehmanen@linux.intel.com>
 <20190910182916.29693-6-kai.vehmanen@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ccc1a764-532d-e21f-dd79-022699076154@linux.intel.com>
Date: Tue, 10 Sep 2019 15:49:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910182916.29693-6-kai.vehmanen@linux.intel.com>
Content-Language: en-US
Cc: libin.yang@intel.com
Subject: Re: [alsa-devel] [PATCH v3 05/10] ASoC: Intel: skl-hda-dsp-generic:
 use snd-hda-codec-hdmi
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



On 9/10/19 1:29 PM, Kai Vehmanen wrote:
> Add support for using snd-hda-codec-hdmi driver for HDMI/DP
> instead of ASoC hdac-hdmi. This is aligned with how other
> HDA codecs are already handled.
> 
> When snd-hda-codec-hdmi is used, the PCM device numbers are
> parsed from card topology and passed to the codec driver.
> This needs to be done at runtime as topology changes may
> affect PCM device allocation.
> 
> Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> ---
>   include/sound/soc-acpi.h                     |  2 +
>   sound/soc/intel/boards/hda_dsp_common.h      | 87 ++++++++++++++++++++
>   sound/soc/intel/boards/skl_hda_dsp_common.c  | 10 ++-
>   sound/soc/intel/boards/skl_hda_dsp_common.h  | 23 ++++++
>   sound/soc/intel/boards/skl_hda_dsp_generic.c |  1 +
>   5 files changed, 122 insertions(+), 1 deletion(-)
>   create mode 100644 sound/soc/intel/boards/hda_dsp_common.h
> 
> diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
> index 35b38e41e5b2..26d57bc9a91e 100644
> --- a/include/sound/soc-acpi.h
> +++ b/include/sound/soc-acpi.h
> @@ -60,12 +60,14 @@ static inline struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
>    * @acpi_ipc_irq_index: used for BYT-CR detection
>    * @platform: string used for HDaudio codec support
>    * @codec_mask: used for HDAudio support
> + * @common_hdmi_codec_drv: use commom HDAudio HDMI codec driver
>    */
>   struct snd_soc_acpi_mach_params {
>   	u32 acpi_ipc_irq_index;
>   	const char *platform;
>   	u32 codec_mask;
>   	u32 dmic_num;
> +	bool common_hdmi_codec_drv;

That change would need to be moved to a separate patch earlier to avoid 
breaking compilation of patch 4
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
