Return-Path: <SRS0=VrYT=MP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EA4C4338F
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Jul 2021 06:08:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA22160E90
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Jul 2021 06:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA22160E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C71B516FF;
	Fri, 23 Jul 2021 08:07:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C71B516FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627020492;
	bh=nfjMYYDAdJ0mS6vnbCKbhvMtM6vBjTeoY2KKpHgC0EQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q6Xvr4H13dYWKNR3Y+FOm2iCvQ6ieDr8TFvSxjZzEvEy1hlMlExvmtWl6qf1y796A
	 IntPI457u5ZxQQ5Ek/G0v7Jnegxs/TNqHw8VVhaLGwuBSpjp6NRpyLfx9lv2oMyR4o
	 P/u5xBi2qhqCZyNT7vzGmvTRQTmU/sIzaYmgfM+o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E922F804AC;
	Fri, 23 Jul 2021 08:07:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A8AFAF804AF; Fri, 23 Jul 2021 08:07:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51DA9F804AB
 for <alsa-devel@alsa-project.org>; Fri, 23 Jul 2021 08:07:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51DA9F804AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="BTv1O0Yw"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22F5B60E8B;
 Fri, 23 Jul 2021 06:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627020437;
 bh=nfjMYYDAdJ0mS6vnbCKbhvMtM6vBjTeoY2KKpHgC0EQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BTv1O0YwtMhGrf5fctah6xv8gWRmJvuAJRwIML4wcwJsgciqq1ZjK0RrBROb596Ai
 TIR+ZyRVzkkr2V/VCw7IffuA5L0oBajUQ92uJ7H6TGDLo0koh0XF+DquQwJCDQmBEc
 MRLLyk8nY64rmUe8rTSn6/AECDzvtQdPC532Zwm+pwEttH1dtLzM0GET7Ep2DNQCzd
 GmXqFdZJXm8ogdaGrVxDm3r/yeXb3vonc5VcuwNxXsooUVwkMZhIe7CcthxJHsvGPx
 xfBHvkxQmZkCTzfrslYO1/5yF0oG9tG6jZK/xv3i2V8QCqFSLmxueKb6OJGqyX8Pxv
 1GAmUywlkYw1A==
Date: Fri, 23 Jul 2021 11:37:13 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] soundwire: dmi-quirks: add quirk for Intel 'Bishop
 County' NUC M15
Message-ID: <YPpckX5M/QcxUrvE@matsya>
References: <20210719233248.557923-1-pierre-louis.bossart@linux.intel.com>
 <20210719233248.557923-2-pierre-louis.bossart@linux.intel.com>
 <YPl6Z+jqR9gnTw05@matsya>
 <c86efd0f-b941-f3ff-885d-f1d0d7d46d30@linux.intel.com>
 <fc9494a5-3729-500c-b4c9-76c023aaedd6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc9494a5-3729-500c-b4c9-76c023aaedd6@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 tiwai@suse.de, gregkh@linuxfoundation.org, Rander Wang <rander.wang@intel.com>,
 broonie@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
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

On 22-07-21, 09:29, Pierre-Louis Bossart wrote:
> 
> 
> On 7/22/21 9:25 AM, Pierre-Louis Bossart wrote:
> > 
> > 
> > On 7/22/21 9:02 AM, Vinod Koul wrote:
> >> On 19-07-21, 18:32, Pierre-Louis Bossart wrote:
> >>> The same quirk is used for LAPBC510 and LAPBC710 skews who use the
> >>> same audio design.
> >>>
> >>> These devices have the same BIOS issues inherited from the Intel
> >>> reference, add the same _ADR remap previously used on HP devices.
> >>
> >> This fails to apply on rc1, pls rebase or if there are any dependencies,
> >> do spell them out
> > 
> > it likely depends on
> > 
> > [PATCH] soundwire: dmi-quirks: add ull suffix for SoundWire _ADR values
> > 
> > which was sent by Bard when the merge window opened.
> 
> And you've just applied that dependency, do you mind retrying Vinod?

Yes it applies now...

-- 
~Vinod
