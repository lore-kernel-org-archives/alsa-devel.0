Return-Path: <SRS0=GrjN=62=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6660CA90AF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 16:39:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B87206CC
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 16:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c3OcvAE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B87206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C56116B0;
	Tue, 12 May 2020 18:38:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C56116B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589301557;
	bh=cphcUYST00oaRsfCQHAkJjxh25yMpbNWhWOsledJB8Q=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c3OcvAE6WUOLnbTUWnny8/Oje7u0SVq/y18ylCGGQ+fPaT1H9CLwlWmrXzCkGNRp8
	 X7G4MOxICVHRNjE2+Pp5n520oPX7TO3h0IZQu0G/uf63ALguJ+0iBMG0gl9gHx3uM5
	 f0dPJ3gp/TY/9CCHZfO7Ap4iNWxYvc6yhlAxCtCc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EBCD2F800E3;
	Tue, 12 May 2020 18:38:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B3431F8014C; Tue, 12 May 2020 18:38:23 +0200 (CEST)
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75595F800B7
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2020 18:38:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75595F800B7
Received: by mail-oi1-f196.google.com with SMTP id r66so18783247oie.5
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2020 09:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KeYFuchHUV4oG06etMyeWZGVdFDkZmCFlBwg/KVFhKU=;
 b=d2nIOTp7JugQqSuI83I1YPneV5lOsKFxZoCCy/5Dp286CAHQC6Vx1/cBj0s0qQqLSP
 NL/dkHaGO7YgEbzkVcskdK07GX6EIyDXPx36xuVheq8DuC5k5eM8xu2jEbLV+4uulbR9
 YkJi9pIYTlBR7JDDmPOVyX7zjZScdmY24NeKShdGD6duODP/3a1+DbcCmZcchVQqMvz8
 JKodICuU4fp+WSibdX+pt9MZ08uE0Yh9r1PTUDDhtP87iJW27SZ6orzNHI2Avhraba79
 mzFuFEFlGgqepwmvXesQSY55T677CI1QO8M3w77JU0D0Vl8ru/2gkaPpULdtvHaYvcIt
 8rBw==
X-Gm-Message-State: AGi0Pubp+z4kPHjjR9aTpRh6x1YYL/sK3gkyzwkL12Llj0QahApvnWrP
 kgEiNQLWBwp6LFOJfsu/ew==
X-Google-Smtp-Source: APiQypKIND1xo73jiriB4lL8f7Yv7R7T6ZKHMlotm4ARjozaBncOmDZy+ZFpBOhARLLZciwC/lXy8A==
X-Received: by 2002:aca:3cc6:: with SMTP id
 j189mr20111395oia.137.1589301494954; 
 Tue, 12 May 2020 09:38:14 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 34sm144510otq.67.2020.05.12.09.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:38:14 -0700 (PDT)
Received: (nullmailer pid 12285 invoked by uid 1000);
 Tue, 12 May 2020 16:38:13 -0000
Date: Tue, 12 May 2020 11:38:13 -0500
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_esai: Add new compatible string for imx8qm
Message-ID: <20200512163813.GA12151@bogus>
References: <cover.1588320655.git.shengjiu.wang@nxp.com>
 <307a82c80c27b807165e1f532dd9aecbad9b2eae.1588320656.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <307a82c80c27b807165e1f532dd9aecbad9b2eae.1588320656.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, timur@kernel.org,
 Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, lgirdwood@gmail.com, robh+dt@kernel.org,
 tiwai@suse.com, nicoleotsuka@gmail.com, broonie@kernel.org, festevam@gmail.com
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

On Fri,  1 May 2020 16:12:06 +0800, Shengjiu Wang wrote:
> Add new compatible string "fsl,imx8qm-esai" in the binding document.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,esai.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
