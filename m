Return-Path: <SRS0=0EZw=NY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D761C432BE
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 12:53:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF68F610D2
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 12:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF68F610D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E4D117B1;
	Thu,  2 Sep 2021 14:52:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E4D117B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630587188;
	bh=LV06zfgFdNC9e1Y7eStlekjXKGketIdIWp4SotN5SDg=;
	h=References:From:To:Subject:Date:In-reply-to:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V6dtDa+KxEA+vigcdcd5U/SXdS7tLJB5xQLFLaTgFMOtzLpWYQ7Dc57TrAAGG/Xgy
	 cZ/4pLMJSSapZ7o88XnSTCaFiiP1vU+MO6kwYaOD5yxosb5A+eZtVx5P05O4AehFq3
	 MgZBMEr6x9HtUQUyBuDKaC8wbBTU91ogDfd0sHDE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9DC8F80125;
	Thu,  2 Sep 2021 14:52:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3F34F80269; Thu,  2 Sep 2021 14:52:16 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10E4BF80125
 for <alsa-devel@alsa-project.org>; Thu,  2 Sep 2021 14:52:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10E4BF80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="QTk5hM6c"
Received: by mail-wm1-x32f.google.com with SMTP id
 79-20020a1c0452000000b002e6cf79e572so1363955wme.1
 for <alsa-devel@alsa-project.org>; Thu, 02 Sep 2021 05:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:date:in-reply-to
 :message-id:mime-version;
 bh=XUQYJFf0VLoed4JNR3bJk8DdGmygiKizVinf3zNZhJo=;
 b=QTk5hM6cRX7Vag5fBHfIGeza7Gcb1CrOImwXRWX/tUo4pmpjLmUx9zGHyE/mC3pJPT
 NwPl+3wafeOiVJQqeXPoo/qK3fM6Xdo83WhZEVjwLWn1EK++PdfKrpWF1feAG02UOamx
 Qvxjnks2r6bbean2ZB3OiwA8WW7OKO0iO0O8MOIAuKLafEcdSNsFNIpKLCPrKrCvhfFL
 HGcA7Dg/hEBxAdqHLwQkS5DofZuFFMxF70Ikc0MHAFnfd+aIKsRlHW32pk6cSmJoYUwB
 eUoDkKJwfd0ychlZhdLxmRkOhCUNHYiebn2sBPtQbiE0KLqY21JHwDzfd9fjiCoO3P0G
 MhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
 :in-reply-to:message-id:mime-version;
 bh=XUQYJFf0VLoed4JNR3bJk8DdGmygiKizVinf3zNZhJo=;
 b=P8F32D5POF9+x7+luUEPLvGeCJYFgcLfHGlzPhOYu/lFQRMa5D+lEWhJDDU11Vm5p3
 X/cKEtZyo7bVVmUooXV5Po9rmVYKnDUjQNyHgJ5lPol0QKcdKS1fm0iu3yTs5+jN8cMN
 OlNYblws8jBumQ8e2gQC/pGWm+r98oFyMUWeMBpwHKTJZWBcfCMVg4rN/CQKwGdMvPuU
 FxwDJ4Di9YEHa2wCDmQsccDzE7wgmLo0bbDEKXBz8/rluy/fObvm5DpUafJ1UsiOGGR+
 sRDFXmyXNNIPIATFau1gvop8qUmK/hl802KdDHmEJcEE6U4/OhMwZOdRoJzQKlMNkqa/
 wvrg==
X-Gm-Message-State: AOAM530AFUMo1fVAmVYha54j+50AjeM2S9+W4ifM2uqq3KmrsPbTk9OQ
 NBZKfG+uGLSyy6SsIvvGCwJNJg==
X-Google-Smtp-Source: ABdhPJzPz9XOAIc35pFuBE/Q9Eg6RqNF24BiJ5nOV48yKD7O45stK/C7AYYFgjow2p8m9xr050S43A==
X-Received: by 2002:a05:600c:259:: with SMTP id
 25mr2997861wmj.82.1630587124128; 
 Thu, 02 Sep 2021 05:52:04 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id n4sm2071215wro.81.2021.09.02.05.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Sep 2021 05:52:03 -0700 (PDT)
References: <1630562033-13231-1-git-send-email-spujar@nvidia.com>
User-agent: mu4e 1.6.5; emacs 27.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
 lgirdwood@gmail.com, robh+dt@kernel.org, thierry.reding@gmail.com
Subject: Re: [PATCH v2 0/3] Convert name-prefix doc to json-schema
Date: Thu, 02 Sep 2021 14:44:12 +0200
In-reply-to: <1630562033-13231-1-git-send-email-spujar@nvidia.com>
Message-ID: <1jilzj5edo.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 stephan@gerhold.net, linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
 linux-tegra@vger.kernel.org
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


On Thu 02 Sep 2021 at 11:23, Sameer Pujar <spujar@nvidia.com> wrote:

> Following are the changes:
>   - Add json-schema for 'sound-name-prefix' documentation under
>     'name-perfix.yaml'
>   - Use schema references wherever needed.
>   - Remove txt based doc
>
>
> Changelog
> =========
>
> v1 -> v2
> --------
>  * Provide top reference to name-prefix.yaml as suggested by Rob
>    for patch 2/3
>  * Dropped couple of unreachable email ids from Cc list in commit
>    message of patch 2/3
>  * No changes in remaining patches
>   
>
> Sameer Pujar (3):
>   ASoC: Add json-schema documentation for sound-name-prefix
>   ASoC: Use schema reference for sound-name-prefix
>   ASoC: Remove name-prefix.txt

Thanks a lot for this Sameer.
With the small update required by Rob's bot and the comment on patch #1
taken care of, you may add:

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

>
>  .../devicetree/bindings/sound/name-prefix.txt      | 24 ---------------
>  .../devicetree/bindings/sound/name-prefix.yaml     | 35 ++++++++++++++++++++++
>  .../bindings/sound/nvidia,tegra186-dspk.yaml       |  9 ++----
>  .../bindings/sound/nvidia,tegra210-dmic.yaml       |  9 ++----
>  .../bindings/sound/nvidia,tegra210-i2s.yaml        |  9 ++----
>  .../devicetree/bindings/sound/nxp,tfa989x.yaml     |  9 ++----
>  Documentation/devicetree/bindings/sound/rt5659.txt |  2 +-
>  .../bindings/sound/simple-audio-mux.yaml           |  9 ++----
>  8 files changed, 51 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/name-prefix.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/name-prefix.yaml

