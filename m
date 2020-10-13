Return-Path: <SRS0=Nc9k=DU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A40C433E7
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A95A221FC
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 02:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UYTovYmM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDNDAtaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A95A221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84E3E820;
	Tue, 13 Oct 2020 04:41:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84E3E820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602556916;
	bh=8UzLNMJoHU8HSzYatq3OymQ886/xpnDCfNyxud2dbvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UYTovYmMjYnpnHsjWKUFRSz4o0gdgeq7WuZmYuiCDF1RfjKvA1HZBQyV1o3CjZD6d
	 HdjxQl7yTZbdYnLhWMuB+A33slx2vo52iqY2QYTct9Ji4iZXoUgu7bB+/dVNuMF7fi
	 spjVgIDDp9x+BxHxHuzehOrDQNkSLmSCyAYEZvsI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08914F8016F;
	Tue, 13 Oct 2020 04:41:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E066F801A3; Tue, 13 Oct 2020 04:41:03 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94650F800CE
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2020 04:40:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94650F800CE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="eDNDAtaI"
Received: by mail-qt1-x843.google.com with SMTP id r8so15008007qtp.13
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2020 19:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8UzLNMJoHU8HSzYatq3OymQ886/xpnDCfNyxud2dbvg=;
 b=eDNDAtaIOkTrkCQT5OpVtvF/qz069+8PKCvChRgPbX0q2zn94GU9dI57OcV9OFdPc+
 PKKaZzoThmZ3SY6GiVriiThlVkeXZUrPaImmThvJaOVNc58AmthvDY2xgTonHrqWZhHc
 wL0i28ECHuGUdLwkZE2FYEsBuKtEhjogt0mqNkUDeXeiiYRl4LF60h8lWgeL6gIe/62I
 Oa96ZjQBOWpkChWL3sx87yDHfnLhR4EJNY4hmcHX+yYl9MbatCgY/H398cgd5jS1e6Lw
 F/fRIn9J/FuK/TVRhxOEAgioCRbMSz5g15qq5BUHjTOuql1O10EL0CFMGoh+fJ05wWbK
 k42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8UzLNMJoHU8HSzYatq3OymQ886/xpnDCfNyxud2dbvg=;
 b=GoU2PuwQgV9gsRXhYjRQLJVgu5fxbJhKTt9g5ZhwpRISQaT4wb93eP6HrrATTjNjZM
 /F72npnPQbmtI24FeaFv/6rLkRvVhaW8Nq9cH0mmBumeq/9oq69Jny8MxCTYMUM3QK3O
 Go4ssFl8xqE17kNKFvOODEawXn2al+aj03My7HHvoc6h7EKyGEg2WVldS7UERgd8SZ2s
 Tp8l2sz5jY/v1KHdsqTnsCCoSpAJ7xOKnWzeOnECl+5o1Q/kGgyfrJ9Nwj0+QrzWKRW4
 LdQqhzT27pxo/UnEZTiJ1zBPoZzPaBfjx4q5MtHP5A0jeOGH8/bT1RJ20tkqZmugmZmi
 P3YQ==
X-Gm-Message-State: AOAM533d+JJKcWUurZbsoTIVUkKfytvam8q2mwim+7pfez2Ze7tnI7i2
 vN2l/aZjJeUgvzgzSZaPn/ciRvXR88/LApq9IaQ=
X-Google-Smtp-Source: ABdhPJwfW64NzIqBo8ICVJEOXbPnwJlOFIecdiLN2hRGt6Q5FcUk484wbQ1KiNyXGY1QZyXo7SRVoZd1qDn9KXBCnwI=
X-Received: by 2002:ac8:4d03:: with SMTP id w3mr13279186qtv.360.1602556854073; 
 Mon, 12 Oct 2020 19:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <1602492582-3558-1-git-send-email-shengjiu.wang@nxp.com>
 <20201012190037.GB17643@Asurada-Nvidia>
In-Reply-To: <20201012190037.GB17643@Asurada-Nvidia>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 13 Oct 2020 10:40:43 +0800
Message-ID: <CAA+D8AP=c6p5_hdXP3uk5FaMPsW9cUif_gs9k-JQu48vifVvTw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Add support for higher sample rates
To: Nicolin Chen <nicoleotsuka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
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

On Tue, Oct 13, 2020 at 3:09 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Hi Shengjiu,
>
> On Mon, Oct 12, 2020 at 04:49:42PM +0800, Shengjiu Wang wrote:
> > Add 88200Hz and 176400Hz sample rates support for TX.
> > Add 88200Hz, 176400Hz, 192000Hz sample rates support for RX.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
>
> Probably should put your own Signed-off at the bottom?

will update in v2.

>
> Anyway:
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
