Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15072C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Mar 2022 15:52:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2533218C8;
	Fri, 11 Mar 2022 16:51:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2533218C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647013962;
	bh=JmxFiE1YuRlulTG1wzs3sPPp3iEQ87GH49TOz5RZZkE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L5eFnaDSPorCKxm5MGnTHB2kxl9EYY4nTZIKN12T3CeH7BaclQZvahiwVAgyq1EWn
	 a/wzJujMcs2b9hbbqLH0RcmwFRwkqV+pjtBEdkOAg4gyqyJf1f+99J/z3QJ+ioZVbI
	 aEV9HdIZl9S5A2NUlWD6zkmtqUqgKimFr63HZfjU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B901BF8012C;
	Fri, 11 Mar 2022 16:51:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D8D5BF80227; Fri, 11 Mar 2022 16:51:50 +0100 (CET)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62AD4F800D2
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2022 16:51:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62AD4F800D2
Received: by mail-oi1-f181.google.com with SMTP id b188so9700559oia.13
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2022 07:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aFQmY8Q3Xcs50vqeMZuNuMuDo4MjkwmEEkUJ4NeBy6w=;
 b=IYk1t774s96ffONPke+OakjV3+Y2cDtN/TFNBz8bK4+zEKQn70rALogBOuJCT9YdA7
 JPoMdJpCBBwDseg4Gba+nZQuC+qYKalDf3dmJNZdR/tz0NIQ8sXmcStDc/BnWyKH7Y1F
 MCXLSwLg3INWsBlUN/gEg4ikRJ2d3msixHjulCVle9CsjV2Ue3pzalMZb0xYWw7lAvL3
 ivSvcCx1HxOp11lapXU1H9ybT9IskuTowYfQrNoghlycHQ5B71HhFOKAIM1VRoSDcXIV
 /khduKBD/yfgueHLRb4LSntoqcD/H5GECMsQodFUSSzty2J7YjhpsvO3L1hNU/u4BPoN
 +ZDA==
X-Gm-Message-State: AOAM5334AaqKSW4ipqGQPi37FjB1zEVAIXcuwTq43rKB+tP5GDmSD2AH
 ZFfSs8XLYPaF/IwHRwRpfg==
X-Google-Smtp-Source: ABdhPJxOckzuMfoeKLRh2uMhfA7547OHTQ+38S+0GQ+35G6dShSqk8U+eYRPpxG5WGYqgKkP1XXYIg==
X-Received: by 2002:a05:6808:218b:b0:2da:5fd1:a85b with SMTP id
 be11-20020a056808218b00b002da5fd1a85bmr5388120oib.71.1647013902733; 
 Fri, 11 Mar 2022 07:51:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 r21-20020a05683002f500b005b249ffa43fsm3856004ote.22.2022.03.11.07.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Mar 2022 07:51:42 -0800 (PST)
Received: (nullmailer pid 3868935 invoked by uid 1000);
 Fri, 11 Mar 2022 15:51:41 -0000
Date: Fri, 11 Mar 2022 09:51:41 -0600
From: Rob Herring <robh@kernel.org>
To: Steve Lee <steve.lee.analog@gmail.com>
Subject: Re: [V2 2/2] ASoC: dt-bindings: max98390: add reset gpio bindings
Message-ID: <YitwDaQcXUApGKW4@robh.at.kernel.org>
References: <20220311132906.32292-1-steve.lee.analog@gmail.com>
 <20220311132906.32292-2-steve.lee.analog@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311132906.32292-2-steve.lee.analog@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 ryans.lee@maximintegrated.com, broonie@kernel.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org
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

On Fri, 11 Mar 2022 22:29:06 +0900, Steve Lee wrote:
>  This adds support for the reset gpio binding.
> 
> Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/maxim,max98390.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
