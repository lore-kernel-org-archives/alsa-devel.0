Return-Path: <SRS0=duqq=OS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ACEC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 21:26:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567A061246
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 21:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 567A061246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B933168E;
	Tue, 28 Sep 2021 23:26:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B933168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632864410;
	bh=f36YpelBc9fB7TCSA+TOC5+TxNwUwOr+48i8NaJbFD0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LJ7QFuNPMZ65FzjWh4OLZsnpb8YneQTiD6bfXR58gWx9QzTK3msSX0/Ks/yqs6S+M
	 RUT4Qvn+L5KdNmSSF6uCZzfBOJj3D/93apOBhRj1enf3N5rY1nR6Er757KLmzc9mpC
	 vQlm99fAD1DLhVDXAogsp4hLfe/ECvLz1ujMH1pQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7882BF8032C;
	Tue, 28 Sep 2021 23:25:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED289F804AD; Tue, 28 Sep 2021 23:25:57 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 49AE7F80105
 for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2021 23:25:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49AE7F80105
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="224463698"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; d="scan'208";a="224463698"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 14:25:45 -0700
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; d="scan'208";a="438223466"
Received: from ppahwa-mobl1.amr.corp.intel.com (HELO [10.212.48.236])
 ([10.212.48.236])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 14:25:43 -0700
Subject: Re: [PATCH 01/13] ASoC: soc-pcm: Don't reconnect an already active BE
To: Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
 lgirdwood@gmail.com, robh+dt@kernel.org, thierry.reding@gmail.com,
 jonathanh@nvidia.com, catalin.marinas@arm.com, will@kernel.org,
 perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com
References: <1630056839-6562-1-git-send-email-spujar@nvidia.com>
 <1630056839-6562-2-git-send-email-spujar@nvidia.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <be6290d1-0682-3d93-98a6-ad0be3ca42c1@linux.intel.com>
Date: Tue, 28 Sep 2021 16:25:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1630056839-6562-2-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, sharadg@nvidia.com, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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



On 8/27/21 4:33 AM, Sameer Pujar wrote:
> In some cases, multiple FE components have the same BE component in their
> respective DPCM paths. One such example would be a mixer component, which
> can receive two or more inputs and sends a mixed output. In such cases,
> to avoid reconfiguration of already active DAI (mixer output DAI in this
> case), check the BE stream state to filter out the redundancy.
> 
> In summary, allow connection of BE if the respective current stream state
> is either NEW or CLOSED.

This patch breaks our SOF CI tests, ironically in all cases where we
have a mixer with a 'Deep buffer' port! The tests with multiple streams
all fail with this error:

[  124.366400]  Port0 Deep Buffer: ASoC: no backend DAIs enabled for
Port0 Deep Buffer
[  124.366406]  Port0 Deep Buffer: ASoC: dpcm_fe_dai_prepare() failed (-22)

Reverting this patch restore the mixer functionality.

I see multiple problems with this patch:

At a high-level, there's at least a race condition where this BE state
is checked without any protection. That was already a problem that I
highlighted in a recent RFC and still working on, when we have multiple
FEs we can have START/STOP triggers happening concurrently and it's
necessary to serialize these triggers when checking the state, and this
patch increases the 'surface' for this race condition.

But in addition we'd need to agree on what an 'active BE' is. Why can't
we connect a second stream while the first one is already in HW_PARAMS
or PAUSED or STOP? It's perfectly legal in ALSA/ASoC to have multiple
HW_PARAMS calls, and when we reach STOP we have to do a prepare again.

And more fundamentally, the ability to add a second FE on a 'active' BE
in START state is a basic requirement for a mixer, e.g. to play a
notification on one FE while listening to music on another. What needs
to happen is only to make sure that the FE and BE are compatible in
terms of HW_PARAMS and not sending a second TRIGGER_STOP, only checking
the BE NEW or CLOSE state is way too restrictive.

I will agree this sort of mixer use cases is not well supported in
soc-pcm.c, but let's not make it worse than it was before this patch,
shall we?

I can send a revert with the explanations in the commit message if there
is a consensus that this patch needs to be revisited.

[1] https://github.com/thesofproject/linux/pull/3177
[2] https://sof-ci.01.org/linuxpr/PR3177/build6440/devicetest/

> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  sound/soc/soc-pcm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 48f71bb..e30cb5a 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -1395,6 +1395,10 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
>  		if (!fe->dpcm[stream].runtime && !fe->fe_compr)
>  			continue;
>  
> +		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_NEW) &&
> +		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_CLOSE))
> +			continue;
> +
>  		/* newly connected FE and BE */
>  		err = dpcm_be_connect(fe, be, stream);
>  		if (err < 0) {
> 
