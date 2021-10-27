Return-Path: <SRS0=Z19R=PP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60666C433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 14:08:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A7C60EFE
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 14:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45A7C60EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC4F316A4;
	Wed, 27 Oct 2021 16:07:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC4F316A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635343718;
	bh=y2iUyfxogYwzRhdZU9D/AnpQNxbxN3w7Kr2HaddMK7M=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MoCTY1kBktJTXajQAjnTHdMYlyBhT8gpUgS1vf1Ie7+tGN0ziBKI1cJn/s5peQsBv
	 sbunPIOWwnOZgd0I7XzXCHfbuk8J5TWmlLh2nnpnnh4QPQ0+FDKuA06BAF8e0mspfN
	 Z5FEGpPZfNSPBHQf/UIXh6yTbzbzX8RLVjY0gHko=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46CB6F8025A;
	Wed, 27 Oct 2021 16:07:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BCD46F8025E; Wed, 27 Oct 2021 16:07:46 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A6E5F800FF
 for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2021 16:07:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A6E5F800FF
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="210947199"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; d="scan'208";a="210947199"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2021 07:07:35 -0700
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; d="scan'208";a="494848956"
Received: from deryzhov-mobl1.ccr.corp.intel.com (HELO [10.212.69.94])
 ([10.212.69.94])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2021 07:07:35 -0700
Subject: Re: [PATCH 1/3] ASoC: nau8825: add set_jack coponment support
To: David Lin <CTLIN0@nuvoton.com>, broonie@kernel.org
References: <20211027025142.25898-1-CTLIN0@nuvoton.com>
 <20211027025142.25898-2-CTLIN0@nuvoton.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <27e07d55-9666-9c6a-0098-4ad9ba6e9d0d@linux.intel.com>
Date: Wed, 27 Oct 2021 09:02:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211027025142.25898-2-CTLIN0@nuvoton.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, SJLIN0@nuvoton.com,
 KCHSU0@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com,
 mac.chiang@intel.com
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

typo in commit subject:
coponment -> component

please use scripts/checkpatch.pl --strict --codespell

On 10/26/21 9:51 PM, David Lin wrote:
> Use set_jack ops to set jack for new machine drivers. Meanwhile,
> the old machine drivers can still call previous export function
> "nau8825_enable_jack_detect".
> 
> Co-developed-by: Mac Chiang <mac.chiang@intel.com>
> Signed-off-by: Mac Chiang <mac.chiang@intel.com>
> Signed-off-by: David Lin <CTLIN0@nuvoton.com>
> ---
>  sound/soc/codecs/nau8825.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
> index 67de0e49ccf4..c845f19b7c41 100644
> --- a/sound/soc/codecs/nau8825.c
> +++ b/sound/soc/codecs/nau8825.c
> @@ -2416,6 +2416,12 @@ static int __maybe_unused nau8825_resume(struct snd_soc_component *component)
>  	return 0;
>  }
>  
> +static int nau8825_set_jack(struct snd_soc_component *component,
> +			    struct snd_soc_jack *jack, void *data)
> +{
> +	return nau8825_enable_jack_detect(component, jack);
> +}
> +

in some cases, this function can be called with a NULL jack argument.
See other codec drivers, e.g.

int arizona_jack_set_jack(struct snd_soc_component *component,
			  struct snd_soc_jack *jack, void *data)
{
	struct arizona_priv *info = snd_soc_component_get_drvdata(component);

	if (jack)
		return arizona_jack_enable_jack_detect(info, jack);
	else
		return arizona_jack_disable_jack_detect(info);
}

