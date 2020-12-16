Return-Path: <SRS0=ORgw=FU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E657AC4361B
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Dec 2020 18:30:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC02A23AA1
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Dec 2020 18:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC02A23AA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFD2E1749;
	Wed, 16 Dec 2020 19:29:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFD2E1749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608143408;
	bh=Q2mXO69JI+C4KlbS8Xnjif7vhtiejtfU/T6AKn+mJUU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WJ7BfDMw3Z6UyGcd1Q5yZBAy5E0ARU7RPzoIpSTm0V0CxrLvrjqdQh8juVNj3oqMo
	 IdfrxV6CNRFD+Ue2t2LYEwPpE3TzW7L1BAwBwtLomSQLbmNg256PnoqbL6YfAetReX
	 E7FzyrSZGcQxekrnVx5D3TTaoyee68dOFDBePcFA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55F5AF80171;
	Wed, 16 Dec 2020 19:29:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD39DF801F7; Wed, 16 Dec 2020 19:29:15 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44251F80168
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2020 19:29:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44251F80168
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="RQQ5ktXz"
Received: by mail-ej1-x636.google.com with SMTP id b9so9241788ejy.0
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2020 10:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=erIoBEbKbiz5oRvHJ2Hn0NTy908E7i+ePDr/KDJfqn0=;
 b=RQQ5ktXzQkitjNrDXhSj68Nk76iCrFiuj/7rR8NhYWibX+TJEUAZ1ABRoLCFSvSyhD
 K+XSzAJ8+JptHtbXZgAMLd0C8CH7rASXoNDM/suXiZSey8fRstAT7j/a3LBA4Z/ItkcW
 1KLlUTyufegGfHsfw6OASMbx35T/dOUZh2n2DtwPkjnY7UvC1lGopN435jaOCu9sLQRC
 d+0ogLUP8B1gq+H/wdjWWd1r3jNt330yGJXpKDpBReCXvcZc0s9aGyzV4dq/pX7OCHL8
 DrffsY8AoJZdbDgf3GUaosn01KgA5PC0mG+pQYhmh8NhXGU0wbK+OS4rc88M46Z8G6Pg
 yO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=erIoBEbKbiz5oRvHJ2Hn0NTy908E7i+ePDr/KDJfqn0=;
 b=TcyDLFcZHd/6bZfKAe9b184WIfk+GSCHQtYioVA+l1tSaPSAc2H9QDdCBEZt284N6K
 7agshZWZokjXNQlTwRtE5k4/p42OhA7CT0QHOPAhwfdv3KoKoxhU7S8PbYcaC2Xo5Vwa
 Bb4AXvA4RqqgqZAUoR7KAdWL7B1HUP+CUIa+HcW+LMrjSEtiGVpisoEcdwLybWPe4PPX
 fJTKiyUnWJoUyFCXhQ6oMH8HBQHC2zKseBMaSklyeg+DTX8iY6/ZyECQNpoAF0Mt8QF4
 iHIg/vdoreca7EyUNG7/0e8ze2MhIGMVL0rwVeaF3/hGzl7Nd2n2fXHuTGrb7De6APhR
 dTYQ==
X-Gm-Message-State: AOAM530odp5NLrUqE/gihvqjdQR0Y8dDBAp/J8b/uWIiF6aydJNz7ha0
 HjWKbZ5RMW3AlvCkti3G6FU=
X-Google-Smtp-Source: ABdhPJwYrZeKblL+48+EBX3qrAEooomDWvRk7xg3KKtcF9HUnU1fmEnVGyTYAjoEyim5ZUFQy/DxOg==
X-Received: by 2002:a17:907:da7:: with SMTP id
 go39mr33278642ejc.58.1608143352040; 
 Wed, 16 Dec 2020 10:29:12 -0800 (PST)
Received: from ryzen.localdomain (89-212-27-98.dynamic.t-2.net. [89.212.27.98])
 by smtp.gmail.com with ESMTPSA id v9sm2032877ejk.48.2020.12.16.10.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Dec 2020 10:29:11 -0800 (PST)
Date: Wed, 16 Dec 2020 19:29:09 +0100
From: Amadej Kastelic <amadejkastelic7@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 01/01] Add VID to support native DSD reproduction on FiiO
 devices.
Message-ID: <X9pR9X/uCqoij1b0@ryzen.localdomain>
References: <X9j7wdXSr4XyK7Bd@ryzen.localdomain> <s5h8s9xoj6o.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h8s9xoj6o.wl-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On Wed, Dec 16, 2020 at 04:38:07PM +0100, Takashi Iwai wrote:
> On Tue, 15 Dec 2020 19:09:05 +0100,
> Amadej Kastelic wrote:
> > 
> > Message-Id: <c759bc50134ea434bfed0a183e0ce72984f5b609.camel@gmail.com>
> > 
> > Add VID to support native DSD reproduction on FiiO devices.
> > 
> > Tested-by: Amadej Kastelic <amadejkastelic7@gmail.com>
> > Signed-off-by: Emilio Moretti <emilio.moretti@gmail.com>
> 
> Could you give your own sign-off, too?  Each person who submits the
> patch needs the sign-off.  This is mandatory for merging to the
> upstream.
> 
> 
> thanks,
> 
> Takashi

Signed-off-by: Amadej Kastelic <amadejkastelic7@gmail.com>
