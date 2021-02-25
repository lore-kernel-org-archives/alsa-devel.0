Return-Path: <SRS0=dMuI=H3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9103CC433E6
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Feb 2021 03:11:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0751664EBA
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Feb 2021 03:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0751664EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B2BC1666;
	Thu, 25 Feb 2021 04:10:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B2BC1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614222704;
	bh=EnWKtR8Gi6MBZCyGkt9dN20MUD2l2Ye826UGjeumL/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tv48G4HYKCYGynxjlrD0EegAXlrmOw5/zAnGmVHheC/0AVmJDHSfvHYYcSLCbTbrR
	 w2SBuMEJLzdsRftPsiLjtEKuAWUXQkJ9+22rdi0awI51VNk9AfBlny/JgKn6aM0Z9v
	 xfTtdAHrEbH5jlJ2dumCssYjUlqnP71/TMIdG928=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0237CF80169;
	Thu, 25 Feb 2021 04:10:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EFA3F8016A; Thu, 25 Feb 2021 04:10:52 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48E26F800D2
 for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2021 04:10:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48E26F800D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="bH9vGPAt"
Received: by mail-lf1-x12c.google.com with SMTP id d24so6341107lfs.8
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2021 19:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EnWKtR8Gi6MBZCyGkt9dN20MUD2l2Ye826UGjeumL/M=;
 b=bH9vGPAt9TT8vyB02A3LusGmI+8chLo2PIYd/qdVnAoXcA4p9U8W5tREoMsyzsBZ4Z
 Q9NWpJGzbzKuGHL8s6oMt0bLW3cEcmbC9NdcLISbdy921Vh/wsagj4AH++LZuIzRDEbT
 /WeaCZUdRo1TnFila95eDP1Wh6V9uR/3XL/ldcc37WLU90lRiqTi5RA7028rpBzspYn0
 uzW+qM+xaP557V5nIjT5QocjQY/t2x2za9ZZhZ52SkaDpq5OPJHeeJmMELdtjDXjttJT
 B9WSVRITYzuXvO6JzTkJ79NxGhasXXQhMfU3k2UQOy3nrYfAVvhpTpohOVYNphQy7Wsl
 Pj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EnWKtR8Gi6MBZCyGkt9dN20MUD2l2Ye826UGjeumL/M=;
 b=kz1XQFo8E60PO5BR+C06DL/itmadbdMXFhLZkjT8HWghKeS79eMiSvTJlXAOebfYxA
 GZ7rq1Hs9+I0WbRbqNsQ2yTe9UGd2vFNNilYn+Rjb+BNhkCveH+Qm8MniwrhoieSAhQG
 HD/X+qYI9dwdaD8f0GBQWv81OlX8gwh+lV50b0yh9dtUYDkj0TQZ2L/tcEwXdTKkOZGY
 SpOEcM2NPHMManmMQyX7Q1Q8miPutZCKHkYRT4l3oLfM2XayXoDAVVB5+nEQmx3bURAD
 91r9EjKAfmBzWpLytIittJJSccmxZVotMicPIQZaYAntbmp3J8SBP++0JjgoKZoMSseK
 DKPA==
X-Gm-Message-State: AOAM532Cardw/ug8OswzgU/tcYvT1A+SPUBMm8Owoxz9QYAkmbTd7U2X
 5T0XhvLZB65Er/hkyDYsousLuuYfu43/FfQe88U=
X-Google-Smtp-Source: ABdhPJxCV+TqWtFTdMF/6bZM7j6af9TKwjCsqsLP5PqihQfPd5E2/w9l1zUzIOTZC6eXqdEZ1+/twFQLRzEl5p88ras=
X-Received: by 2002:a19:4147:: with SMTP id o68mr691484lfa.295.1614222649170; 
 Wed, 24 Feb 2021 19:10:49 -0800 (PST)
MIME-Version: 1.0
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-4-git-send-email-shengjiu.wang@nxp.com>
 <20210210221252.GA2885308@robh.at.kernel.org>
 <CAA+D8APfd8trC8cFsT8k8G54nhrYDrwXxECx9RpDAgw3rco9DQ@mail.gmail.com>
In-Reply-To: <CAA+D8APfd8trC8cFsT8k8G54nhrYDrwXxECx9RpDAgw3rco9DQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 25 Feb 2021 00:10:38 -0300
Message-ID: <CAOMZO5D3HgVF6Gq6sFo7j7OJ63NVN--ZtmwZCoM7=dmmhVZchQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] ASoC: dt-bindings: fsl_rpmsg: Add binding doc for
 rpmsg cpu dai driver
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Rob Herring <robh@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org
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

On Thu, Feb 18, 2021 at 4:21 AM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:

> > rpmsg is a protocol. What's the h/w block?
>
> On Linux side this driver is a virtual driver, it is running
> on Arm Cortex-A core. The h/w block is controlled by
> another core (cortex-M core). so this driver actually
> doesn't touch any hardware, it just does configuration
> for rpmsg channel.
> fsl,version: There are maybe different image running on M core, this
> is the image version, different image has different function.

To answer Rob's question: the hardware block that handles these
messages is the Message Unit block.
