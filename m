Return-Path: <SRS0=bexm=YQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89E4CA9EB6
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 18:27:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30B8721928
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 18:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vSiBvnnR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0JmadXmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B8721928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EF6841;
	Wed, 23 Oct 2019 20:26:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EF6841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571855249;
	bh=VJEKvD8KHCtwXpjfr8JYAHRk5hlMGfREQcHjUtj8bJY=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vSiBvnnRHvMzLbrdCK3EDMuVpcgqh+nWRORbNWXdoe+0evu/m/WLlp99Wtayt4ton
	 oWzyBBrwMPi6iNfiZt+HY3ryd4SLtYJU83TENeSjzUEvQpqoO7D28UwljVoIvU4zB9
	 0HhMQ9/29AqpceORVxXsu3ieAGCyrXE33lxDIFGU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 862B6F80112;
	Wed, 23 Oct 2019 20:26:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A0CE3F80368; Wed, 23 Oct 2019 20:26:37 +0200 (CEST)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A31FEF80112
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 20:26:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A31FEF80112
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk
 header.b="0JmadXmX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ilfsvkQZhflxpwApssuF0SxtHAiqATDZH9AtW7X4oPs=; b=0JmadXmXYKwJL2c+ZhpX92FTQ
 mhe5+ZtixqNGmRC6SrFXmSvi05PSDLOESRYUhXWzvZluFGISA0LCgG6vM3ELBuUo2rKkg//DkRJhO
 gweIiJdxFnwhr/rntlzGxs5ZZ1e6RYo06In0ahN4mL3ZWMX0ZwHEL+5BaJdB2enbSn2mfi/OKVET+
 TaXy1f7tO6jsQvwXhSIv2sClqlP6fZsgVRPVOFVY0SZuaSh7ZB4/41v+ZmPxjkBWpsXVbgiSJPdck
 n77nBTt+E14t7DvtTxmLiJVRFAK6kEXG6FFBKcGQKiRNqATik5H9BgMm61Gfnu02946w6ZcHsK7TQ
 hzbF6bOlA==;
Received: from shell.armlinux.org.uk
 ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:46520)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1iNLKu-0006h6-Jl; Wed, 23 Oct 2019 19:26:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1iNLKs-0005ki-FT; Wed, 23 Oct 2019 19:26:18 +0100
Date: Wed, 23 Oct 2019 19:26:18 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Mark Brown <broonie@kernel.org>
Message-ID: <20191023182618.GC25745@shell.armlinux.org.uk>
References: <20191023161203.28955-1-jbrunet@baylibre.com>
 <20191023161203.28955-2-jbrunet@baylibre.com>
 <20191023163716.GI5723@sirena.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191023163716.GI5723@sirena.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [alsa-devel] [PATCH 1/2] Revert "ASoC: hdmi-codec: re-introduce
	mutex locking"
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

On Wed, Oct 23, 2019 at 05:37:16PM +0100, Mark Brown wrote:
> On Wed, Oct 23, 2019 at 06:12:02PM +0200, Jerome Brunet wrote:
> > This reverts commit eb1ecadb7f67dde94ef0efd3ddaed5cb6c9a65ed.
> > 
> > This fixes the following warning reported by lockdep and a potential
> > issue with hibernation
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Hi Mark,

If you look at the git log for reverted commits, the vast majority
of them follow _this_ style.  From 5.3 back to the start of current
git history, there are 3665 commits with "Revert" in their subject
line, 3050 of those start with "Revert" with no subsystem prefix.

It seems that there are a small number of subsystems that want
something different, ASoC included.  That will be an ongoing problem,
people won't remember which want it when the majority don't.

Maybe the revert format should be standardised in some manner?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
