Return-Path: <SRS0=e91y=7R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF110C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2020 23:11:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C0D20663
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2020 23:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UGbMl8Va"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C0D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0BA8165D;
	Fri,  5 Jun 2020 01:10:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0BA8165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591312283;
	bh=Tx3hinUPkXeFvB43SWg1oFptpyIyCAQ+fOPi5bUG+vc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UGbMl8Vazy/0tbvM/riDUbFeBDS6nN0ZbFky2SdVAk7wvUiggaRdFVhY4XYG/+PSa
	 peD5VRGw3cqcaNshhPIx3PKo7m6N3RAyg9KFCnZqeoFvPiIrNjQUKVo3DjXJihDaKz
	 3NsgH+Vo4PYFuN0IO0xUYJ5+egjvlcb93vDGfXsk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A009BF8023F;
	Fri,  5 Jun 2020 01:10:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF05CF80254; Fri,  5 Jun 2020 01:10:27 +0200 (CEST)
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D6EFF8013C
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2020 01:10:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D6EFF8013C
Received: by mail-il1-f194.google.com with SMTP id a13so7785372ilh.3
 for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2020 16:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Q7WJQlBvPEBNqlkXqh4qqiqq6Tsxm/g6xj5WhRd10ss=;
 b=cDxkzFbDSjqR3H9IY5vO/Ebu/AKEsOaOU12S7IufCkL2p/gQNX3WXHnHpdLWFMeQO2
 FfYg0cJQHmZXq+XbOxZ52ltgo+ZyTgWW13A+rMa1J9Ft44kFBjXReYekgbS4yr9gfd80
 65HVX9iBF+glztM6k8YslKI4JoYoPE4oaejXWtlv8FDX+2jqHBSfBMIQRIZ6ZYhnIUwK
 YU5t908O84ijwXFeFF3dHRrYBSqJqu4rbYjV/C8gCa+FaKVmKEVxZZY2ia+U9I0b+CR/
 adtTnD2uYR23dP2tWBTNzxJT2yq4eQAavIg9Kp/rFmtc62ruf09TdIu/aqhmZSw5zMFb
 ejaw==
X-Gm-Message-State: AOAM531W2J9de5LU0EhntY38psGgxihthoBPCi7Y/D9/GHfLcoaPq3Aj
 69vj48OETg5RT2cdi8qkrg==
X-Google-Smtp-Source: ABdhPJxhRoC5EOIby2CxjIhKZV+cKt0e7Y/t4WAVSnQAJtSBXYT9d9Kfk+hw4tsTbwWNT980FXxeZw==
X-Received: by 2002:a92:c101:: with SMTP id p1mr6258008ile.239.1591312216303; 
 Thu, 04 Jun 2020 16:10:16 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
 by smtp.gmail.com with ESMTPSA id 199sm2162773ilb.11.2020.06.04.16.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 16:10:15 -0700 (PDT)
Received: (nullmailer pid 20793 invoked by uid 1000);
 Thu, 04 Jun 2020 23:10:14 -0000
Date: Thu, 4 Jun 2020 17:10:14 -0600
From: Rob Herring <robh@kernel.org>
To: Steve Lee <steves.lee@maximintegrated.com>
Subject: Re: [V7 PATCH] dt-bindings: Added device tree binding for max98390
Message-ID: <20200604231014.GA20757@bogus>
References: <20200602084337.22116-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602084337.22116-1-steves.lee@maximintegrated.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com,
 steves.lee.maxim@gmail.com, broonie@kernel.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org
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

On Tue, 02 Jun 2020 17:43:37 +0900, Steve Lee wrote:
> Add DT binding of max98390 amplifier driver.
> 
> Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
> ---
> 
> Changed since V6:
> 	* Re-confirm yaml dt binding check
> 	* Add minimum and maximum value for each temperature_calib and r0_calib
> 	* Add maxim prefix for naming.
> Changed since V5:
> 	* Change txt to yaml and fix up the examples.
> Changed since V4:
> 	* No changes.
> Changed since V3:
> 	* No changes.
> Changed since V2:
> 	* No changes.
> Changed since V1:
> 	* Modified sample text in example
> 
>  .../bindings/sound/maxim,max98390.yaml        | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
