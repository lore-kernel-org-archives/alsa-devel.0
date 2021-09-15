Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E18C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 17:07:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0B560E90
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 17:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C0B560E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F339217BE;
	Wed, 15 Sep 2021 19:06:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F339217BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631725640;
	bh=xXr3Gg2C550QfPXaWolBRz1dNdFYDA9+mjoAqVpyk2Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LWO3kltXKHH/zd0z/eoJJFVcS6ATrdeYJhcs0piwIVqJGAjQybsXUaHp83GuVXWei
	 bdPePAJHuoyydKxXlQjbRTYxlVkyUoZHDNNyJSgX0ofk7oYIbYnQpasgc49t5BJedS
	 mduWJ0z+cooTjyput4XojTGjEvjB/TMYr40rXKBE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 741B4F80132;
	Wed, 15 Sep 2021 19:06:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7B12F8027C; Wed, 15 Sep 2021 19:06:27 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71705F80132
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 19:06:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71705F80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="U3vEqEgC"
Received: by mail-wr1-x432.google.com with SMTP id w29so4976421wra.8
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 10:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GTVsTGVHzHHxdcEJg4/8YrzvHZvRek9+ki75XlfwV6w=;
 b=U3vEqEgCOGl+c9PEE+3pQVWcmVpFPwH4Vk1y0emiMUsRJL7SIuEuiz2GuNdcFHZe6C
 DWyPP5WtNcPjHwquO2rXLaXgsGo3XAGuWZ/2vdt6PjOkXhVU0Zv8NWVXNHUIPRtpE+z/
 FXyehLwcE/nMqnUUb3yzosCLAtt/aIngZPEhgJTitK23lRkJgXzZGXOPtFiTkZvbDOPt
 0II9VJR54WTHU5mo/35kAwtjkE7+Wys5Cvyfl0u2ADdMIumGYIZm1cYtFNAB8Ri712Ly
 wWD3sbj3tK0mwP2PVHMe5hVmFLItWdqcuXTdD+RmRJVK0qlVKQjv95qT1DwMA96qtRiU
 RdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GTVsTGVHzHHxdcEJg4/8YrzvHZvRek9+ki75XlfwV6w=;
 b=2GxuTcgWwH3JJxjG9dH3etcHbdXgXJ75OGql5tvlma1ardPramhgMUbbgLcQHre7XC
 3Df64Z+QSK6anIHQIlYqzYS7i2klC1c0aI2+wRCLO1VJ9MpZEuM0JYH1LXw1Bm46nmYf
 XEWYK4b3f+Lf5bcPsNp7KA6OZKUW6bNmGmYXsd1ouNteJphW75Jtw3R5RvdkCpcjNrYx
 MItt1zs/BgVOiPi39wTy7oJcsBO7a0orK9Jn4CnhuFeg/xiMUIq60jDK6lWUdsnnM68T
 fiBAm+opMk6g5yxGsZ5KWWrZz5d92RHu2YIJmyhHGQSuEiq4sD+nL9Zxiy31NUwjLEJp
 93dQ==
X-Gm-Message-State: AOAM533vciXRJfPC8q7HW2CVV0xcRCOUnpY1T/KIREw6/6X8XJ8dGNsV
 zelG7utAUdSE/GlJqnxvdyCiQ8Jykfs=
X-Google-Smtp-Source: ABdhPJwJpOmUK49E3LeTsgzkI8+y91tIlB46nQfOTD778QVq5gZRib5LmUCXTPjYG103hZ2OLszbrQ==
X-Received: by 2002:adf:ce0c:: with SMTP id p12mr1204705wrn.194.1631725576068; 
 Wed, 15 Sep 2021 10:06:16 -0700 (PDT)
Received: from archbook.localnet ([185.213.155.232])
 by smtp.gmail.com with ESMTPSA id f1sm509887wri.43.2021.09.15.10.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Sep 2021 10:06:15 -0700 (PDT)
From: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: sound: add rockchip i2s-tdm binding
Date: Wed, 15 Sep 2021 19:06:14 +0200
Message-ID: <42974939.Tn3hggVSkZ@archbook>
In-Reply-To: <20210915141012.GC12513@sirena.org.uk>
References: <20210903231536.225540-1-frattaroli.nicolas@gmail.com>
 <20210903231536.225540-3-frattaroli.nicolas@gmail.com>
 <20210915141012.GC12513@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Mittwoch, 15. September 2021 16:10:12 CEST Mark Brown wrote:
> On Sat, Sep 04, 2021 at 01:15:34AM +0200, Nicolas Frattaroli wrote:
> > +  rockchip,tdm-fsync-half-frame:
> > +    description: Whether to use half frame fsync.
> > +    type: boolean
> > +
> 
> Why is this not part of the normal bus format configuration?  I don't
> know what this is but it sounds a lot like I2S mode...

This affects all TDM I2S modes, i.e. TDM Normal, TDM Left Justified and TDM 
Right Justified.

Without tdm-fsync-half-frame, we purportedly get the following output in TDM 
Normal Mode (I2S Format):
(ch0l = channel 0 left, ch0r = channel 0 right)

fsync: 	_____________________________
                     	            \____________________________
sdi/sdo: ch0l, ch0r, ..., ch3l, ch3r,  ch0l, ch0r, ...

With tdm-fsync-half-frame, we purportedly get the following:

fsync: 	_____________________________
                     	            \____________________________
sdi/sdo: ch0l,  ch1l,  ch2l,  ch3l,   ch0r,  ch1r,  ch2r,  ch3r

At least, according to the TRM. I do not have an oscilloscope to verify this 
myself, and in the following paragraphs, I will elaborate why this seems 
confusing to me.

The comment block "DAI hardware signal polarity" in soc-dai.h seems to imply 
that what the TRM says the tdm-fsync-half-frame mode is (if one inverts fsync 
polarity of those waveforms), is what is expected:

> * FSYNC "normal" polarity depends on the frame format:
> * - I2S: frame consists of left then right channel data. Left channel starts
> *      with falling FSYNC edge, right channel starts with rising FSYNC edge.
> * - Left/Right Justified: frame consists of left then right channel data.
> *      Left channel starts with rising FSYNC edge, right channel starts with
> *      falling FSYNC edge.

I don't know if this is only applicable to non-TDM I2S, and whether it's 
normal to have the channels interleaved like that in TDM.

I don't see any DAIFMT that does what this does in any case.

So to answer the question, it's not part of the bus format because it applies 
to three bus formats, and I'm completely out of my depth here and wouldn't 
define three separate bus formats based on my own speculation of how this 
works.


