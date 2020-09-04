Return-Path: <SRS0=A1sP=CN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44385C433E2
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 05:11:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C432074D
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 05:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MhMj7s9W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKR4i72o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C432074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52C0D1AB3;
	Fri,  4 Sep 2020 07:10:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52C0D1AB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599196306;
	bh=JL5hlEqAO1CvuAIi2Pmv3JSHZEXfeYK3TlK8ZhEqdLE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MhMj7s9WSaOaFy5MsUxmwxWho1HwnBTMIGCJv9yzhJPW06W6jdL79kOS4XraxNj7n
	 OY9O9OcgZenxUmcq0ELfaYwBnjSroj7yzpNR/3/gg4vN+mpH4gBSu9Yy9TR0Us8M/p
	 gI2g4RccrcfCJWn+Cmi/YnyoaE7zATFltTfc6Q+A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B33ADF80212;
	Fri,  4 Sep 2020 07:10:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F231F8024A; Fri,  4 Sep 2020 07:10:54 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3360CF800F0
 for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2020 07:10:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3360CF800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="EKR4i72o"
Received: from localhost (unknown [122.182.253.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B9F03206B7;
 Fri,  4 Sep 2020 05:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599196242;
 bh=JL5hlEqAO1CvuAIi2Pmv3JSHZEXfeYK3TlK8ZhEqdLE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EKR4i72o6KurMdZKZBFgw9SN1ygVPqUQod9OmNx6AroxLoah11kRndIyyZuBZ8tR/
 WxkEwUIA5KCTCRsY0FLc41Dm8DmaWLdTrB2iXL0771wVVenKdh7rennjUhJJgNxx3P
 bWAPnrmMAwIrXqFx4iihi+34VI324MCDcGPro+mU=
Date: Fri, 4 Sep 2020 10:40:36 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/7] ASoC: soundwire: Move sdw stream operations to
Message-ID: <20200904051036.GU2639@vkoul-mobl>
References: <20200901150240.19288-1-yung-chuan.liao@linux.intel.com>
 <20200903104248.GQ2639@vkoul-mobl>
 <033ea005-e948-c2c6-9bd4-e074d3effde0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <033ea005-e948-c2c6-9bd4-e074d3effde0@linux.intel.com>
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

On 03-09-20, 09:05, Pierre-Louis Bossart wrote:
> 
> 
> On 9/3/20 5:42 AM, Vinod Koul wrote:
> > On 01-09-20, 23:02, Bard Liao wrote:
> > > sdw stream operation APIs can be called once per stream. dailink
> > > callbacks are good places to call these APIs.
> > 
> > Again, please mention here if this is to be merged thru sdw tree or ASoC
> > tree
> 
> Good point, I thought it wouldn't matter but it does. I just gave it a try
> and there seems to be a conflict on Mark's tree w/ drivers/soundwire/intel.c
> (likely due to missing patches already added to Vinod's tree).
> 
> So this should go to Vinod's tree with Mark's Acked-by tag on the ASoC
> changes.
> 
> Alternatively we can also split this in two, with ASoC-only and
> SoundWire-only patches in separate series if it's easier for maintainers. We
> would lose the rationale for the changes but that's not essential.

If there are no dependencies on each other, that is best preferred
option. One should mention in cover-letter about the linked series
though.

> 
> > > Pierre-Louis Bossart (7):
> > >    ASoC: soc-dai: clarify return value for get_sdw_stream()
> > >    soundwire: stream: fix NULL/IS_ERR confusion
> > >    soundwire: intel: fix NULL/ERR_PTR confusion
> > >    ASOC: Intel: sof_sdw: add dailink .trigger callback
> > >    ASOC: Intel: sof_sdw: add dailink .prepare and .hw_free callback
> > 
> > These should be ASoC
> 
> Right. if you are fine with the content and this goes in your tree, can this
> be modified while applying? Or do want a v2?
> 
> > >    soundwire: intel: remove .trigger operation
> > >    soundwire: intel: remove stream handling from .prepare and .hw_free
> > > 
> > >   drivers/soundwire/intel.c        | 60 ++++-------------------
> > >   drivers/soundwire/stream.c       |  2 +-
> > >   include/sound/soc-dai.h          |  3 +-
> > >   sound/soc/intel/boards/sof_sdw.c | 81 ++++++++++++++++++++++++++++++++
> > >   4 files changed, 92 insertions(+), 54 deletions(-)
> > > 
> > > -- 
> > > 2.17.1
> > 

-- 
~Vinod
