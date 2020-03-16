Return-Path: <SRS0=b36W=5B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34CCC0044D
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:33:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B089205ED
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AEL3Gzq7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="kVfqgi8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B089205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C495B1892;
	Mon, 16 Mar 2020 18:32:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C495B1892
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584379995;
	bh=S2SEWsEkGlm9IbrsUaThWvJ27Bw76VE8Uuu2XrWyKJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AEL3Gzq7aZJhnFUe7h+vDGgKE3AaNuLHO1MNn85ObQ026iHwVgeMC6e4ep4QBdAev
	 TRngeXJgs2mOQmMu9eOghrpA6qz3QN05DZjqbgB5dO1XIdPHu/Ijvh1vP4asHAY7rd
	 Ow8wFdW/+GkQOFbVeGs4UgtepF4h8SnX+jltTPcQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A3D5F800CD;
	Mon, 16 Mar 2020 18:32:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD8BEF8015B; Mon, 16 Mar 2020 18:32:23 +0100 (CET)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DB24F800D2
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2020 18:32:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DB24F800D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="kVfqgi8M"
Received: by mail-il1-x141.google.com with SMTP id k29so17371871ilg.0
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2020 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/UdddX4wwQDz+12WfMeeE0PYT30S5yvcKAelCV5+eIQ=;
 b=kVfqgi8MmVHI4jgmyQoox6v7HD6BoDg6OAzo+D9kX6y4DmU6nBDrds4K2gthq+oUL8
 EUPvS2eXqKTVwXfmWtdqcrejpgpw6Qn6rEg4HWqTyQRfVpNNWOUanS5A+ZLD+tNauLX3
 ve71ONi0K0AWPN/XiW6zufoKDFu/NjdYkJ1dlNJCkltuNlek+WL+nExQ3G+tITd9wKfh
 SbTYadUiL2Y8Muo9HwDspIrnKhgIInXsbM+/NpXCddWBrX1Ks/TaSa3/JTSqJuI+xXrT
 AInAYb11+lMyY/37Rr1yGQ5exfTWpIWYR0IUnReWFP/+NsU5f/qaMaK8u1cQxtJURDko
 Nfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/UdddX4wwQDz+12WfMeeE0PYT30S5yvcKAelCV5+eIQ=;
 b=uOK63L/mFDE3URjv4mLb0TJm4C3BUFJg6KQ0DdOdnUg36olfSrxXaVfkGTEImp0lYL
 Iv8Zeoi2ADsGikLfjDO8GVLo3vROmA7PWCx+CeLcJJnXQbpjbAVqEZ44767YTZ6BgLw1
 VzOEXR16czLCNiglbTNiogTJOAAHDUU00GE9c9R1BXktoK8G6WHH0aujNDMPC8E24X2a
 7InMON+A24x6xZWAg551VUzWxnE9WsRurMkZU99SzuxUY7SA0HPnqUWVSZYaIloWuqEA
 WeUH+ABNLNQZbkjGF7cMwNJOEnPnN+nWY/RDejilFbYfp/Df6AbBHEjvoZSI+11gk9k+
 EWUQ==
X-Gm-Message-State: ANhLgQ3nYmLm6rBGuleoqAYPpx8+r+FVqrq40QRDqtveettHoyFHLd0C
 tuR1T/VLu1Q0q5CEjRLXz9UQjfARAhA+oau41yaZsfkk
X-Google-Smtp-Source: ADFU+vuoDw57Nrijkq2uyJ5F37fXZBe/aAQP2IiTVU18VI2wqiI0W7NaiOCnUJvsKoXNxA5DntFmGAciPWjFmlRIrSE=
X-Received: by 2002:a05:6e02:685:: with SMTP id o5mr954242ils.86.1584379935918; 
 Mon, 16 Mar 2020 10:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <87y2s0olg6.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y2s0olg6.wl-kuninori.morimoto.gx@renesas.com>
From: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Date: Mon, 16 Mar 2020 10:32:05 -0700
Message-ID: <CAFQqKeU=m9+N5Drr7XG8KZfnETTnhU7P7Pogq+19mb6VhpC-qw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] ASoC: Merge CPU/Codec DAIs
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
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

On Sun, Mar 15, 2020 at 11:38 PM Kuninori Morimoto <
kuninori.morimoto.gx@renesas.com> wrote:

>
> Hi Mark
>
> Previous v2 patch-set can't be applied
> on top of latest for-5.7 branch.
> This v3 is rebased version on top of it.
>
> Current ALSA SoC has CPU/Codec categorized DAIs.
> But we want to have non-categorized DAIs in the future.
> This was indicated by Lars-Peter before at ELCE.
> But, we *can't* do it right now.
> Because many drivers are considering CPU and Codec separately.
>
> Currently, rtd has both CPU/Codec DAIs array.
>
>         rtd->cpu_dais   = [][][][][][][][][]
>         rtd->codec_dais = [][][][][][][][][]
>
> This patch merges these, like below.
> It still can use rtd->cpu_dais, rtd->codec_dais.
> Of course for_each_rtd_cpu/codec_dais() macro too.
> So we can use/keep existing code/method same as before.
>
>         rtd->dais = [][][][][][][][][][][][][][][][][][]
>                     ^cpu_dais         ^codec_dais
>                     |--- num_cpus ---|--- num_codecs --|
>
>         rtd->cpu_dais   = &rtd->dais[0];
>         rtd->codec_dais = &rtd->dais[dai_link->num_cpus];
>
> There are some code which is doing something *only* for CPU or Codec.
> This patch-set do nothing to such code.
> Maybe it can be updated in the future, maybe not (can't).
>
> I hope this patch-set can be 1st step for non-categorized DAIs.
> But the main purpose so far is that replace the duplicate code
> for borh CPU and Codec.
>
>         -       for_each_rtd_cpu_dais() {
>         -               ...
>         -       }
>         -       for_each_rtd_codec_dais() {
>         -               ...
>         -       }
>         +       for_each_rtd_dais() {
>         +               ...
>         +       }
>
>
> Kuninori Morimoto (6):
>   ASoC: soc-core: Merge CPU/Codec DAIs
>   ASoC: soc-core: Merge for_each_rtd_cpu/codec_dais()
>   ASoC: soc-dapm: Merge for_each_rtd_cpu/codec_dais()
>   ASoC: soc-pcm: Merge for_each_rtd_cpu/codec_dais()
>   ASoC: soc-core: Merge CPU/Codec for soc_dai_pcm_new()
>   ASoC: soc-pcm: Merge CPU/Codec MSB at soc_pcm_apply_msb()

LGTM, thanks Morimoto-san.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
