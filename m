Return-Path: <SRS0=WcGQ=EZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AD6C2D0E4
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 05:02:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4682246EB
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 05:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nkpXNnz5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duj4eOFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4682246EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 56A2C16FA;
	Thu, 19 Nov 2020 06:02:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 56A2C16FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605762171;
	bh=el/1httg8+eewyFs85XYIB7anLyZ9Evz96H4O0xGkiw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nkpXNnz5mnRbQxgH09GVBc0jGQwxrgcIK6YIsO5YJW+/w8QLji9p+PilK0/7ZXDBZ
	 2Qhh7RBKXTvs7fqNx0k7lByV3flQpjaiUzEabnDDQeBW7fk+/V/O17/7X4C86MKpfC
	 VhtScX8N+gy6OMko7X05wR9cBpVREPw9m8INLJxI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CFBA3F80169;
	Thu, 19 Nov 2020 06:02:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69BACF801ED; Thu, 19 Nov 2020 06:01:59 +0100 (CET)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B184F800C5
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2020 06:01:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B184F800C5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="duj4eOFR"
Received: by mail-pf1-x443.google.com with SMTP id 131so3279769pfb.9
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2020 21:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8cz3enAL5Z5Hmb2tunw3mWVvo6ZiOq4lJnWnZV2/xu4=;
 b=duj4eOFRuuoRo/k2/GT7E5UP1NTqvVMJONO2EmKQx4JwzYhwNLBCLf2SokW5rrlgFI
 uhWxiVtmj9lqv35g4VinjX6jszgACQbXZN7duEVfuwdwZKKl4uV/B3IciP51RklxnBkG
 e9vDOnA4/0ctUOpISUygUux++JCmtPQi4KmCa4b8Ucr2SZw0XB6gshJRf1C+VCQtg5aD
 UOS1W+1wNa3L3RfyXaZhipBSoGV8Esfye1CRoe8MoySnHt8lvt7BmCT3nGmkSI21Uqf1
 s1HrD0GFOsedFunmHzmHcxOR9WA0mqTKLxXl+766u2ircarXMerAhy0XM0VrIG9CmxbF
 ZTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8cz3enAL5Z5Hmb2tunw3mWVvo6ZiOq4lJnWnZV2/xu4=;
 b=hX/XGYBbEVfBVKZFn5bZkGt790gmbhy/xHdoa/DyxDhGi5XFVya2SeyPg/iLVEH0/O
 ThgJDzSAlP2kqhECgyjpGIkQdRKPn3UImQBARZuBcIUGIkVdI0JBpPLW4UDNFuVV9T/4
 gpT+zVj8CkDsTTeY7m7VeX+C3+ZxqjSw3A6iSP9LGzA9TOxheBeDKZcUDbJxSfi/ajxI
 8Io2xu4+iAB3BrguqchpP9lGSH1wwdpJQgdxxk4rhj1jmAf2iCyAt7aj7fPGbxV1Q3MM
 oy3yon5Ix4ukyJNNXgs8Pw3QSzCdfuiG2i+c9Mad1+7mc47Dqay1i5tQF0QvCzxYUc2e
 M0PA==
X-Gm-Message-State: AOAM531LH7jhMJ1QaWW0LWZ8wvUrd2qvp/2o4eg3/uxPZDyEwC6LhGEc
 Zm5LzcBxIxD+W3nAP6KJF6U=
X-Google-Smtp-Source: ABdhPJwQdNXkT3Phmm+Z7AT/H+skvgWBxS2LYjl6sXgqQqAOZ7omgkkvUkEcBl/cAAspL+sft1r/UQ==
X-Received: by 2002:a63:380d:: with SMTP id f13mr11633900pga.105.1605762108046; 
 Wed, 18 Nov 2020 21:01:48 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id k8sm27722420pfh.6.2020.11.18.21.01.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 18 Nov 2020 21:01:47 -0800 (PST)
Date: Wed, 18 Nov 2020 21:01:21 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Correct the clock source for mclk0
Message-ID: <20201119050120.GA7124@Asurada-Nvidia>
References: <1605752956-17397-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605752956-17397-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, broonie@kernel.org,
 festevam@gmail.com, linux-kernel@vger.kernel.org
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

On Thu, Nov 19, 2020 at 10:29:16AM +0800, Shengjiu Wang wrote:
> On VF610, mclk0 = bus_clk;
> On i.MX6SX/6UL/6ULL/7D, mclk0 = mclk1;
> On i.MX7ULP, mclk0 = bus_clk;
> On i.MX8QM/8QXP, mclk0 = bus_clk;
> On i.MX8MQ/8MN/8MM/8MP, mclk0 = bus_clk;
> 
> So add variable mclk0_mclk1_match in fsl_sai_soc_data To

Not in favor of "mclk0_mclk1_match" as it doesn't sound explicit
to me. Instead, "mclk0_is_bus_clk" or "mclk0_is_mclk1" might be
better. Or in case that you foresee some other implementation:

enum {
	MCLK0_IS_BUS_CLK,
	MCLK0_IS_MCLK1,
};

static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
+	.mclk0_alias = MCLK0_IS_BUS_CLK,
};
