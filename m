Return-Path: <SRS0=4tTe=BK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4373DC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:40:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3F32074B
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iGp2mMxJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP3joG2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3F32074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3453C1696;
	Fri, 31 Jul 2020 12:39:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3453C1696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596192004;
	bh=z79UlB74SFDGkVx/wf5z/xmQkiHttzepy/SROQkunds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iGp2mMxJObRczHuIhlehm5kz/dhR5WaL3TejwP10pTDJ0QDVj9K/OhRz42QSl0Fse
	 jIItFxcJD0YxhEQ5L7G1f7dz4qAbTEjXfNZuZz4fcaVpyUAI1b8nNzG9txhk9Uqdir
	 Caw3LswT1phm+LRsGM2mciOJAzMokXEPnxu+hpJw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A59FAF80161;
	Fri, 31 Jul 2020 12:39:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 364DFF80171; Fri, 31 Jul 2020 12:39:12 +0200 (CEST)
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F9DCF8015C
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 12:38:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F9DCF8015C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="NP3joG2e"
Received: by mail-lj1-x241.google.com with SMTP id v12so1633259ljc.10
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 03:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z79UlB74SFDGkVx/wf5z/xmQkiHttzepy/SROQkunds=;
 b=NP3joG2eyPBwdPuBC5qMi8kkL6strW9nGbsOxkdGKVfI7BxLID1cEUkgnP+mlCWBxt
 Oi+nhKOnN8wnmJSr3M2SroeZ9Qt4xUC+AT9vZKu6L6+68tugEIhkSESjZv69Xj1qQN8a
 9auoue2YYBt5pDKoWjt7M0NeMZV7aSW696PIHQr9CV4Hc1DxV6ZYT+xu+nc71zXevASU
 KVYQObh7ib1jYD4VBS/DMEGRCtRJ+v86MVx8LN2D2U8gsp6Sv3pAR4dktVdayVwiZu8s
 QefOUUQIIjdbW9tb5HPWFerVWpd0bpdfcg1GsRWhLBRExqnXgLZkRubdIOEvxay8il3Q
 Rc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z79UlB74SFDGkVx/wf5z/xmQkiHttzepy/SROQkunds=;
 b=i5G/cAkbFrmASr2H8/gkWrCOmItUiHjBfyHIRkJUElpJHSm9n+z5iNdRmNINK9vN/V
 Q15yf8Gvek3t5AKEc42qmpUG5pupK8GZAfQBFGi+RNcfxf0injbmaFPDbaMzvKdveF6U
 twunBBaa71N5OiL49UqadhLAnskqj7nz5iZDFue8w7YuSyvOmBUe6PkxyQHc1WtQkpgt
 zwPZ72dMHgCjT3aztLTE+9+BdYCPf4n43YfxTMD2odTIwg6PCit3OfBTJy199SVWKhIi
 AJWJrKmTQgAoaJRECuvdYZhwgJJItZW270gGCNmXkthCiBgEc38ubyJGuwodgeGRlUWj
 0ANQ==
X-Gm-Message-State: AOAM531eRoEGZhK5bYA1M1p14AvOnwKOIX6+1I7w8SjsACmkknpSlQTH
 9WneBwozdGdDoOCAuR14slDzv55s59GA+mMnMUU=
X-Google-Smtp-Source: ABdhPJyTao9Lg7MGHS3w6J9lpe8D0qlnuOVVRbxEmgjJQIelAXZ79/aJ1SXFA2+uNtLKj3VoeR2KEKtfcSTSVW8aM3o=
X-Received: by 2002:a2e:5cc9:: with SMTP id q192mr1646387ljb.452.1596191937433; 
 Fri, 31 Jul 2020 03:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <1596176895-28724-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1596176895-28724-1-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 31 Jul 2020 07:38:46 -0300
Message-ID: <CAOMZO5C89emJ91wZsWe-APJ3OpzX=3+jHx6DAEU5kQjNLLSc4Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix value of FSL_SAI_CR1_RFW_MASK
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
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

Hi Shengjiu,

On Fri, Jul 31, 2020 at 3:32 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> The fifo_depth is 64 on i.MX8QM/i.MX8QXP, 128 on i.MX8MQ, 16 on
> i.MX7ULP.
>
> Original FSL_SAI_CR1_RFW_MASK value 0x1F is not suitable for
> these platform, the FIFO watermark mask should be updated
> according to the fifo_depth.
>
> Fixes: a860fac42097 ("ASoC: fsl_sai: Add support for imx7ulp/imx8mq")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
