Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729CAC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Dec 2021 16:32:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0BE851897;
	Thu, 23 Dec 2021 17:31:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0BE851897
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640277120;
	bh=5h5jlL1CoD8c3uPG+Th3OmXqA0mLDqdKzYcnCsiy/94=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MRdjSt05KAR3wbAAqDi1e2VWUBOSTyc+8jdpayzoR9mb34J/NA+TGisRa8v4HVpPj
	 CV2L6xNvZIVOg1MfkeLShhL4/auN+Jh+ADonCnpdYa8XR+RLTWDA2WBlrN0eEGRHjD
	 ttAWSc60v7GLuDdFAyYGYjpQTKgrpnkZ6shYQklY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 82A42F80084;
	Thu, 23 Dec 2021 17:31:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 342E9F80105; Thu, 23 Dec 2021 17:31:03 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D32C8F80084
 for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2021 17:30:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D32C8F80084
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UNblrztl"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D4F4EB81FC1;
 Thu, 23 Dec 2021 16:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1235C36AE9;
 Thu, 23 Dec 2021 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640277054;
 bh=5h5jlL1CoD8c3uPG+Th3OmXqA0mLDqdKzYcnCsiy/94=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UNblrztlpZhICT0sHBF0Iu0vcot62hR5AKJflq1A29L5YTNuonMuPIIN1FzzB/iiw
 OtqNvs3Ujjtbxvyt77jsJNd6vpYuhzJVU3maglC6yHOhJX64dE5k41CaMDMlbSWUCH
 OX3maWpTyPSPJ7W/SsXtHrI0XbJfizJi6fPmjk+8q8eHT10zcwmT+iCG5bPfmtJp/U
 YQNvh1miHph0e+ZQQGpuWroD6OJrQCnSNT8o1zRDag6G3r6I5idCL7cyW/vS7uraxk
 8V3ZshlUnb8IdXiEgjgxGh4m0iK1PzCT1AHm1RE1nz7wc4iRTUpImEjMriGeRO/IQE
 vKLtheWBHdAUA==
Date: Thu, 23 Dec 2021 22:00:50 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 2/7] ASoC/soundwire: intel: simplify callbacks for
 params/hw_free
Message-ID: <YcSkOuwjKNLDUIc7@matsya>
References: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
 <20211213054634.30088-3-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213054634.30088-3-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, sanyog.r.kale@intel.com,
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

On 13-12-21, 13:46, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> We don't really need to pass a substream to the callback, we only need
> the direction. No functionality change, only simplification to enable
> improve suspend with paused streams.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
