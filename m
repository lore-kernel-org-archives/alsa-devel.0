Return-Path: <SRS0=3aoS=6E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BC3C54FD0
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:44:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5227A20724
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Alxia7wD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5227A20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B31061681;
	Mon, 20 Apr 2020 23:43:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B31061681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587419078;
	bh=8TTcq38dtemsC9f/+uSqEo4gRqsslENAoyGZ/JaPSNo=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Alxia7wDhXh5u934phA2ARIQdgjqM+92ql/s6hBoMlGhx/r965i3bgXeo9iz3jDy+
	 tvIAhJ/vMtKwwDbvfiCWy95Oc9u/Pg2ysb5d+Oyi8CSIuI7lpfpwnIcWQoWhgRtcuV
	 MzK7Oh3G8OkKt9iJOPjv+6krraiTycB09GHtPLQw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B7A1F8013E;
	Mon, 20 Apr 2020 23:43:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 12D3DF801D9; Mon, 20 Apr 2020 23:43:44 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91B7CF800C8
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 23:43:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91B7CF800C8
IronPort-SDR: 2XqzrHVNeO5Br5U9wUE9+STkLAzrsx/b3HMCoXjURb5dcfnYGF+ZKTk+EMf1xCxxcdwo1cqpvk
 s5Uv5rzsQIBg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2020 14:43:33 -0700
IronPort-SDR: E01Qm8Nf61KndHX9s2lriQtz0fPn6NjuThlWeEiUJ3lSu89eF5AnVrvlBhtFlQOqLXezqXnpFf
 W61UA8vy26uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; d="scan'208";a="300404988"
Received: from unknown (HELO ranjani-desktop) ([10.254.50.246])
 by FMSMGA003.fm.intel.com with ESMTP; 20 Apr 2020 14:43:33 -0700
Message-ID: <3fb997e79dd95ba21070ed37a5b1e3103332309d.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/8] ASoC: add snd_compress_ops and replace
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown
 <broonie@kernel.org>
Date: Mon, 20 Apr 2020 14:43:33 -0700
In-Reply-To: <87wo6avdq1.wl-kuninori.morimoto.gx@renesas.com>
References: <87wo6avdq1.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
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

On Mon, 2020-04-20 at 16:05 +0900, Kuninori Morimoto wrote:
> Hi Mark
> 
> Current snd_soc_component_driver has compr_ops,
> but it is created for ALSA, not for ALSA SoC.
> This means it doesn't know the callback is for which component,
> thus, each callback needs to get component via lookup function.
> 
> It is not good design, and will not work in the future,
> because ASoC can have multipul same name component which
> current lookup function can't handle.
> 
> This v2 patch-set adds new snd_compress_ops and call
> callbacks with component.
> v1 is here
> 
> Link: 
> https://lore.kernel.org/alsa-devel/87blnqpuqp.wl-kuninori.morimoto.gx@renesas.com/
> 
> Kuninori Morimoto (8):
>   ASoC: soc-compress: add snd_compress_ops
>   ASoC: codec: wm_adsp: use snd_compress_ops
>   ASoC: uniphier: use snd_compress_ops
>   ASoC: qcom: q6sp6: use snd_compress_ops
>   ASoC: intel: atom: use snd_compress_ops
>   ASoC: sof: use snd_compress_ops
>   ASoC: sprd: use snd_compress_ops
>   ASoC: soc-compress: remove snd_compr_ops

LGTM, Morimoto-san. Thanks!

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

