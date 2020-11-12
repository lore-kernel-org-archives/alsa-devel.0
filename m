Return-Path: <SRS0=f4/q=ES=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D49EC56201
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 16:47:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC11216FD
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 16:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bYoeAF//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC11216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A8F4C1846;
	Thu, 12 Nov 2020 17:46:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A8F4C1846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605199638;
	bh=+OD1H+PQL0+julAcOmqfl0YvGeLkkGqI5h5kzpkWBq4=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bYoeAF//HmBwSP+zpqkjIZcQfOcpgWNPTnPmS7bAgN/+I8EuX0+cadoWfcFnb5QJ+
	 m7XRNxrkTVQwc1o96z6zNc5NrVkjCductDlR4JOMLt0ARYTyHo3xoemVFSj9EVZZVu
	 +kdMv0M9BbZ6rpgE6Lm0cXoIgVjCdSFk6zwx8Rlw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31A3DF804D2;
	Thu, 12 Nov 2020 17:45:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3213AF804D6; Thu, 12 Nov 2020 17:45:04 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C1954F804C3
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 17:44:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1954F804C3
IronPort-SDR: BRc0Ir94r8mE/y2gDYZEOugSBgf++bV5L5naBbsPiXQJLR2Z08IO128wl1APQBKq8VfNUHfKq5
 U1DiEjjPu66w==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="255048497"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; d="scan'208";a="255048497"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2020 08:44:21 -0800
IronPort-SDR: Aja4qnK+Ky7te7O1hSqpqRH+mgOdOHtxm/zx9ijqIydsn1M1aIU3DR85u+Luvt3+6sOCJ+YBX1
 aVQoWcVeGEUQ==
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; d="scan'208";a="532232049"
Received: from rtrevino-mobl2.amr.corp.intel.com ([10.212.195.40])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2020 08:44:20 -0800
Message-ID: <ea26b6dfe07cf5faefa21fde0b90698aaa5506fb.camel@linux.intel.com>
Subject: Re: [PATCH 07/12] ASoC: soc-component: add
 snd_soc_component_compr_get_codec_caps()
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown
 <broonie@kernel.org>
Date: Thu, 12 Nov 2020 08:44:19 -0800
In-Reply-To: <87y2j76vq3.wl-kuninori.morimoto.gx@renesas.com>
References: <878sb78ac4.wl-kuninori.morimoto.gx@renesas.com>
 <87y2j76vq3.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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

On Thu, 2020-11-12 at 13:37 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> component related function should be implemented at
> soc-component.c.
> This patch adds snd_soc_component_compr_get_codec_caps().
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  include/sound/soc-component.h |  2 ++
>  sound/soc/soc-component.c     | 21 +++++++++++++++++++++
>  sound/soc/soc-compress.c      | 13 ++-----------
>  3 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/include/sound/soc-component.h b/include/sound/soc-
> component.h
> index 7fd45462963e..d91e0eb1546d 100644
> --- a/include/sound/soc-component.h
> +++ b/include/sound/soc-component.h
> @@ -455,6 +455,8 @@ int snd_soc_component_compr_get_params(struct
> snd_compr_stream *cstream,
>  				       struct snd_codec *params);
>  int snd_soc_component_compr_get_caps(struct snd_compr_stream
> *cstream,
>  				     struct snd_compr_caps *caps);
> +int snd_soc_component_compr_get_codec_caps(struct snd_compr_stream
> *cstream,
> +					   struct snd_compr_codec_caps
> *codec);
>  
>  int snd_soc_pcm_component_pointer(struct snd_pcm_substream
> *substream);
>  int snd_soc_pcm_component_ioctl(struct snd_pcm_substream *substream,
> diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
> index 6f560238e2f9..2f1628100208 100644
> --- a/sound/soc/soc-component.c
> +++ b/sound/soc/soc-component.c
> @@ -545,6 +545,27 @@ int snd_soc_component_compr_get_caps(struct
> snd_compr_stream *cstream,
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_component_compr_get_caps);
>  
> +int snd_soc_component_compr_get_codec_caps(struct snd_compr_stream
> *cstream,
> +					   struct snd_compr_codec_caps
> *codec)
> +{
> +	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
> +	struct snd_soc_component *component;
> +	int i, ret;
> +
> +	for_each_rtd_components(rtd, i, component) {
> +		if (component->driver->compress_ops &&
> +		    component->driver->compress_ops->get_codec_caps) {
> +			ret = component->driver->compress_ops-
> >get_codec_caps(
> +				component, cstream, codec);
> +			if (ret < 0)
> +				return soc_component_ret(component,
> ret);
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_component_compr_get_codec_caps);
same comment for get_codec_caps() as well. We can maybe use this
directly instead of soc_compr_get_codec_caps()?

Thanks,Ranjani

