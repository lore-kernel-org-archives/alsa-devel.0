Return-Path: <SRS0=gvoF=NC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE16C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Aug 2021 18:20:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90FE60FC0
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Aug 2021 18:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A90FE60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C8E6172B;
	Wed, 11 Aug 2021 20:19:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C8E6172B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628706022;
	bh=XLPjJRxp0bPAhY+csQxyDaBncYEBtOeQleoWOs1FFV4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AowTUjyioV+qnt3F9mAMCuZe2MONtUlEZGv/SbqsntivrGerP2SIxgerBEL9F6P85
	 j3Ny0/EI47g1Fu3CJCLEKQBj6YNg4UygKZH/Lupff3WBfxospS/RqTuZQ/d59+fmYx
	 sAUcApKBdSsK9eNRfpAWCgss/M067FxQDYlPhXIU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ECA63F8020D;
	Wed, 11 Aug 2021 20:19:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBF70F8016B; Wed, 11 Aug 2021 20:19:29 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46F96F8016B
 for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2021 20:19:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46F96F8016B
Received: by mail-pj1-f45.google.com with SMTP id
 u21-20020a17090a8915b02901782c36f543so10957695pjn.4
 for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2021 11:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ilpZFfh2W+CY8+HCSImTzYloCYVl2pqPpxQYj2d5QPI=;
 b=DVg9mZR+N3i/khOL8CE9VI+v/H3EVxEU63+xGfoavABaOJdqlqkYHqXMY3JDUu5+qp
 3KTl6BDQqEw4sTGE0Z2KGImQU4G8QuCqfePfwJ5FkFDR9x9vY+68T7yDsFu8LgF6SKIo
 CutiO95xDScaJvOdVtKh4xf7HGSltomyHjwnAv4PgJVAwQyRwhwqCmnXr1DClm9nZKlU
 09ev7JRozRx8ErQ+HQQzJ4J8o0z6VWQws0dnkTFMELyJnJbXRnk6gn4nQsttFcF/E97r
 FxzKJpeYge6NVMmKAHsOqtwrereQra+4oRV8HjD/Uw812tOgP4REso1U1dGsFUes3UgO
 +wRQ==
X-Gm-Message-State: AOAM532L1emys5YaPir+d5TaKCiM4CJwbSpLPfLdE/vgClc7/ltjew2c
 sEXB1XBxpjlFjDw69Zd6yQ==
X-Google-Smtp-Source: ABdhPJxUdAalxENdH6d6efbOmzxEgsbEVrYlNZ1GqZ+dtvFoyMVQkp9dVRHrCSA/A1CQgbuDZCz/iQ==
X-Received: by 2002:a63:5002:: with SMTP id e2mr41094pgb.256.1628705963297;
 Wed, 11 Aug 2021 11:19:23 -0700 (PDT)
Received: from robh.at.kernel.org ([208.184.162.215])
 by smtp.gmail.com with ESMTPSA id 15sm141463pgp.3.2021.08.11.11.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Aug 2021 11:19:22 -0700 (PDT)
Received: (nullmailer pid 29882 invoked by uid 1000);
 Wed, 11 Aug 2021 18:19:17 -0000
Date: Wed, 11 Aug 2021 12:19:17 -0600
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 05/20] ASoC: dt-bindings: replace q6afe bindings with
 q6dsp-audio-ports
Message-ID: <YRQUpZeusOEA9aOM@robh.at.kernel.org>
References: <20210803125411.28066-1-srinivas.kandagatla@linaro.org>
 <20210803125411.28066-6-srinivas.kandagatla@linaro.org>
 <20210804175334.GE26252@sirena.org.uk>
 <225bc8df-0d78-09d6-4dc9-8cc2145f095f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <225bc8df-0d78-09d6-4dc9-8cc2145f095f@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
 bjorn.andersson@linaro.org
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

On Thu, Aug 05, 2021 at 10:16:14AM +0100, Srinivas Kandagatla wrote:
> Thanks Mark for the review,
> 
> On 04/08/2021 18:53, Mark Brown wrote:
> > On Tue, Aug 03, 2021 at 01:53:56PM +0100, Srinivas Kandagatla wrote:
> > > DSP Audio Ports bindings have been documented with DSP services bindings
> > > which makes it difficult to reuse them, so pull them out in to a dedicated
> > > bindings.
> > > Also as part of this change convert them into yaml format.
> > 
> > > This patch also removes q6afe bindings as dsp services are now documented in
> > > apr bindings.
> > 
> > This feels like it's multiple changes stuffed into one commit which
> > makes it difficult to review, especially since I'm having a hard time
> > connecting the code changes with the description.  For example this says
> > it removes the "q6afe bindings" but we seem to be adding some in the
> > newly added YAML file.  At the very least the commit message needs to be
> > improved but I think this probably needs to be split out into separate
> > changes each doing one thing.
> This patch is doing yaml conversion + removing the "qcom,q6afe" compatible
> from the existing bindings + header file renaming.
> 
> I agree, will split the header file renaming and yaml conversions as two
> patches, that should probably help. I will also update the commit message
> with more details.

Perhaps also relicense the header to include Qcom's preferred license.

Rob
