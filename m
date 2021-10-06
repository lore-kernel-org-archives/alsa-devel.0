Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD6AC433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 18:36:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F6A60F35
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 18:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98F6A60F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D94A83A;
	Wed,  6 Oct 2021 20:35:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D94A83A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633545363;
	bh=0v3StcxAnNmAW8xX+IwQP3W35Dvp3AnkYw6CC7+XbwA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EC+ucC20If9WwUxloP3kkkvZw1yOCbLh6om73W88bBMb/9si8GoGQGheypcgZFPHT
	 rh/FYrtFU/3SfpVRwGf/19ExaAsk6Ym00tgjwZMHvQGrBc7x/XIkXdDqxX+O3n9Nim
	 4Ggb+nDf+gPJDO/MneNaTXBb+eax5priCmIQlg+4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A014F80229;
	Wed,  6 Oct 2021 20:35:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97B49F80240; Wed,  6 Oct 2021 20:35:11 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F743F800FE
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 20:35:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F743F800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="V0jNzxJM"
Received: by mail-qk1-x72e.google.com with SMTP id g21so3487221qki.11
 for <alsa-devel@alsa-project.org>; Wed, 06 Oct 2021 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pEruuwb7cFwr8Ofs6shqqJVVofNEKWYdi6q9NkQEo5U=;
 b=V0jNzxJMeyddmMFs1uAHg88DuwmoRlW6I1WULYxGh5c4yht9k8VM5GWrRah9BKjsJ8
 eF+yfgWFZZ3zV9wSH2fOqwmZ5ti4skmxpJJ8U18MAx6+18/sVEfZKu5tyM2hyACUJ3h1
 Kgp1GwTX5s7IOTaaBKFKmk3dcC2kQtnV7gWT3N1Qo8f3+2Z0Ky5KU5YgItZb5bvDzV48
 ehn0TiDRTGVn23f7lg9QktVnm7MbpLqX8CiZvcIkW9yazLT6x5Tn3D4otRgBJJAR94O2
 v3SgtlnmBDnhbWZi3oFoyjSpUcQJ2g7rovgKEQidM0wrf80ASJtjoe9f/KejepSxbxrE
 0QNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pEruuwb7cFwr8Ofs6shqqJVVofNEKWYdi6q9NkQEo5U=;
 b=leJwKHKovnrm55HkEKD+UfDNDPiFy4J6hG0jBdwND5XZG+82Xcl7XLP1SW2Mv2dJt/
 2UMsqv1M6uLZQl/NyPoEeI7I2CUT8nyjCY4nH9z3T0disdAzgsqc6NrXygkQahskkVO6
 0MvHnLGDnXDPIG/0pPrvx4ZXxLSxNf0QAH6Iea9TTEGsqVXx5T22f2LY6Nzf+4lKqAWj
 jSR0f6DTi2RH5q5G9vanfrhVVdjt4DhaakkMLGFUvB9SGA2SQqXk5p59mK15VY5b2jK6
 QA2oKiSFhJt8lyM3byFGjMb79O9eE7FnsOOSKlxdg+IxTzbEjoZjEkAky0B3HNxL/wDo
 MGKg==
X-Gm-Message-State: AOAM532BRSwNeWwdM1IJxTVmMx/kHEOAFsWhQzqF5joMai09ZkLF1hhW
 CZUpKHJ6Qh2VLDpiCQuOyUk5HjO5UdHFTYTr2pQNEg==
X-Google-Smtp-Source: ABdhPJy3jjCRVqXoNRtJJpwgI9yhI0CVPdM/QofbR3SvmvtTbaf6ap4RgHTiernJVUxL284FMGOVtXzT9EWW+OHkdSs=
X-Received: by 2002:a37:b142:: with SMTP id a63mr209095qkf.393.1633545302972; 
 Wed, 06 Oct 2021 11:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211006161805.938950-1-brent.lu@intel.com>
 <20211006161805.938950-4-brent.lu@intel.com>
In-Reply-To: <20211006161805.938950-4-brent.lu@intel.com>
From: Curtis Malainey <cujomalainey@google.com>
Date: Wed, 6 Oct 2021 11:34:52 -0700
Message-ID: <CAOReqxjGX6fwqNjX0i31JiQJ+vRCMNTTFBhn7L=iPzYvVMk9mQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ASoC: Intel: sof_rt5682: use id_alt to enumerate
 rt5682s
To: Brent Lu <brent.lu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 ALSA development <alsa-devel@alsa-project.org>,
 Rander Wang <rander.wang@intel.com>, Mac Chiang <mac.chiang@intel.com>,
 Gongjun Song <gongjun.song@intel.com>, Bard Liao <bard.liao@intel.com>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
 Yong Zhi <yong.zhi@intel.com>, Charles Keepax <ckeepax@opensource.cirrus.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 Paul Olaru <paul.olaru@oss.nxp.com>, Libin Yang <libin.yang@intel.com>,
 Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Curtis Malainey <cujomalainey@chromium.org>
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

>  };
>
> +static struct snd_soc_acpi_codecs adl_rt5682s_hp = {
> +       .num_codecs = 1,
> +       .codecs = {"RTL5682"}
> +};
> +
>  struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>         {
>                 .id = "10EC5682",
> +               .id_alt = &adl_rt5682s_hp,
>                 .drv_name = "adl_mx98373_rt5682",
>                 .machine_quirk = snd_soc_acpi_codec_list,
>                 .quirk_data = &adl_max98373_amp,
> @@ -296,6 +302,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>         },
>         {
>                 .id = "10EC5682",
> +               .id_alt = &adl_rt5682s_hp,
>                 .drv_name = "adl_mx98357_rt5682",
>                 .machine_quirk = snd_soc_acpi_codec_list,
>                 .quirk_data = &adl_max98357a_amp,
> @@ -304,6 +311,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>         },
>         {
>                 .id = "10EC5682",
> +               .id_alt = &adl_rt5682s_hp,
>                 .drv_name = "adl_mx98360_rt5682",
>                 .machine_quirk = snd_soc_acpi_codec_list,
>                 .quirk_data = &adl_max98360a_amp,

Is there any way we can collapse this and the primary id into a single
list to avoid having 2 locations to track for the IDs?
