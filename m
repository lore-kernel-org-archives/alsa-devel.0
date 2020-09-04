Return-Path: <SRS0=A1sP=CN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF0EC433E2
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:20:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9B520770
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RfSWbrmk";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltvDjDrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9B520770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6664B1AF9;
	Fri,  4 Sep 2020 11:19:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6664B1AF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599211219;
	bh=aLb7RDrgL7T4FtSR3hH9b7N4/mywRLSkPDaPL6LBGd8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RfSWbrmkToy0WpSzb51FHyB83L9EQLW2aWJF2DT+85sRmwMdnKrXcdVWhONPdj428
	 lq11vrpSVHktre+qXTWK96i18zgRuZ8AWZeRZSTzPL+U+mqhKKb3Y/9bKqrtGvcWk/
	 3NQ5bgXdXwHZQiPFbuvgLQ/OfOaBY1EUo6ptClfo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99A49F8026F;
	Fri,  4 Sep 2020 11:18:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 626F5F8028F; Fri,  4 Sep 2020 11:18:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 792ABF801DA
 for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2020 11:18:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 792ABF801DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ltvDjDrK"
Received: from localhost (unknown [122.182.253.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4795520748;
 Fri,  4 Sep 2020 09:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599211121;
 bh=aLb7RDrgL7T4FtSR3hH9b7N4/mywRLSkPDaPL6LBGd8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ltvDjDrKq9IdoVaFEXNA2ahBFszBxYzaw2+zTsFhLOovicAbu1Owj746x3535lZpB
 226YTmmV73ouIE0MWJzkq1zU5sxWIkHo1UnfRcBEsyePffNr7CSxn3FvyYYbxEnITM
 EqvVIW/s+eScmApRF4hEXJe6xrmSzPmyyP80B5+E=
Date: Fri, 4 Sep 2020 14:48:31 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2 0/9] soundwire: use FIELD_{GET|PREP} in subsystem
Message-ID: <20200904091831.GW2639@vkoul-mobl>
References: <20200903114504.1202143-1-vkoul@kernel.org>
 <169e2a94-37db-a9c0-748f-99af46aef3e5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169e2a94-37db-a9c0-748f-99af46aef3e5@linux.intel.com>
Cc: alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

On 04-09-20, 15:46, Bard liao wrote:
> 
> On 9/3/2020 7:44 PM, Vinod Koul wrote:
> > Use the FIELD_{GET|PREP} in soundwire subsytem and remove the local
> > SDW_REG_SHIFT().  This makes code IMO look much neater
> > 
> > Tested this on db845c board
> > 
> > Changes in v2:
> >   - fold in fixes provided by Bard and Pierre
> >   - Use GENMAS_ULL for addr
> >   - rebase to next and fold in new intel change
> > 
> > Vinod Koul (9):
> >    soundwire: define and use addr bit masks
> >    soundwire: bus: use FIELD_GET()
> >    soundwire: slave: use SDW_DISCO_LINK_ID()
> >    soundwire: stream: use FIELD_{GET|PREP}
> >    soundwire: qcom : use FIELD_{GET|PREP}
> >    soundwire: cadence: use FIELD_{GET|PREP}
> >    soundwire: intel: use FIELD_{GET|PREP}
> >    soundwire: intel_init: use FIELD_{GET|PREP}
> >    soundwire: remove SDW_REG_SHIFT()
> > 
> >   drivers/soundwire/bus.c                 |  6 +--
> >   drivers/soundwire/cadence_master.c      | 61 +++++++++++--------------
> >   drivers/soundwire/intel.c               | 52 ++++++++-------------
> >   drivers/soundwire/intel_init.c          |  2 +-
> >   drivers/soundwire/qcom.c                | 22 +++------
> >   drivers/soundwire/slave.c               |  2 +-
> >   drivers/soundwire/stream.c              | 13 ++----
> >   include/linux/soundwire/sdw.h           | 21 ++++++---
> >   include/linux/soundwire/sdw_registers.h |  7 ---
> >   9 files changed, 75 insertions(+), 111 deletions(-)
> 
> Tested it on Intel platforms.
> 
> Tested-by: Bard Liao <yung-chuan.liao@linux.intel.com>

Thanks Bard, applied now

-- 
~Vinod
