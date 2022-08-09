Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DFDC19F2D
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Aug 2022 20:16:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5439A829;
	Tue,  9 Aug 2022 22:16:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5439A829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660076210;
	bh=wJYlbFOkJJwTgMFJ+I52i56gXBHw0Vqwm9QnnRZ6AYU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VUZFDZ3Lc6a/HXJ548UKomJNItno0jR4/ZY6BJZ6AvAXSX8/1fJ8y3btgIwE3qe04
	 eFR684fQDYvKzzfH9VPCf3qS7LDKC7SYmlfZMkyrFDDhVF26cJNSH8SCT3iR23zp6a
	 YGsF2XluuLFkBj8VXthKHYocVMzJwci20MLzJ/Qc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DBDADF80132;
	Tue,  9 Aug 2022 22:15:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7E9DF8016C; Tue,  9 Aug 2022 22:15:56 +0200 (CEST)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com
 [209.85.166.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7BE56F80132
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2022 22:15:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7BE56F80132
Received: by mail-io1-f49.google.com with SMTP id l24so10496592ion.13
 for <alsa-devel@alsa-project.org>; Tue, 09 Aug 2022 13:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=P6nva6fF4oucGEQzdC/pymMNLM5179tf7HGPx3y8Hyc=;
 b=R26KMfd0L3U2zVXRo8mVDQHSP/yepZQFBC2XVmBmj9cwKzUwoXejZxZ/dM3zEP7yci
 1Xy+HolP9E0CJW9zaFrjQvvrqD4oDd1+NHmd0mfnHhnx71shekVuhB7oB7hnCzF4G9Jo
 cc3IU73vO00N7BsoNZWfgl5VdxgW2SmlVAmeAMztLwGc5G38lsZHL2fi1uJTg94XGqEr
 kypxrMNGr5cFvhjobZTVB8iRdvnUOwxeH2JZej1TAMP+RmUZmSqqWpYKbqb3Ck6/qKBi
 jO9YEzvx0I2pEKgcf89aPUCy2qYsX8zeJ96Wk8DXEoUGTjiSWu3Wr7tZCIL9gQ2/hQRY
 WOlg==
X-Gm-Message-State: ACgBeo3vTvgZpgRGgj+EBQwQavN/o3gngxj6TvLnmOdX0hzmbuhSxcbX
 m1+ypk/B7b4/P13ttLHTnw==
X-Google-Smtp-Source: AA6agR4NKtP/OF5xrXLLg3UNZO4muwOsD9ToaP+gwyexb1NzV6xUl19KqXN5MxSKBjLT4fP4zW+grQ==
X-Received: by 2002:a05:6638:144a:b0:343:2464:d030 with SMTP id
 l10-20020a056638144a00b003432464d030mr3269144jad.89.1660076148592; 
 Tue, 09 Aug 2022 13:15:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id
 w76-20020a022a4f000000b00342d85cde45sm4762488jaw.120.2022.08.09.13.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 13:15:47 -0700 (PDT)
Received: (nullmailer pid 2319487 invoked by uid 1000);
 Tue, 09 Aug 2022 20:15:44 -0000
Date: Tue, 9 Aug 2022 14:15:44 -0600
From: Rob Herring <robh@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH v3 2/3] ASoC: dt-bindings: Add sample format conversion
Message-ID: <20220809201544.GA2319453-robh@kernel.org>
References: <1659936452-2254-1-git-send-email-spujar@nvidia.com>
 <1659936452-2254-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659936452-2254-3-git-send-email-spujar@nvidia.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, tiwai@suse.com, lgirdwood@gmail.com,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org,
 krzysztof.kozlowski+dt@linaro.org
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

On Mon, 08 Aug 2022 10:57:31 +0530, Sameer Pujar wrote:
> Presently "convert-channels" and "convert-rate" DT bindings are available
> for channel and rate fixups respectively.
> 
> Similarly add "convert-sample-format" binding to fixup DAI sample format
> as well. This is added to audio-graph-card based bindings.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  Documentation/devicetree/bindings/sound/audio-graph-port.yaml |  4 ++++
>  Documentation/devicetree/bindings/sound/audio-graph.yaml      |  2 ++
>  Documentation/devicetree/bindings/sound/dai-params.yaml       | 10 ++++++++++
>  3 files changed, 16 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
