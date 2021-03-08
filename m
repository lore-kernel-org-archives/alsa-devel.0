Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF19C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 13:17:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D38651C3
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 13:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D38651C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E0D6F187D;
	Mon,  8 Mar 2021 14:16:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E0D6F187D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615209451;
	bh=Mq/RjOi7oMvBkyqqQDEJlkZFAJdUsCm3Qg8+RS8/HSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QQmHFIuMqonq3exAxFCot60IJCIKJgHcbUd9pLHtzSZqSa3Zg3Ttv1TETTBZygq8e
	 RGgx8Q8vMRlu+w5EXfkDCLoC26uWVIEl213JjokeZBRMIRxZR0hwoxIIbK4KbrtFfn
	 9JKpHQE/R7GhpjPQx5swXzGElQki2i5vyQO6KASs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25F0EF800D0;
	Mon,  8 Mar 2021 14:16:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8F9CCF801D8; Mon,  8 Mar 2021 14:16:38 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C77AF800D0
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 14:16:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C77AF800D0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="BdHyVo3y"
Received: by mail-qv1-xf33.google.com with SMTP id h7so4539103qvm.2
 for <alsa-devel@alsa-project.org>; Mon, 08 Mar 2021 05:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mq/RjOi7oMvBkyqqQDEJlkZFAJdUsCm3Qg8+RS8/HSo=;
 b=BdHyVo3yQuV3DV48f3bJjriWahibIKWTlkYMWIxyjaeMsJ0eLXR8/VVMc34NswrBkC
 nKHr9BKZyu88I8ghJ6Kz0bzo/xOsVeSY5AW9j3eSukKNb6S9EoyrHqodb/q4uU8cCXcN
 Po3Jw1pEtrFsNCNXsPE842EFlS8agYdjp/MUiN2RO/1OWj1wtXDqUBtThXJ0hMa3zYgz
 L6BdI+D+n6aycm+pFueaaDTXSSZycUyibySGKH0sExDhkPr/eT4gnVnPNS+PyzZFXRuo
 sK39l5TRhwHhFKTo/4rbSyBnSv80SmWhlhrQyai6FZws9G78Ok8rJi2z9Xe+Lv8QsLYJ
 ECDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mq/RjOi7oMvBkyqqQDEJlkZFAJdUsCm3Qg8+RS8/HSo=;
 b=f/DJT9VAgEn0ceMeTiJ6Up0dJm1nQN3jC9affcBd4kHf3LbZw9A4leI0fHnZaAwU3q
 wIRgz+EJAj7EkOkrwTg9o3yG8C7EBKjQYscpGDPCKpcRJ7hEiZ2jxzou90cWTZSpV1g5
 LSJ5QOZJfPkTKD5oppiaNF9gmHMy1j2B8h9ntx0dnC5MjqlSiYoACmuYo314NGisL+wu
 qzbHH0hude9YQsUGzfsOBJfBYdGscVs8ZfkbPhTDhZsRDy5ufCd021TuvZVhYlur+JoT
 Z3k5+1q66Z/xY0DUa7V1N02YOjKiMv71zdMiaBAWNZENzDUFQg8aWUYgmA7itpX9ADrD
 PyDQ==
X-Gm-Message-State: AOAM531aagP7FMuRhPB7Suz6IhaQdWm8Nbg16/0o6jkpauHhKoyFggPH
 WQJWDxmja4WBUJ8UaOD7WeULmxIhDZaxGSMKsa8=
X-Google-Smtp-Source: ABdhPJygKdeW7eWlM9tZB3oGSyuFSBjt6ZqB3nTQwnEAkBjDRdfL3US7UMWjWXaXySP+UvXlKsBkA6VqexayPm1FufM=
X-Received: by 2002:a05:6214:76f:: with SMTP id
 f15mr20582682qvz.56.1615209387754; 
 Mon, 08 Mar 2021 05:16:27 -0800 (PST)
MIME-Version: 1.0
References: <1614221563-26822-1-git-send-email-shengjiu.wang@nxp.com>
 <1614221563-26822-8-git-send-email-shengjiu.wang@nxp.com>
 <20210306203617.GA1164939@robh.at.kernel.org>
In-Reply-To: <20210306203617.GA1164939@robh.at.kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 8 Mar 2021 21:16:16 +0800
Message-ID: <CAA+D8APUVqyRRPc4GDwJqQEcnEPLxQMcZ+VhkbbrOx7hQs1jSA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] ASoC: dt-bindings: imx-rpmsg: Add binding doc for
 rpmsg machine driver
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
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

On Sun, Mar 7, 2021 at 4:37 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Feb 25, 2021 at 10:52:43AM +0800, Shengjiu Wang wrote:
> > Imx-rpmsg is a new added machine driver for supporting audio on Cortex-M
> > core. The Cortex-M core will control the audio interface, DMA and audio
> > codec, setup the pipeline, the audio driver on Cortex-A core side is just
> > to communitcate with M core, it is a virtual sound card and don't touch
> > the hardware.
>
> This sounds like 1 h/w block (the interface to the cortex-M), your DT
> should be 1 node. If you need 2 drivers to satisfy the needs of the OS,
> then instantiate one device from the other device's driver.
>

Ok, I will change it in v4.

best regards
wang shengjiu
