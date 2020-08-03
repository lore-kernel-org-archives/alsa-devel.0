Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAB4C433E1
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:05:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C963120738
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YH/z5SVR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxdsHDR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C963120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C45B61661;
	Mon,  3 Aug 2020 10:04:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C45B61661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596441939;
	bh=JQhWyZCVsm1G4JknXIoHQfXgK4iljQnAor7p1n9Of9w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YH/z5SVRIGWodN20089IgEq8we26Vja6oPIGav34Akwi9O3v/tOlvxGF+ADcQRgoB
	 BOBxhWI5Knih9Bx+cz7foXvyOEL+E+/pno4XlrC7ERPwdy1YSajwcJdspsEh3E4ik/
	 7rK2c/szdpv0N+oRr2FpOpTjb0pj3vw53OWtcjlw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66D99F801F7;
	Mon,  3 Aug 2020 10:04:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2AF7CF80218; Mon,  3 Aug 2020 10:04:48 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09ECAF800B7
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 10:04:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09ECAF800B7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="SxdsHDR/"
Received: by mail-qk1-x742.google.com with SMTP id l23so34450593qkk.0
 for <alsa-devel@alsa-project.org>; Mon, 03 Aug 2020 01:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SbxuUNCCa6ME9VA4qtvs1h8FPSgrKaIDkh4zhn6OcKk=;
 b=SxdsHDR/CMqtwMOGCpm+P3ZmX6jQtEE+sdvUP0ggRkCVAptrad6mAJnDn3R9LTlRLT
 RdkJUW0hPtegQ59VFDJxSiqHIyon86tf1OoH6ZO38apbVYGl7Hzl5WE+87btTZ+OkzIJ
 Dy+DcRBoGFUeKXDLw42f2HuNjfHlTHYRzh0GG/g0wLYMZxcsXf5PSo1KI2Hh0b9Oq4gI
 WfE97iOgJjWT0bQ88xWSWT4K5jztgCrJIdFWbhqb77hdt6/GQzarAaNZCH5XcRrzklYF
 k9Mvpyn740h8Ud+tK1xo/yCUrJCKFSFXnTEqu7CL89APAIcYoLuDSFIda0KmwjYN4sWG
 JMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SbxuUNCCa6ME9VA4qtvs1h8FPSgrKaIDkh4zhn6OcKk=;
 b=ag+/kiLplLM44qIR+8t2sWgvwazIIVCQLncF2HnZM422ceqkQupGCo6FdYBO6qM3Ql
 wXKMLujtYvfP42hqsffTDB7Ki+xrMN4TZ2ZNgnXMXgJ93Jop7bqSJJRT31sBdQ4cI2JU
 X7KgFuEJwcZrpckpqi7aGIK14+7HNG5syF5XPUkLEJywpjaYGxiiTtAwmWM06m0qaa4c
 yBsP6jj2tW7AeDRqRVX97+VBjymey/SaE+7e6SMPG4ni6Ij7fwBI4hGLHLusCixvA5SJ
 NSyAiAUPX5LCCfXaho/Dw7+1IxwM1F+89VuBQyLSexBOWcP5ScyvZ4RchtC4BFG0ez0a
 idpA==
X-Gm-Message-State: AOAM533XAbeGXc8lSAEy97OpE136TFM9R74edrBhfYnX9qFNqG34H99w
 e+Z/Gk8diB45/ggdb1bBv3+T7WzOp7POtwIK44g=
X-Google-Smtp-Source: ABdhPJzByIPDL7NYWq8UK3KcJM4lmBsSInj2L7u+lqt9skSqwBP62kAhaIYGIfs2yPZrY2LMIq7cqfATqyDENfdDx18=
X-Received: by 2002:a05:620a:b8d:: with SMTP id
 k13mr15300055qkh.450.1596441874047; 
 Mon, 03 Aug 2020 01:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <1596424674-32127-1-git-send-email-shengjiu.wang@nxp.com>
 <20200803054037.GA1056@Asurada-Nvidia>
In-Reply-To: <20200803054037.GA1056@Asurada-Nvidia>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 3 Aug 2020 16:04:23 +0800
Message-ID: <CAA+D8AOGF44UUq=P1S-M5TUwDUaOnqVmHJKPDBM9DAzt1nVzmQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Clean code for synchronize mode
To: Nicolin Chen <nicoleotsuka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
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

On Mon, Aug 3, 2020 at 1:42 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Aug 03, 2020 at 11:17:54AM +0800, Shengjiu Wang wrote:
> > TX synchronous with RX: The RMR is no need to be changed when
> > Tx is enabled, the other configuration in hw_params() is enough for
>
> Probably you should explain why RMR can be removed, like what
> it really does so as to make it clear that there's no such a
> relationship between RMR and clock generating.
>
> Anyway, this is against the warning comments in the driver:
>         /*
>          * For SAI master mode, when Tx(Rx) sync with Rx(Tx) clock, Rx(Tx) will
>          * generate bclk and frame clock for Tx(Rx), we should set RCR4(TCR4),
>          * RCR5(TCR5) and RMR(TMR) for playback(capture), or there will be sync
>          * error.
>          */
>
> So would need to update it.
>
> > clock generation. The TCSR.TE is no need to enabled when only RX
> > is enabled.
>
> You are correct if there's only RX running without TX joining.
> However, that's something we can't guarantee. Then we'd enable
> TE after RE is enabled, which is against what RM recommends:
>
> # From 54.3.3.1 Synchronous mode in IMX6SXRM
> # If the receiver bit clock and frame sync are to be used by
> # both the transmitter and receiver, it is recommended that
> # the receiver is the last enabled and the first disabled.
>
> I remember I did this "ugly" design by strictly following what
> RM says. If hardware team has updated the RM or removed this
> limitation, please quote in the commit logs.

There is no change in RM and same recommandation.

My change does not violate the RM. The direction which generates
the clock is still last enabled.

>
> > +             if (!sai->synchronous[TX] && sai->synchronous[RX] && !tx) {
> > +                     regmap_update_bits(sai->regmap, FSL_SAI_xCSR((!tx), ofs),
> > +                                        FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
> > +             } else if (!sai->synchronous[RX] && sai->synchronous[TX] && tx) {
> > +                     regmap_update_bits(sai->regmap, FSL_SAI_xCSR((!tx), ofs),
> > +                                        FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
>
> Two identical regmap_update_bits calls -- both on !tx (RX?)
The content for regmap_update_bits is the same, but the precondition
is different.
The first one is for tx=false and enable TCSR.TE. (TX generate clock)
The second one is for tx=true and enable RSCR.RE (RX generate clock)

best regards
wang shengjiu
