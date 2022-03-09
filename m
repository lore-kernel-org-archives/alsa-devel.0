Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82532C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Mar 2022 12:35:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBF26174B;
	Wed,  9 Mar 2022 13:34:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBF26174B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646829327;
	bh=+N+UjvMw7WyIRIWyQIQ+HgMvt0V9y8H1HvyRCLum/n8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tyuwmQK+pMTPy4y6qzo/Dxny9gOOLuxpAX3MHsu/8vY1Cm2+aRiZuwD4xJOYLjnUR
	 E00gXOgTFlLTyIzikZhjW6mbgTfDrOEejqoa8wTEZADDnCPgCMgm4eFUGjTGQfSBUc
	 I5xj0colqAPjgjaW0DgapEi4Vo6ym3MjkHBxIn70=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 572A5F80158;
	Wed,  9 Mar 2022 13:34:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73DB7F8016C; Wed,  9 Mar 2022 13:34:35 +0100 (CET)
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C973F80155
 for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2022 13:34:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C973F80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=metanate.com header.i=@metanate.com
 header.b="4Lgu9ZCh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description; bh=nK67APL81JLn2DAt7Qt6f0T7aBnoQTZj/X9iXtjWIUU=; b=4Lgu9
 ZCh0u+tEJoTz3z1+uiapYfpGVVFlP889AEj4Gw/mohxZYScIwXtpbNsm/RDmGKbNcHdLm4zji/hCg
 AcoQEiBgCO5VS9MCJr/LZVGckz3kW2ULRx1ca5IqeZ9uPX1hu4GVDJxHnhKfljGQ/FjSHxRmUWNvX
 OCdSZQ35hijioNZw8WnC2ysUCOmjswbqYOcytezvHvzEF4c4xELaP0iqPQjovaEi5ZnRm8Wsdh3To
 Jjou/gtLs13rLb2HQhGwyypw3gBgFP/2buK0gHqwGrasfYZ0MiLXu1imfn6pNBYSqX4jPxmBBmMPk
 A/3XWaecoMvN1WBU3gkNHZebf4eIQ==;
Received: from [81.174.171.191] (helo=donbot)
 by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.93) (envelope-from <john@metanate.com>)
 id 1nRvWP-0001JT-Q7; Wed, 09 Mar 2022 12:34:29 +0000
Date: Wed, 9 Mar 2022 12:34:28 +0000
From: John Keeping <john@metanate.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tas5805m: fix pdn polarity
Message-ID: <Yiie1OUCvi49f1Q7@donbot>
References: <20220309104104.3605112-1-john@metanate.com>
 <YiiZv7Fc8a4O1nYR@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiiZv7Fc8a4O1nYR@sirena.org.uk>
X-Authenticated: YES
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Daniel Beer <daniel.beer@igorinstitute.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>
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

On Wed, Mar 09, 2022 at 12:12:47PM +0000, Mark Brown wrote:
> On Wed, Mar 09, 2022 at 10:41:04AM +0000, John Keeping wrote:
> 
> > Fixes: ec45268467f4 ("ASoC: add support for TAS5805M digital amplifier")
> 
> Please don't insert fixes tags unless you're actually fixing a bug,
> stylistic improvements like this - people try to use the tag for
> backporting bug fixes and so on so extra tags create noise for them.

This isn't purely stylistic - it affects the interpretation of pdn-gpios
in the device tree so that it matches all of the other bindings that use
this property: active means PDN asserted.

There are currently no in-tree users of the binding and the patch adding
it is queued for the next merge window.
