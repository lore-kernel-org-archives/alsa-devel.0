Return-Path: <SRS0=JTem=5M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55765C43331
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 20:58:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D67F0208E4
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 20:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tAnCVWXz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xEeGDCgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67F0208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB5521661;
	Fri, 27 Mar 2020 21:57:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB5521661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585342724;
	bh=RgrPt9tySRJLmHza0fW3xHHS6+RmaCFlMYTyDCYHr1E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tAnCVWXzs61dy37r+C+9H8eCLDWWE7iDpBgFXAiaHz8aXoCFuVkaxp47AB2XmS/aS
	 6U4RMeEXFES3ahzLoGQ7iMZzZtlN1inafgIfJKs+Z2YwUemDf6bwu+NcO5qC7Qjy4l
	 vgSCM7BhWFuvDZWvEniibZmD6Sw5wjmM3NGRqFU8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 287AAF80147;
	Fri, 27 Mar 2020 21:57:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DFCFF80158; Fri, 27 Mar 2020 21:57:52 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5B1EF800EA
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 21:57:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5B1EF800EA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="xEeGDCgT"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 43E532076B
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 20:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585342666;
 bh=RgrPt9tySRJLmHza0fW3xHHS6+RmaCFlMYTyDCYHr1E=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=xEeGDCgT2uFJjd8r01m04l4zsxTxDM1PDLHXACs/5RnDcNPEVO8njtVIKXVZYxdLV
 hkxKz7aL54xAmsdfWsHWGqvduNzkBn7h7r+FbkZ67UkGRGu9hwDUFu08BMK23EjvlB
 7ylJ+jQM1wF7xI3ovdBafFtdl9QdDrAQ9xrMXbNw=
Received: by mail-qk1-f172.google.com with SMTP id b62so12396855qkf.6
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 13:57:46 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1eu+6V5h3pkm8QlR3vClDOpsiAPZOelys4fCzHC2XysjhDQG8y
 tZ/TrqkOKdhtkjkoPC7fMSUXJT+bq+YzhrgF+A==
X-Google-Smtp-Source: ADFU+vvy8zfMg0Lcg8/2c14ugs6YthbMLNdUeEeyFjmhaODyuRV9hLl5dBdqzOApPCLiLIJSNOZjgZuKkqZK6pm8698=
X-Received: by 2002:a37:8502:: with SMTP id h2mr1304822qkd.223.1585342665409; 
 Fri, 27 Mar 2020 13:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200327155721.7596-1-festevam@gmail.com>
In-Reply-To: <20200327155721.7596-1-festevam@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 27 Mar 2020 14:57:34 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+wB=84rnSQqd+6-42LtPDz5=Xxt6ypWbVrxUjKONPz2g@mail.gmail.com>
Message-ID: <CAL_Jsq+wB=84rnSQqd+6-42LtPDz5=Xxt6ypWbVrxUjKONPz2g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: sound: cs42l51: Remove unneeded I2C unit name
To: Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@st.com>
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

On Fri, Mar 27, 2020 at 9:57 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> The following warning is seen with 'make dt_binding_check':
>
> Documentation/devicetree/bindings/sound/cirrus,cs42l51.example.dts:18.15-34.11: Warning (unit_address_vs_reg): /example-0/i2c@0: node has a unit name, but no reg or ranges property
>
> Fix it by removing the unneeded i2c unit name.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks!

Acked-by: Rob Herring <robh@kernel.org>
