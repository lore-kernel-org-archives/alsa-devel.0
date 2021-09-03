Return-Path: <SRS0=Q8D2=NZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1793EC433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 17:53:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E7A460F90
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 17:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E7A460F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89733184D;
	Fri,  3 Sep 2021 19:52:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89733184D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630691621;
	bh=6q4gBBBL4bqURUOOPGPlHuArKQV47E4ufh+H/em7U34=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FU7mf2nWJqeLSoGWeklmUoV6VX250jemeZWAfb/34Cldb1t9+o6hMH9R0/hfIB+A4
	 JuLZVuQpHiGCBh7/YttdfuJgkwguay3aoF6mVw0ZJrcQRlhuJpek4Zlz0snN2QXeyT
	 49dfIlushurOjAMwnzpuj5G1jKTow8FJUOSu+jdk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B5AEF80088;
	Fri,  3 Sep 2021 19:52:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4A529F80254; Fri,  3 Sep 2021 19:52:49 +0200 (CEST)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A83AF80088
 for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2021 19:52:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A83AF80088
Received: by mail-oi1-f174.google.com with SMTP id w144so121901oie.13
 for <alsa-devel@alsa-project.org>; Fri, 03 Sep 2021 10:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ab+TOfSW9tqy1GvA7+jr5WcKpyI0xKVbDiDjcxTGaRQ=;
 b=hvr1N7zPvAcTNiT+VBWMr8/+FSQEFFs7ux3MbCSxuMfnrjrF/2WS8JkW6JtlcPwfFJ
 9ejvVszEbFFggE6BpotnQu4Qse4n6PaDgMWxpB2aY8qcLadhxsrfaMdoCuOUrUfwzyAG
 dMKekVeko8MqLVnCK9vC71SmcGQNERvzzSVXb2vrz4XrOITUGrq5+zP3flfxBxC0JzmJ
 9g1tm4pRr7ZsWJRTRwXsrAzRL81JnvrGTmxhspqxNuwSQLBRj/7bdVzEwzXrHfG4gbqd
 js66BicwAuxIIGTvgubwsTo3mQBbvTQxCZoHJ+aU1BJX1brSOgLwDn2ubMaWpiPBtXlE
 GfPA==
X-Gm-Message-State: AOAM532ymp4VfWwynF7FfV1gH6kpP944zNPkJLpV9KLif2wqzszx4Zrj
 TgVgpVRAzZB74lNnoxKrNg==
X-Google-Smtp-Source: ABdhPJynHisMcXt6Cjq5kcgTxfZ0dwcJc53BrDE8xZsXZNGv8gvY6NKOhq8Gd/AL8RP/wVHKqERS+g==
X-Received: by 2002:a05:6808:494:: with SMTP id
 z20mr27434oid.103.1630691558782; 
 Fri, 03 Sep 2021 10:52:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id f25sm7895otp.2.2021.09.03.10.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 10:52:38 -0700 (PDT)
Received: (nullmailer pid 3166874 invoked by uid 1000);
 Fri, 03 Sep 2021 17:52:37 -0000
Date: Fri, 3 Sep 2021 12:52:37 -0500
From: Rob Herring <robh@kernel.org>
To: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v2 02/52] ASoC: dt-bindings: Convert Bluetooth SCO Link
 binding to a schema
Message-ID: <YTJg5eZqniTY3E4E@robh.at.kernel.org>
References: <20210901091852.479202-1-maxime@cerno.tech>
 <20210901091852.479202-3-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901091852.479202-3-maxime@cerno.tech>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Samuel Holland <samuel@sholland.org>, linux-sunxi@googlegroups.com,
 Liam Girdwood <lgirdwood@gmail.com>,
 Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
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

On Wed, 01 Sep 2021 11:18:02 +0200, Maxime Ripard wrote:
> Bluetooth SCO Link are supported by Linux with a matching device tree
> binding.
> 
> Now that we have the DT validation in place, let's convert the device
> tree bindings for that driver over to a YAML schema.
> 
> Cc: alsa-devel@alsa-project.org
> Cc: devicetree@vger.kernel.org
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> ---
> 
> Changes from v1:
>   - Accept either a 0 or 1 #sound-dai-cells
> ---
>  .../devicetree/bindings/sound/bt-sco.txt      | 13 -------
>  .../bindings/sound/linux,bt-sco.yaml          | 38 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 13 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/bt-sco.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/linux,bt-sco.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
