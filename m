Return-Path: <SRS0=uo8V=AL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3978C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:12:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6682073E
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OPhiHEH6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ok0vl9Ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6682073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89AFC1691;
	Tue, 30 Jun 2020 16:11:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89AFC1691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593526345;
	bh=KaJ8A/mtp7tiazUWqWYM9IFm5G1Nvqs2cqWvKn5WT8o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OPhiHEH6B+DZ0fpexvq/uehZHCeo+QzKUZuqUAxEP6Nis0fHhb4fJ8fV+6aNja4Bm
	 UjivS13JnYTImd1suz0lWToceN+uEXuvWKbyli4nkL/W19QoeL2ZNYEbAwjxIw0u7i
	 pnBGsZUYQn37hzXuLOjkvQCRdOnGvH4S8tfiHE3I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23EC1F80135;
	Tue, 30 Jun 2020 16:11:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ABABCF801F2; Tue, 30 Jun 2020 16:11:33 +0200 (CEST)
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1EB31F800EA
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2020 16:11:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1EB31F800EA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ok0vl9Ax"
Received: by mail-lj1-x242.google.com with SMTP id d17so8059790ljl.3
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2020 07:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KaJ8A/mtp7tiazUWqWYM9IFm5G1Nvqs2cqWvKn5WT8o=;
 b=ok0vl9AxjEtaqLYePLsNsU1F7UuQ/mCyacTbBucXkiBM5MoPdlgeD8vCjscO6H/YoO
 g1Y3tdvyyEKK9q2yfyRX9/W8woqV+6qqe1GPTYjJkO9URBKyG+2vC45bHjhFP+Sighy2
 dcI8F8s5Vfo8GRj3oMeByIZH7a/604pe6LCm/s6p1IQsq5+qrX/E6xr9jj/E9WES9Zng
 GiWCiezZOrh0uh1CoZcuMKEdEiqSdgeXf23b5DujkEjlrgSSWrX93szxwsGoC+pad/wM
 3rIglYZoPvhcbPpRVHCSSeoloCgm6pd895s39sP/y8I08clro7W8b/Nj6lHf1jboCDy2
 6uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KaJ8A/mtp7tiazUWqWYM9IFm5G1Nvqs2cqWvKn5WT8o=;
 b=G2LYXtLzBnvMC764KtsaB2qSDEuZPCodQBpriwYiCFQL1F2EyHGsdtqeYC80tiOlon
 ItAEL/qudZu1rSLKzurq1Z+pFlwA0ZkALSKyUAF6GlISJvYci9S8M43XPbURmeaQBBUE
 faPl/s0ahHqMwa3uWnBqfAAEo8NgLklGatf7cNQ5oUarVNlxlq5ayx+fhZYzrl5M66T0
 FMOqh+/Pa8zJhnfFz2M9fcCtKnN9exds/o3TEEP+Ov30s+5tt2uH5wmSDqwkK438bZRy
 PLjYIGVcoF/NVWLQsfkH/JjNDTxK15KaO0PFDQboU+mfeL1DSnQs2EcEk00ztoj63zrM
 OHuA==
X-Gm-Message-State: AOAM530zq9DmTTU/0xYwwQ3osQZgQdXsFmyiqcoRPuPQ5mSiqma50L9X
 gDG8dNkUufi//aXd03nUBTwa1cdrSR21Ujc0BZE=
X-Google-Smtp-Source: ABdhPJz5MIpXGlHgP1fvLS1Lh6z16GezmdUmGLLPMdcG9JOfzkS5KaVN414xdFAZLh68lRYnPXjkaFaK/PAFHUS7YMU=
X-Received: by 2002:a2e:880e:: with SMTP id x14mr978719ljh.218.1593526288891; 
 Tue, 30 Jun 2020 07:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <1593525367-23221-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1593525367-23221-1-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 30 Jun 2020 11:11:17 -0300
Message-ID: <CAOMZO5CZ2NhbFJJj8OAeJonA--ZfbfUWqhWCYRqeJE_v8QdKFQ@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: fsl_asrc: Add an option to select internal ratio
 mode
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
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

On Tue, Jun 30, 2020 at 11:07 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> The ASRC not only supports ideal ratio mode, but also supports
> internal ratio mode.
>
> For internal rato mode, the rate of clock source should be divided
> with no remainder by sample rate, otherwise there is sound
> distortion.
>
> Add function fsl_asrc_select_clk() to find proper clock source for
> internal ratio mode, if the clock source is available then internal
> ratio mode will be selected.
>
> With change, the ideal ratio mode is not the only option for user.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
