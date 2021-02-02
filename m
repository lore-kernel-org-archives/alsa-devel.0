Return-Path: <SRS0=BHSX=HE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D5DC433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 04:45:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2DEB60C3E
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 04:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DEB60C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7CE171742;
	Tue,  2 Feb 2021 05:44:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7CE171742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612241100;
	bh=/Uu6nhhPRG0xelNUcutobrsnbE1m4ygZ8a43Nff8nvw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dNaYAGlSLCUnmSWRQvXquwSi80N3H5EsIQa3K9glq7zHXizsrJgirVUkB/ZUfiXuQ
	 lfQyGcA664ZgPlednsa2zpuM675OOiMYhWYqloKbRLq1up0QfnM4k3d5KcEioMdxjw
	 WPhAySVsKRhmDzSDTjVcM+j7pqGT6BhUdp9zUHRE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C3C5F80109;
	Tue,  2 Feb 2021 05:44:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21077F80171; Tue,  2 Feb 2021 05:44:09 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C666BF80109
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2021 05:44:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C666BF80109
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VTaYaEz2"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48A5A64EDA;
 Tue,  2 Feb 2021 04:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612241045;
 bh=/Uu6nhhPRG0xelNUcutobrsnbE1m4ygZ8a43Nff8nvw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VTaYaEz2TCCBkkNs/iHyu1FwyDOqbTbttAQDr83JrYM19iIB3vMQhpnzDwFwLZa+J
 9pJkCh9ccNULcmtcgKaXsbNPX43bw7ZmuYcmDWIdBdEY3guWL3OLP3vYks+Diy61nq
 mF85CVgRwHJNFLtQ1VJsejGMAMA3/INZsTL4Xhcmm8vKuehMPFKBAd0eujjdxr/J/7
 dtYogzETNb3Az4sn6SVgFpmp21EZT+IaYldj5WYa6ZEv3EWc3CdsOlUgWwjJI0BApI
 jtNa+s2jjYuxcofsV1XX4r3ObrN1+WcfWxcJOZCfvFcXaUbQqVN51oTL5nRHGKqwFv
 hFpOc6Wr1JLIw==
Date: Tue, 2 Feb 2021 10:14:00 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 3/3] soundwire: bus: clear parity interrupt before the
 mask is enabled
Message-ID: <20210202044400.GI2771@vkoul-mobl>
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-4-yung-chuan.liao@linux.intel.com>
 <20210201110921.GZ2771@vkoul-mobl>
 <f5ef9a07-73df-c2b6-3e03-001f53700c5b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ef9a07-73df-c2b6-3e03-001f53700c5b@linux.intel.com>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org, jank@cadence.com,
 sanyog.r.kale@intel.com, Bard Liao <yung-chuan.liao@linux.intel.com>,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

On 01-02-21, 10:29, Pierre-Louis Bossart wrote:
> 
> > >   	 * Set SCP_INT1_MASK register, typically bus clash and
> > > diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> > > index f7ba1a77a1df..c1fdc85d0a74 100644
> > > --- a/drivers/soundwire/intel.c
> > > +++ b/drivers/soundwire/intel.c
> > > @@ -1286,7 +1286,8 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
> > >   	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
> > >   		prop->hw_disabled = true;
> > > -	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH;
> > > +	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
> > > +		SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
> > 
> > move this to intel patch please..
> > 
> > >   	return 0;
> > >   }
> > > diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> > > index a2766c3b603d..30415354d419 100644
> > > --- a/include/linux/soundwire/sdw.h
> > > +++ b/include/linux/soundwire/sdw.h
> > > @@ -426,6 +426,7 @@ struct sdw_master_prop {
> > >   };
> > >   #define SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH	BIT(0)
> > > +#define SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY	BIT(1)
> > 
> > Why not add this quirk in patch 1..?
> 
> There is an element of history here. We first found out about the bus clash
> on multiple devices and dealt with a specific bug number. Then we spend
> weeks on the parity issue on a new platform and ultimately showed we needed
> a similar work-around.
> 
> All these problems are not typical from a user perspective; they appear when
> loading/unloading modules in loops, at some point it seems some hardware
> devices don't always reset properly or there's something problematic in
> power delivery.
> 
> I don't think it's an issue if we refactor the code to add the quirks first,
> and add the intel.c patches later. We probably want 2 intel changes to keep
> the references to the bugs though and the detailed explanations.

Yes I would like to see that. Explanations are always welcome including
development/debug notes.. Changelogs are very important documentation for
kernel, so relevant details are always good to add.
> 
> > Also add comments about each quirk, hopefully it wont be a big table
> 
> Sounds fine.

-- 
~Vinod
