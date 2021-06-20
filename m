Return-Path: <SRS0=Bo48=LO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36F1C48BDF
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 11:19:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5DA6109E
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Jun 2021 11:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5DA6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 743DB16D4;
	Sun, 20 Jun 2021 13:18:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 743DB16D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624187956;
	bh=XeKE2kaBHUnfzjf/vQMQrtOWbvMD97a5Jmepymkn9Ts=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AerwdMa4A/h4Heh4Dt32UR4PhvWX6fgl1J09QhZ+OL29UWfH20uBtza41P4VX12rA
	 XL5QLpznmB26rrqJm+D29TCdCYoEqWnUKsL7cZJFm3/x+IyiBSNMJb4sD5vls93cBf
	 ZalUsYm/kBtz3rpnm3c5i+lQnQiqgzseORCp/TP8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E7357F80271;
	Sun, 20 Jun 2021 13:17:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D79D9F80424; Sun, 20 Jun 2021 13:17:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89122F8026A
 for <alsa-devel@alsa-project.org>; Sun, 20 Jun 2021 13:17:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89122F8026A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MeyBG5pO"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D448A610CA;
 Sun, 20 Jun 2021 11:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624187859;
 bh=XeKE2kaBHUnfzjf/vQMQrtOWbvMD97a5Jmepymkn9Ts=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MeyBG5pODNkYtlVHpduy19eTQ5T9Kl3qGffbyfIiVVU5alC1LzFsY5Hm9mgoeraDz
 IEjoXUXlrkHGApQEWNx7jHdIE3HiOqOJ4d942WfSPb8jxELbKFhYCjWhymcMO9UEJ8
 gF5QjiWKz5Xt+ENy5BqXaed6ASvgfFChUtWleTw0uikJIZk3uenSpukE5rt8Kh1sXP
 vuAAlEMkDCeO7s41pV8aJckfFGbJ6CqZLiSSDv29zYxbSjXVmycO9ChmOuMFkoTNjz
 hIPxbN5Vg4QYQrI2yofFm1TZYnESeAOvK3DClclXpFf39AHQcvfrPiNcYEPchBQhNP
 1GpUauIiwMy9w==
Date: Sun, 20 Jun 2021 16:47:35 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH] soundwire: stream: Fix test for DP prepare complete
Message-ID: <YM8jz8/kzMNg9xBB@vkoul-mobl>
References: <20210618144745.30629-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618144745.30629-1-rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
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

On 18-06-21, 15:47, Richard Fitzgerald wrote:
> In sdw_prep_deprep_slave_ports(), after the wait_for_completion()
> the DP prepare status register is read. If this indicates that the
> port is now prepared, the code should continue with the port setup.
> It is irrelevant whether the wait_for_completion() timed out if the
> port is now ready.
> 
> The previous implementation would always fail if the
> wait_for_completion() timed out, even if the port was reporting
> successful prepare.
> 
> This patch also fixes a minor bug where the return from sdw_read()
> was not checked for error - any error code with LSBits clear could
> be misinterpreted as a successful port prepare.

Applied, thanks

-- 
~Vinod
