Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3127C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Dec 2021 11:35:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BE0F1732;
	Mon, 20 Dec 2021 12:34:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BE0F1732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640000100;
	bh=I5Jt0O1zB5qYbbsoWEIySpLhFeEwX+yQwrcVj0d4tHg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bac64W7L++0aobixT7rTciI1YsRiozQ36gW3Vrgdiiter+s8Itiz2IHDItgXEifu7
	 11GQcxCBMtkE7RUzzZM59xJzWrXf0twiuyzG9ZZ9I3w8qEayIqM9Os2dUwqWGv2rvp
	 17CraJrrFgfoRIWKD/1rO3k92lP1gAOlaZvrxxHM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C36EAF8011F;
	Mon, 20 Dec 2021 12:34:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF92BF8012A; Mon, 20 Dec 2021 12:34:07 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86880F8011F
 for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2021 12:34:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86880F8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="fL/aSdMN"
Received: by mail-qv1-xf32.google.com with SMTP id fq10so500470qvb.10
 for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2021 03:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ib8Kih7Amxg/C5PLNgANyvS2G85OvDYw3t1xVRH3hC0=;
 b=fL/aSdMNkssqWy7s78XDEPpbq5/3gelPx7ScrqzppvAuEuv6t3M1100HL3mSlULtlc
 F0sqn8hZBz+MeV5zbPLtQsnn2/zCaRWlNiWr4jYM+VtQZosYPLkns1sOIjBoxq9U+OIM
 6TLjvsncy7mC8VlDJrHii60N/Y+8wSt2w9QMqHPTXu8WARntQLRB9tJkpRL9rnUg1Ha/
 M/yWagu/XXLk4qPSRcJq6xvBwLDJ/p5YlJ7W5TjFuhp10d6yN1kgglPkajbLtOdSMGSC
 Td3oLutGk8eFoyfSp19rSW89JF2b+UNJnJ7FXq2vRIRGXXp1cX6vNs+Ew0JfFERfgFnz
 h+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ib8Kih7Amxg/C5PLNgANyvS2G85OvDYw3t1xVRH3hC0=;
 b=M/Jn6NhpNIufByzVyVFzQRJJjYXzGY8dcHisJnWzA4cEy/k+o78MxAfB4WddnufLgH
 Nla0CWU5+qzsZmHhFWOK0fGqrqHMeu6Y89w19+/XAZ6mgpjvi0n9gsbUH4t5Zqt2nH+k
 eVCLfrMw9rmkxt5fhoxVaTSW7uLhrj+U5O2F9kfxo+Lnr39mdAu1V0fa4uh4xqGnt4oL
 6CZUfOnB+NlOUzkSDeT+z7/BbrUwy2LWZNaRQNhAk4J+OKd1Up6cey0BW9ID7ZkabSnI
 ySEM5YYHOiSdugFwIW0UThS0CAC3S2DMlNabdKPPT3meXe2ZpFt31y9llwehq8a1wkZW
 KSUg==
X-Gm-Message-State: AOAM531K15OXe5qVE7CDXw9dS1Ca9S3edn3S3Ev2DtH16vT2Dq9myNkF
 x2uBl4gk/7wzywXJ0/Y+rhxUO2qb6jMEJvk3IlY=
X-Google-Smtp-Source: ABdhPJxSwutSaVWp5ud4GYuWiIEhgPAAhF+uWzhLUzOnca4ez90/D72CI2qIraVw90NXzlcabzgkeg1U4D0UIxUBJA8=
X-Received: by 2002:a05:6214:2622:: with SMTP id
 gv2mr12310705qvb.128.1640000036192; 
 Mon, 20 Dec 2021 03:33:56 -0800 (PST)
MIME-Version: 1.0
References: <SL2PR06MB3082D6C1C65786A1E8DD0397BD709@SL2PR06MB3082.apcprd06.prod.outlook.com>
In-Reply-To: <SL2PR06MB3082D6C1C65786A1E8DD0397BD709@SL2PR06MB3082.apcprd06.prod.outlook.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 20 Dec 2021 19:33:45 +0800
Message-ID: <CAA+D8APDEhri4RKfjwSe-pM_xGKV+Oc6JVJUPFBqU8T+VH5K8A@mail.gmail.com>
Subject: Re: [PATCH] sound: fsl: add missing put_device() call in
 imx_hdmi_probe()
To: =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Thu, Dec 9, 2021 at 5:58 PM =E7=8E=8B=E6=93=8E <wangqing@vivo.com> wrote=
:
>
>
> >> From: Wang Qing <wangqing@vivo.com>
> >>
> >> of_find_device_by_node() takes a reference to the embedded struct devi=
ce
> >> which needs to be dropped when error return.
> >
> >...
> >
> >>        data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> >>        if (!data) {
> >> +             put_device(&cpu_pdev->dev);
> >
> >If it's of_find_device_by_node() you need an of_node_put() since you're
> >dropping a reference on the OF node.
> >
>
> Label fail will drop a reference on the OF node.
> Also, put_device() is called later except this branch,
> we just need to add put_device() here.
>
I agree with you. But could you please add the info in this
commit that
the commit:
f670b274f7f6 ASoC: imx-hdmi: add put_device() after of_find_device_by_node(=
)
is partially fixing the original issue, so we still need this fix.

Best regards
Wang Shengjiu
