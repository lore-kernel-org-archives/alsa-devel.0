Return-Path: <SRS0=7OoL=EF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DAFC00A89
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:30:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67662208B6
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gCbu1nMc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1bDXsBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67662208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9BEFD15E0;
	Fri, 30 Oct 2020 09:29:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9BEFD15E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604046630;
	bh=5aG0OoLrJuN/4lMve0As2arDf2khH+IajAllE76GAq0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gCbu1nMcRRfPPdW2B743bBZzTgSowEEBFo/wrKGwmOpqTRYXYemdpTTM5/Zz63KHy
	 k+J8isWEMZc9uhrl/ulkgXOS76pP5to9wBbArImRykM7JcqK6hEu07B7KOnTuwLLsh
	 xgzf/0kNymWGcUq7d0Lo8yU10IGRMozmw5p5k3v4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15886F801D5;
	Fri, 30 Oct 2020 09:29:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46591F80212; Fri, 30 Oct 2020 09:29:34 +0100 (CET)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C01EF80107
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 09:29:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C01EF80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="i1bDXsBm"
Received: by mail-qt1-x844.google.com with SMTP id m65so3518543qte.11
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 01:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2SmP2XG2z3yyrdfUO9SkbT5PkhpXi9KOLge2mZeMb5U=;
 b=i1bDXsBm1niQ4dkdDbmR9gg6PC1JZxcVuqDMoIU0x9yV4eCKiO7o8WT1gLVhGbua+W
 VSQZz/9X1dfTZK7P3wLdKlpscV6K9QmiH3GTCxZkVydSulOWMgGtX1r8H2KdukRelmYV
 edizOroqwJafVC6nOIPEiBOx37tjE8bEon36kr6517o7gv5RrScCd7ln8wa8xhnpGqsU
 b3auk81D2jZttt3Ztoa/HIhlJh3DakWKMdVWiXa85ZDKeLn4IAPgv7Zo/hpuTilTU9gA
 oyW+WpiGsqHa2x3pWM0/xE7mMhPGN5KP4Gb11NEJo4XszZzED+eirG1lNWhaHn4vo1Dl
 upGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2SmP2XG2z3yyrdfUO9SkbT5PkhpXi9KOLge2mZeMb5U=;
 b=qupb3VSXkLerfR037DfoBDa47VCYOlKsCiu7ZyEdySgRxE3I6ScSPUTI4c3hvqqkvL
 dQI7egMIAjUo03iK+IT6+c+mLixsFQGEJTRGsYX0Mqv8TDg35N+OJL8Py4lB4Gem5Xsd
 144/KZ7+P3Qng9be1qjUNNmej1TNmnt/upQi4msoeV6k76GbK+tohwCL5jXAolkcA4mQ
 uTBsDxiwY7bTm38WrkGQW1PmuULiaijMeRZLfWm9VHD/SZHOsS5WO5zg8ImE3UTZnwL7
 H6uEDDnTwj0Wf/YjTsWy2u3Wie6FCBNvkBB4nxqCCMAG8ywo8NLfKIVblNPTa0tHB3A2
 RPDQ==
X-Gm-Message-State: AOAM532Pxs97w0SpMwKcGZsF5cegQ16zLzMHJqN5/64mXBuTTi0WAW30
 xBZYwXwfJWm6sJb5Dog6a24ffDtCi3p6P8lxWV0=
X-Google-Smtp-Source: ABdhPJzkbx+wUo5qTc/A5mLSgJdG9vfP6tbrvgVQoe1Oj4ip/QKJPl/1/B4em0IUQc5bqYk4VWdgJWXeCNWIuiLyc9s=
X-Received: by 2002:aed:26e3:: with SMTP id q90mr947606qtd.121.1604046566560; 
 Fri, 30 Oct 2020 01:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <1603877930-10553-1-git-send-email-shengjiu.wang@nxp.com>
 <20201029152721.GB1901783@bogus>
In-Reply-To: <20201029152721.GB1901783@bogus>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 30 Oct 2020 16:29:15 +0800
Message-ID: <CAA+D8AOC3FSCH48p8e61W7Vz5Ri9Hhz_Hbw24cXtEp0OO2gT8g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: fsl_aud2htx: Add binding doc
 for aud2htx module
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linuxppc-dev@lists.ozlabs.org
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

On Thu, Oct 29, 2020 at 11:28 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, 28 Oct 2020 17:38:49 +0800, Shengjiu Wang wrote:
> > AUD2HTX (Audio Subsystem TO HDMI TX Subsystem) is a new
> > IP module found on i.MX8MP.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> > changes in v2:
> > - fix indentation issue
> > - remove nodename
> >
> >  .../bindings/sound/fsl,aud2htx.yaml           | 64 +++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
> >
>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml: 'additionalProperties' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml: ignoring, error in schema:
> warning: no schema found in file: ./Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
>
>
> See https://patchwork.ozlabs.org/patch/1389813
>
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>

ok, will fix it.

best regards
wang shengjiu
