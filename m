Return-Path: <SRS0=JTem=5M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD74C43331
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:57:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAE720575
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SUJXNLXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAE720575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2AEE1664;
	Fri, 27 Mar 2020 19:56:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2AEE1664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585335465;
	bh=U9pklU9EmfFvzFR7r8ynL/lNjbWhIPl2dars/GXvI7I=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SUJXNLXzKGJmZb6HAj9Pr2ebXtYNo5n06bAALLSE7lV9q6xnD2rj0qpPtpSbpoXCm
	 WRmN0F28neBWdCYZQ96YDlh2GTFs1fVYMa5D0WlMUuL2WNczz0VUQtHGZRXEAXJMOK
	 FEWhPCPl9Fjj5cZ2+Y/kPNwxbf4IromjZ2IJuZJM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5DDA9F80147;
	Fri, 27 Mar 2020 19:56:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0308FF80158; Fri, 27 Mar 2020 19:56:53 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A68AFF800EA
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 19:56:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A68AFF800EA
IronPort-SDR: JYlv6MGo4uLNqLt7NUhgycUNgNb2iGwCsKTBuAS4X2CSDUTir+bznA+g/wZENhwj4+49kZK8SU
 zlVJ3XwngYnw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 11:56:39 -0700
IronPort-SDR: jrUxe26pdZF91C9fuJav8lcfkOuZZcsLGC/dVjYsR9Du0DcMU3ZYrjX7XpDehfoKjPZV9+yAoo
 YGL0lzcEuhlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; d="scan'208";a="266301825"
Received: from ghoshsan-mobl1.amr.corp.intel.com (HELO [10.135.26.162])
 ([10.135.26.162])
 by orsmga002.jf.intel.com with ESMTP; 27 Mar 2020 11:56:38 -0700
Subject: Re: [PATCH v2 3/6] ASoC: topology: Check return value of
 soc_tplg_*_create
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
References: <20200327204729.397-1-amadeuszx.slawinski@linux.intel.com>
 <20200327204729.397-4-amadeuszx.slawinski@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ea618248-5c0c-24f2-b1fb-2b5aecb16049@linux.intel.com>
Date: Fri, 27 Mar 2020 13:56:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200327204729.397-4-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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



On 3/27/20 3:47 PM, Amadeusz Sławiński wrote:
> Functions soc_tplg_denum_create, soc_tplg_dmixer_create,
> soc_tplg_dbytes_create can fail, so their return values should be
> checked and error should be propagated.
> 
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
> ---
> 
>   v2:
>    Added this patch
> 
>   sound/soc/soc-topology.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> index c3811dd66b68..860bced933d6 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -1124,6 +1124,7 @@ static int soc_tplg_kcontrol_elems_load(struct soc_tplg *tplg,
>   	struct snd_soc_tplg_hdr *hdr)
>   {
>   	struct snd_soc_tplg_ctl_hdr *control_hdr;
> +	int ret;
>   	int i;
>   
>   	if (tplg->pass != SOC_TPLG_PASS_MIXER) {
> @@ -1152,25 +1153,30 @@ static int soc_tplg_kcontrol_elems_load(struct soc_tplg *tplg,
>   		case SND_SOC_TPLG_CTL_RANGE:
>   		case SND_SOC_TPLG_DAPM_CTL_VOLSW:
>   		case SND_SOC_TPLG_DAPM_CTL_PIN:
> -			soc_tplg_dmixer_create(tplg, 1,
> -					       le32_to_cpu(hdr->payload_size));
> +			ret = soc_tplg_dmixer_create(tplg, 1,
> +					le32_to_cpu(hdr->payload_size));
>   			break;
>   		case SND_SOC_TPLG_CTL_ENUM:
>   		case SND_SOC_TPLG_CTL_ENUM_VALUE:
>   		case SND_SOC_TPLG_DAPM_CTL_ENUM_DOUBLE:
>   		case SND_SOC_TPLG_DAPM_CTL_ENUM_VIRT:
>   		case SND_SOC_TPLG_DAPM_CTL_ENUM_VALUE:
> -			soc_tplg_denum_create(tplg, 1,
> -					      le32_to_cpu(hdr->payload_size));
> +			ret = soc_tplg_denum_create(tplg, 1,
> +					le32_to_cpu(hdr->payload_size));
>   			break;
>   		case SND_SOC_TPLG_CTL_BYTES:
> -			soc_tplg_dbytes_create(tplg, 1,
> -					       le32_to_cpu(hdr->payload_size));
> +			ret = soc_tplg_dbytes_create(tplg, 1,
> +					le32_to_cpu(hdr->payload_size));
>   			break;
>   		default:
>   			soc_bind_err(tplg, control_hdr, i);
>   			return -EINVAL;
>   		}
> +		if (ret < 0) {
> +			dev_err(tplg->dev, "ASoC: invalid control\n");
> +			return ret;
> +		}

Sounds good, but this happens in a loop, so would all the memory 
previously allocated by denum/dbytes/dmixer_create leak, or is it freed 
automatically somewhere else?

> +
>   	}
>   
>   	return 0;
> 
