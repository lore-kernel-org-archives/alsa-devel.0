Return-Path: <SRS0=lB/p=BW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364C0C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:33:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B016C20774
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gt085z3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B016C20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 24DA3827;
	Thu, 13 Aug 2020 00:32:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 24DA3827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597271624;
	bh=mTjUUM/oSxvaCRaJl1Rg92NHjdmJdP6a7PRy99FvGhk=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gt085z3hzJzhxL4ZS2NAaeETXeMn9YI+yez2WEHd/o0xav/yiy2sHHKGjMKcg7vVs
	 oUJu97ohXtVioaOqi7tCb6qiA+Shz8/QgcyBDWUEKnK8TeZieCoOV/ftoPAChoYm8B
	 oRTh9rUiDpzxDwXmjlRIQGe6YwHeGWZV1fLJWWNk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F7A0F801DB;
	Thu, 13 Aug 2020 00:32:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18953F8022B; Thu, 13 Aug 2020 00:32:51 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0244.hostedemail.com
 [216.40.44.244])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0A4CF80147
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 00:32:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0A4CF80147
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id C315D100E7B65;
 Wed, 12 Aug 2020 22:32:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: board29_4d052b526fef
X-Filterd-Recvd-Size: 2655
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf16.hostedemail.com (Postfix) with ESMTPA;
 Wed, 12 Aug 2020 22:32:33 +0000 (UTC)
Message-ID: <f5dedf2d8d8057de3eaa2f9126f44cebb0653b09.camel@perches.com>
Subject: Re: [PATCH] dt-bindings: Whitespace clean-ups in schema files
From: Joe Perches <joe@perches.com>
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Date: Wed, 12 Aug 2020 15:32:32 -0700
In-Reply-To: <20200812203618.2656699-1-robh@kernel.org>
References: <20200812203618.2656699-1-robh@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
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

On Wed, 2020-08-12 at 14:36 -0600, Rob Herring wrote:
> Clean-up incorrect indentation, extra spaces, long lines, and missing
> EOF newline in schema files. Most of the clean-ups are for list
> indentation which should always be 2 spaces more than the preceding
                                     ^
> keyword.
[]
> diff --git a/Documentation/devicetree/bindings/arm/arm,integrator.yaml b/Documentation/devicetree/bindings/arm/arm,integrator.yaml
> index 192ded470e32..f0daf990e077 100644
> --- a/Documentation/devicetree/bindings/arm/arm,integrator.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,integrator.yaml
> @@ -67,9 +67,9 @@ patternProperties:
>        compatible:
>          items:
>            - enum:
> -            - arm,integrator-ap-syscon
> -            - arm,integrator-cp-syscon
> -            - arm,integrator-sp-syscon
> +              - arm,integrator-ap-syscon
> +              - arm,integrator-cp-syscon
> +              - arm,integrator-sp-syscon

Confused a bit here.
          - enum:
	10 spaces to dash
old line:
            - arm,integrator-ap-syscon
	12 spaces to dash
new line:
              - arm,integrator-ap-syscon
	14 spaces to dash

Is it supposed to be 2 spaces more than the preceding line
or 4 more?


