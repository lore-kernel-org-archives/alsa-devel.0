Return-Path: <SRS0=NKE9=43=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC856C10F27
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:51:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7212D20637
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jZF/dHFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7212D20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C78F11662;
	Tue, 10 Mar 2020 19:50:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C78F11662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583866302;
	bh=n+cyrf7lfGTbCHVUgVgAurLOC6uO4AK85qBrh6PLbJs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jZF/dHFg9N29SyHaGa8aMaBw+zFqXnLb3uncLVQe1EwJXJhObqLyERVkR0WPwF3il
	 DnnvJT50UjRRrbLtKItu0kXfe8/VwFApWavrmpwfnlfhAIaLMEktF6AdJu5z76XOxG
	 v6DSIJG2UjKE/bEXWXlEc/V+ZSxYKlQjYwJoIYqo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30594F8020C;
	Tue, 10 Mar 2020 19:50:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3EA26F80217; Tue, 10 Mar 2020 19:49:47 +0100 (CET)
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 739FFF800DA
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2020 19:48:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 739FFF800DA
Received: by mail-ot1-f67.google.com with SMTP id b3so14247544otp.4
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2020 11:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EzS4Ory16y/BLSb6no87Sernjs2m/cGxUWkwz4EtDSw=;
 b=Qx6m6SY4Sq43EaGH+NMXHSSuUSchZcgNRwxaYxSkE9QaM/WD6FCf+hf7gytKgesr34
 12sllq8njfidUPAA+ogTXangroRGmpf03IXAXI7BHtaA+zdzNpiiez0wRVTpkwEVAT0I
 tIbj8kK7X53m1TMgIoNmmu47fOB/3kKYX10NkLQsBDkES9o14lLgDUpoWuWtNMua7sIO
 sUAUTrLRwvVscdOp13mrmXbZ6lvgXP1FlnWZEGjmwl0mGXnGT+q4muAMDCsceX2VFPmS
 l0hUHtUSjtXc7Sp7dNL7Sa5bNcmO4xHKLZ104LXF2gUpLi849HxXT/npwLCCLygWhFP/
 HLgQ==
X-Gm-Message-State: ANhLgQ2C6ZyNxPuHM31JcUjDx4RSnvX0QnWjBhz0J7tdYnrRiEKKqnYu
 8sPDwXgmwqeH/98EqL/H+Q==
X-Google-Smtp-Source: ADFU+vsMU183YY5TJ9IDWm2qf6EIOH/EKHLHafJAiNQIT7jZ1BNW3xQAYT9kBEXnBN09EB1NU0f2WQ==
X-Received: by 2002:a9d:750d:: with SMTP id r13mr7271522otk.321.1583866126181; 
 Tue, 10 Mar 2020 11:48:46 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id a73sm2633320oib.16.2020.03.10.11.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 11:48:45 -0700 (PDT)
Received: (nullmailer pid 15229 invoked by uid 1000);
 Tue, 10 Mar 2020 18:48:44 -0000
Date: Tue, 10 Mar 2020 13:48:44 -0500
From: Rob Herring <robh@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] dt-bindings: sound: Convert cirrus, cs42l51 to json-schema
Message-ID: <20200310184844.GA15190@bogus>
References: <20200228152706.29749-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228152706.29749-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 olivier.moysan@st.com, Benjamin Gaignard <benjamin.gaignard@st.com>,
 lgirdwood@gmail.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 broonie@kernel.org
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

On Fri, 28 Feb 2020 16:27:06 +0100, Benjamin Gaignard wrote:
> Convert cirrus,cs42l51 to yaml format.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/sound/cirrus,cs42l51.yaml  | 69 ++++++++++++++++++++++
>  .../devicetree/bindings/sound/cs42l51.txt          | 33 -----------
>  2 files changed, 69 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/cs42l51.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
