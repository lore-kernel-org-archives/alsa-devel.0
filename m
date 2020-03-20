Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44A8C4332D
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:33:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2A520722
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ul9UXhZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2A520722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F5DE3E;
	Fri, 20 Mar 2020 18:32:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F5DE3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584725596;
	bh=WsjgjMc5V84hg2ru5hJzn4ARjRe9A0ITrIl/CNrlPLg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ul9UXhZkQcE8Y8MKcXmB99b5Rx7S0Mb4KdOy/ETROMs92WjeLdWBSTEhXuj5DPSUX
	 i6HY5+JfNcBWtVRohtdRAKDPTjD20qHbWh21+8gS/ywWxkxSMNAKRV1SExBTMwfDWe
	 viMfEX91rqwPoNVI4INgKQv65pKDbmhfMLk7Y+/w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C58B9F80139;
	Fri, 20 Mar 2020 18:32:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F63EF8015B; Fri, 20 Mar 2020 18:32:23 +0100 (CET)
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
 [209.85.166.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 214ABF800DD
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 18:32:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 214ABF800DD
Received: by mail-il1-f193.google.com with SMTP id r5so1623432ilq.6
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2020 10:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FXIfsAVUFp8IJFPm+/hNheLawxwEVeZKgbspez8Hy3A=;
 b=JJ8Hk0sqc4Q8Yh7cbEInCvh5yyAlXLvAuAfZmSt7Dst+X4S1Jncb2Huuuf7W569nwO
 2WOEOSYvhBLopIZJy7Tie4aBoYCavXIrVTFbv4tJv+orXOCnBx5jnyr6qXa1O/D9OQkr
 /t4u8ZX6gMznRVNJu30BFbNPAAyHslTNM3xFzcxS0DCjNW2zPpWn6sZAS6BkPfpc5lGW
 OE15s0JeWevDN+ECsEmQ3bkPCnQ0ULu6N7hsevetrwXxret0Up7vCeQlF3AsurWnn5Va
 QT40ffTopfZH1FH+PH2VXl0q0wKM/H48QWRCrAJ0M1JH/PyPaFXMZklT16icXoQ9cKPV
 0SRA==
X-Gm-Message-State: ANhLgQ2itePzEsLyjBlWXaRJA2I7hIDyekYXJ4G6Pu4jxmnqhGaV2e+7
 ZgBRncyWFSx3XIjmtRBRkg==
X-Google-Smtp-Source: ADFU+vvyOEHh52ksLg64oqQQtskIyPgC3Gb9PgcVjz3NdBpqcYEYi8YkzZvcjgp/TY2ZkGE4F1dg5g==
X-Received: by 2002:a92:d641:: with SMTP id x1mr9850010ilp.223.1584725536379; 
 Fri, 20 Mar 2020 10:32:16 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
 by smtp.gmail.com with ESMTPSA id j23sm1874792ioa.10.2020.03.20.10.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 10:32:15 -0700 (PDT)
Received: (nullmailer pid 16573 invoked by uid 1000);
 Fri, 20 Mar 2020 17:32:13 -0000
Date: Fri, 20 Mar 2020 11:32:13 -0600
From: Rob Herring <robh@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v5 1/7] ASoC: dt-bindings: fsl_asrc: Add new property
 fsl,asrc-format
Message-ID: <20200320173213.GA9093@bogus>
References: <cover.1583725533.git.shengjiu.wang@nxp.com>
 <24f69c50925b93afd7a706bd888ee25d27247c78.1583725533.git.shengjiu.wang@nxp.com>
 <20200309211943.GB11333@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309211943.GB11333@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
 tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
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

On Mon, Mar 09, 2020 at 02:19:44PM -0700, Nicolin Chen wrote:
> On Mon, Mar 09, 2020 at 11:58:28AM +0800, Shengjiu Wang wrote:
> > In order to support new EASRC and simplify the code structure,
> > We decide to share the common structure between them. This bring
> > a problem that EASRC accept format directly from devicetree, but
> > ASRC accept width from devicetree.
> > 
> > In order to align with new ESARC, we add new property fsl,asrc-format.
> > The fsl,asrc-format can replace the fsl,asrc-width, then driver
> > can accept format from devicetree, don't need to convert it to
> > format through width.
> > 
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > index cb9a25165503..780455cf7f71 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > @@ -51,6 +51,11 @@ Optional properties:
> >  			  will be in use as default. Otherwise, the big endian
> >  			  mode will be in use for all the device registers.
> >  
> > +   - fsl,asrc-format	: Defines a mutual sample format used by DPCM Back
> > +			  Ends, which can replace the fsl,asrc-width.
> > +			  The value is SNDRV_PCM_FORMAT_S16_LE, or
> > +			  SNDRV_PCM_FORMAT_S24_LE
> 
> I am still holding the concern at the DT binding of this format,
> as it uses values from ASoC header file instead of a dt-binding
> header file -- not sure if we can do this. Let's wait for Rob's
> comments.

I assume those are an ABI as well, so it's okay to copy them unless we 
already have some format definitions for DT. But it does need to be copy 
in a header under include/dt-bindings/.

Rob
