Return-Path: <SRS0=P1jl=LH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27217C48BDF
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Jun 2021 14:02:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFABA6128A
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Jun 2021 14:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFABA6128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0E841786;
	Sun, 13 Jun 2021 16:01:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0E841786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623592932;
	bh=0GuJ8MA8YvAb5LFEu1wccuQD+B/n8HPSEdt3rIsJcas=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gHAKxM6Luv1nSYiTCj5SaNaUKY1+BNm+K3yuVgNNEcnoKlO5ntm1hLEDSjUYRSff6
	 /KzPwgXs7GS+tpE9SCNiMPoagIUdilTTqeuEP063UF0leljUDrgVPnzoiyvigle4jT
	 +IxUGeNjVPqDF2SijzWt50whU4Qa688z/4bkdMDE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E7B3F800FB;
	Sun, 13 Jun 2021 16:01:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1CBFFF80165; Sun, 13 Jun 2021 16:01:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E9E1F800FA
 for <alsa-devel@alsa-project.org>; Sun, 13 Jun 2021 16:01:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E9E1F800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="o+51Gt//"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D401261357
 for <alsa-devel@alsa-project.org>; Sun, 13 Jun 2021 14:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623592862;
 bh=0GuJ8MA8YvAb5LFEu1wccuQD+B/n8HPSEdt3rIsJcas=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=o+51Gt//Duy1u56s/dk9eBSqfx7WwhWuvnaaLdrcMaG3LmeZrVtGkRkI0C4u7F+xe
 MxBf0MbTrfv0YH/G6frmBvYzEuaW6sMJahhiCIvqmWnkPBI768dvBpziGRFpQSGnJQ
 Kw7IJpvWeimsERuU/hgc07usgvl1rNQG03BeR0t6imRpYE4d960nqdYjJPaCOl9t6f
 YZyIUp/KPawWcIo6YortJ8GsP/C6ZZ7N4JC6L+MCWK34JxuTCNX+HDy0cm9zJZYQpV
 IF4eKBEJiwc1AqZkcKAiObyK0Xr18kE6SKRBUxzlTr07ucdXnGiyumBZKLXih4B07+
 /5bcHZKbI8W2w==
Received: by mail-pj1-f52.google.com with SMTP id g4so8293756pjk.0
 for <alsa-devel@alsa-project.org>; Sun, 13 Jun 2021 07:01:02 -0700 (PDT)
X-Gm-Message-State: AOAM531vz5K5zgrATHURHZ5Ht2oo7CDgdmXhrOHY7J2hVCgmekmmjEnd
 bUxBnlplAFiRYB1RCgru9lTfSQMaYgj1AXthXRs=
X-Google-Smtp-Source: ABdhPJyFOyiJWkaOurdmvQmKHDKj6R/+QYd0Y/yarti/BChQroTPj0Zm9Ag2edUHztcoSXwOu7UmDfTXDUlbEeJ5BU4=
X-Received: by 2002:a17:902:d4c8:b029:102:715b:e3a5 with SMTP id
 o8-20020a170902d4c8b0290102715be3a5mr12622809plg.83.1623592862495; Sun, 13
 Jun 2021 07:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210611093626.579176-1-yangyingliang@huawei.com>
 <20210611093626.579176-10-yangyingliang@huawei.com>
In-Reply-To: <20210611093626.579176-10-yangyingliang@huawei.com>
From: Timur Tabi <timur@kernel.org>
Date: Sun, 13 Jun 2021 09:00:25 -0500
X-Gmail-Original-Message-ID: <CAOZdJXUn9FgdhiPAqbxMrz4tSeqQ_S+L9jkpg48NxCo5Fz7PXQ@mail.gmail.com>
Message-ID: <CAOZdJXUn9FgdhiPAqbxMrz4tSeqQ_S+L9jkpg48NxCo5Fz7PXQ@mail.gmail.com>
Subject: Re: [PATCH -next 9/9] ASoC: fsl_xcvr: check return value after
 calling platform_get_resource_byname()
To: Yang Yingliang <yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>,
 PowerPC Mailing List <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>, timur@kernel.org
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

On Fri, Jun 11, 2021 at 4:32 AM Yang Yingliang <yangyingliang@huawei.com> wrote:

>         rx_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rxfifo");
>         tx_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "txfifo");
> +       if (!rx_res || !tx_res) {
> +               dev_err(dev, "Invalid resource\n");
> +               return -EINVAL;
> +       }

If platform_get_resource_byname() returns an error, it's probably
because the name cannot be found.  So I think this error message is
more accurate:

"could not find rxfifo or txfifo resource"
