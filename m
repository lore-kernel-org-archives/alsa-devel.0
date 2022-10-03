Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43053C4332F
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Oct 2022 16:21:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A00C183E;
	Mon,  3 Oct 2022 18:20:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A00C183E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664814106;
	bh=nYZ3OPwym3/lCLl802gVWM/RZFxDegAll462MzFd8Hs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GE+mtqS9Wo7GUupTx6WPU126J5WalBGIzP16XHbDAPXZPp9quZ929TqTzhAqAHwJO
	 4zlqxG0wpOmrKmeiqk+TgQRR5tkx/DTdXkoeSbxWFq/2pWyZ7wqnOvkQJnM11suavQ
	 my0OhK7y2kCMnpkjZTfJV6ohjJNbIeqQbWRg4wUQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96EEFF80224;
	Mon,  3 Oct 2022 18:20:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 436A6F80269; Mon,  3 Oct 2022 18:20:54 +0200 (CEST)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E5B9F800CC
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2022 18:20:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E5B9F800CC
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-1327ba38599so2838006fac.11
 for <alsa-devel@alsa-project.org>; Mon, 03 Oct 2022 09:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=SrQIQIx2drceX3SN+9GboVD+7L3gb+zcudmTPkuxG4o=;
 b=5hCdOrlaj/7RoX8jTQmZDLJDTE1F5RnVja/tsTqdyY6UPe0dH+jgI1N+i4Rd53U4oB
 8QjyqY9a/nwYFe0fYmp20xcOKvGzNOsAqMdeb5zffl7NaASOse0pmzap3sExuAG3fj/Z
 hw/W8APJ2QKyj34csrAFSMBsvCX0/2HPVr0JMBw4LWGTA0Tw1vFDTYt+OxErnvOwHUxC
 aEn1hCkVRa/oavKduRu6Fzprgc1QClvu+ULkjgraonPnViS244Kfbr6CZPx+uQ0BKA8U
 ENbEN+7qfUG9ldEbIaJ2D6NSt1bALzswpX7U2eApLyYHyl+2S/HeoWxFkWBVRIOumnxH
 da8A==
X-Gm-Message-State: ACrzQf1zFwvsj+6Unq84r4xItJIo46ABF5XA9A1UEPZurBpI978yAEzy
 +LCCQGgd9H+55Vshc3oEeg==
X-Google-Smtp-Source: AMsMyM6cKgji6ciyhbfcp4feIvszGehOxAdPhv6e9KCbMI8b2WBWiPgQvBwA1TqrxbMdcC2DrtjgNg==
X-Received: by 2002:a05:6870:f60e:b0:131:b7cc:f994 with SMTP id
 ek14-20020a056870f60e00b00131b7ccf994mr5798922oab.113.1664814046016; 
 Mon, 03 Oct 2022 09:20:46 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 u17-20020a4ac991000000b00435a8024bc1sm2146879ooq.4.2022.10.03.09.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Oct 2022 09:20:45 -0700 (PDT)
Received: (nullmailer pid 2402827 invoked by uid 1000);
 Mon, 03 Oct 2022 16:20:44 -0000
Date: Mon, 3 Oct 2022 11:20:44 -0500
From: Rob Herring <robh@kernel.org>
To: Chancel Liu <chancel.liu@nxp.com>
Subject: Re: [PATCH v3 1/7] ASoC: dt-bindings: fsl_rpmsg: Add a property to
 assign the rpmsg channel
Message-ID: <166481404372.2402771.4568296878254068845.robh@kernel.org>
References: <20220930064441.2548505-1-chancel.liu@nxp.com>
 <20220930064441.2548505-2-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930064441.2548505-2-chancel.liu@nxp.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, Xiubo.Lee@gmail.com, shengjiu.wang@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, tiwai@suse.com, nicoleotsuka@gmail.com, broonie@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com
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

On Fri, 30 Sep 2022 14:44:35 +0800, Chancel Liu wrote:
> Add a string property to assign the rpmsg channel this sound card sits
> on. This property can be omitted if there is only one sound card and it
> sits on "rpmsg-audio-channel".
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,rpmsg.yaml  | 36 +++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
