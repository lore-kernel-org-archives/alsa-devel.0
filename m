Return-Path: <SRS0=S7Ib=7P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363C6C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2020 09:03:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B824B20772
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2020 09:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="J3XIGNe6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAhc4Vya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B824B20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 375D81614;
	Tue,  2 Jun 2020 11:02:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 375D81614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591088602;
	bh=ucs42Iz/kbBKflFW6zvQpMzG7SBqBXdVeSGNEUXuRjA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J3XIGNe63ZXo6hUVIN1eZ/dmW0wZr7vZ86s+zaF5KaERQvz0Td54iUI0bZMuOSlIW
	 6vked+20WRnf72ES6XoVM7OZNj1QZAB/d7+ha9fMyO0w6ak6Wm3lGSVwR1c3xMt2dr
	 Bc86a+r8GaoqooymYnuWP4xU17sk5UyrkQQC37y8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9E4AF80260;
	Tue,  2 Jun 2020 11:02:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51E29F80260; Tue,  2 Jun 2020 11:02:30 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C881BF800B8
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2020 11:02:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C881BF800B8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YAhc4Vya"
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7127420679;
 Tue,  2 Jun 2020 09:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591088540;
 bh=ucs42Iz/kbBKflFW6zvQpMzG7SBqBXdVeSGNEUXuRjA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YAhc4Vyah8ojoJC/K/dVBlgtd+tylzqZgMP2YfVjSv703EoXR6n22eBNdP1ZBrX0L
 eE+GlAf6OnOM2oGHfv0/3+sCTgf/hI8pYhr6Bmcs2du4Jh2//d1GrKfhT6nQ46TTPc
 HLt5of1DzQOFQCljjHP0qNHK9lVwe32MosM+n3+o=
Date: Tue, 2 Jun 2020 11:02:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] soundwire: clarify SPDX use of GPL-2.0
Message-ID: <20200602090219.GB2735864@kroah.com>
References: <20200531172807.27042-1-yung-chuan.liao@linux.intel.com>
 <20200601053809.GA1420218@kroah.com>
 <686345af-4fda-4bc1-c3bf-da31406e806b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686345af-4fda-4bc1-c3bf-da31406e806b@linux.intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@linaro.org, tiwai@suse.de,
 mengdong.lin@intel.com, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>, rander.wang@linux.intel.com,
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

On Mon, Jun 01, 2020 at 03:50:13PM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 6/1/20 12:38 AM, Greg KH wrote:
> > On Mon, Jun 01, 2020 at 01:28:07AM +0800, Bard Liao wrote:
> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > 
> > > Change SPDX from GPL-2.0 to GPL-2.0-only for Intel-contributed
> > > code. This was explicit before the transition to SPDX and lost in
> > > translation.
> > 
> > It is also explicit in the "GPL-2.0" lines as well, did you read the
> > LICENSES/preferred/GPL-2.0 file for the allowed tags to be used for this
> > license?
> > 
> > So this doesn't change anything, and we are trying to cut down on this
> > type of churn until, maybe, after the whole kernel has proper SPDX
> > lines.
> 
> My commit message was misleading, sorry. For SoundWire, we recently added
> new files with GPL-2.0-only (master + sysfs), as recommended since the short
> GPL-2.0 identifier is deprecated (https://spdx.org/licenses/GPL-2.0.html
> https://spdx.org/licenses/).

Again, that is the SPDX new list, of course they want to depreciate
older versions.  But we started the kernel conversion _before_ the newer
version was there, let's not worry about changing anything at this point
in time as that is unneeded churn.

For new files, fine, pick which ever tag you want to use as documented
in the LICENSES/* files, but do not change existing ones please.

thanks,

greg k-h
