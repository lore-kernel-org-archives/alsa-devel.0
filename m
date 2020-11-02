Return-Path: <SRS0=b8gG=EI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3F2C00A89
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 05:07:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABB421D91
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 05:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Cr/pnk70";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxLWWeV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABB421D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42B6316CC;
	Mon,  2 Nov 2020 06:06:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42B6316CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604293639;
	bh=bTbYZ6f3Vu9T+1x8GWMSV/2rgiTNLAtDdz5UArlVlNU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cr/pnk707g1IEbCKbGhR3Do+4jbjiwruAXR4iEYyGEqzAZhGAn+k9o/05+pMRaA3H
	 yb754UArjUdQQ8YX1OZii4TDYJsMRdiLicJPcmit0lIGMFF5tCA/2cA2dFN5fFJm2H
	 0s7DSLAuLghMQIh2ppkJ/pg3S7Mj0zonLWlF0kgM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9CB5F80229;
	Mon,  2 Nov 2020 06:06:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8743EF80229; Mon,  2 Nov 2020 06:06:27 +0100 (CET)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4BA80F8015A
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2020 06:06:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BA80F8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="oxLWWeV0"
Received: by mail-pl1-x642.google.com with SMTP id r3so6259305plo.1
 for <alsa-devel@alsa-project.org>; Sun, 01 Nov 2020 21:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0i5kulrXeAXUUmHumUD66U2ITbxD8qnUW4/n36OfF0g=;
 b=oxLWWeV0SaX8q4sdK7/2sB2mbbneJH+6xiBYeqoFyU0KRp6CX4AAHRz6ZcIpCMuGs1
 K57ec6IiNS0f09FIv7F0ALXBwtlgJkApB7AmFEzolud2Scts1RGkIMpChWza8ZWYqq32
 iG9jnd6FoC1qoTUt8FG+Tqh96LB63osUaZFzASsd331qTXlfszZF8qEYTXDyIEPza1g6
 rCQ6+kS0iVGm1BZVWvdi5ujQ+XT4q5cIgozr9tH4CuJAWawDb1tPvyX1UyBa64dZOmY/
 Qseu2Xk2wdM8W4NJUc/aIg4txizhbYAMC1xRU1E+saPOrw0Lb6Opw2ZfetN7H7my9w9C
 FGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0i5kulrXeAXUUmHumUD66U2ITbxD8qnUW4/n36OfF0g=;
 b=esO0QUrHH8uqy23XA8xbTyXFZ8bqhxTazd9Tq4xiSLo0jOdoDYGerD/V2SUl3gaWzC
 gK73+o908aCtjk5jYStg1afPxBNw4a5Z1S32zmjDnNq9I+EVcgtjBC/FrlWPMQY9aU8N
 6O9ePctrq4cIj2xtBwxzV3pF7L8E5YETVY6clt+jnN0JuiLmsR0YuR75MHhF2Q/k0D5B
 ihBbAusPCH3I/CndqKtPO2eR6e0Rs6PLdKW64XVk1hqJNpsJxfU28ALzwNxG14AyYJRi
 n6JNRqraQkHOXgCitOoZfO35zHeqFypTkUmzOypzq63j5+jE5Me7xgZBTUKYTHeaH0iU
 nEsQ==
X-Gm-Message-State: AOAM53087Nl5I1BZNyYWGd3ujJf2bjbzriyDCUzHTXW0zno+Bo7WGylQ
 ma16n/FrIhCZq+SulwiRjcswShrYqFREXtYcPjY=
X-Google-Smtp-Source: ABdhPJzWpC1jLa2KqR8b6+I+di15SNciBGq8RyUOeA6dDIbQSFfhtHxvZw1hOKfw0BDne7Nf3l3IdI42sswxOrnNTvA=
X-Received: by 2002:a17:902:8eca:b029:d2:4276:1b2d with SMTP id
 x10-20020a1709028ecab02900d242761b2dmr19651785plo.17.1604293580359; Sun, 01
 Nov 2020 21:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20201030075724.1616766-1-ajye_huang@compal.corp-partner.google.com>
 <20201030075724.1616766-3-ajye_huang@compal.corp-partner.google.com>
 <CA+Px+wXPRg7aDU5+vr6R_BxuFfhuDeG3iEQeAUKWNtX8YmVC1Q@mail.gmail.com>
 <CALprXBZ+NmR8Y4sMkh4Y-N_FG+rGEOhUBVTKXRXNFp8H+f0btw@mail.gmail.com>
 <CA+Px+wWouXWS2F+Bqs3MkJxCuXORhpXcUF5ZuSHo6exprBF4hg@mail.gmail.com>
In-Reply-To: <CA+Px+wWouXWS2F+Bqs3MkJxCuXORhpXcUF5ZuSHo6exprBF4hg@mail.gmail.com>
From: ajye huang <ajye.huang@gmail.com>
Date: Mon, 2 Nov 2020 13:06:06 +0800
Message-ID: <CACCVik-enBjUsaB1cZPb4Dp01Wj222jsT5Y-fjSL5E50XAFLcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: qcom: sc7180: Modify machine driver for 2mic
To: Tzung-Bi Shih <tzungbi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Douglas Anderson <dianders@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, ALSA development <alsa-devel@alsa-project.org>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Patrick Lai <plai@codeaurora.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>,
 Andy Gross <agross@kernel.org>, Tzung-Bi Shih <tzungbi@chromium.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 Cheng-Yi Chiang <cychiang@chromium.org>
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

Hi, Tzung-Bi
I will release v3 version base on your suggestion

Thank you for your reply
Ajye

Tzung-Bi Shih <tzungbi@google.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8830=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=887:19=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Oct 30, 2020 at 6:55 PM Ajye Huang
> <ajye_huang@compal.corp-partner.google.com> wrote:
> > But dmic_get() will need dmic_switch, should i keep dmic_switch?
>
> I see.  I overlooked it.  You can keep the dmic_switch for this
> purpose or just call gpiod_get_value_cansleep().
