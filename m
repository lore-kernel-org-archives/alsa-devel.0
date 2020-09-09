Return-Path: <SRS0=lIjM=CS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3271AC43461
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 06:27:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD7920C09
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 06:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="O+jtc2Jy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="FFf6yfDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD7920C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C5DA116EF;
	Wed,  9 Sep 2020 08:26:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C5DA116EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599632857;
	bh=e/ZBcQKT82oAYWdfyTAVwhkKixk9eFrrms8Prt8GvBA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O+jtc2JylmdrkHlMkR57Nh5vR/zpPT/c9VkTSs2tm5+5yzT1/s30h99M8JiM+ER6Q
	 F9z1nYwydws8ECHY1ReK4E7po64qOYyT5CWScp5jKUpSV/dsYMNuWadioJUpXDEKlG
	 BnZS+f91QudTTvYNxJsBE1D/NQzFL4n4MzG3O1KQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4ADDBF800E9;
	Wed,  9 Sep 2020 08:26:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8CACDF8021C; Wed,  9 Sep 2020 08:26:40 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 157D8F800E9
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2020 08:26:29 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 411ECA003F;
 Wed,  9 Sep 2020 08:26:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 411ECA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1599632788; bh=6TM8UZlhBVv9GZrB00/bGCYuJ/Qyusmp7Cmt1ltZKcU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=FFf6yfDs3hx+hvXuYuWrkEfLUTOhqOAtk4wkhSPmdAVgR+55abBg9kGOR/HUGfNJJ
 Z5S2vP0gJXEQG/RBsVWsmRabvxqKUGHStNN06cMAPG+G1A3UBMmR0DJRiPUnfV3L7W
 I/6xuxSFxXgi5ZdnRcLvIMBY8M+Bs6Bt3Gc4IPzU=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  9 Sep 2020 08:26:13 +0200 (CEST)
Subject: Re: [PATCH] soundwire: Add generic bandwidth allocation algorithm
To: Bard Liao <yung-chuan.liao@linux.intel.com>, alsa-devel@alsa-project.org, 
 vkoul@kernel.org
References: <20200908131520.5712-1-yung-chuan.liao@linux.intel.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <fdf22a3c-457f-09ef-8dc5-c0f3871cf2ce@perex.cz>
Date: Wed, 9 Sep 2020 08:26:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908131520.5712-1-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: vinod.koul@linaro.org, gregkh@linuxfoundation.org,
 ranjani.sridharan@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org, bard.liao@intel.com,
 jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, linux-kernel@vger.kernel.org
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

Dne 08. 09. 20 v 15:15 Bard Liao napsal(a):
> This algorithm computes bus parameters like clock frequency, frame
> shape and port transport parameters based on active stream(s) running
> on the bus.
> 
> Developers can also implement their own .compute_params() callback for
> specific resource management algorithm, and set if before calling
> sdw_add_bus_master()
> 
> Credits: this patch is based on an earlier internal contribution by
> Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah. All hard-coded
> values were removed from the initial contribution to use BIOS
> information instead.
> 
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/Kconfig                     |   5 +
>  drivers/soundwire/Makefile                    |   3 +
>  drivers/soundwire/bus.c                       |   6 +
>  drivers/soundwire/bus.h                       |  46 +-
>  .../soundwire/generic_bandwidth_allocation.c  | 427 ++++++++++++++++++
>  drivers/soundwire/intel.c                     |   3 +
>  drivers/soundwire/stream.c                    |  12 +
>  include/linux/soundwire/sdw.h                 |   3 +
>  8 files changed, 503 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/soundwire/generic_bandwidth_allocation.c

I did testing and I've not found any issues. The abstraction looks good.

Acked-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
