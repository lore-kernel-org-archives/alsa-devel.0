Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2BEC433C1
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 12:11:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E66D6198D
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 12:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E66D6198D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F342B950;
	Mon, 22 Mar 2021 13:10:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F342B950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616415103;
	bh=sKtlNsySk+3lyJOkySuRpOVg/xOmHDzdz+lMwu8QQCw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CwLXSAWtwMaU82OQROHYtePtLO7PcHpfHhp22BZx2pbfe/skJIU1I5R/dv1j7qWnE
	 8wxb5d1fUpqNVy7LX07imNAukrg3fb6jRirOYI89O3CxQ+gDNewOiQum+9fXu5qBv0
	 cMryhGxZV+ClJtmNYbHi/0382soA5ocRt3HKdRdc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EC03F80156;
	Mon, 22 Mar 2021 13:10:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5EF15F8016B; Mon, 22 Mar 2021 13:10:51 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0799AF8012F
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 13:10:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0799AF8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="oRYjw8ZC"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D64EE6196F;
 Mon, 22 Mar 2021 12:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616415046;
 bh=sKtlNsySk+3lyJOkySuRpOVg/xOmHDzdz+lMwu8QQCw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oRYjw8ZCNBp0L7vFuUU45dCImCBbOYOxgFBqhA5Qx0CFcNxdwQwhft+e1OnYkEZF6
 nQ6i6kR5mq2BwC3uZpBz5j5d8xr/GmJRLA6pNOn2q4N+UOocTKD6Xo0TiicpTKIr8a
 oXgKPnXZ+cCyyI77ZGIQYeIrRMW4B/1Ved9UcArf4oyQFw5ybpUH/MsJRo+pMTXJe3
 zrb/DHRmKAWMBUYaUqMdnLKPtViPw/D0r+vVdvFNA+nDp+6ASPoEISa93gLj7m5pVv
 kXO5wQfDakTV7/T8b8q/D3zxR/SfpCIJ7gEFNFs/o9yz4/8+Bu5aXhxQhMpY8GH6Ez
 0QpnLB/rymcvw==
Date: Mon, 22 Mar 2021 17:40:42 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2 0/3] soundwire: clear bus clash/parity interrupt
 before the mask is enabled
Message-ID: <YFiJQlmJH8TX46IU@vkoul-mobl.Dlink>
References: <20210302082720.12322-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302082720.12322-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

On 02-03-21, 16:27, Bard Liao wrote:
> The SoundWire specification allows a Slave device to report a bus clash
> or parity error with the in-band interrupt mechanism.
> Unfortunately, on some platforms, these errors are randomly reported and
> don't seem to be valid.
> This series suggests the addition of a Master level quirk to discard such
> interrupts. The quirk should in theory have been added at the Slave level,
> but since the problem was detected with different generations of Slave
> devices it's hard to point to a specific IP. The problem might also be
> board-dependent and hence dealing with a Master quirk is simpler.

I think this is fine approach to deal with quirks... Controllers can set
the quirk as required. I have fixed up blank line in patch 1 and applied

-- 
~Vinod
