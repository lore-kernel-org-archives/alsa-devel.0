Return-Path: <SRS0=YhdC=HD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59007C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 10:42:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA6C64E94
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 10:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA6C64E94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFDBE1768;
	Mon,  1 Feb 2021 11:41:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFDBE1768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612176167;
	bh=TVANGH7ZETuH0LoK/AHXwSPPc/+hi8n0Z9uIpWL3w74=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JdCJnxhNhqbjQyD/QGPpnzEfuZNAxxuu1+cHmeyvHahhF2jeNY0ZAMq9uBmRM9qZ1
	 zMscENhPU8DfoH7XrkCSwNALt6vlgmGGvXxB9jcipcYiPaJm4GoKLE+p5BAxUrnmUr
	 fHmY9OFlF+8zTJi55BbXtgAxbqSNRnsCBEPcmGPI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31A5BF80151;
	Mon,  1 Feb 2021 11:41:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B835EF80156; Mon,  1 Feb 2021 11:41:13 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82B2DF80151
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 11:41:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82B2DF80151
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="J3EiX6nD"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0468E64E9D;
 Mon,  1 Feb 2021 10:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612176070;
 bh=TVANGH7ZETuH0LoK/AHXwSPPc/+hi8n0Z9uIpWL3w74=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J3EiX6nD+2WLy/6GybVaI4EEP2tYQg/LS0DNglkkgN750mbUtPx90ocGsYqB+lMZr
 +t8GYcMHa+0QVVDkW/4hiB81+5nhh4xFDnyZw8ErFDDLlR0ygauzj+JoUicT9c4sdn
 JKzDnJbRWq20UY/gWoL1maVy8/uoHxifhC5DFey/uX+YrX+5VjqvK+0ftgyXhdAG5a
 zDAhUNDeCLQW/oKNf4qpzYK2NPtOWSIOa/LpQwjx4/ff7jpYzZ9+wGtGJ/h/SaKYsD
 XA3pK1yZv6gn1LJCefMRttTgQMGKJXTiScRc8V0i+kaaT2NTvOa1sO0dWIjyYgiM7A
 2e5UNWcEv+XmA==
Date: Mon, 1 Feb 2021 16:11:05 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: return earlier if no slave is attached
Message-ID: <20210201104105.GX2771@vkoul-mobl>
References: <20210126085439.4349-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126085439.4349-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
 srinivas.kandagatla@linaro.org, jank@cadence.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

On 26-01-21, 16:54, Bard Liao wrote:
> From: Chao Song <chao.song@linux.intel.com>
> 
> If there is no slave attached to soundwire bus, we
> can return earlier from sdw_bus_prep_clk_stop() and
> sdw_bus_exit_clk_stop(), this saves a redundant value
> check.

Applied, thanks

-- 
~Vinod
