Return-Path: <SRS0=+StP=ZM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24EEC432C3
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:14:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB3D2071C
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iSjrno29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB3D2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31D1D1711;
	Wed, 20 Nov 2019 17:13:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31D1D1711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574266469;
	bh=Lzzo27+OtNk6AWiERuesfxobbrWOsKyh6PEUUgOFlQ8=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iSjrno29qagI1iB3G0/Vu4tMX2WzKlrdf7m6L8WMOaOwnbYP3BrjOH/QYetzgN2+q
	 YqOGakd/wMonevIdEhgqEOUspwGpsveipXkA7ixRPNjD11oxEIlDyDi7SPL+eptY0V
	 KelnSt0HxK7ec1cGx+t3prkS+enxOzKwSuInrLtY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28385F80160;
	Wed, 20 Nov 2019 17:10:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C67A3F8014F; Wed, 20 Nov 2019 17:10:46 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A790DF800C1
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 17:10:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A790DF800C1
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Nov 2019 08:10:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; d="scan'208";a="204862319"
Received: from ngoel1-mobl1.amr.corp.intel.com (HELO [10.255.66.61])
 ([10.255.66.61])
 by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2019 08:10:37 -0800
To: Jaroslav Kysela <perex@perex.cz>,
 ALSA development <alsa-devel@alsa-project.org>
References: <20191120093712.11370-1-perex@perex.cz>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <dfe78a0b-1cb6-ce19-61bd-86cfded0e3d5@linux.intel.com>
Date: Wed, 20 Nov 2019 08:55:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191120093712.11370-1-perex@perex.cz>
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: improve the DMI long card code
 in asoc-core
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



On 11/20/19 3:37 AM, Jaroslav Kysela wrote:
> Add append_dmi_string() function and make the code more readable.
> 
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> Cc: Mark Brown <broonie@kernel.org>
> ---
>   sound/soc/soc-core.c | 66 +++++++++++++++++---------------------------
>   1 file changed, 25 insertions(+), 41 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index b4683d4588ee..1d1baf78818c 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1755,6 +1755,23 @@ static int is_dmi_valid(const char *field)
>   	return 1;
>   }
>   
> +/*
> + *
> + */

unneeded comments or missing text?

> +static void append_dmi_string(struct snd_soc_card *card, const char *str)
> +{
> +	char *dst = card->dmi_longname;
> +	size_t dst_len = sizeof(card->dmi_longname);
> +	size_t len;
> +
> +	len = strlen(dst);
> +	snprintf(dst + len, dst_len - len, "-%s", str);
> +
> +	len++;	/* skip the separator "-" */
> +	if (len < dst_len)
> +		cleanup_dmi_name(dst + len);
> +}
> +
>   /**
>    * snd_soc_set_dmi_name() - Register DMI names to card
>    * @card: The card to register DMI names
> @@ -1789,61 +1806,36 @@ static int is_dmi_valid(const char *field)
>   int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
>   {
>   	const char *vendor, *product, *product_version, *board;
> -	size_t longname_buf_size = sizeof(card->snd_card->longname);
> -	size_t len;
>   
>   	if (card->long_name)
>   		return 0; /* long name already set by driver or from DMI */
>   
> -	/* make up dmi long name as: vendor.product.version.board */
> +	/* make up dmi long name as: vendor-product-version-board */

here you are just fixing a misleading comment, yes?
I don't see any dots to dashes substitution but better ask.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
