Return-Path: <SRS0=ORgw=FU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF42C4361B
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Dec 2020 11:07:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A47523382
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Dec 2020 11:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A47523382
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2107C16F2;
	Wed, 16 Dec 2020 12:06:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2107C16F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608116836;
	bh=9n7C1KwHSXGNk3/j6d+B0DnB8QpszBbT+jJEcTHafME=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oO3Tm2gXQkJRWu1iLe6z2VTL/blgRedikk9CU51F3JHV/VXLwkcmg/RZFFnhCVWxC
	 ar+itnlHvrYD85ybB6bAD4Nl0zQcdoe8+d7xgTGUS9095x2j5KqFi5lmOgIpqSWMer
	 6Xf/uU8JLPNH/5vPnOUD3T6dWIJnC9Vsl4fCHii0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A1F3AF80171;
	Wed, 16 Dec 2020 12:06:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 752B3F801F7; Wed, 16 Dec 2020 12:06:24 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73D9BF8014B
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2020 12:06:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73D9BF8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="S/e3+RcH"
Received: by mail-pg1-x52c.google.com with SMTP id c22so1964325pgg.13
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2020 03:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=JOOQpcp04fe7Ai/Scwmonj/jlQhNtKVes7u2TT8U0X4=;
 b=S/e3+RcHwRHNREai4eV3qePPu5aVF50Zv73xS38GVyJ01iu3wrbAQ5c791t/5IkcYM
 1WPdO8T0vOZqxG/6jTyKhnHhI2uOROTX3RiXlVB9SbQVUYH2gXbnBLABWzBmd+5ozCpZ
 yxT/GVm88oUEFKTpSUp9IVwXH5+3kepB5F+fYJ9ilSVWa7dDYXwEBdW96fWGC9XX9Muj
 CK36MiA+sqFVH3fEUnJ4Brul5Fn8uHNVDUhWFFJyUsUoNNm9yDI9gRoK1sttDIa116l5
 0pV9CICzrSs71tWCCUqmHKmFT6qM82MP9M4MxqnLKpbpZhqdJnzPySpObjgQg5rXk8W0
 KxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JOOQpcp04fe7Ai/Scwmonj/jlQhNtKVes7u2TT8U0X4=;
 b=QPyRc0Bd3gnmVO78jyVc1NDxHgCY5DS39XBvpy9cNjjIAuqv05U8qUJTUDRSXeK5Ne
 80YP6IILzAKSMUdKErrZtz5DkhrIToPra7Vi75Qe7vsXSc2beYEhAx1MEc5byuWqhH6T
 XoeBsHi2iJtWE0ogNvccvY3WWPRT+beMI+ijuHnj+t06pSJrSV19Dmgr08rT14FQv86j
 nn5jXJFae/x/qeYR8NFHChQOK7KSzslvTsBR/oi0kWYVTvGcLkOzlCTEXnKADPoKVnp1
 KBqc4McB1XEEIAeArlNy5DRbVxOdx2r39EQ9RSt+5ItQO5xGtPGQN5mpc1JDR+opFvOF
 OXyg==
X-Gm-Message-State: AOAM5321jrcLUfm5QHaP7ErVbN3W+Mbm3dJFM7tKx1MdRkUEjQbxAdyl
 CuqEUEVPxY3Tb5A+QNwYZHA=
X-Google-Smtp-Source: ABdhPJzgryV5EFyPEgVKa/Ym7NmyHZP5f5iQ8HNSLMTnXY9UjxcdOzvVstG7QN5HnbmPU2WH/SttAQ==
X-Received: by 2002:aa7:8d86:0:b029:19e:cb57:2849 with SMTP id
 i6-20020aa78d860000b029019ecb572849mr26379440pfr.54.1608116773633; 
 Wed, 16 Dec 2020 03:06:13 -0800 (PST)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
 by smtp.gmail.com with ESMTPSA id
 fw12sm1729790pjb.43.2020.12.16.03.06.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Dec 2020 03:06:13 -0800 (PST)
Date: Wed, 16 Dec 2020 03:06:06 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: imx-hdmi: Fix warning of the uninitialized
 variable ret
Message-ID: <20201216110605.GA2156@Asurada>
References: <1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
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

On Wed, Dec 16, 2020 at 06:44:24PM +0800, Shengjiu Wang wrote:
> From: shengjiu wang <shengjiu.wang@nxp.com>
> 
> When condition ((hdmi_out && hdmi_in) || (!hdmi_out && !hdmi_in))
> is true, then goto fail, the uninitialized variable ret will be
> returned.
> 
> Signed-off-by: shengjiu wang <shengjiu.wang@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
