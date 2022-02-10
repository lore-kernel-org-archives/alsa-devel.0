Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074DBC433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Feb 2022 13:50:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3195C1929;
	Thu, 10 Feb 2022 14:49:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3195C1929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644501022;
	bh=QI5LDB2KPQTsI0Rf8cfbWacWSB1sk8X6zQXAsK+3whk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZzCtaK9ZSZBt2GDT1PXpB2CTgF/sJIgVdao9LYhySYcVrWorpPa+KVKe1kaiN3AI7
	 QS1FCZJUuy9c08FjwwnVuYYVNOBVuDgPZu2UdeCij2wIAFONP68RwuW0ZsXDNYjTYM
	 UA0LSaIkjKZMJW34eWi7pKnoQJFjACuv7ruT2hNQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8FC8F80423;
	Thu, 10 Feb 2022 14:49:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D2D6F80302; Thu, 10 Feb 2022 14:49:04 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C614AF80302
 for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2022 14:48:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C614AF80302
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dFBZodrb"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DDC03B82559;
 Thu, 10 Feb 2022 13:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30CFC004E1;
 Thu, 10 Feb 2022 13:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644500935;
 bh=QI5LDB2KPQTsI0Rf8cfbWacWSB1sk8X6zQXAsK+3whk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dFBZodrbTVhElVqc2vFBBsPARCCo5mBBJX6FR2cvh9qqZIk3XZvF0axuJzDyhYR2c
 2vjzZSsyS0DBW48d8vD0JL0o0LXB5YYXBQwV+VwTM5FWlb24FR3tW9aFgsoR32VLIk
 A4uSWtOSCRkJvCN41sAjUzXtilYmAdJ//FI1lvC/OBnBM8weHxaGhKL6S43JZd38dj
 wMvV6k2l5OstMy3gelb+0grLRZ3IKSxz4WTukDolpMysbLGBPiheTFZ8cKX/14ax5e
 lbBsJGchIN9G7HxA3CPXbi+H77OnwWc+mCkcK38TpajDolsBo6Tw7unyuBpWxt1Pbr
 6BFFrIK+kd/oA==
Date: Thu, 10 Feb 2022 19:18:51 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: bus: add dev_warn() messages to track
 UNATTACHED devices
Message-ID: <YgUXw59EzUx8BXYm@matsya>
References: <20220126011527.27930-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126011527.27930-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 srinivas.kandagatla@linaro.org, sanyog.r.kale@intel.com, bard.liao@intel.com
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

On 26-01-22, 09:15, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> In rare cases, some devices seem to lose sync and never re-attach on
> the bus. This seems to happen only when there are more than one device
> per link, which suggests either an electrical issue, a race condition
> or a state machine issue.
> 
> Add two dev_warn() messages to identify the sequence by which the
> devices become UNATTACHED.

Applied, thanks

-- 
~Vinod
