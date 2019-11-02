Return-Path: <SRS0=jALZ=Y2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539DCCA9EC7
	for <alsa-devel@archiver.kernel.org>; Sat,  2 Nov 2019 17:18:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC65321726
	for <alsa-devel@archiver.kernel.org>; Sat,  2 Nov 2019 17:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LvjIKdW2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+y6PFIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC65321726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 051A21863;
	Sat,  2 Nov 2019 18:17:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 051A21863
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572715105;
	bh=sjuoZaqU4GAqTScDiLGEB5iAcCmD2yVcWVerhrNI3KI=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LvjIKdW2I3P+vWkMRA6BzE7rbg6A6JpnlzIMmlySAldO8TzcBa72IfXT+5FnDg9vv
	 LbYNPfAJoPXzzCXdMXbIW9Mdgti2pKM1pkUXS+FFsGAF8grJZgitXzguvthXxHEpZ9
	 rfdfhgZmTihJ/OVH132ir21mJskfDDbT2kGJmIN0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70269F80361;
	Sat,  2 Nov 2019 18:17:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7B931F80392; Sat,  2 Nov 2019 18:17:10 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD935F80361
 for <alsa-devel@alsa-project.org>; Sat,  2 Nov 2019 18:17:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD935F80361
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="A+y6PFIM"
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C91AE218AC;
 Sat,  2 Nov 2019 17:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572715023;
 bh=GfQZUABhRi5OXyXYO6lH8FZhAHfWp5MMlR+i3/nES8U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A+y6PFIMFFdJFUZ14xT8WjFhSXeVpe1WlLeE8anw3zqlW5XiWqgqfo8ADuiospU5O
 Tib2MySF1VSyv7tpn0X2TBNucsn9M1M2xD4GVPwjm4I7XfsSCZp+4UGVKL3vFC2qaQ
 yWYPa/gqq40mD0fWUJK695XF8Ct6KOe5ZPmg7vKw=
Date: Sat, 2 Nov 2019 18:16:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Vinod Koul <vkoul@kernel.org>
Message-ID: <20191102171653.GE484428@kroah.com>
References: <20191031095307.GB2695@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191031095307.GB2695@vkoul-mobl.Dlink>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [GIT PULL] soundwire fixes for v5.4-rc6
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, Oct 31, 2019 at 03:23:07PM +0530, Vinod Koul wrote:
> Hi Greg,
> 
> Please pull to receive couple of fixes for soundwire. All these changes
> have been sitting in linux-next as well
> 
> The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:
> 
>   Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.4-rc6

Pulled and pushed out, thanks.

greg k-h
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
