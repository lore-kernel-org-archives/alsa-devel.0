Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9C7C10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:25:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5502620746
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="a4/FdCUz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="t14GJbGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5502620746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C842181F;
	Fri, 13 Mar 2020 16:24:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C842181F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584113120;
	bh=57yu1VLSyho246r9scD6iEgcSi1hrHBXg23DNjtPMn4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a4/FdCUz1DxslzytdFp8g1Ay5aNq+0YjpeZdQ03JMsNIGhabGdHTxIxnKZfvcCEsD
	 cYk0ijOU/RV4+oJApbPHqgnemJmhDTL++ZTi55dmT+btP1bHo+x5dgxYWQjat8femm
	 LJKc/+3V2uHD1GzPrfLW+Nv8YjKfRP1Ko3TEUg1Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 026E3F80090;
	Fri, 13 Mar 2020 16:24:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11567F8021D; Fri, 13 Mar 2020 16:24:26 +0100 (CET)
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6211F80090
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 16:24:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6211F80090
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="t14GJbGq"
Received: by mail-il1-x142.google.com with SMTP id w15so1922205ilq.6
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xdmj7dBGTEHYp0XfOUP3pgJPgVMfyI7vloWUgMImLRo=;
 b=t14GJbGq+31U9rFrQ5hx0ldNDMZnrzj5Gg49E5ewOaGJh4lJ0JLoCaCA7vGwW1YkaZ
 nsOnvnPxwArbB37mMz91zA/AWAiwhflCnHUQdVJxHc69UT4ZxGYM0WljZGUWPqTqApH+
 /a0MyHqcg8gXwgtbKH0pRnuqv+fYKbdyCXfIXkt4dpLt9wPkLGmvu4O1ZLDLZt8lJFNJ
 WwwWcX8Q1Qt2J9TKnHuycVBgaro6zqa+ImKm4i0NmlrR2nlt6VPziAaiz3TJsQMUMjKm
 yNOWDCsoyLYd3/ayEXLy6VLNgBNz4LThmN04JvAIupUNHRuKwhr3SKCkMKyEeWe3dh7R
 YZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xdmj7dBGTEHYp0XfOUP3pgJPgVMfyI7vloWUgMImLRo=;
 b=jE1UVueLowK+9++YpLUDlYc3jGkWrJJRaXZKrTRyP168kNkUmZyLSzIMfiFiBUxrUN
 afMj/ieY6UroqBAOo4cBw1PFPxvDGDQV8RWUHxNOGJzv4wafj8X+AY9/NyKIf6R8WsMY
 PRoOwfXxYWOHHkDy7Znhlf+G8zEQ/yxFN8Emfo/7Axc0lILyqgrMHnvXwGnMszpv69yJ
 oTQ9zf14vAFZoBcFxuKDWmJRzNYFXfWBDacKjbZnTFOVVuvQ2LN+csQoRrEXg4b4aQmE
 u6stfy8O2Pe8NZfzkAJ/EcogllBI9TL5NWPtPhD6pUFA9dxTWTtyzRmaPhCijSXbe4dG
 gzNQ==
X-Gm-Message-State: ANhLgQ1QpheEoLFTnHS1HDhy/4UKBxO9B7EC/RzPXxaeX1x1k0klt8gA
 t1uCzidaW5SIMv/oWWx9Bz1S7WeCNbi5yuxvfXUOXg==
X-Google-Smtp-Source: ADFU+vtBKWdt3SGpjCE//hapLPICujUj6Ray7fUfPQMsygaIKYZ8BJHCnMQQTxZpu427ZbepH4nh+Qz2Lylqpj0RhC8=
X-Received: by 2002:a92:911b:: with SMTP id t27mr14163871ild.142.1584113058578; 
 Fri, 13 Mar 2020 08:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200312144429.17959-1-guennadi.liakhovetski@linux.intel.com>
 <20200312144429.17959-9-guennadi.liakhovetski@linux.intel.com>
In-Reply-To: <20200312144429.17959-9-guennadi.liakhovetski@linux.intel.com>
From: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Date: Fri, 13 Mar 2020 08:24:07 -0700
Message-ID: <CAFQqKeUuSzqqDzRRVaMMVV+7iKJAfo-Azh4z7QYUZfXQFdiTqg@mail.gmail.com>
Subject: Re: [Sound-open-firmware] [PATCH 08/14] ASoC: SOF: fix uninitialised
 "work" with VirtIO
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>, sound-open-firmware@alsa-project.org
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

On Thu, Mar 12, 2020 at 7:51 AM Guennadi Liakhovetski <
guennadi.liakhovetski@linux.intel.com> wrote:

> In the VirtIO case the sof_pcm_open() function isn't called on the
> host during guest streaming, which then leaves "work" structures
> uninitialised. However it is then used to handle position update
> messages from the DSP. Move their initialisation to immediately after
> allocation of the containing structure.
>
> Signed-off-by: Guennadi Liakhovetski <
> guennadi.liakhovetski@linux.intel.com>
> ---
>  sound/soc/sof/pcm.c      | 2 --
>  sound/soc/sof/topology.c | 5 +++++
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
> index f4769e1..cd77796 100644
> --- a/sound/soc/sof/pcm.c
> +++ b/sound/soc/sof/pcm.c
> @@ -475,8 +475,6 @@ static int sof_pcm_open(struct snd_soc_component
> *component,
>         dev_dbg(component->dev, "pcm: open stream %d dir %d\n",
>                 spcm->pcm.pcm_id, substream->stream);
>
> -       INIT_WORK(&spcm->stream[substream->stream].period_elapsed_work,
> -                 sof_pcm_period_elapsed_work);
>
>         caps = &spcm->pcm.caps[substream->stream];
>
> diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
> index 9f4f886..16ee748 100644
> --- a/sound/soc/sof/topology.c
> +++ b/sound/soc/sof/topology.c
> @@ -2459,6 +2459,11 @@ static int sof_dai_load(struct snd_soc_component
> *scomp, int index,
>         spcm->stream[SNDRV_PCM_STREAM_PLAYBACK].comp_id =
> COMP_ID_UNASSIGNED;
>         spcm->stream[SNDRV_PCM_STREAM_CAPTURE].comp_id =
> COMP_ID_UNASSIGNED;
>
> +
>  INIT_WORK(&spcm->stream[SNDRV_PCM_STREAM_PLAYBACK].period_elapsed_work,
> +                 sof_pcm_period_elapsed_work);
> +
>  INIT_WORK(&spcm->stream[SNDRV_PCM_STREAM_CAPTURE].period_elapsed_work,
> +                 sof_pcm_period_elapsed_work);
>
Hi Guennadi,
Maybe it's better to use the newly introduced for_each_pcm_streams() macro
here?
Thanks,
Ranjani
