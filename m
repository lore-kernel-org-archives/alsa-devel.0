Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F5BC433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Nov 2022 00:09:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E2CA1621;
	Wed, 23 Nov 2022 01:08:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E2CA1621
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669162166;
	bh=zLCNweSjB29MG8MJ4f0QFntbG8mDaA4Em92CzdktT0c=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kw7VHvE/1L9FyFo3ryF7wVtQYkwk2L72MBi1hz9PhazLCAXdbeNW6aRTrGa8Xe44p
	 QJOupA44q30DXPPs7SZr8YKc8WbiGzv9V7oYXbIys8gL7zjBWdwOmer2cmd35hhS6t
	 Ym4BpIrKhXVOj2MUqJNC8aFk5Jg22H5364YFp7Iw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D22AEF80154;
	Wed, 23 Nov 2022 01:08:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96BEDF80272; Wed, 23 Nov 2022 01:08:34 +0100 (CET)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com
 [209.85.166.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3AC5BF80154
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2022 01:08:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3AC5BF80154
Received: by mail-io1-f48.google.com with SMTP id b2so12112369iof.12
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2022 16:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c5ZPbYkKnK2IkXf6T8FgMRx12jqOc1F0dei+USA8qpg=;
 b=VlW9GiJyjFyVXDSKkF9h6eEHy4g8XJ049p/E9Tu0A3iejLOS0GK1LICh8gPbOVABXG
 bwKnnGByCQpMylHMRvBCPb0BosQWcgsvCVnZjZVYtVoskn92W9OgtjAN9i7WM5Kfu7YT
 PWXnMyvZFipE3KFuCaaNNQj6lSYh0VP4uQodQRsuXour1m5k/Zn7vCEl8RsM8kzjK2wm
 vrmient6xmTVMwPsOcI7EEQlMfYwseID25MQDiXDJFeChEEr+ZzLB/nC4JbQKvjicXht
 To1dgOV1Q94nwGjJOQLT0rscFVj/ZBNJU0w73hkTR7GuizXB3vZwJvfogn3Uje93Iz3o
 pw1g==
X-Gm-Message-State: ANoB5pmMIBl/5i71Za0gQXjkxP/potr/KuclmwwAh2NRD5RGmkofYIVT
 SNxteBw6wfCXXJvcomytMA==
X-Google-Smtp-Source: AA0mqf6Wr7xqm6RogMUZda84qHyMvqZUsWZi6Gq6zcsxkRFMGZ1oVHNeafF1Qzbl4qKI3CfQBYwImg==
X-Received: by 2002:a05:6638:3458:b0:376:24f6:2dc3 with SMTP id
 q24-20020a056638345800b0037624f62dc3mr11956348jav.26.1669162110050; 
 Tue, 22 Nov 2022 16:08:30 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a05663822a700b003752e5b3c23sm5756588jas.20.2022.11.22.16.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Nov 2022 16:08:29 -0800 (PST)
Received: (nullmailer pid 828924 invoked by uid 1000);
 Wed, 23 Nov 2022 00:08:31 -0000
Date: Tue, 22 Nov 2022 18:08:31 -0600
From: Rob Herring <robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Move fixed string node names under
 'properties'
Message-ID: <166916210667.828774.15527231190149112577.robh@kernel.org>
References: <20221118223708.1721134-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118223708.1721134-1-robh@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Jerome Neanne <jerome.neanne@baylibre.com>,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Thierry Reding <thierry.reding@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-tegra@vger.kernel.org, Andrew Davis <afd@ti.com>
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


On Fri, 18 Nov 2022 16:37:07 -0600, Rob Herring wrote:
> Fixed string node names should be under 'properties' rather than
> 'patternProperties'. Additionally, without beginning and end of line
> anchors, any prefix or suffix is allowed on the specified node name.
> These cases don't appear to want a prefix or suffix, so move them under
> 'properties'.
> 
> In some cases, the diff turns out to look like we're moving some
> patterns rather than the fixed string properties.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../arm/tegra/nvidia,tegra20-pmc.yaml         | 54 ++++++++--------
>  .../bindings/regulator/ti,tps65219.yaml       | 14 ++--
>  .../bindings/sound/tlv320adcx140.yaml         | 64 +++++++++----------
>  3 files changed, 66 insertions(+), 66 deletions(-)
> 

Applied, thanks!
