Return-Path: <SRS0=vsGj=3L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B19C32771
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 04:31:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28C320828
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 04:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gwbGhAtn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="K3oUIPQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28C320828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D4D821658;
	Wed, 22 Jan 2020 05:31:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D4D821658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579667511;
	bh=oQudZ9BgwhdKzckmfXvf43j0+dBCDJb5KqPWNRxgCxc=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gwbGhAtnQEKJizIt3bTQYDF1gcWxWs1iffEHP89rIzCAPLvdEenmiIDCzbVjUKukX
	 ViEhmQaQkDIBTilnc9UEAJN5WH1KdLSFJxYaD2esjxqQBTFvaEAktlQRGxxImp3SF+
	 l6yjTE1uU8rHYdFytykdwwHJsaf0OCno3A/YcfWM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A8F8F8007E;
	Wed, 22 Jan 2020 05:31:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5903DF8020C; Wed, 22 Jan 2020 05:30:59 +0100 (CET)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7422F800E7
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2020 05:30:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7422F800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="K3oUIPQn"
Received: by mail-il1-x141.google.com with SMTP id c4so4194753ilo.7
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2020 20:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AnWkcQ3zHvNk7ymBuExC0eU27CP/OMV5sxbH1OnMyoY=;
 b=K3oUIPQnxXRx0hwzg3NyazTQF4nFJiNBlFSEQjYAsxNwmB1+BsKlCwsZTwfPe3gQIg
 0pxdq3zo/Uv7bDhyFweyVvTla6YRx8TXj4FoWZx6mQJkfrcRhni8OKCZr7UIqbizAwz7
 alh7WXKoY7t8oHt799wYv/8oTFelJmzSZ5vdkTfMmTCRZhRe4rAU99tUZbk59ldJfjGz
 eyvGmrQI/9D9DWdmdVvnDSaIQ7OFB17ZHlEsApC54qpqiEdIDnsHVrSSA8pSJzsepxXo
 wcO5bZjunmGYwzhlXXH2uAZg0YnCcUAOTvAYGVwSLhzOnrewOG+tEksCHJzWGgVUfR4E
 +NAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AnWkcQ3zHvNk7ymBuExC0eU27CP/OMV5sxbH1OnMyoY=;
 b=Q/yGjsdPEHu2RqAHR1E/NjQ9ZKrfeMxRHRzPH2fOoUc/CFVr0Hb0MfrRapH0el4Svu
 Lkuz6adQE8To50OeDnOgYRldcRgEwKapaB/icSs8lNxF2d0CLpW14SoPbdNPaEYwJd2U
 pUFeP9bqCYtQKUN2LHCv4aXe2OwAVh5XvaGXUwXIClILMWCAbJUyOrr7AzBYd5FC5YHf
 DAdCFU8ioxRt0uP/16xntR7nf+6odFKpcPa16NT8aV7iWRZIodbPZq+aj4xRZy9mWEKY
 F/SgUZOsnIHAo5mjKA4Mgw5185dxbGDJp3ENMoqW8Uwj4Ku0fqhS2hDukKGUinRihW6w
 4iWw==
X-Gm-Message-State: APjAAAV2lzd2WSr85TrMP1ASxI0KTLG6YicMygI3Ma7ReMz8+lA7Bspk
 E1LEvURiPBFQHY4brigcHDKAp7bGAeMX2M3RfRG21Q==
X-Google-Smtp-Source: APXvYqyv/menL7kATu037kHeoKoLDdCNhxX+l4/jTiWYFpjcpNyzod1fti4W49fkKoFs4rzSrTm63AOJANJcTua7saU=
X-Received: by 2002:a92:911b:: with SMTP id t27mr6527860ild.142.1579667449736; 
 Tue, 21 Jan 2020 20:30:49 -0800 (PST)
MIME-Version: 1.0
References: <87a76gmiar.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a76gmiar.wl-kuninori.morimoto.gx@renesas.com>
From: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Date: Tue, 21 Jan 2020 20:30:38 -0800
Message-ID: <CAFQqKeV3174asC4Nd9iJawnv3X78Ec4Js3G=kQNJ0m3EiXtyBg@mail.gmail.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 0/7] ASoC: soc-pcm: add soc_rtd_xxx()
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

On Tue, Jan 21, 2020 at 4:46 PM Kuninori Morimoto <
kuninori.morimoto.gx@renesas.com> wrote:

>
> Hi Mark
>
> My ALSA SoC cleanup series focus to soc-pcm as 2nd step :)
> These create new soc_rtd_xxx() function, and cleanup soc-pcm.c
> (It will be more cleanup later)
>
> Kuninori Morimoto (7):
>   ASoC: soc-pcm: add soc_rtd_startup()
>   ASoC: soc-pcm: add soc_rtd_shutdown()
>   ASoC: soc-pcm: add soc_rtd_prepare()
>   ASoC: soc-pcm: add soc_rtd_hw_params()
>   ASoC: soc-pcm: add soc_rtd_hw_free()
>   ASoC: soc-pcm: add soc_rtd_trigger()
>   ASoC: soc-core: remove null_snd_soc_ops

The series looks good. Thanks, Morimoto-san.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
