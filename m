Return-Path: <SRS0=jkt5=7E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE62FC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 07:29:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B213206DD
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 07:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XVr44sYi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="quDWI+OJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B213206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C65C1861;
	Fri, 22 May 2020 09:28:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C65C1861
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590132576;
	bh=a+GWZTXoEmAqJ588Ld4QrK6+dfifuM37WVBYkefXSgA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XVr44sYiE3gSZSYYqWo9Ny23q4ADWHQvXcwNqYg658XB0qDadtxBIjpv1D17pfhfK
	 /3Xrgphy/wWhuoeftCLpP/8DeEV3QDS269LmSMjgrUMp+q/CAwZm8Yx1IGIG/X9sPF
	 ZKrCzeIH0w8jPJIXApHDnB9w+2FaTZybkjZc9O6Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B938F801DA;
	Fri, 22 May 2020 09:28:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F05D8F801F9; Fri, 22 May 2020 09:28:42 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 575AEF80111
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2020 09:28:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 575AEF80111
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="quDWI+OJ"
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 94223206DD;
 Fri, 22 May 2020 07:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590132514;
 bh=a+GWZTXoEmAqJ588Ld4QrK6+dfifuM37WVBYkefXSgA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=quDWI+OJ7MZQgBlI9ukwhi9CNgoNFN6Y9tPAex3fnyo7GLU8VnsHkTa7ArhP2vU4v
 6Gul75XflD0bDuPoiv4fGUh+EGcWwuDr8oQkFpY/ulcP2N4/GKtIGR0A2xqdIdA8lG
 j+IdQd3iTsR9e3UpBG8Zzoaljfcvwbw7+g0fvjZ8=
Date: Fri, 22 May 2020 09:27:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [GIT PULL] soundwire updates for v5.8-rc1
Message-ID: <20200522072751.GA853066@kroah.com>
References: <20200521142739.GB374218@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521142739.GB374218@vkoul-mobl.Dlink>
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
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

On Thu, May 21, 2020 at 07:57:39PM +0530, Vinod Koul wrote:
> Hi Greg,
> 
> Please pull to receive updates for soundwire. The big news the
> sdw_master_device getting completed along with sysfs attributes for
> master and slave devices. That closes the long cleanup work done by
> Pierre and Bard for the devices.
> 
> The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:
> 
>   Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.8-rc1

Pulled and pushed out, thanks.

greg k-h
