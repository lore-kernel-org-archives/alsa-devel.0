Return-Path: <SRS0=YoTX=4X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91F4C10DCE
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Mar 2020 21:08:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4317D206E6
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Mar 2020 21:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fHk5In2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4317D206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 630371668;
	Fri,  6 Mar 2020 22:07:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 630371668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583528908;
	bh=2mfrs87G+mp61INLOjJJUHS6elry9LikqjA0aMaQkZY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fHk5In2Bd7F49VErKXseYaxhWRnCVpD4UdfqKR4GNm7y8esLOIlyy+5v3ImsO7cl3
	 /wxkOkkcBJSZ2QAn1kF5/8RepNQV0wkT0Ws58TPssUghIXaWD7OebMrxjKlZ0e+fv/
	 0dm5CHT3Swo5xm4YiWIcS8hgk4L9R1TplRdtUFAU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A558F80125;
	Fri,  6 Mar 2020 22:06:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2DC73F801F9; Fri,  6 Mar 2020 22:05:55 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE7A0F801ED
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2020 22:05:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE7A0F801ED
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Mar 2020 13:05:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,523,1574150400"; d="scan'208";a="275688921"
Received: from jrbond-mobl.amr.corp.intel.com (HELO [10.254.11.58])
 ([10.254.11.58])
 by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2020 13:05:47 -0800
Subject: Re: [PATCH 2/7] ASoC: Intel: Skylake: Select hda configuration
 permissively
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20200305145314.32579-1-cezary.rojewski@intel.com>
 <20200305145314.32579-3-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ab7ad0e3-bc46-c761-4357-65d8563df5cc@linux.intel.com>
Date: Fri, 6 Mar 2020 14:57:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305145314.32579-3-cezary.rojewski@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: vkoul@kernel.org, broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
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



On 3/5/20 8:53 AM, Cezary Rojewski wrote:
> With _reset_link removed from the probe sequence, codec_mask at the time
> skl_find_hda_machine() is invoked will always be 0, so hda machine will
> never be chosen. Rather than reorganizing boot flow, be permissive about
> invalid mask. codec_mask will be set to proper value during probe_work -
> before skl_codec_create() ever gets called.

humm, what would happen e.g. if you have select the SKL driver but there 
is no ACPI information to select an I2S-based machine driver, and 
HDaudio/iDISP are disabled? You would have no error checks then?


> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>   sound/soc/intel/skylake/skl.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index d66231525356..4827fe6bc1cb 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -481,13 +481,8 @@ static struct skl_ssp_clk skl_ssp_clks[] = {
>   static struct snd_soc_acpi_mach *skl_find_hda_machine(struct skl_dev *skl,
>   					struct snd_soc_acpi_mach *machines)
>   {
> -	struct hdac_bus *bus = skl_to_bus(skl);
>   	struct snd_soc_acpi_mach *mach;
>   
> -	/* check if we have any codecs detected on bus */
> -	if (bus->codec_mask == 0)
> -		return NULL;
> -
>   	/* point to common table */
>   	mach = snd_soc_acpi_intel_hda_machines;
>   
> 
