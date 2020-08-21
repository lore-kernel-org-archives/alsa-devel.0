Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D90C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 05:14:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90CF6208E4
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 05:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="o71cnppw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3go8loj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CF6208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F8981676;
	Fri, 21 Aug 2020 07:13:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F8981676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597986846;
	bh=JQU9mXlGQHqxpkXNmcu6IbDvpZpRpleWG+SpVgI46EU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o71cnppw4hpMRrbsMu1f3ptAG/cAXZz4Jp4DXsI6JaBWau3oitySwzx4FhQInfUJ7
	 XE8AlzQODrG4ATG8IVT9fdUoeDRlGqAIBpM30hY5qA8BSd4Ty7USicgnetp1x3PlRZ
	 mH8m8YrH/bARBv8U2pGvUV2Y0At5LWRoNzbPOQ/c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9AEF8F80216;
	Fri, 21 Aug 2020 07:13:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 444EEF80218; Fri, 21 Aug 2020 07:13:08 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2129AF800D2
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 07:13:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2129AF800D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="r3go8loj"
Received: from localhost (unknown [122.171.38.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AF910208E4;
 Fri, 21 Aug 2020 05:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597986782;
 bh=JQU9mXlGQHqxpkXNmcu6IbDvpZpRpleWG+SpVgI46EU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r3go8lojTbEr7ggmy34F0+6ntC9It3xWedK5ixdQJNd69UfcoBhfw1ZVVES0UBx1C
 53+Qcl+WCvJloPT1DqSyzYFXyohCwPrcIDdDKAgyjRWVO2VirAC4SQGw2n4ZQPJi+Q
 b1EBU3mrpoDTXRzBpebubmxnxIuZYz+en4iTmEZY=
Date: Fri, 21 Aug 2020 10:42:58 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] soundwire: SDCA: add helper macro to access controls
Message-ID: <20200821051258.GJ2639@vkoul-mobl>
References: <20200816201058.9687-1-yung-chuan.liao@linux.intel.com>
 <20200817121411.GR2639@vkoul-mobl>
 <2ab412c5-bf96-5ba3-c193-5a8ad9071bbb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ab412c5-bf96-5ba3-c193-5a8ad9071bbb@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, broonie@kernel.org, srinivas.kandagatla@linaro.org,
 jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>, rander.wang@linux.intel.com,
 bard.liao@intel.com
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

On 17-08-20, 10:14, Pierre-Louis Bossart wrote:
> 
> > > The upcoming SDCA (SoundWire Device Class Audio) specification defines
> > > a hiearchical encoding to interface with Class-defined capabilities,
> > 
> > typo hiearchical
> 
> ok
> 
> > > based on which audio function, entity, control and channel being used.
> > 
> > Can you please elaborate on what do these terms refer to?
> > 
> > Also can we have some documentation for this and how Linux is going to
> > use it..
> 
> These are concepts in the SDCA draft spec, and that should be the reference.
> We worked with MIPI so that this spec will be available with a click-through
> agreement when ratified, for now it's only available to contributors per
> MIPI bylaws.
> 
> If you do not have access to this specification, then that's a real problem.
> Maybe you need to let Bard take care of this part as a co-maintainer?
> 
> The goal with this macro is to enable a first set of codecs drivers using
> these concepts to be released upstream. All you need to know at this point
> is that controls are defined in a hierarchical way and accessed with a
> read/write transaction from/to the address created with the following macro.

Hmmm, if we cannot get some kind of Documentation of what it means and
review the code, then I do not see a point in getting this into kernel.

As kernel community we would like to see some form of Documentation
associated with the patches on what this means.

If that is not possible due to MIPI regulations, maybe deferring
this would make sense

Thanks
> 
> > > +/* v1.2 device - SDCA address mapping */
> > > +#define SDW_SDCA_CTL(fun, ent, ctl, ch)		(BIT(30) |			\
> > > +						 (((fun) & 0x7) << 22) |	\
> > > +						 (((ent) & 0x40) << 15) |	\
> > > +						 (((ent) & 0x3f) << 7) |	\
> > > +						 (((ctl) & 0x30) << 15) |	\
> > > +						 (((ctl) & 0x0f) << 3) |	\
> > > +						 (((ch) & 0x38) << 12) |	\
> > > +						 ((ch) & 0x07))
> > > +
> > 
> > how about adding an underscore to the arguments here:
> > 
> > #define SDW_SDCA_CTL(_fun, _ent, _ctl, _ch)
> > and so on..
> 
> I checked the SoundWire defines and the vast majority of the macros don't
> use underscores, and when they do there's no consistency between 1 or 2
> underscores.

-- 
~Vinod
