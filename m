Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C18C43334
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jun 2022 07:54:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F05919FE;
	Thu, 16 Jun 2022 09:54:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F05919FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655366095;
	bh=rcwH0ulAlavs7HSDs9lt1orRYI8gVC64sC765T0cyLs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TW1LTModR7eNFEoJTFPpSxB1rRqTuxJ5cXu/B75zLwMo3iA3PAL6pPsevPYVo+kWm
	 wBtOeypRV2+eOkfgxdJ/5q4d5F59VofEHT46GSFzYe6GIL134eDu18XgRpQb/xgI/V
	 wwzQCXrJB1s8BCj9AQ2+5jHmZBH90NsqcJxibA7c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 38D23F8012A;
	Thu, 16 Jun 2022 09:54:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7DE42F800D3; Thu, 16 Jun 2022 09:53:58 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C10DF800D3
 for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2022 09:53:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C10DF800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="AJ0HPsBU"
Received: by mail-lj1-x231.google.com with SMTP id e4so639430ljl.1
 for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2022 00:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mUkmS4Z0DyeMmdjuxEPlq2pjLfUlOJ3MsLFFXv5JaTo=;
 b=AJ0HPsBU8qRppWXekaLXqODE0k+TJQdXqyZ4pGuUPYeiOddOYh2XZhCAwrMbz8NFOL
 ICj1KXYBgBcBaO1skv/60dOkIEczwKqJaDVowVrwoFsIN3wttnQL8th/swp7YhbARB9l
 4F5GWAhr+TvBmBc/yyn2FaOWkGZVVrkwqZBO8GQMS0WPpurg+34ROUb0k4COJA6mskEW
 vC+QwlUAe0LTp5usxgXo3OqtdixoiGIo+XAhakmyhvIk+IdXE+0melSObnpVd5WUdvS9
 HT/oAZPmTcKD4NymwXssgGzOmLphfHiBd5QaxD2pQspGSFkyvAPAc3WQl3iCOPHgaQO9
 qOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mUkmS4Z0DyeMmdjuxEPlq2pjLfUlOJ3MsLFFXv5JaTo=;
 b=f1wn0Xlqtd4ZNxIyFdghxnc2XvKJsyGrGuQoV2puZlqTgk4CExO3BZk3JQyalXuahg
 lzvnWL4nrVc7yZX4Sil7IC5aMPhc226jEhd6gmZhqNqkTytbKIJ2CT3g5qJfKEFQ8DfZ
 SEMdbm/M4M0dZI8TiXNow/XyO5P9NdJwCTPiCljsi0pxj7PVWbqw49o4PftDR5zxpgCX
 x+D/F9DqTRp8PS3dDBj0CrSCYOFQ3KeCBAokzM8lK+RcfLloctd0a+YLWhBDJneoLgIW
 KWZ6Jh/J6oYT3rVGeYb0zzXmJRQQGBt/tYjD3+PtsJOcpjwsCS82ebOGh0SpBKKZoed1
 yD+g==
X-Gm-Message-State: AJIora8OUW+2HprupA4RMYHvfOuuTyyx7UzLhSCGRiqiEfORFhY8MnzL
 vtaxiD7KV6W5fosDEH3cqftNQo7sjNOZ6gnGYBs=
X-Google-Smtp-Source: AGRyM1sXa5MxZmMaYrthL9kddZQqDV6TP6OLiTEaCHASD/FfC4TEVlRpHCks6gjOsu6xXcc1trg0BfrUAfD/aoatOUc=
X-Received: by 2002:a2e:9113:0:b0:255:a3e6:93cb with SMTP id
 m19-20020a2e9113000000b00255a3e693cbmr1948076ljg.312.1655366030089; Thu, 16
 Jun 2022 00:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <1655179884-12278-1-git-send-email-shengjiu.wang@nxp.com>
 <1655179884-12278-6-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5BRVBawK2PRvTazkQf-wExOuni9qD76Ha3FYmZZQyPRsg@mail.gmail.com>
In-Reply-To: <CAOMZO5BRVBawK2PRvTazkQf-wExOuni9qD76Ha3FYmZZQyPRsg@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 16 Jun 2022 15:53:38 +0800
Message-ID: <CAA+D8APKt+_JbbuQ=WaK7v8FM7SFCACif-Qx=gwuaLL=fGwLQw@mail.gmail.com>
Subject: Re: [PATCH 5/7] ASoC: fsl_sai: Move res variable to be global
To: Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

On Wed, Jun 15, 2022 at 10:22 PM Fabio Estevam <festevam@gmail.com> wrote:

> Hi Shengjiu,
>
> On Tue, Jun 14, 2022 at 1:25 AM Shengjiu Wang <shengjiu.wang@nxp.com>
> wrote:
> >
> > The resource info need to be accessed by hw_params()
> > function for multi fifo case, the start address may
> > be not the FIFO0. So move it to be global first.
>
> Actually, it is not global. It is being added as a member of struct
> fsl_sai.
>
> Please rephrase the Subject to:
>
> ASoC: fsl_sai: Make res a member of struct fsl_sai
>
> and then in the commit log:
>
> "So move it to be a member of struct fsl_sai."
>

Thanks, I will update them.

best regards
wang shengjiu
