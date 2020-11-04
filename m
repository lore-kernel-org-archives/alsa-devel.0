Return-Path: <SRS0=IYsu=EK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF62C4742C
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:58:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5E42080D
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pmpbTrBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5E42080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D6D9167D;
	Wed,  4 Nov 2020 19:57:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D6D9167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604516277;
	bh=2dYs55xebl1V1IbRI02IMSSb9NKk/2G++5wzCR9C3/s=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pmpbTrBzNUs8Ufs5Jq4jXs3ru1RAS8duJ1ZuF77ahYP9iScmKAvJEcLNEqEzSenGS
	 Tao1oCHgKgyiHMPX/onmeHYqd5w5AecNsb8HsK91RDf9yoUikbOVN8QHgPO7hk0Bzh
	 EHmEzYpcPujh/XQQMgGgkJ0TNlTM6nNe6pPPMIF4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02DB1F80232;
	Wed,  4 Nov 2020 19:57:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5B25F80234; Wed,  4 Nov 2020 19:57:05 +0100 (CET)
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 617ACF80229
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2020 19:56:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 617ACF80229
Received: by mail-ot1-f67.google.com with SMTP id 79so12843040otc.7
 for <alsa-devel@alsa-project.org>; Wed, 04 Nov 2020 10:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VFWuzwJSbzZgP3QJ9+E0rWgVzccQnC1YvFD5b/UokjA=;
 b=UCclq6gMhqsKNGcst9AoMgNpPQFcDWy65emDQ7mnubO7z8HislHpotGFnQ8LPF6ofd
 HXUD+81k61q5YnNTSa1+6qMTKbOef+/ZvrlkQPIChPAJb6290/A8zPQj3BFOw073b5C2
 N8m6cc1tNTG7hQ5Soudkb/hqZPaRcbLep+qKCsWh0gLNeLkbmrAW+4R0M0wTW2bMVoBz
 sWYTdWkhXgBRD2T0tIJJsXrf06jhDm+54T0rPtBRVdls2v7sG2mseplCHNqJ0GFLA1pB
 KQVe+oDplBUSZj2PM2M+dMrI+mscKC1W1NQbxUraHVbH1tiSSJ+i+gJVktbN/9mvxLg7
 C1+Q==
X-Gm-Message-State: AOAM530xrQwv/k3DBseYbLjMQHERgYfu3tkuoFda3b7U2kUZlqFUQWhC
 tzf/yu8t79ppJonQ50jjJw==
X-Google-Smtp-Source: ABdhPJws0729OuS+J73/HqFJI9wECuK1AqYDP1g32egUbxndlt30IEgUrdNjDMDR5RzcZc2UJAjHSQ==
X-Received: by 2002:a05:6830:2ef:: with SMTP id
 r15mr5683837ote.261.1604516212970; 
 Wed, 04 Nov 2020 10:56:52 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id y22sm735450ooa.2.2020.11.04.10.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:56:52 -0800 (PST)
Received: (nullmailer pid 3947080 invoked by uid 1000);
 Wed, 04 Nov 2020 18:56:51 -0000
Date: Wed, 4 Nov 2020 12:56:51 -0600
From: Rob Herring <robh@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [PATCH v4 7/9] dt-bindings: mediatek: mt8192: add audio afe
 document
Message-ID: <20201104185651.GB3946406@bogus>
References: <1604390378-23993-1-git-send-email-jiaxin.yu@mediatek.com>
 <1604390378-23993-8-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604390378-23993-8-git-send-email-jiaxin.yu@mediatek.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, tzungbi@google.com,
 Bicycle.Tsai@mediatek.com, tiwai@suse.com, robh+dt@kernel.org,
 shane.chien@mediatek.com, broonie@kernel.org,
 linux-mediatek@lists.infradead.org, Trevor.Wu@mediatek.com,
 p.zabel@pengutronix.de, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org
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

On Tue, 03 Nov 2020 15:59:36 +0800, Jiaxin Yu wrote:
> This patch adds mt8192 audio afe document.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
> This patch depends on following series that has not been accepted:
> https://patchwork.kernel.org/cover/11752231
> (dt-bindings/clock/mt8192-clk.h is included in it.)
> https://patchwork.kernel.org/patch/11755895
> (dt-bindings/power/mt8192-power.h is included in it.)
> https://lore.kernel.org/patchwork/patch/1321118
> (dt-bindings/reset-controller/mt8192-resets.h is included in it.)
> 
>  .../bindings/sound/mt8192-afe-pcm.yaml        | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml:10:4: [warning] wrong indentation: expected 2 but found 3 (indentation)
./Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml:15:7: [warning] wrong indentation: expected 4 but found 6 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/sound/mt8192-afe-pcm.example.dts:19:18: fatal error: dt-bindings/clock/mt8192-clk.h: No such file or directory
   19 |         #include <dt-bindings/clock/mt8192-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/sound/mt8192-afe-pcm.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1392703

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

