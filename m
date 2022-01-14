Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D62CC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Jan 2022 16:59:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6E70201A;
	Fri, 14 Jan 2022 17:58:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6E70201A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642179548;
	bh=+1pGGMgJD1gWSUhSADnc/vSXAOdsM7lkf2JLgAS3+k4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BkNiSA5CXTLzfvlwGsx8maIUyAao/FQLn65lwqHtTrercDop5plMg162QGz3mzUv/
	 ueneTP/QozR6pXZQjdIiOoVCUumU+s2Pp0XIgU0d7TY81g3sNq9iOtq7jpFQeiJtlH
	 RTdYqqiOjaQrfYNOOxNa/Gk0n6wfhBHw7zAS3YMY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 239FEF8032B;
	Fri, 14 Jan 2022 17:58:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B2C7F8027C; Fri, 14 Jan 2022 17:58:15 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D68E8F8027C
 for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2022 17:58:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D68E8F8027C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="iVbeHVWM"
Received: by mail-qt1-x82e.google.com with SMTP id f17so11286338qtf.8
 for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2022 08:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3/LknUee5tShvPQdGCDJMgZycBj7j7tFq0oVBnp2e2k=;
 b=iVbeHVWMHHQPD1rqqEEZ8DrfcGbToE5o1zbVM35kRg/Odick5qpphoDqLNEV9QsqWM
 MdJuBLZpxmVZUGKZ/U+RT1Dz9gF35kE9KGSv9DtH01kx/MVKsj0th6OCGg44bRFur3do
 owooPCV25uNhuTReUXOtvctS+yL0qqIjAuYoQWs4Z/fXicEeTIVphCSjEonP+DaPuugh
 iRERJ3q7mKRJ4tiaWnKlZ7vUZPO83bjO7ijrkCdhr1Td21bxGEASeVEyhxiK2/fZmGpC
 HdiecBrry7MYtklo3Uo9OBTlnElF/8Q4Pd8a6vxoN6d9aP8OLwdBZQ6B3ug4ThoM3j8K
 v2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3/LknUee5tShvPQdGCDJMgZycBj7j7tFq0oVBnp2e2k=;
 b=gTNtauqKtoherg5yP1zfga33vwjXD1lCSo/55A3SBCv5z6jFo+gmWCW2G6CtX51WEq
 TuvIaIMwcBrnleCm4UDdq0Edd7xOOPFVcsdBT1qbTIlLWvldyde5oUk81iCwo88QGfel
 Ga6k7CL3pus2stMmtn2eD3ZiwF3aOACNZB4StMz4fbJLYCETxzF6thIkHgZ9zR3TKtpU
 FNvqaLZxkkN5kOx6Njrd00mR0MxbJuNWXrTap1mX0JjU/x7wPw6LD9zD315jNS5EZXd0
 O7Zs1drEIJlVeePzCTI8PK7zR+jkTQJDnSQxZPiqJxy21n6yy3mccbhooNaaQ6c22TSq
 dIYg==
X-Gm-Message-State: AOAM531H5CsH+T2kkxN1jzM0jKoB0+3P3V2qYRsgTylWKomgCe+geE9K
 +8y2MeBwAZW/8n+BqmLAAlKdBDFYnQHGIqLQlCHcHg==
X-Google-Smtp-Source: ABdhPJxLfPwEEBa+Ap9zKOritX0zyA/zOHrcclb56wSl9nFh7Fse60RiU41+kwlDQ+/tbTFIav2jJw6+dJm7B0eVyJU=
X-Received: by 2002:ac8:5c8e:: with SMTP id r14mr8329561qta.42.1642179488381; 
 Fri, 14 Jan 2022 08:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20220114114633.742-1-allen-kh.cheng@mediatek.com>
 <20220114114633.742-3-allen-kh.cheng@mediatek.com>
In-Reply-To: <20220114114633.742-3-allen-kh.cheng@mediatek.com>
From: Curtis Malainey <cujomalainey@google.com>
Date: Fri, 14 Jan 2022 08:57:58 -0800
Message-ID: <CAOReqxiSAhrSjXVW=D+ndXko95qLuHGkkNs5Wf-yVEcv1YompQ@mail.gmail.com>
Subject: Re: [PATCH v14 2/2] mailbox: mediatek: add support for adsp mailbox
 controller
To: "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Kevin Hilman <khilman@baylibre.com>, Mark Brown <broonie@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Tzung-Bi Shih <tzungbi@google.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 sound-open-firmware@alsa-project.org
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

> +
> +static struct mtk_adsp_mbox_priv *get_mtk_adsp_mbox_priv(struct mbox_controller *mbox)
> +{
> +       return container_of(mbox, struct mtk_adsp_mbox_priv, mbox);
> +}

this could probably be inline


> +
> +static struct mbox_chan *mtk_adsp_mbox_xlate(struct mbox_controller *mbox,
> +                                            const struct of_phandle_args *sp)
> +{
> +       return mbox->chans;
> +}

also could probably benefit from inline
