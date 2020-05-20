Return-Path: <SRS0=qDfi=7C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A087C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 12:01:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA4D5207D3
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 12:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fEjKfJde";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYO/p4wI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4D5207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 235C017D9;
	Wed, 20 May 2020 14:01:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 235C017D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589976117;
	bh=gXYFaHeuywZQoNmnvlqACdAzkXGUwSDZXZb5EP2pMiU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fEjKfJdeXeboFX55BWo5Q4tcrtYhDE/eSJsMYHmjL6zBsinh4KTF9ss7+6apAxuan
	 RJ5cg+m4KUhsPqNwNQSwiYjPZIwxXnhanxkpTuxc/V8+N7oV+hLf3i0r9qTV/lY2QD
	 cKUumRkyyWa4ZhqDiaitaf8QFSTaH85Gm01fwC+A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F332F801DA;
	Wed, 20 May 2020 14:01:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28303F801F9; Wed, 20 May 2020 14:01:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4DAFF80111
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2020 14:01:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4DAFF80111
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VYO/p4wI"
Received: from localhost (unknown [122.178.227.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 679E8207C4;
 Wed, 20 May 2020 12:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589976060;
 bh=gXYFaHeuywZQoNmnvlqACdAzkXGUwSDZXZb5EP2pMiU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VYO/p4wI8rY36t3/yE5oS/yS8har9AXeP1B/N186MwodO+UOTFKHUu9k3L0Gubu4T
 gz+SX/wQBDxBSD1jV63ZPWSI1+mS2QZEXPOaCogm+pfug19Blh3D/PpmlTvgRHt8Dt
 N46onprz2D/Zbo8xYIp92FOYceNT0R9vInv8KEmQ=
Date: Wed, 20 May 2020 17:30:56 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/3] soundwire: add sysfs support
Message-ID: <20200520120056.GW374218@vkoul-mobl.Dlink>
References: <20200518203551.2053-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518203551.2053-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
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

On 19-05-20, 04:35, Bard Liao wrote:
> Add soundwire sysfs support.

Thanks for this, I have applied these and two patches for issues I found,
one was trailing line in drivers/soundwire/sysfs_slave.c and other was a
typo (3rd patch)

-- 
~Vinod
