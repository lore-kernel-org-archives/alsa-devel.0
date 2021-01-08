Return-Path: <SRS0=g0zL=GL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98089C433DB
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jan 2021 08:29:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259B623435
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jan 2021 08:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259B623435
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEA081663;
	Fri,  8 Jan 2021 09:28:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEA081663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610094559;
	bh=SAoDiXJG+49pPIJcmLEdT3YdpudMLb3tXzuV+M1ddMg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mow1+m9YTPbCZqd3fuU1hkrXqlpR7UqzC47HMhf3hpOTaZIZBgESVq6B+Rub3VeUM
	 KKvTS5We6mtRK5g7ozQZ/8fGSmjNIEp01ILMqRDvQ/KqVxpWGOz5Hc6jZGHmowvRmW
	 XhtZLvLAo2wkhuEet2Zv1Qwk18ctKpYnEAodRtVc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27244F800E9;
	Fri,  8 Jan 2021 09:28:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B976F80166; Fri,  8 Jan 2021 09:28:20 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CE0B2F800E9
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2021 09:28:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE0B2F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="EnEKOJIN"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CC7A23435;
 Fri,  8 Jan 2021 08:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610094479;
 bh=SAoDiXJG+49pPIJcmLEdT3YdpudMLb3tXzuV+M1ddMg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EnEKOJIN+WnD4u6lFgo77faKCj54N+d/pFKhcGzW/Y3/Ccl68siuEONd2+MQVmWwA
 g8i5J1Jp9PRFqP+bjh1UVHmW6ZNZoM79Em/nHN5DHOG6ps9hEvQuax6LdoYTVQba6R
 W0M3rPvSPrbm/vYAaPU9CsppYeuXAhSoIAN8UGVK69VCDMDjU1FlkyeISfeCHTf0Cp
 UrPLrlJpGz0S4tUYkZu+D7Yp8uZm4/13PvNs53jDnTG1yuR/TZx3S6Q2A5kjWrfu5R
 w1MefWO2hD7veYyvb2xtc7eB2pAO3ZpInFWl5OgE2Cy2VRAsn/olPyc/xhF+bAgyze
 9qY+rCVqge15w==
Date: Fri, 8 Jan 2021 13:57:54 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 05/10] dma: tx49 removal
Message-ID: <20210108082754.GW2771@vkoul-mobl>
References: <20210105140305.141401-1-tsbogend@alpha.franken.de>
 <20210105140305.141401-6-tsbogend@alpha.franken.de>
 <b84dadc2e98b1986dc800c5f6f202880ed905b38.camel@perches.com>
 <20210107164015.GA12533@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210107164015.GA12533@alpha.franken.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-spi@vger.kernel.org,
 linux-rtc@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>,
 Jakub Kicinski <kuba@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 linux-watchdog@vger.kernel.org, Joe Perches <joe@perches.com>,
 Mark Brown <broonie@kernel.org>, Matt Mackall <mpm@selenic.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Alessandro Zummo <a.zummo@towertech.it>, netdev@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 "David S.  Miller" <davem@davemloft.net>
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

On 07-01-21, 17:40, Thomas Bogendoerfer wrote:
> On Wed, Jan 06, 2021 at 11:10:38AM -0800, Joe Perches wrote:
> > On Tue, 2021-01-05 at 15:02 +0100, Thomas Bogendoerfer wrote:
> > > Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > []
> > > diff --git a/drivers/dma/txx9dmac.h b/drivers/dma/txx9dmac.h
> > []
> > > @@ -26,11 +26,6 @@
> > >   * DMA channel.
> > >   */
> > >  
> > > 
> > > -#ifdef CONFIG_MACH_TX49XX
> > > -static inline bool txx9_dma_have_SMPCHN(void)
> > > -{
> > > -	return true;
> > > -}
> > >  #define TXX9_DMA_USE_SIMPLE_CHAIN
> > >  #else
> > >  static inline bool txx9_dma_have_SMPCHN(void)
> > 
> > This doesn't look like it compiles as there's now an #else
> > without an #if
> 
> you are right, no idea what I had in mind while doing that.
> 
> Vinod,
> 
> as this patch series found a still active user of the platform,
> could you drop the patch from your tree, or do you want a revert
> from me ?

Dropped now

-- 
~Vinod
