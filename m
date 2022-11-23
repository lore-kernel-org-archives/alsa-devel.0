Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B3EC433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Nov 2022 14:43:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FC2D164F;
	Wed, 23 Nov 2022 15:42:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FC2D164F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669214588;
	bh=7SNmcq1yWdkIA0Q3jpHfksHLwFfvTlR32HWw7nBmwo0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aCwNk6ubyC9H97JCVHlFRlbclPaKqtDIZufXZRFainK9uXQIyDbuI6zvtGPBr/5sN
	 32UlckgfTso9Cv2KoOAHIO0v4G5LPzAZmpZVu3du6UKyJlq4x2M0DlfnZqwb9T5eoi
	 k073RD2xQ8Jxq6rBfJ3uBX95648AVr4xWj2CKWQs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A790FF80149;
	Wed, 23 Nov 2022 15:42:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 75605F8025D; Wed, 23 Nov 2022 15:42:15 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36631F80149
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2022 15:42:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36631F80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jUfiUx1e"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 147DE61D65;
 Wed, 23 Nov 2022 14:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DF7C433D7;
 Wed, 23 Nov 2022 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669214524;
 bh=7SNmcq1yWdkIA0Q3jpHfksHLwFfvTlR32HWw7nBmwo0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jUfiUx1ej1qzFn9VEbIewkkyyGFGC0dEp3Cx6CUVm2zuld2a6OeDfUYsYgnJIl4r8
 MF2BnzEOlHV2ELlxDW+8NS2+petzIuyaKYOMpYjpC8r9V1CVVZao/TZLaZB9jL0EnJ
 /42qUkmLB7Tdyx9UZ2vEh/K6ayCpkjuFce3twDDUL7NeX8XXadDzOtQADtP1XSYe+q
 wah4X0As+SHJVKqbGOoICOA11A5vvMeXVqDqLsSR/BlTPpS8696wrt27qJarz5M6wu
 NqzT5TnAQg1tZZNcHjD2Ph0tXLXMozm7V3oGYs55EYJydshJ0krXxeEp2F6OTf1pfU
 kWuElHUoYfG0A==
Date: Wed, 23 Nov 2022 20:12:00 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/7] soundwire: intel: introduce hw_ops and move
 auxdevice handling to dedicated file
Message-ID: <Y34xON3Vtfm53CB6@matsya>
References: <20221111013135.38289-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111013135.38289-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 bard.liao@intel.com, pierre-louis.bossart@linux.intel.com
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

On 11-11-22, 09:31, Bard Liao wrote:
> This series adds yet another set of cleanups
> a) all the helpers are now exposed as hw_ops callbacks
> b) the auxiliary device code is now completely generic.
> 
> This will allow for easier introduction of new hw_ops implementations in
> the future without throwing away all the goodness of the auxiliary device
> handling. Since there will be a tighter coupling with HDaudio, it's likely
> that future hw_ops are implemented in the SOF driver directly.

Applied, thanks

-- 
~Vinod
