Return-Path: <SRS0=h1r5=K4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD07C47083
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 19:50:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD43613E9
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 19:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD43613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7341E16E5;
	Wed,  2 Jun 2021 21:49:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7341E16E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622663398;
	bh=nJTILRhzdd8HidEXNoS7/DBkZd4QJUpJwcayMhtxiJ4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZNVeb2t13iXuSxLOZgEJRvB07TovdWPcoCgllyah0KZzmzFtLSsvpJDQlmF+6/OV2
	 Z8ZERdhfdd4ZdEkULJMc3WmHFNt4y+H5w8/NgY6cChQnn6NfW/9gPXIkW8IzuNlQ/M
	 kY2b9Tjtl9xrU77kvyOvF3Fu+G6bWh8yZMaJozqY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 05D14F802A9;
	Wed,  2 Jun 2021 21:49:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3E6AAF80424; Wed,  2 Jun 2021 21:49:07 +0200 (CEST)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47619F80273
 for <alsa-devel@alsa-project.org>; Wed,  2 Jun 2021 21:49:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47619F80273
Received: by mail-oi1-f179.google.com with SMTP id h9so3833277oih.4
 for <alsa-devel@alsa-project.org>; Wed, 02 Jun 2021 12:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jtV1ThCtM7t5bRqErtDMzcqKoHDyAJSDa1BT0RCscz0=;
 b=ZqK2q8JsYc/1qVdDva+f4V0K9skWthV3Jg8Y/BZH6lIag5g70+xk4VKGjYwvjFam0t
 IZKPr6Vx4ABJedQ3I7X+EwVpp6kqNVU+vfk/9xv5yDmNKXHzveae4AeFBy1a/j8uaGjx
 EdwUv1/tYWugmjwIwFHjWH3fHVMMFlr1rfDcdWoRtf2PN42Yo6VzhwpgEmBvUDhule0v
 +I1aU5cOQwhlmQqy79iGff2whr3kqrK06zdNyM6Js+jdYk78DyfzlW+EWvrMz4mC0X5T
 bSStBUijkNQgHa3P8AAKA9bS8Ld+j7bIVzFnvbRZPqW71my10rcyw+MBiQCZDLGm8Ede
 A1Yw==
X-Gm-Message-State: AOAM533LtEb3Vqb14pobNb+W1PfL01PeGqD++vqsW+YL5j35T14QmqLR
 7deLLUPL7JBcslT8jIS+tQ==
X-Google-Smtp-Source: ABdhPJz/oLI4K1/9AxZkHckLFH5qLUyGTkbUyEG9RqzfzQ4n8Q2R5Uu6t5AsQVEeCrA2+xnWW9JlLA==
X-Received: by 2002:a05:6808:6:: with SMTP id u6mr4935800oic.80.1622663339562; 
 Wed, 02 Jun 2021 12:48:59 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id a14sm180880otl.52.2021.06.02.12.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 12:48:58 -0700 (PDT)
Received: (nullmailer pid 3869918 invoked by uid 1000);
 Wed, 02 Jun 2021 19:48:58 -0000
Date: Wed, 2 Jun 2021 14:48:58 -0500
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 1/4] ASoC: dt-bindings: wcd934x: add bindings for
 Headset Button detection
Message-ID: <20210602194858.GA3869855@robh.at.kernel.org>
References: <20210524110700.27077-1-srinivas.kandagatla@linaro.org>
 <20210524110700.27077-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524110700.27077-2-srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org
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

On Mon, 24 May 2021 12:06:57 +0100, Srinivas Kandagatla wrote:
> Add bindings required for Multi Button Headset detection.
> WCD934x support Headsets with upto 8 buttons including, impedance measurement
> on both L/R Headset speakers and cross connection detection.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wcd934x.yaml          | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
