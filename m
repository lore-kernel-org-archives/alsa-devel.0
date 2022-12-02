Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8B6C47088
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Dec 2022 13:56:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F39D180D;
	Fri,  2 Dec 2022 14:55:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F39D180D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669989400;
	bh=dA+wAZeomB9qQr4INOsKRz+2GqDJj2TOGL5kSr4LrW4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u0jF3E5looeaM3ToSvbU0dHRqswlQ8TrWzSh4R86rhgC39iUEhmNyCIX5SvvKXpNP
	 y0A9tAN9c/lNdrHFhDlpW7nJ2BiSYV/8fSPfF/JmIORul2miWVhfvDxbtv0rqy9sH4
	 4sAM04W3ZttoCIUNpwo9vPIuepyjxj6kMWDGwNxY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1105FF80272;
	Fri,  2 Dec 2022 14:55:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 60845F80310; Fri,  2 Dec 2022 14:55:48 +0100 (CET)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2989EF8026A
 for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2022 14:55:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2989EF8026A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk
 header.b="n9y4h+lB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kvxrxBCW4GJgYGlNptg0Jo2kSacfwxWOJC7wYSfaQ+M=; b=n9y4h+lBKpjvC+qcxZ9QUWJvJF
 C3/9TSDciRShHSITeTUQjoRDls71w1M6DnuAkECGHxajU2yczLVbAq/B24xdWQW7+uxokkygLfLPb
 sY/8IPccPc4kTlVxa12eoT+BW7UsPs8TEXaM3vkaINYe2eT54UroYGy+hAUZrP6ekBvhZUl6VPSS8
 8x0L6fA+7UrYeOjphSSYOrovyHpYSlyN07ElRmMH+uG12kpjcdzrrqYwNF/MZQfnjDpcuAPK364yD
 8oFDyMZQTGNKvnR2MRwxJQ1NINoKFcUeM/HUVyefJr51sb1H1HKeHLAO1qFiYZgdGy1xGbLhSUI13
 +60svlVQ==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35530)
 by pandora.armlinux.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <linux@armlinux.org.uk>)
 id 1p16Vr-0004AX-B6; Fri, 02 Dec 2022 13:55:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1p16Vo-0004Rk-Em; Fri, 02 Dec 2022 13:55:32 +0000
Date: Fri, 2 Dec 2022 13:55:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 0/2] ASoC/tda998x: Fix reporting of nonexistent
 capture streams
Message-ID: <Y4oD1Of4wfN0dMGi@shell.armlinux.org.uk>
References: <20221130184644.464820-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130184644.464820-1-broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 dri-devel@lists.freedesktop.org
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

On Wed, Nov 30, 2022 at 06:46:42PM +0000, Mark Brown wrote:
> The recently added pcm-test selftest has pointed out that systems with
> the tda998x driver end up advertising that they support capture when in
> reality as far as I can see the tda998x devices are transmit only.  The
> DAIs registered through hdmi-codec are bidirectional, meaning that for
> I2S systems when combined with a typical bidrectional CPU DAI the
> overall capability of the PCM is bidirectional.  In most cases the I2S
> links will clock OK but no useful audio will be returned which isn't so
> bad but we should still not advertise the useless capability, and some
> systems may notice problems for example due to pinmux management.
> 
> This is happening due to the hdmi-codec helpers not providing any
> mechanism for indicating unidirectional audio so add one and use it in
> the tda998x driver.  It is likely other hdmi-codec users are also
> affected but I don't have those systems to hand.
> 
> Mark Brown (2):
>   ASoC: hdmi-codec: Allow playback and capture to be disabled
>   drm: tda99x: Don't advertise non-existent capture support
> 
>  drivers/gpu/drm/i2c/tda998x_drv.c |  2 ++
>  include/sound/hdmi-codec.h        |  4 ++++
>  sound/soc/codecs/hdmi-codec.c     | 30 +++++++++++++++++++++++++-----
>  3 files changed, 31 insertions(+), 5 deletions(-)

Looks sane.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
