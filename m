Return-Path: <SRS0=lC1U=7X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987CFC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:02:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA2B2070B
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gjwSnM12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA2B2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A914B886;
	Wed, 10 Jun 2020 20:01:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A914B886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591812143;
	bh=nSrTucNZxhHNKwMGcLOrjRFSWet7lRRCbezFdT+Fq6I=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gjwSnM12tjmCMP8V1vWWyhq2o61XjvQ+NZJ2l3pMQAMhikk6GECLMDXoxiKhCuhB5
	 DgkhVh01EEgOPel8a1dLa7o3esykN8YCByok28fjQYmVCrSz7L0s9G1OD7kr5PfTDC
	 zrRvsJJuJtCYW8UUBzlZ8WpgQ5Nwx//OwHqBhe50=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27B58F800E0;
	Wed, 10 Jun 2020 20:01:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EFD5EF8021C; Wed, 10 Jun 2020 20:01:29 +0200 (CEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20E27F800E0
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2020 20:01:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20E27F800E0
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr
 [86.202.110.81])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 07B8EC0005;
 Wed, 10 Jun 2020 18:01:18 +0000 (UTC)
Date: Wed, 10 Jun 2020 20:01:18 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/6] Enable Greybus Audio codec driver
Message-ID: <20200610180118.GZ3720@piout.net>
References: <cover.1591802243.git.vaibhav.sr@gmail.com>
 <20200610173711.GK5005@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610173711.GK5005@sirena.org.uk>
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 Alex Elder <elder@kernel.org>, Vaibhav Agarwal <vaibhav.sr@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Greer <mgreer@animalcreek.com>, Takashi Iwai <tiwai@suse.com>,
 greybus-dev@lists.linaro.org, Johan Hovold <johan@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
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

On 10/06/2020 18:37:11+0100, Mark Brown wrote:
> On Wed, Jun 10, 2020 at 10:58:24PM +0530, Vaibhav Agarwal wrote:
> > The existing GB Audio codec driver is dependent on MSM8994 Audio driver.
> > During the development stage, this dependency was configured due to
> > various changes involved in MSM Audio driver to enable addtional codec
> > card and some of the changes proposed in mainline ASoC framework.
> 
> I'm not sure why you're copying me on a staging driver?  I don't recall
> the base driver having been submitted properly yet.

That was my suggestion, the whole history is that I submitted a patch
removing this driver as it was not getting compiled and so didn't go
through the componentization. See
https://lore.kernel.org/lkml/20200507212912.599433-1-alexandre.belloni@bootlin.com/

My point was that if we were to keep that driver, the goal would be to
have it out of staging instead of simply making it compile.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
