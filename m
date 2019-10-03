Return-Path: <SRS0=AoKC=X4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670D1C10F14
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:17:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F7B218DE
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="V4XtgRlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F7B218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1ECB31674;
	Thu,  3 Oct 2019 12:16:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1ECB31674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570097835;
	bh=yiBSGhUmZnzGJ5rbUPrwkyuYEzkzi+hHRkhX8wmDdpI=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V4XtgRlbPxqmDQPKL9JtOsfkb4nr7YfeSmZmPsRexr0rzK3cEtff7VBuV8fNrTytK
	 Zu5c8NJtqNSys8aU/Vx1A2o5AMO+5D223CzStnTbxJTtdkBRhe0ZvrxUaAh3W+WQJu
	 yC70canHBCNZGwU/2SYgU7EIdomjabFVX1z2JwFo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E690F804FF;
	Thu,  3 Oct 2019 12:16:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 725F8F800DE; Thu,  3 Oct 2019 12:16:03 +0200 (CEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A53F3F800DE
 for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2019 12:16:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A53F3F800DE
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 52210AD63;
 Thu,  3 Oct 2019 10:16:00 +0000 (UTC)
Date: Thu, 3 Oct 2019 12:15:58 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <20191003101558.GG17916@kitsune.suse.cz>
References: <20191002081717.GA4015@kitsune.suse.cz>
 <91e2fc425e0dea92d7f131da890e52af273de36c.1570005196.git.msuchanek@suse.de>
 <c0b00292-2529-135d-8282-974684508396@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c0b00292-2529-135d-8282-974684508396@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH 2/2] soundwire: depend on ACPI || OF
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, Oct 02, 2019 at 11:06:14AM -0500, Pierre-Louis Bossart wrote:
> On 10/2/19 3:33 AM, Michal Suchanek wrote:
> > Now devicetree is supposrted for probing sondwire as well.
> 
> typos...
> 
> also it'd be simpler to squash the two patches together and add in the

Except we have kernels with one or both of the patches these patches
fix.

> commit message a mention that the s390 builds without ACPI and without OF.
Makes sense.

Thanks

Michal
> 
> > 
> > Fixes: a2e484585ad3 ("soundwire: core: add device tree support for slave devices")
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >   drivers/soundwire/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> > index c73bfbaa2659..c8c80df090d1 100644
> > --- a/drivers/soundwire/Kconfig
> > +++ b/drivers/soundwire/Kconfig
> > @@ -5,7 +5,7 @@
> >   menuconfig SOUNDWIRE
> >   	tristate "SoundWire support"
> > -	depends on ACPI
> > +	depends on ACPI || OF
> >   	help
> >   	  SoundWire is a 2-Pin interface with data and clock line ratified
> >   	  by the MIPI Alliance. SoundWire is used for transporting data
> > 
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
