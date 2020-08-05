Return-Path: <SRS0=cqJl=BP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8D8C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 05:04:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D1822CB3
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 05:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BAzdoJiG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0+e+ASi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D1822CB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F33D84C;
	Wed,  5 Aug 2020 07:04:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F33D84C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596603897;
	bh=O1Yf6Y718hMe4K8VRm3Wd6UUkupezguf+8/6YvK8mv0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BAzdoJiGAXZsj14YGhB4+A3av63L3zAPB2ueU4ppA40Xd8Bkhbt89x/l3QrCsdW1W
	 dfnxVuwM78WUJBRxWcLFKwf9f4AndEbiekAOXudoeZeotyIVVGPInqEn5vCbI1wPlS
	 k/BQmcGZM3FKOAafrs6MK06LnsrE9ChSsPjJTgQ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72EFEF801F7;
	Wed,  5 Aug 2020 07:04:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98410F80218; Wed,  5 Aug 2020 07:04:02 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74B52F800B7
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2020 07:03:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74B52F800B7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="p0+e+ASi"
Received: by mail-qt1-x843.google.com with SMTP id e5so18766564qth.5
 for <alsa-devel@alsa-project.org>; Tue, 04 Aug 2020 22:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pJ+vSUIfqUpR/OfEnitTx0/E2WJkwWGAd7jXaGWXUSE=;
 b=p0+e+ASizlzhr9HvCBd0RSANYOffAstBixdT/gc+PGRA3WXffZI0bH00pFNrrd3D/9
 w6BGn++Pxi73MkkbA9k/LteCWLjqk/zey4aZljPqYMdn11ZZmlCGZZxnfdcHwADa7v0h
 KuvTA7QSAFYYk7YqF8XGS5oBE0hXKUf6e86LOqdF10lzDBSynzGsib+HoGKFawjs6SVV
 9xs+kulL5aH4Hzo9HNbTvEon7mKwi7R8rfQ0R0UiPIhr9yv49x7blWgxYcRcrduhCv4b
 gU6IGg4iT0SPgCnXiPoovfgcMbeSAaPwiMVjPDfKRjAqihonMBlgUt6AnWiCxqBjalDQ
 o1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pJ+vSUIfqUpR/OfEnitTx0/E2WJkwWGAd7jXaGWXUSE=;
 b=YkNoBVCOvWvfvrjW/DWu5nGXV95tAAALEQwbJOwjCudno9NwQgfxGfl7NE45pxldY6
 B+KLAH1S+60APJMfPGkUhRTM+xiqdEuHwj5G/ziytVH8bzB0DnYRxLFtof7kRZXmxfje
 QhZTaI89b3d6XKGaeTDOwRi74WWDZ0zp+3xo4ps+4L+7LG8mstxA5FAGbaoX+qKGtNSM
 rxF6dIWoXLoyjQSEkD42smonHbaVCb3gc8AQmgU0RJvaBZ3c4k7c0Te7L0nK99XZNDoP
 G2XZFux0V6npZlD2YaX73FbHt3HqBiTWwAsDTSau/OXmb/BZh6AxdlfHyWWfjpQCWgVD
 cYGQ==
X-Gm-Message-State: AOAM532OuJDgud0jkSF+Re6ty6fpACjYXTDfPUT+tY4OI7LlhdY0EL75
 vqb0NmnpvPSRadADrD/o6hUrfw2yyQ6en5QKLk4=
X-Google-Smtp-Source: ABdhPJxP151f0b2pd7JM99jfAomT13Boin3/gUNf7Zg7iIwdHSVUQNJ4Qya2mEifL2X6+m0qcvOVqpVaIqcCAWtPj9k=
X-Received: by 2002:ac8:6d0f:: with SMTP id o15mr1533677qtt.121.1596603828149; 
 Tue, 04 Aug 2020 22:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <1596594233-13489-1-git-send-email-shengjiu.wang@nxp.com>
 <1596594233-13489-3-git-send-email-shengjiu.wang@nxp.com>
 <20200805041111.GB10174@Asurada-Nvidia>
In-Reply-To: <20200805041111.GB10174@Asurada-Nvidia>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 5 Aug 2020 13:03:37 +0800
Message-ID: <CAA+D8ANv-qURC_wu3TzWiiiCAXC88Gc+WGssdjmuWoLPTRm3pA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: fsl_sai: Refine enable and disable sequence
 for synchronous mode
To: Nicolin Chen <nicoleotsuka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
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

On Wed, Aug 5, 2020 at 12:13 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Wed, Aug 05, 2020 at 10:23:53AM +0800, Shengjiu Wang wrote:
> > Tx synchronous with Rx:
> > The TCSR.TE is no need to enabled when only Rx is going to be enabled.
> > Check if need to disable RSCR.RE before disabling TCSR.TE.
> >
> > Rx synchronous with Tx:
> > The RCSR.RE is no need to enabled when only Tx is going to be enabled.
> > Check if need to disable TSCR.RE before disabling RCSR.TE.
>
> Please add to the commit log more context such as what we have
> discussed: what's the problem of the current driver, and why we
> _have_to_ apply this change though it's sightly against what RM
> recommends.
>
> (If thing is straightforward, it's okay to make the text short.
>  Yet I believe that this change deserves more than these lines.)
>
> One info that you should mention -- also the main reason why I'm
> convinced to add this change: trigger() is still in the shape of
> the early version where we only supported one operation mode --
> Tx synchronous with Rx. So we need an update for other modes.
>
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> The git-diff part looks good, please add this in next ver.:
>
> Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
>
> Btw, the new fsl_sai_dir_is_synced() can be probably applied to
> other places with a followup patch.
Do you mean move it to the beginning of this file?

best regards
wang shengjiu
