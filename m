Return-Path: <SRS0=QusE=P7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED00AC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Nov 2021 21:59:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC95361073
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Nov 2021 21:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC95361073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FAC51662;
	Fri, 12 Nov 2021 22:58:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FAC51662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636754342;
	bh=EXFypx1hkx6XL2zsAx5VflkzExtSLUPuEBzP676xfp4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iA3i0mgbu8uvD+6FDbIF14iheF0gW3Eu/zNOMMa0S8W/jqbPZSQIDeTtaa7NzFrAL
	 T7FXVjALRjbbRL4XRdAMPInQn9MBFDXsYW2J6TWzW8aOnS4EnJ6NcmZd69FFAefVV/
	 CyghJdMA5TZ1BjUj66BfV0Li4nwca+MvFvWlAryQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 082BEF80227;
	Fri, 12 Nov 2021 22:58:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7703F8049E; Fri, 12 Nov 2021 22:58:10 +0100 (CET)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87248F8014D
 for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2021 22:57:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87248F8014D
Received: by mail-oi1-f169.google.com with SMTP id r26so20421863oiw.5
 for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2021 13:57:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xccSVfJVrdrr8KimAN3EMNzjL3fPcR3SofzIz95+CP4=;
 b=C0NBO4nvap/1OxZNUnPWANImLWMaY1eGUAXeVn+SQAASu+S8qp2GVLsQRmSke/ZyQJ
 +HIaLxJlHbV9bTs0kiJ4JYx3Gn7Zfq8eM2tDdpzbDiBeteG/SRW0dEgdbKcLNA44fWL/
 g5GJfeQGiioH2f9R8TzoSY5ywAxMy/UIDu/tQHWfK9vM+5iE/9CzHmGbHjBpNIwTXsl5
 fC1GfwW5Lq2bukeThhd0WyMFieT5PCqXlclFEiNH49H0F7swuKA8L5ny9Pff1PuRM8bC
 UAYwhalGZvItkd5n27E5OPWPx+jj7RjNJkZX3yO4QO8mHk+73HsGN7/UdJejJTe8kenl
 x0yA==
X-Gm-Message-State: AOAM531i4XwOD6AOXZTCeU5BYGddJgO/m44w/Pduej+RqUhRMDA5KS/m
 oPMg6dC7XV/TkG/mUN5keA==
X-Google-Smtp-Source: ABdhPJzXH2uXtlwTPVV2Dnd3/REyaabvQJmrcCmiIDT4uAxXHmANZrjgTnOCq8iJBXTHbKI27bKF8A==
X-Received: by 2002:a05:6808:179d:: with SMTP id
 bg29mr28294193oib.138.1636754277332; 
 Fri, 12 Nov 2021 13:57:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id k14sm1442785otb.50.2021.11.12.13.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Nov 2021 13:57:56 -0800 (PST)
Received: (nullmailer pid 3444888 invoked by uid 1000);
 Fri, 12 Nov 2021 21:57:55 -0000
Date: Fri, 12 Nov 2021 15:57:55 -0600
From: Rob Herring <robh@kernel.org>
To: Ricard Wanderlof <ricardw@axis.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: sound: tlv320adc3xxx: New codec driver
Message-ID: <YY7jY9+0n1RzdZ/1@robh.at.kernel.org>
References: <alpine.DEB.2.21.2111041421580.31205@lnxricardw1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2111041421580.31205@lnxricardw1.se.axis.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 alsa-devel <alsa-devel@alsa-project.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
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

On Thu, 04 Nov 2021 14:25:31 +0100, Ricard Wanderlof wrote:
> 
> DT bindings for tlv320adc3xxx driver, currently supporting
> Texas Instruments TLV320ADC3001 and TLV320ADC3101 audio ADCs.
> 
> Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
> ---
>  .../bindings/sound/ti,tlv320adc3xxx.yaml      | 137 ++++++++++++++++++
>  include/dt-bindings/sound/tlv320adc3xxx.h     |  28 ++++
>  2 files changed, 165 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,tlv320adc3xxx.yaml
>  create mode 100644 include/dt-bindings/sound/tlv320adc3xxx.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
