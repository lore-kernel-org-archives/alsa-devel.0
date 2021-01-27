Return-Path: <SRS0=72a4=G6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCC2C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 08:04:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597A82074A
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 08:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597A82074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9460170A;
	Wed, 27 Jan 2021 09:03:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9460170A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611734668;
	bh=nW1BQYbKv8WqL0V9JB9+wYv5JYNeA7kUpL8SzVgc1vk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=okvDhl8YRQ0Vq3cnYstMgKpDPbjbLP79lN7d+nLi4MBevp7aZsZtVx2llKCsbYpQM
	 l7s6W2uiSMHepb4EM6nmzOr//h7qZlwj81zxBqYke01ctH/bev67RfBFC3GGTBWLnQ
	 r85KwD2tmaM6gDDHr7gpU/kU7sdUh12BtuHDzVMY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3831FF80218;
	Wed, 27 Jan 2021 09:03:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 568F2F80259; Wed, 27 Jan 2021 09:03:36 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6474F8011C
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2021 09:03:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6474F8011C
Received: from mail-lj1-f198.google.com ([209.85.208.198])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1l4fnU-0005x6-8N
 for alsa-devel@alsa-project.org; Wed, 27 Jan 2021 08:03:28 +0000
Received: by mail-lj1-f198.google.com with SMTP id 2so828828ljr.17
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2021 00:03:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BYnxZjkpzfC+NOLdZn/Vx49r1S2Fj5QM9to9FiqOHGQ=;
 b=Mi5WSr02d8RQeuvBGYwTckeeQjhVJZhnvviQJqYS/OBE00oUjEMveVbo7ujLMluUSq
 FDCzQaqyZVcRaeWtMl2Iqh1piEv2wtwYem4k0VdpMi/WMTV5zEYPK8jG9xrm7cDPNmAN
 k4+bFg1df6DVsPz87WuCmCQjemkAcErvP9FIIGCW/rd8rkNIEEG2/fb8MEedEBNggJ29
 8DVYkr6XTgM1QdJlvvAitZIr0FbGlD1wZMQsKCeq8wQJdGogtrTqUwfo+yh1rV0j9Xdo
 g6dVFzaTmMAHp/AFTihCJ/VvbikWbHlqhoEt+bG5fhmVGat9U4rQZkmnkZr9veoj8MJP
 nlBA==
X-Gm-Message-State: AOAM533LvrCpRzeLznGKj6GaIR44x82IEF914bgcLCQTHGDcUQX+vEZY
 O60I9MUrd3tBjoiYIb8y5aXXclfA09B5imiMw9AfzX2usLX7PzJiuzahRrqtkeetQ4uUoGuu2gE
 goq8rfWV68dll1of9KP57t105onzqT0IztAfXpfc3sKhaL+uPu0fureoC
X-Received: by 2002:a19:84d5:: with SMTP id g204mr4396003lfd.425.1611734607744; 
 Wed, 27 Jan 2021 00:03:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzukkfM22JBbXn8lpLyZ0W/0RfK5Jk0dTyJ15eG7sMIFt7uVRcvd7WAvyPkWo4YYfR9pM5bQLvNcG8+FMK9TW0=
X-Received: by 2002:a19:84d5:: with SMTP id g204mr4395988lfd.425.1611734607474; 
 Wed, 27 Jan 2021 00:03:27 -0800 (PST)
MIME-Version: 1.0
References: <20210125115441.10383-1-cezary.rojewski@intel.com>
In-Reply-To: <20210125115441.10383-1-cezary.rojewski@intel.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 27 Jan 2021 16:03:15 +0800
Message-ID: <CAAd53p4fycxLn6y0WpaMWvWkN8EwmT216b40DavttfshN_GMRg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: Compile when any configuration is
 selected
To: Cezary Rojewski <cezary.rojewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
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

On Mon, Jan 25, 2021 at 7:55 PM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> Skylake is dependent on SND_SOC_INTEL_SKYLAKE (aka "all SST platforms")
> whereas selecting specific configuration such as KBL-only will not
> cause driver code to compile. Switch to SND_SOC_INTEL_SKYLAKE_COMMON
> dependency so selecting any configuration causes the driver to be built.
>
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Suggested-by: Amadeusz S=C5=82awi=C5=84ski <amadeuszx.slawinski@linux.int=
el.com>
> Fixes: 35bc99aaa1a3 ("ASoC: Intel: Skylake: Add more platform granularity=
")
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>

Still not working:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1902457/comments/66

Kai-Heng

> ---
>  sound/soc/intel/Makefile         | 2 +-
>  sound/soc/intel/skylake/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
> index 4e0248d2accc..7c5038803be7 100644
> --- a/sound/soc/intel/Makefile
> +++ b/sound/soc/intel/Makefile
> @@ -5,7 +5,7 @@ obj-$(CONFIG_SND_SOC) +=3D common/
>  # Platform Support
>  obj-$(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM) +=3D atom/
>  obj-$(CONFIG_SND_SOC_INTEL_CATPT) +=3D catpt/
> -obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) +=3D skylake/
> +obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON) +=3D skylake/
>  obj-$(CONFIG_SND_SOC_INTEL_KEEMBAY) +=3D keembay/
>
>  # Machine support
> diff --git a/sound/soc/intel/skylake/Makefile b/sound/soc/intel/skylake/M=
akefile
> index dd39149b89b1..1c4649bccec5 100644
> --- a/sound/soc/intel/skylake/Makefile
> +++ b/sound/soc/intel/skylake/Makefile
> @@ -7,7 +7,7 @@ ifdef CONFIG_DEBUG_FS
>    snd-soc-skl-objs +=3D skl-debug.o
>  endif
>
> -obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) +=3D snd-soc-skl.o
> +obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON) +=3D snd-soc-skl.o
>
>  #Skylake Clock device support
>  snd-soc-skl-ssp-clk-objs :=3D skl-ssp-clk.o
> --
> 2.17.1
>
