Return-Path: <SRS0=Bo48=LO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41BEC48BDF
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 11:09:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993F060FEE
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 11:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993F060FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ACDA016CD;
	Sun, 20 Jun 2021 13:08:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ACDA016CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624187351;
	bh=ysuTIytzhYGpN6sB7X0cshVo6zQPn51Xxk1B7js3ERc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LSnguKz8Um2H61DM5sWOQXPP1wIisgGw/3EuqWURkS5nsrp+Dl3bpaOJtzd0x47aT
	 7FFOJfE1Gyo7gSYYqSl8F7dz0lEuHOUx0QaVOdWAsgKUAijEDxGI/PwXHA039I1jtT
	 GcELX5Q8pWwtZjkNjeVpSwXdQSU6AIGqObdWoTKY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35CDBF8025F;
	Sun, 20 Jun 2021 13:08:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 60B18F80268; Sun, 20 Jun 2021 13:08:19 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED78FF8016D
 for <alsa-devel@alsa-project.org>; Sun, 20 Jun 2021 13:08:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED78FF8016D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JVMwlwZl"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B98C760FEE;
 Sun, 20 Jun 2021 11:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624187293;
 bh=ysuTIytzhYGpN6sB7X0cshVo6zQPn51Xxk1B7js3ERc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JVMwlwZlhWubUqLRm0qzfJJ32BFf2Vo/WxH2kb91Ix7FQj9KaKF2jVg6quwZ8ptPA
 xoNnwinhKE2s/62Z72hZB9hhQdQF+Xe6VzmBNlX9Y0KO5Xq+aTCCUaMbNZugi0v+If
 JbgKls+yhpyhgnvVtIaso+7robyjAHKW+4J2ReqeujiPt7no1V2A2oUWnGE/pTAavE
 Pz397FgM+56jqqO9C+RojoKXTEpoFn0W+zGPbBfpuDrLAsT0h9CIm8dZP6Z3D8xGXo
 ExFVc+S+ZrPV+ftNQIcY39wzxolz6ruvlYeVhXRlKYCBZMh4HiTBi0dmwZZL1TinYz
 WOgP8YnQt0aaA==
Date: Sun, 20 Jun 2021 16:38:09 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/5] soundwire: export sdw_update() and sdw_update_no_pm()
Message-ID: <YM8hmXvz9XxkbQyt@vkoul-mobl>
References: <20210614180815.153711-1-pierre-louis.bossart@linux.intel.com>
 <20210614180815.153711-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614180815.153711-2-pierre-louis.bossart@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>, Hui Wang <hui.wang@canonical.com>,
 broonie@kernel.org, Shuming Fan <shumingf@realtek.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>, Bard Liao <bard.liao@intel.com>
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

On 14-06-21, 13:08, Pierre-Louis Bossart wrote:
> We currently export sdw_read() and sdw_write() but the sdw_update()
> and sdw_update_no_pm() are currently available only to the bus
> code. This was missed in an earlier contribution.
> 
> Export both functions so that codec drivers can perform
> read-modify-write operations without duplicating the code.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
