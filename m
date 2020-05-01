Return-Path: <SRS0=J9ZO=6P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC95AC35280
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 20:15:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549832166E
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 20:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dmg+rvg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549832166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A702C168C;
	Fri,  1 May 2020 22:14:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A702C168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588364106;
	bh=TevFkjb5rNexzQ+5edWV1jKKHFVOqDomhs7zDWXFj/s=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dmg+rvg2czyaet4wnJcZD0tibxxQr/drDVWP5S6FdbukAxORZWgv5UL7FXKz5HAY/
	 SMd1Pbopi8byTDhRPMgHKDjm4DZPW3/Fh2tqBJj4cGxIN5I8fJ4nFSdM12iP6U8fYO
	 BOO1SM+jq2ReB18vwXN3xd75PckmsRI00vrmXnkU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24A70F800B6;
	Fri,  1 May 2020 22:14:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E588F8022B; Fri,  1 May 2020 22:14:14 +0200 (CEST)
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E999FF800E5
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2020 22:14:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E999FF800E5
Received: by mail-ot1-f67.google.com with SMTP id g14so3470634otg.10
 for <alsa-devel@alsa-project.org>; Fri, 01 May 2020 13:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2xG6LfTRRj7zxxC5OOjRbiExVAKfImflfttUoxbE6Wk=;
 b=C0RrA5lYGm6FTmxiheoTNrrOYoPYA1ff79QAKKE3uZ2bT14F+RI7BTYDrMYMG1mLxC
 wbcD74S6NKD8WpJSQM7zubM/o+uZhhPoowwTTc32Yg3xuJ0wY2HN9EaIutLwQB4/9reO
 RXgcm2Z+uqdq8UcdaYNMVvpGvWyoO0pUx1LXsGnuKqd4lcS27rApU5aSsq0TnaJi4ffC
 tCvVYepK4KfiWZEeYrUnokKjWiXpsK/2PCXqI6W5yguFirKspy9VHn5Unz/0u7pOicJV
 kYhAbcaFKsoJKSTjVD/htnKpOmhy+ae3mCM8Q6agZDKAauqnzUWDQr+dXm06G0CNdNa2
 YheQ==
X-Gm-Message-State: AGi0Pub4eR+Hy5h/Endpi4rrEB1RSAHIsxv9iqY8t+cGQkcHDjAomsPl
 eQtTK2+06IXfmREB7I8hjA==
X-Google-Smtp-Source: APiQypK5652+F+YPF+Qn5GQulTJDVC1+CGSNJ8JQC4ySwrNbIYJVtWlnY9BlUtvjDv0XE2FcIET1+g==
X-Received: by 2002:a9d:6e3:: with SMTP id 90mr5124784otx.261.1588364044458;
 Fri, 01 May 2020 13:14:04 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id d61sm1065978otb.58.2020.05.01.13.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 13:14:03 -0700 (PDT)
Received: (nullmailer pid 26942 invoked by uid 1000);
 Fri, 01 May 2020 20:14:02 -0000
Date: Fri, 1 May 2020 15:14:02 -0500
From: Rob Herring <robh@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: dt-bindings: audio-graph-card: switch to yaml base
 Documentation
Message-ID: <20200501201402.GA8603@bogus>
References: <87ftcxv2lk.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftcxv2lk.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
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

On Tue, Apr 21, 2020 at 02:18:15PM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch switches from .txt base to .yaml base Document.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../bindings/sound/audio-graph-card.txt       | 337 --------------
>  .../bindings/sound/audio-graph-card.yaml      | 416 ++++++++++++++++++
>  2 files changed, 416 insertions(+), 337 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/audio-graph-card.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/audio-graph-card.yaml

This needs to be a series, so they are applied together and don't break 
the tools if only the ak4613 patch is applied.

As mentioned in the other patch, I think this needs to be broken up to 
multiple schemas and avoid definitions.

I'd really like to see either simple-card deprecated to use the 
graph-card or drop the 'simple-card,' prefix to align the property 
names.

Rob
