Return-Path: <SRS0=58lj=CZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563A1C43461
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:49:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D382220A
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NBsF4KUx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rU44eXu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D382220A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 702B7825;
	Wed, 16 Sep 2020 13:48:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 702B7825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600256958;
	bh=q22OaBxxEw6PyPXyvZAT7++83kuaZ/3S8KGaQFuZbuc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NBsF4KUxfx9F4gQAqVWHJUiI/0SpaNbNPM7HM10NuLzDJtrTU77dKro23DZjxhLgB
	 qqrQONWIm/1XJDrBuisPRXpq9c8+7E8DSKiNH13N/4rKzSihIochHee2eNnHcGatEz
	 f+n0Fbqc05Mc7c9x+jRDdJU36u0zGXP6dbAvgYE8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED005F8015C;
	Wed, 16 Sep 2020 13:48:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62907F800F1; Wed, 16 Sep 2020 13:48:26 +0200 (CEST)
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 477B3F800F1
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 13:48:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 477B3F800F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="rU44eXu9"
Received: by mail-lf1-x144.google.com with SMTP id q8so6645135lfb.6
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 04:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8EqraEW4q0BQREzcz7DOOl5CowgKAV1RWSkOPCRavNE=;
 b=rU44eXu9IYnr41wxdt6v9T2BK23fXOMiYHbuvJ4fBvbIhQJevbN9DCu7zeoSzO1b7r
 XNnu+btJPV045o+iwfbkQjbyUDrAOjfp6elbTCasVlluLFW5gIHT1X4yyVMsJJSLCNAC
 w19tIW8BZ6o4Laen2U7uJnAps2VyVw0pZtsvyenkUx/e0PJjbGpRc5c+UKkDiRuxNx1Z
 Vy/jgkfhkbKz8hoq4Z7JSgBxGLEoMUrX6gT9NxbIf/7NGcZQYxDnj5nAaqPkHAqpqUgG
 xl042OMDHACLbpwLg253ADTbCnsM8kZMCesIY07WiMgcAcKlZT0dgv668gr+5Rz4V3QD
 N2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8EqraEW4q0BQREzcz7DOOl5CowgKAV1RWSkOPCRavNE=;
 b=RnqiZGcCpmv1jOK7hpoJF+DqoeSXveImD/DMpwCHTN5TQsZd4TIjiphK5YdFINLxk3
 JumNLUiXQYd6h3Tr4DWfJfO2DrgSNbcN9scke4rXzoZq/ReH5G57Kg0FqKwKiCroBUXk
 mmBKDJlefiB6yTAAgLBFLomgQ8mofQ9/5285yTwjncXGdW/aq/b+tmDIkW/OadkmxMCj
 RAtUfhMmwPppgHsr2FKBeZDZpbvTnASZc+iNRxilM9mALRfx4MAFbZKlXuV1ey6Mmq00
 10ugAhVQ6mSd75fJGqmku7nHOXmJ6SljQ6LUs6bhfMvnWHCmtNZ+CUKgsgqB2yqh4zdo
 xK9w==
X-Gm-Message-State: AOAM533HCSwO2TEsnKZYWHru3CNJ+R0II7OJ5OcW3oN+cUxrvfWa4gSV
 zc+IibMpBB7Uhtx4Psn9Ack6XAOs2WF+FYLmhuw=
X-Google-Smtp-Source: ABdhPJyLQQjbAn1PyXukvYJe9+/3BtvyQn2weWT99qvd4/rq7/DfXmAyofM4kYWfrGNcNfdwXWq2A9YgjXkIDgtp/SM=
X-Received: by 2002:a19:820c:: with SMTP id e12mr7282855lfd.215.1600256894436; 
 Wed, 16 Sep 2020 04:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <1600251387-1863-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1600251387-1863-1-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Sep 2020 08:47:59 -0300
Message-ID: <CAOMZO5Dyo5J8SRWYLyh3bxwtcuAH=r6pcQg7-vtXfO2H6n4Exg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ASoC: fsl_sai: update the register list
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo.Lee@gmail.com, lgirdwood@gmail.com, tiwai@suse.com,
 Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

Knob kmg

On Wed, Sep 16, 2020, 07:23 Shengjiu Wang <shengjiu.wang@nxp.com> wrote:

> As sai ip is upgraded, so update sai register list.
>
> Shengjiu Wang (3):
>   ASoC: fsl_sai: Add new added registers and new bit definition
>   ASoC: fsl_sai: Add fsl_sai_check_version function
>   ASoC: fsl_sai: Set MCLK input or output direction
>
>  sound/soc/fsl/fsl_sai.c | 77 ++++++++++++++++++++++++++++++++++++
>  sound/soc/fsl/fsl_sai.h | 87 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 164 insertions(+)
>
> --
> 2.27.0
>
>
