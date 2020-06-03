Return-Path: <SRS0=5Ozn=7Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69EEC433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Jun 2020 17:36:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C882053B
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Jun 2020 17:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vA2fyL7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C882053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6C83827;
	Wed,  3 Jun 2020 19:36:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6C83827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591205813;
	bh=nxsv91YZ1f6yIdqc/jstEYWMXL8RqTOBWwlCy/hGDns=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vA2fyL7XP8aQvtn82Q5Se5400CuhTNCD4g3Y2t+tfw2fueYMdkp/grEYAcXsZe54w
	 jhPzArDNADckHaPBplxz0I7JHgMOe3Dmciyu/v51D5mfwLX9w7R5h069uMIG3ISYIB
	 T4tkHgx+iC7KDleoiLItTgkETqdfbxh/rOJ0hfn8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A9E2F801EC;
	Wed,  3 Jun 2020 19:36:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 315FBF801ED; Wed,  3 Jun 2020 19:36:00 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC41FF800D0
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2020 19:35:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC41FF800D0
IronPort-SDR: 36D1XSQvOS6W9XyjLvWHAeNml6iU9exJqqRS177bupFanFEwi2Bfc7RGC0a/SIZSUgqJxBgPLi
 mLN4+CTbTmKQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2020 10:35:47 -0700
IronPort-SDR: 1s/hq7IMP2nQvcTHpEhunyq7Kpl7lKy/DVPQPHuP0DvOUWt4VEeGRfy/ZvOmt/uYimVsEKJli5
 h8B9a8La7SsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,468,1583222400"; d="scan'208";a="445192654"
Received: from unknown (HELO ranjani-desktop) ([10.254.43.45])
 by orsmga005.jf.intel.com with ESMTP; 03 Jun 2020 10:35:47 -0700
Message-ID: <af9426ea89afc8ab987c7e6f21846cf3cc13b775.camel@linux.intel.com>
Subject: Re: [PATCH 17/24] ASoC: soc-component: add
 snd_soc_component_compr_pointer()
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown
 <broonie@kernel.org>
Date: Wed, 03 Jun 2020 10:35:47 -0700
In-Reply-To: <87lfl7y3as.wl-kuninori.morimoto.gx@renesas.com>
References: <87a71nzhy2.wl-kuninori.morimoto.gx@renesas.com>
 <87lfl7y3as.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
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

On Mon, 2020-06-01 at 10:37 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> component related function should be implemented at
> soc-component.c.
> This patch adds snd_soc_component_compr_pointer().
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
> index da1d89d0b476..0e05aedaee05 100644
> --- a/include/sound/soc-component.h
> +++ b/include/sound/soc-component.h
> @@ -450,6 +450,8 @@ int snd_soc_component_compr_get_caps(struct
> snd_compr_stream *cstream,
>  int snd_soc_component_compr_get_codec_caps(struct snd_compr_stream
> *cstream,
>  					   struct snd_compr_codec_caps
> *codec);
>  int snd_soc_component_compr_ack(struct snd_compr_stream *cstream,
> size_t bytes);
> +int snd_soc_component_compr_pointer(struct snd_compr_stream
> *cstream,
> +				    struct snd_compr_tstamp *tstamp);
>  
>  int snd_soc_pcm_component_pointer(struct snd_pcm_substream
> *substream);
>  int snd_soc_pcm_component_ioctl(struct snd_pcm_substream *substream,
> diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
> index 8f223dd060e8..8a24d6f3572a 100644
> --- a/sound/soc/soc-component.c
> +++ b/sound/soc/soc-component.c
> @@ -549,6 +549,27 @@ int snd_soc_component_compr_ack(struct
> snd_compr_stream *cstream, size_t bytes)
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_component_compr_ack);
>  
> +int snd_soc_component_compr_pointer(struct snd_compr_stream
> *cstream,
> +				    struct snd_compr_tstamp *tstamp)
> +{
> +	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
> +	struct snd_soc_component *component;
> +	int i, ret;
> +
> +	for_each_rtd_components(rtd, i, component) {
> +		if (component->driver->compress_ops &&
> +		    component->driver->compress_ops->pointer) {
> +			ret = component->driver->compress_ops->pointer(
> +				component, cstream, tstamp);
> +			if (ret < 0)
> +				return soc_component_ret(component,
> ret);
Morimoto-san,

This seems slightly different from the original loop in
soc_compr_pointer() where we break as soon as the condition is true. So
should we return irrespective of the return value here?

Thanks,
Ranjani

