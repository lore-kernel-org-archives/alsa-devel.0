Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE9DC4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Nov 2022 14:47:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3ABFD1682;
	Wed, 23 Nov 2022 15:46:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3ABFD1682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669214828;
	bh=yaH550cdeNMLNbXJl+DEdZNkNMeJwd/85Dz+Y32n6LI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ca/zfCHCfANcAx2FOCk4Or39dB5ZsH6Q5I6pU9kK1M8wem7M+/ecbgUhomi1QAR66
	 k8sJVpPgtAfANokzZ/eRYSrA3l3Jkw9ZfU1KWrHGLlfPIGa7ARZBTEdJC3i4tX6bQI
	 nV+Aa1z9+mcHIgpUyznvHG+C+QAtIRE+p2pjUgk4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A814CF80557;
	Wed, 23 Nov 2022 15:46:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0B98F80557; Wed, 23 Nov 2022 15:46:15 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9BB8FF80557
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2022 15:46:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9BB8FF80557
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="CxN1IEEz"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 82501B8202D;
 Wed, 23 Nov 2022 14:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B133EC433C1;
 Wed, 23 Nov 2022 14:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669214771;
 bh=yaH550cdeNMLNbXJl+DEdZNkNMeJwd/85Dz+Y32n6LI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CxN1IEEzW35m0QAQc+KOd1OreLmacMFoy8EFfAjlmHKj/ei5Gg6xuqkfA7SXP30QL
 EY44Od0F6eAI0mgNm21PY8gG8VaAAxPCv/i9/EFWEPTHvT+KrwG6tQuB8jYMlZDbkc
 UWuSV+irVLFmhBHB0NU8Zg+VW/vKKzQS1Ej1t9MQ09srt0Hd64Y2CvOCSsy+SJwbs2
 e9ZtFo0bnX8kieQ/7whau3vAapRTqVR9HNgbn1ZtZspvvDPvpd8cF2NPLEWQIPZEFa
 QK9MxFOZWrJVMtmt2BauBS3s34VSqn0hBuDGrkW+09Z8ge3a9gCo+6Cv4pp7YKf26k
 Ild0AGseXTwjQ==
Date: Wed, 23 Nov 2022 20:16:07 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 6/8] soundwire: intel_init: remove sdw_intel_enable_irq()
Message-ID: <Y34yL5DbEpkBLU1x@matsya>
References: <20221111042653.45520-1-yung-chuan.liao@linux.intel.com>
 <20221111042653.45520-7-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111042653.45520-7-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, broonie@kernel.org, bard.liao@intel.com
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

On 11-11-22, 12:26, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The functionality is implemented with per-chip callbacks, there are no
> users of this symbol, remove the code.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
