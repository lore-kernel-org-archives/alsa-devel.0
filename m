Return-Path: <SRS0=7OoL=EF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FB5C4363A
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:20:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDAFD20756
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CzhCY30j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vPF6leW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAFD20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 118061614;
	Fri, 30 Oct 2020 12:19:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 118061614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604056835;
	bh=Nk5L79pAxCBDDlmGbMnk8ZREZE3prtsj5+zpKkmAwdg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CzhCY30jiSbY2CxSAgO+TkEGzWoSeWyCNfaDiQYfrdn7c3/1ZnNk1P+j1bEENX49b
	 RyrhTqtHjinzqwZ1NowbPs2EyzgSKHM16KKiB3ovTmKblLruBIg/y0iB1AG0hD0Iq+
	 6BjTCirGf/w5cYwptHorUb1lFB5+39UxS1iIse3w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CAECF800C0;
	Fri, 30 Oct 2020 12:19:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B23BFF80212; Fri, 30 Oct 2020 12:19:42 +0100 (CET)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1FC1DF800C0
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 12:19:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1FC1DF800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="vPF6leW+"
Received: by mail-io1-xd42.google.com with SMTP id h21so7074948iob.10
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 04:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5RA/dTcPLcLSjFsM4pTf8628QTB+ljlVPvTwaOAvSI8=;
 b=vPF6leW+6gfiBr1s7qfSqOlKqUhfUMZVxmg71BGMeoJBHzeltWCTbYEuXa0oT2dpud
 wFpsNu4u69HfrJAKI0EOaTm6zsS8jIGH3m+9HVCNWrLlCCPoSjJqD2wE8IxwVeOWCTT/
 s9zIz/l9hy6s0sd/GXp4XfEvSvKGZqcAbjIb+9V91QPh/+m5tmqwRgj69T+okuTdts7j
 f8Rb2Xhxxuv3wU2FnzTR+xffJLffig2bPxtSDt6/d+Kun2cCrXvDLDclwQ1mGchUWUEe
 kh7V2O04DMTgLQ+QNYBQpIuNOLClV0FN3U+CjlNZaGC2yFYQ9Oo0c77oTqWY7rM+3aR7
 b19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5RA/dTcPLcLSjFsM4pTf8628QTB+ljlVPvTwaOAvSI8=;
 b=XfpIPDXKxoW7L5L+5hf8n5rSH35XTk1finVkbERJaSvsxhhtjO+Guu5RjCZBsgcKN2
 3LvjYTDMm4sz/bOS+GSU6iqcMa192XslFp7oH4Q7XynFE/kI7OPhUMpW3t0SXRlAb04K
 A1Vj37cOxad04GYSmInuh1VbLzF48lP09R8dr/6geelwikcg/wMUJHbb/aIqqb10IJ2v
 SPBWCHbjEXnPq+wtEYlj/RwS34IDarKFPSBrgI3P1o6LouPI+gpwLVMZzKwDuglm1LXW
 gmLbDIPspksbNx5VkZTHugwOMFMD9p7x+KyAD+RU5klowqWyGfSQ33RkphRownSBzXF5
 OoQg==
X-Gm-Message-State: AOAM53341H91obSvlGsaDYw18d3HFK/rSs632He+rftN+spfq4Gpxav6
 wLLIM+3QQ2PNgq1y1af83MZe7QA8q5uAer4dSwaVlA==
X-Google-Smtp-Source: ABdhPJy/oufOebW5MWlnuf1Ro28TfvpmK+4mcN6r8qxQ28XDMOnf4ekL4Po96CPF9erK2pQu3QvP3fFFwmkHIFBVjmc=
X-Received: by 2002:a5e:9244:: with SMTP id z4mr1374790iop.53.1604056776404;
 Fri, 30 Oct 2020 04:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201030075724.1616766-1-ajye_huang@compal.corp-partner.google.com>
 <20201030075724.1616766-3-ajye_huang@compal.corp-partner.google.com>
 <CA+Px+wXPRg7aDU5+vr6R_BxuFfhuDeG3iEQeAUKWNtX8YmVC1Q@mail.gmail.com>
 <CALprXBZ+NmR8Y4sMkh4Y-N_FG+rGEOhUBVTKXRXNFp8H+f0btw@mail.gmail.com>
In-Reply-To: <CALprXBZ+NmR8Y4sMkh4Y-N_FG+rGEOhUBVTKXRXNFp8H+f0btw@mail.gmail.com>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Fri, 30 Oct 2020 19:19:25 +0800
Message-ID: <CA+Px+wWouXWS2F+Bqs3MkJxCuXORhpXcUF5ZuSHo6exprBF4hg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: qcom: sc7180: Modify machine driver for 2mic
To: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Douglas Anderson <dianders@chromium.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, ALSA development <alsa-devel@alsa-project.org>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Ajye Huang <ajye.huang@gmail.com>,
 Patrick Lai <plai@codeaurora.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>,
 Andy Gross <agross@kernel.org>, Tzung-Bi Shih <tzungbi@chromium.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 Cheng-Yi Chiang <cychiang@chromium.org>
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

On Fri, Oct 30, 2020 at 6:55 PM Ajye Huang
<ajye_huang@compal.corp-partner.google.com> wrote:
> But dmic_get() will need dmic_switch, should i keep dmic_switch?

I see.  I overlooked it.  You can keep the dmic_switch for this
purpose or just call gpiod_get_value_cansleep().
