Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5512C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Feb 2022 16:38:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94B701736;
	Thu, 17 Feb 2022 17:37:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94B701736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645115895;
	bh=Uh7SxgDiyle9Pt/1uKaz13Cdta+fG3LaUxSIrP3UDS4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aZ09hpt4jur4oyZ5cWmPmbkZW4nCqscm7Ke7Vr5oSMSec0u0QoU1/CpK2falIsODq
	 V9JUAKimgULLOzBjPyCx9+U5wvzUr1P2HJRywRrhLVg5SNvzf0tRbxKK2tpsFjz4K8
	 lwhXZOqh3uFOU+TewAm+FWgeNBXmOmJYnseRMaa0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 246FBF8023B;
	Thu, 17 Feb 2022 17:37:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6544DF80240; Thu, 17 Feb 2022 17:37:23 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC99DF800C0;
 Thu, 17 Feb 2022 17:37:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC99DF800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="oEfugztL"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E330CB82372;
 Thu, 17 Feb 2022 16:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790FAC340E8;
 Thu, 17 Feb 2022 16:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645115837;
 bh=Uh7SxgDiyle9Pt/1uKaz13Cdta+fG3LaUxSIrP3UDS4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oEfugztLGZ7KhKwtqEn9223T5MTF3xJxhO3dM2rtP9knaPDX97ekj22/Z1Ab70pBN
 4YNpm1mvWitXZ54ygxOgXm4QD0J1YXv3SX5zTMAws+LvFC99vaz3nRr3GjzFrsAqSZ
 /RpkNgGF8xxDs1g4J1ziT97ggzP23ySrpk5wwnGzl2eutVtCIZIDVyqvwyvfd6EuML
 TxPJ3n2XK3XEwexOe24bDRnFFV9jvNSNLPW8QiMAQiVG9KlwkTWiAsItK8E4chdWRH
 tzV+xyCwVuO1ULuUZkMv2495aU5ht22ip6UyTRrMOKgsp3VuD1nKzReRfrAqum4E9y
 pgosy2BeSWmeg==
Date: Thu, 17 Feb 2022 10:44:58 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH] ASoC: SOF: Replace zero-length array with flexible-array
 member
Message-ID: <20220217164458.GA932472@embeddedor>
References: <20220217132755.1786130-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217132755.1786130-1-steve@sk2.org>
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-hardening@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, sound-open-firmware@alsa-project.org
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

On Thu, Feb 17, 2022 at 02:27:55PM +0100, Stephen Kitt wrote:
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use "flexible array members"[1] for these cases. The older
> style of one-element or zero-length arrays should no longer be used[2].
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds
> and get us closer to being able to tighten the FORTIFY_SOURCE routines
> on memcpy().
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Link: https://github.com/KSPP/linux/issues/180
> Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  include/sound/sof/topology.h | 2 +-
>  sound/soc/sof/topology.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sound/sof/topology.h b/include/sound/sof/topology.h
> index d12736e14b69..adee6afd1490 100644
> --- a/include/sound/sof/topology.h
> +++ b/include/sound/sof/topology.h
> @@ -237,7 +237,7 @@ struct sof_ipc_comp_process {
>  	/* reserved for future use */
>  	uint32_t reserved[7];
>  
> -	uint8_t data[0];
> +	uint8_t data[];
>  } __packed;
>  
>  /* frees components, buffers and pipelines
> diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
> index e72dcae5e7ee..1d119d1dd69d 100644
> --- a/sound/soc/sof/topology.c
> +++ b/sound/soc/sof/topology.c
> @@ -2164,7 +2164,7 @@ static int sof_process_load(struct snd_soc_component *scomp, int index,
>  	 */
>  	if (ipc_data_size) {
>  		for (i = 0; i < widget->num_kcontrols; i++) {
> -			memcpy(&process->data + offset,
> +			memcpy(&process->data[offset],
>  			       wdata[i].pdata->data,
>  			       wdata[i].pdata->size);
>  			offset += wdata[i].pdata->size;
> 
> base-commit: f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3
> -- 
> 2.27.0
> 
