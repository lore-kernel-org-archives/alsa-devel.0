Return-Path: <SRS0=lo3o=NO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C24C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 20:12:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA9B613D0
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 20:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4EA9B613D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00FD7820;
	Mon, 23 Aug 2021 22:11:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00FD7820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629749566;
	bh=ljr62TYUHmK745y9SWqYmbAm0F4qGEjnQPHguXF/vIA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o5BBVHq7qUaHwX2PJB/Ooj9aypEbjqPCaDzOps0qA3n+hy0HoVih0kOjtr06DUArN
	 6jo82vquQC2BfmbBMVrzmWlOpeaB8b8KpM2COxxZR+jNJ/v91JdOqFfxlEFGTpOUb1
	 /Xkt/dW66e2yK5qzGG88FbwhbGWx4rGbGz4A/8iQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 81925F8016E;
	Mon, 23 Aug 2021 22:11:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A66DF8020C; Mon, 23 Aug 2021 22:11:54 +0200 (CEST)
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com
 [91.221.196.215])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B9A7F800E7
 for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2021 22:11:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B9A7F800E7
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
 by mx1.smtp.larsendata.com (Halon) with ESMTPS
 id 50d88782-044e-11ec-b37b-0050568c148b;
 Mon, 23 Aug 2021 20:11:35 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net
 [80.162.45.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: sam@ravnborg.org)
 by mail01.mxhotel.dk (Postfix) with ESMTPSA id 3A061194B3E;
 Mon, 23 Aug 2021 22:11:58 +0200 (CEST)
Date: Mon, 23 Aug 2021 22:11:42 +0200
X-Report-Abuse-To: abuse@mxhotel.dk
From: Sam Ravnborg <sam@ravnborg.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 1/2] dt-bindings: panel: ili9341: correct indentation
Message-ID: <YSQA/iR6D/Ej1kWx@ravnborg.org>
References: <20210819101020.26368-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819101020.26368-1-krzysztof.kozlowski@canonical.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 David Airlie <airlied@linux.ie>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>,
 Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Dillon Min <dillon.minfei@gmail.com>
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

On Thu, Aug 19, 2021 at 12:10:19PM +0200, Krzysztof Kozlowski wrote:
> Correct indentation warning:
>   ilitek,ili9341.yaml:25:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Thanks, applied to drm-misc-next, and the patch will show up in -next in
one to two weeks.

	Sam
