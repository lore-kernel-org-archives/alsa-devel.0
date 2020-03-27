Return-Path: <SRS0=JTem=5M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24473C43331
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:17:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9790F21556
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RDnRB31d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9790F21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFC841661;
	Fri, 27 Mar 2020 19:16:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFC841661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585333035;
	bh=OU4IHWI8HyypcrTYTfFTf/NIsVU8nopfJdhYC5BD8v4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RDnRB31dfhlkcPxx4w7J1818g/5mQwXIrpBb/F7mTt7FF7LALlY4WQgDZmqBRlGVt
	 ChaqPouXZDbm8VGx04mzAjwnONGFim4hwQ6nbMX2vILOIZSPoQrEcbIGmhmz9tu3Re
	 9XjBGqLAZZt0mLXuM0tEwWAWaUfiNzAtIMvIavbg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 408FAF8011B;
	Fri, 27 Mar 2020 19:16:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7CFA8F80158; Fri, 27 Mar 2020 19:16:23 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20E5FF8011B
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 19:16:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20E5FF8011B
IronPort-SDR: /UDJfga7qHhVcp4xo6DQtNHu9E+UR7hpw0YW+40n2mR+T/U9q3rJgbKLMhFeOeKI0r1b6kO73r
 o+MQMZHiBUwQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 11:16:14 -0700
IronPort-SDR: PwI5KI0sqlcX8zo/oyk6Y1k11pON+BlPluPujKN9Z/+uyvmKfTiRnVfTTD/c4PN2/VWesfzHFu
 D11Gm7Apbgyg==
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; d="scan'208";a="394453560"
Received: from aslawinx-mobl1.ger.corp.intel.com (HELO [10.249.133.141])
 ([10.249.133.141])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 11:16:12 -0700
Subject: Re: [alsa-devel] [PATCH v3 5/8] ASoC: soc-pcm: call
 snd_soc_dai_startup()/shutdown() once
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <87d0anceze.wl-kuninori.morimoto.gx@renesas.com>
 <875zgfcey5.wl-kuninori.morimoto.gx@renesas.com>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Message-ID: <54b81b41-f4cf-c28c-0ec5-363e2c62796b@linux.intel.com>
Date: Fri, 27 Mar 2020 19:16:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <875zgfcey5.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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

On 2/10/2020 4:14 AM, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current soc_pcm_open() calls snd_soc_dai_startup() under loop.
> Thus, it needs to care about started/not-yet-started codec DAI.
> 
> But, if soc-dai.c is handling it, soc-pcm.c don't need to care
> about it.
> This patch adds started flag to soc-dai.h, and simplify soc-pcm.c.
> This is one of prepare for cleanup soc-pcm-open()
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> ---
(...)

>   static inline void *snd_soc_dai_get_dma_data(const struct snd_soc_dai *dai,
> diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
> index 51031e33..73a8293 100644
> --- a/sound/soc/soc-dai.c
> +++ b/sound/soc/soc-dai.c
> @@ -295,17 +295,24 @@ int snd_soc_dai_startup(struct snd_soc_dai *dai,
>   {
>   	int ret = 0;
>   
> -	if (dai->driver->ops->startup)
> +	if (!dai->started &&
> +	    dai->driver->ops->startup)
>   		ret = dai->driver->ops->startup(substream, dai);
>   
> +	if (ret == 0)
> +		dai->started = 1;
> +
>   	return ret;
>   }

Hi,

the above change breaks simultaneous playback and capture on single DAI 
in more complicated use cases. With above change when one runs playback 
first, startup callback is skipped when running capture while playback 
is still running.

With snd_soc_skl it leads to null pointer dereference, because we didn't 
initialize streams properly:

[   78.901574] dpcm_be_dai_hw_params:2219:  Analog Playback and Capture: 
ASoC: hw_params BE Analog Playback and Capture
[   78.901582] dapm_update_dai_unlocked:2638: snd_hda_codec_realtek 
ehdaudio0D0: Update DAI routes for Analog Codec DAI capture
[   78.901585] dapm_update_dai_chan:2612: snd_hda_codec_realtek 
ehdaudio0D0: Connecting DAI route AIF3TX -> Analog Codec Capture
[   78.901590] dapm_update_dai_chan:2612: snd_hda_codec_realtek 
ehdaudio0D0: Connecting DAI route AIF1TX -> Analog Codec Capture
[   78.901608] dapm_update_dai_unlocked:2638: snd_soc_skl 0000:00:1f.3: 
Update DAI routes for Analog CPU DAI capture
[   78.901612] dapm_update_dai_chan:2612: snd_soc_skl 0000:00:1f.3: 
Connecting DAI route Analog CPU Capture -> codec0_in
[   78.901615] dpcm_fe_dai_hw_params:2277:  Analog HDA DSP: ASoC: 
hw_params FE Analog HDA DSP rate 48000 chan 2 fmt 2
[   78.901622] skl_pcm_hw_params:307: snd_soc_skl 0000:00:1f.3: 
skl_pcm_hw_params: hda-dsp-analog-dai
[   78.901624] 
==================================================================
[   78.907515] BUG: KASAN: null-ptr-deref in 
skl_pcm_hw_params+0x102/0x3d0 [snd_soc_skl]
[   78.914003] Write of size 4 at addr 0000000000000044 by task arecord/2119

Amadeusz
