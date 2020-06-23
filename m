Return-Path: <SRS0=bSXK=AE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD14CC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:33:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623872072E
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WCmaqulW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfKUA1iM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623872072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED9F11733;
	Tue, 23 Jun 2020 10:32:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED9F11733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592901194;
	bh=YNmhotv/d3jyzSimRBTqeSiGURz2lKZVcgeGaqmsJT0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WCmaqulWVBehh6IU5P34fACyLOwyO8p+44F+X3jcSU7AGHg+WlJvEppk1o2FBNfLx
	 dvpMOdjiIQENlbSDz4+MY0AHRaQ1F6qyL2c39EGMlVzYM0lkuq0qEOI8oBdyEc3E8W
	 NYV10C0gHZzjQ2IILSoxx/6RswH8t5SAyfDEcYKc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E577F80218;
	Tue, 23 Jun 2020 10:32:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4CBD8F80234; Tue, 23 Jun 2020 10:32:22 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACC31F8012F
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 10:32:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ACC31F8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="MfKUA1iM"
Received: by mail-qk1-x742.google.com with SMTP id 80so6218414qko.7
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 01:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WUXkMq3EwcMN7rag+IOzTouUq2jW1leXveyXqam81mE=;
 b=MfKUA1iM2cNLIQb0gJHMFANrfHxAxLJ7OauUZ2pO/Zib5rQxdceNoygxEhaSDMdHF9
 oRekPg5JE8wO67W1XXq2VajDG1CD5zGtq6DzJ+Qqzc0xSSHh8EvgNnEnJ7pA67a4qEGf
 lPl3QQNFvtUUy0Dxt3X/UuNwZ7fbemOh29ZTt497SOrwO3oL3Sey/D/ilE2uGS2PQFbx
 8eRe/P+4LFzxcDQI8ZY/wsYR0Eaj3Q5c4e3/otG65UcV+dUVpriPExa1pjkoV6FtNKsk
 eTFyhw3iNwgYihpOJRXlLTx1rYmcfRPPKKxP+HEqKHn704oUg1p1fMwDArGlPS5755W+
 rRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WUXkMq3EwcMN7rag+IOzTouUq2jW1leXveyXqam81mE=;
 b=kit8xSMdeKpgG++T05ame33jNqbhdfTc9Ye+nWqdoMA+yYCLfxF40vfVKxxiIyqSdl
 cQzTxOhp7L4BHC7z/NHeOpdTxz2hAO81FT0TsqfWNfs06tSJCspv+KA+WouGjZGV5v93
 ousQtDOR1B/1EIv1l/t5cq2xlMYRu64w6YlCDGMnvpE3N/v3+qS2tekdvltrVlgULYN1
 OMRW9q4vi2pSZPyWAb1v1b4NJNFPWC18r26zvWo79j+FEkyeYGMHF3bP5EPhwTXrN3BD
 w41Q2UY1NhkOa+vpEcqpUnaTidYj4f4Ou48de9TznsZGEgN9yJWWxkbPow+FmNZ9O1yM
 /bvA==
X-Gm-Message-State: AOAM5300LdthhYrUrFbEY5j+omfVQyKB4ae3hOzPzaLDg9ZX/2haOIA5
 yH7DGykN3MB9LPzkkIiShhf80B7I2VXFdfLdw23LGnHf
X-Google-Smtp-Source: ABdhPJy8aJP9b/KoDke180z5lb657c5ulXpRf52exbUwqEylh9UUhQV3q7rSAK3MRe5vqIrWMG20D3EDlUJCCfc0XW8=
X-Received: by 2002:a37:8a43:: with SMTP id m64mr18899695qkd.37.1592901133739; 
 Tue, 23 Jun 2020 01:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <39ac8f24-3148-2a3d-3f8d-91567b3c4c9e@web.de>
In-Reply-To: <39ac8f24-3148-2a3d-3f8d-91567b3c4c9e@web.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 23 Jun 2020 16:32:02 +0800
Message-ID: <CAA+D8APR2NGAn9jRDSZzr1fgj5u0hAvH19VxZS+tj2A7j3PCuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: fsl_mqs: Don't check clock is NULL before
 calling clk API
To: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, kernel-janitors@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>,
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

On Tue, Jun 23, 2020 at 3:38 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > In-Reply-To: <cover.1592888591.git.shengjiu.wang@nxp.com>
>
> I guess that it should be sufficient to specify such a field once
> for the header information.

seems it's caused by my "git format-patch" command, I will update
it, hope it is better next time.

>
>
> > Because clk_prepare_enable and clk_disable_unprepare should
> > check input clock parameter is NULL or not internally,
>
> I find this change description unclear.

    clk_prepare_enable and clk_disable_unprepare check the input
    clock parameter in the beginning of the function, if the parameter
    is NULL, clk_prepare_enable and clk_disable_unprepare will
    return immediately.

    So Don't need to check input clock parameters before calling clk
    API.

Do you think this commit message is better?

best regards
wang shengjiu
