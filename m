Return-Path: <SRS0=eDLw=CB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0247C433E1
	for <alsa-devel@archiver.kernel.org>; Sun, 23 Aug 2020 03:49:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D7F2074D
	for <alsa-devel@archiver.kernel.org>; Sun, 23 Aug 2020 03:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kAFebeWP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLWyeib8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D7F2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7ACC81670;
	Sun, 23 Aug 2020 05:48:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7ACC81670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598154577;
	bh=DDLMIpARLo60QyGkeB/hSld17jPkDxqbSncFsDkEUXo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kAFebeWPosnVU8AbnInxOKzSoXnMi1ySedcLK4izz+CWRIlws5SzzQY+mMdIprRbX
	 AvVmH1kT5tcbj74YNdyT+dk+Z44KGqaFHgvz4rI4hOBaR8ATYsdRAlvg9/KPDiVZmV
	 zMtENZ837lfNglROc6zpi1JWpGUGcjkxLYhGBp9k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 072CBF800EB;
	Sun, 23 Aug 2020 05:48:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52E71F8025A; Sun, 23 Aug 2020 05:48:43 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41894F800EB
 for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2020 05:48:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41894F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="kLWyeib8"
Received: by mail-qt1-x843.google.com with SMTP id e5so4037676qth.5
 for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2020 20:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ifz33jCf1uh5PVEoowr/JfI2gQmxuqYW31QuiG6PsJM=;
 b=kLWyeib8YAnIuLkwCUzHRV6VucC/iWuf8LL6FH4cHkp8ckkYJhdqkT29zdB4eTYtmW
 5agyzLko8o7IiTjrsUGo2dmiDwIRmlLvLPhKsyPk6TSy1AKq2IoZsVAJIOVIehaYUyY2
 ado4LS/XOQxsmb67rAuflYr73m+RK2ADoGkAs7Q3ObLgvtJVgWbTRDLZDwqNjcH9HfyQ
 lQtLk7ODr6EF+e5yu53lkgHS+o088PL/HYTHfJNbcjfJEua6ffwrY186xvBC9WYzOwmc
 JUGsOQZilbfmRSI3CUp9d8KAHRBwt47BS/uviMKAVg9UkQyF9Zd81xMAZOCnQlfOYjuC
 s7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ifz33jCf1uh5PVEoowr/JfI2gQmxuqYW31QuiG6PsJM=;
 b=Zgliuz2asGQwDcfneNYlN57N0qntcQnWfofm9OjYbne1MOJ74TVBic/vBVhOgoIY05
 e9fQhW/h8HGr8Muf/nnepjKSaAA5jaFAwWfbCmaSjVphez1Nb2bsQF+fu1z5epszPcOW
 +3H4gGRRS445FGxI0xGeGiR6UTKrwGfPTK+HLCOJtEI30k/5uniNZoB9fTRFSkxKcVMD
 58/uAOE9IvsGAh2qlSOYaUaUV9htJGSnplS8i0e7vz6ff1AZUle2s4WLN+z8p3CwR1QF
 RekLtzkXnr0BHU8Ey+Qz21uKJeg6Rj/W5+g3ov6PjIYkVGHiqZuFmZZn9qc/o9xgQYBh
 KT5w==
X-Gm-Message-State: AOAM531osg/orXQ03QPxzeyw4sssj3YqsvfpSRhFgb2s4GH6e8VhNbYs
 SQh/6/ioMWijb/8rhuK8T5s=
X-Google-Smtp-Source: ABdhPJxcW/gJgraQEn5SqHN7VH2RkIDqY0mJF+1R3gpCtOCAZSQDLqD9CFQca+eouDl3K8bbz/be2g==
X-Received: by 2002:ac8:73d9:: with SMTP id v25mr222890qtp.82.1598154512740;
 Sat, 22 Aug 2020 20:48:32 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
 by smtp.gmail.com with ESMTPSA id c70sm5788098qke.109.2020.08.22.20.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2020 20:48:31 -0700 (PDT)
Date: Sat, 22 Aug 2020 20:48:29 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/5] ASOC: SOF: Intel: hda-codec: move unused label to
 correct position
Message-ID: <20200823034829.GA2636427@ubuntu-n2-xlarge-x86>
References: <20200813175839.59422-1-pierre-louis.bossart@linux.intel.com>
 <20200813175839.59422-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813175839.59422-2-pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
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

On Thu, Aug 13, 2020 at 12:58:35PM -0500, Pierre-Louis Bossart wrote:
> Cppcheck reports the following warning:
> 
> sound/soc/sof/intel/hda-codec.c:191:1: style: Label 'error' is not
> used. [unusedLabel]
> 
> This label is indeed only used conditionally, move it where it's
> actually used.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/sof/intel/hda-codec.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
> index 2c5c451fa19d..119aa9ffcc66 100644
> --- a/sound/soc/sof/intel/hda-codec.c
> +++ b/sound/soc/sof/intel/hda-codec.c
> @@ -178,6 +178,11 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address,
>  	}
>  
>  	return ret;
> +
> +error:
> +	snd_hdac_ext_bus_device_exit(hdev);
> +	return -ENOENT;
> +
>  #else
>  	hdev = devm_kzalloc(sdev->dev, sizeof(*hdev), GFP_KERNEL);
>  	if (!hdev)
> -- 
> 2.25.1
> 

I don't get this patch because there is no moving of a label, it just
introduces it, where it is actually completely unused in the function as
far as I can tell in both v5.9-rc1 and next-20200821. When building with
clang in certain configurations, this introduces the same type of
warning:

sound/soc/sof/intel/hda-codec.c:182:1: warning: unused label 'error'
[-Wunused-label]
error:
^~~~~~
1 warning generated.

It seems like this should be reverted as it does not actually do
anything.

Cheers,
Nathan
