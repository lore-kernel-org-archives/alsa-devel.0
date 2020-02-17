Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA9FC34021
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:42:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE83C208C4
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EzrIQ6dn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="WwxkUyin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE83C208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00F02846;
	Mon, 17 Feb 2020 15:41:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00F02846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581950554;
	bh=mupifk44OONGo3mIFc74CI18Xi3bdf8D0wYQxQ+wxAg=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EzrIQ6dngxGWr48d93SwvnDzOykqpR7bGhvFbdzr1SLYc0pDtEfqZicNr2IuLcoAu
	 KcT7jtshrUmkggzs6vEcD2mI6/mAZRxPwCpudH4gk4pxM9USyBoDRqpw66btWtq1KC
	 Db+mhR40KwQPOetuF0tFa5rbZgsPE1e4NPnm05JM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 58F78F80172;
	Mon, 17 Feb 2020 15:41:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 132A2F801F4; Mon, 17 Feb 2020 15:41:41 +0100 (CET)
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70171F800C4
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 15:41:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70171F800C4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="WwxkUyin"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1581950492;
 s=strato-dkim-0002; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=cFRtptfsaUlKo1DNByJ5pB2rNEq/gwFCmQzD67nfBms=;
 b=WwxkUyinrQpAiI+2ZXL1HDMgD8iQ2gpMo2N38jW/bLeonGb7SIp7TkiwwC8py9rit5
 jn/f0Uq2olYwRSkwpfNvWNfwRYpmTdqLTKOwTO3ioRFFUjjHgl5Z1KcRdKz34IwKobtG
 TQFR+Z0WUlySZsYFp2JsjwUSh4UHC5Sd5JHvUVTw+1hYgEzU2jpHMQDbtXfnF520ecAM
 Gl8kMubjy5IrHsUXLCFWENq1DiSbXS47OUhu32jLHzFbS1X7Facnv6UV5T5Y77usy9eu
 3GonhHJ2psoa/n0DBlvX6tMGl2X831ovSpjk4bPUa23SsoGdCSNCGORPjJuVG6r3LQnA
 NucQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJKBk/pyQ=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net by smtp.strato.de (RZmta 46.1.12 AUTH)
 with ESMTPSA id a01fe9w1HEfPcdV
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 17 Feb 2020 15:41:25 +0100 (CET)
Date: Mon, 17 Feb 2020 15:41:20 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Sameer Pujar <spujar@nvidia.com>
Message-ID: <20200217144120.GA243254@gerhold.net>
References: <1579443563-12287-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1579443563-12287-1-git-send-email-spujar@nvidia.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 broonie@kernel.org, tiwai@suse.com
Subject: Re: [alsa-devel] [RFC] ASoC: soc-pcm: crash in snd_soc_dapm_new_dai
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Sun, Jan 19, 2020 at 07:49:23PM +0530, Sameer Pujar wrote:
> Crash happens in snd_soc_dapm_new_dai() when substream->private_data
> access is made and substream is NULL here. This is seen for DAIs where
> only playback or capture stream is defined. This seems to be happening
> for codec2codec DAI link.
> 
> Both playback and capture are 0 during soc_new_pcm(). This is probably
> happening because cpu_dai and codec_dai are both validated either for
> SNDRV_PCM_STREAM_PLAYBACK or SNDRV_PCM_STREAM_CAPTURE.
> 
> Shouldn't be playback = 1 when,
>  - playback stream is available for codec_dai AND
>  - capture stream is available for cpu_dai
> 
> and vice-versa for capture = 1?
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  sound/soc/soc-pcm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 74d340d..5aa9c0b 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -2855,10 +2855,10 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
>  
>  		for_each_rtd_codec_dai(rtd, i, codec_dai) {
>  			if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_PLAYBACK) &&
> -			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_PLAYBACK))
> +			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_CAPTURE))
>  				playback = 1;
>  			if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_CAPTURE) &&
> -			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_CAPTURE))
> +			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_PLAYBACK))
>  				capture = 1;
>  		}
>  

There are no longer any playback/capture PCMs registered on
qcom/apq8016_sbc with this patch. :(

With this patch:
  $ ls /dev/snd
  controlC0  timer

Without this patch:
  $ ls /dev/snd
  controlC0  pcmC0D0p   pcmC0D1c   timer

(There is exactly one playback-only and capture-only PCM normally...)

The routing looks like this:
  qcom-apq8016-sbc 7702000.sound: ASoC: registered pcm #0 WCD multicodec-0
  qcom-apq8016-sbc 7702000.sound: multicodec <-> Primary MI2S mapping ok
  qcom-apq8016-sbc 7702000.sound: ASoC: registered pcm #1 WCD-Capture multicodec-1
  qcom-apq8016-sbc 7702000.sound: multicodec <-> Tertiary MI2S mapping ok
  WCD: connected DAI link 7708000.lpass:Primary Playback -> 771c000.codec:AIF1 Playback
  WCD: connected DAI link 7708000.lpass:Primary Playback -> 200f000.spmi:pm8916@1:codec@f00:PDM Playback
  WCD-Capture: connected DAI link 771c000.codec:AIF1 Capture -> 7708000.lpass:Tertiary Capture
  WCD-Capture: connected DAI link 200f000.spmi:pm8916@1:codec@f00:PDM Capture -> 7708000.lpass:Tertiary Capture

For the playback stream, codec_dai and cpu_dai (lpass) only support SNDRV_PCM_STREAM_PLAYBACK.
The same applies to the capture stream.

I'm a bit confused about this patch, isn't SNDRV_PCM_STREAM_PLAYBACK
used for both cpu_dai and codec_dai in the playback case?

Thanks,
Stephan
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
