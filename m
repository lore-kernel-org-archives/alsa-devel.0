Return-Path: <SRS0=2x8D=I4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8158C433C1
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 22:46:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DD5619D3
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 22:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DD5619D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E04D71675;
	Wed, 31 Mar 2021 00:46:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E04D71675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617144412;
	bh=w9ngSkZzR/unWq3zDaMRN4ju1djyeL734dg46zLhd2g=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gEGrjdA4gaKN8i/vvOU56nMc/oQkcnS1jSRMELxALGywL0kKVQPJQ5A2VEJRL6Cm8
	 0jdIVDshplf5jFRcG8DheeMbQYDyLe1QJBcEqtpo8eRL3K+rVWL6B+l1sh2xb8Dtt4
	 8wH+ZKOaqAaw3Ov4N5onXBnz7eBd2NBdpVOtMA3U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 722B4F8023E;
	Wed, 31 Mar 2021 00:46:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8418DF80240; Wed, 31 Mar 2021 00:45:59 +0200 (CEST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86B9CF800B9
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 00:45:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86B9CF800B9
Received: by mail-oi1-f181.google.com with SMTP id m13so18066242oiw.13
 for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2021 15:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cLGY/U77bjaTReaj2IIARZWRCCbRNc7FTLFruMbM/vg=;
 b=DZtrRNnhDeRQ00mzrQQUgFnwpp05b9l6mbdH+LSwsBUSiubHEaNpA9hNFOwjetV008
 p+39ZjoZgyiXxTQf9BSCC+dTifFtgTAVXaWCsvryYCKQdZyfKb6/YJkSAuLX1S186h5k
 oOovxwNiNvEBLeJQLnOE2UGDQLEuFwtHUCL05F47mkJHcggIVY5rrUSxqW1h/CP0ofdd
 5JNT+T/XYHx0yeFNDNxjeOseTsiYTYNlAFoaOOhXrn/XQuozOFaWF29l+1ybb4L/Rj5Y
 C64ypt2WOnCqWfyZDCpnNoFdp4Kta4GWYZ9XgmweXveF0008rRgBFNLx7fzm0xM08IUV
 MLDQ==
X-Gm-Message-State: AOAM5324i0psr2K7S4VnLWiRTKCLMGFGbnooO3QmQ925SXlZHhPxtVvn
 qf3ot7SF0/VyQGGVye8RzQ==
X-Google-Smtp-Source: ABdhPJwEBrY+z1c9H+Ydo5wbfdprtBqSKqvER/L2vbgFu9N7KHmRm7qB+S0Adse53LXloREJLLHdAw==
X-Received: by 2002:a54:4492:: with SMTP id v18mr141539oiv.49.1617144353522;
 Tue, 30 Mar 2021 15:45:53 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s193sm79142oih.52.2021.03.30.15.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Mar 2021 15:45:52 -0700 (PDT)
Received: (nullmailer pid 850891 invoked by uid 1000);
 Tue, 30 Mar 2021 22:45:51 -0000
Date: Tue, 30 Mar 2021 17:45:51 -0500
From: Rob Herring <robh@kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: renesas, rsnd: Clear warning
 'dais' is a required property
Message-ID: <20210330224551.GA842101@robh.at.kernel.org>
References: <20210330030631.2253-1-thunder.leizhen@huawei.com>
 <20210330030631.2253-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330030631.2253-2-thunder.leizhen@huawei.com>
Cc: devicetree <devicetree@vger.kernel.org>,
 alsa-devel <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
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

On Tue, Mar 30, 2021 at 11:06:30AM +0800, Zhen Lei wrote:
> When I do dt_binding_check, below warning is reported:
> Documentation/devicetree/bindings/sound/renesas,rsnd.example.dt.yaml: \
> sound@ec500000: 'dais' is a required property
> 
> I looked at all the dts files in the "arch/arm64/boot/dts/renesas/"
> directory, I found that all nodes that contain the "dais" property have
> compatible string: "audio-graph-card". So I can be sure that the
> "$ref: audio-graph.yaml#" should be corrected to
> "$ref: audio-graph-card.yaml#".
> 
> In addition, not all nodes have compatible string "audio-graph-card", so
> the "$ref: audio-graph-card.yaml#" should be described as "anyOf". To
> ensure the validation of "anyOf" always passes, group it with the "if"
> statement, because the result of the "if" statement is always not empty.

'anyOf' is probably not right here.

In any case, the is going to conflict with my series[1].

Rob

[1] https://lore.kernel.org/r/20210323163634.877511-1-robh@kernel.org/
