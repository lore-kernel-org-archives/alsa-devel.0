Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52A8C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Apr 2022 11:11:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 36E9F16D2;
	Thu, 14 Apr 2022 13:10:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 36E9F16D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649934683;
	bh=B/1tgmAGUpguw5H1LN4QJqZnt8JIa4mgt53+CKvzFps=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bKI5I3H4xgOswnyhgAQop64uTTaYNotbclMqIpUfgJYmWe++qNDac9B9GyblyDhHy
	 FGdftdMSKYvSG9TlxTguqs+0qqiDrylccjO2WiWKni7vIumA3uTDlJcdbsG7Bg/lHw
	 jX7z18uEjLnQCDOkQHTenQ1Vcq+5IeaPgzYFwmAM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFDB2F8012E;
	Thu, 14 Apr 2022 13:10:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84E4AF80162; Thu, 14 Apr 2022 13:10:31 +0200 (CEST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63CB2F80095
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2022 13:10:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63CB2F80095
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1nexMk-0004XR-Nl; Thu, 14 Apr 2022 13:10:22 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1nexMj-0005aj-LJ; Thu, 14 Apr 2022 13:10:21 +0200
Date: Thu, 14 Apr 2022 13:10:21 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 00/21] ASoC: fsl_micfil: Driver updates
Message-ID: <20220414111021.GK4012@pengutronix.de>
References: <20220408112928.1326755-1-s.hauer@pengutronix.de>
 <20220414075114.GC2387@pengutronix.de>
 <Ylf3fAU5TV/RnHBW@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ylf3fAU5TV/RnHBW@sirena.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:06:35 up 14 days, 23:36, 64 users,  load average: 0.08, 0.23, 0.17
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 dmaengine@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
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

On Thu, Apr 14, 2022 at 11:29:16AM +0100, Mark Brown wrote:
> On Thu, Apr 14, 2022 at 09:51:14AM +0200, Sascha Hauer wrote:
> 
> > Ok to apply this series? I just realized that I missed to Cc: you on
> > this series. Let me know if I should resend.
> 
> Please resend.  What's the plan with the dmaengine bits - it looks like
> the ASoC bits are relatively substatantial here?

Ok, I'll resend. I'd like to merge the dmaengine bits through your tree.
I have collected the acks from Vinod for this. I just rechecked there
are no conflicts with -next so far.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
