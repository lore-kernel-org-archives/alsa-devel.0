Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3645C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Feb 2022 07:06:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1A6A175F;
	Tue, 22 Feb 2022 08:05:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1A6A175F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645513604;
	bh=BEmyYTNG2Q7fqUXny6fJqX3YplVH0bxgIOOIVInBThA=;
	h=Date:To:Subject:From:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=e8dD78LU+58pUl2Yg9e4HEcf850ryhbMA/W127O4cK/Bj1kYvjHtrEdwsaODoFVCj
	 eTZfTyQuFeeCyynziwkCn0Ji96AWBaZcTtuiZeZjRqb/Ax24yvVjb9Jio4EHhaQAiA
	 mJaHvpL041/BDdP+bdlkAYDlJMTtESCeM2CCgCiI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85A05F80311;
	Tue, 22 Feb 2022 08:05:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9A6BF8013D; Mon, 21 Feb 2022 16:05:20 +0100 (CET)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F448F80118
 for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2022 16:05:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F448F80118
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1nMAFU-0002bC-L2; Mon, 21 Feb 2022 16:05:12 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1nMAFU-00045l-66; Mon, 21 Feb 2022 16:05:12 +0100
Date: Mon, 21 Feb 2022 16:05:12 +0100
To: alsa-devel@alsa-project.org
Subject: Codec without controls in device tree
Message-ID: <20220221150512.GF9136@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:42:50 up 72 days, 23:28, 85 users,  load average: 0.64, 0.86, 0.65
User-Agent: Mutt/1.10.1 (2018-07-13)
From: Sascha Hauer <sha@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
X-Mailman-Approved-At: Tue, 22 Feb 2022 08:05:22 +0100
Cc: Mark Brown <broonie@kernel.org>
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

Hi,

I have several i.MX8 boards here which have codecs connected to them
which are really just plane D/A converters without any control interface
like a pcm1754 or a pcm4104 in hardware mode. Currently we use the
simple-audio-card OF driver with custom codec code in sound/soc/codecs/.
The codec does nothing except specifying desired rates, channels and
formats.
Is this the way to go or is there some device tree solution to get rid
of the codec?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
