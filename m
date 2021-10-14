Return-Path: <SRS0=9Cbg=PC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D4EC4332F
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Oct 2021 15:39:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A0561053
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Oct 2021 15:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99A0561053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE5641691;
	Thu, 14 Oct 2021 17:38:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE5641691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634225985;
	bh=xd2Z6vObY1T2yHw99Gt6lAexOvTNAR+VdurjW6SSb30=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tYdjXHn0LMFuUyDkgQypGIaNIl1kDZfqFMaRNvh6ulT4DdTjBSPmEeeLYKx1vZb5L
	 xpsvDicdSaqlANNejJSLA+Lm2YwbW3+TFvsYLHVpJzQhoSoKZomhkya5B7rx7EsY2X
	 ZOt+QeeGlB7afXNX7NjyH461NngGvE7yEWm0b8B8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4034F804FA;
	Thu, 14 Oct 2021 17:37:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2429F804E6; Thu, 14 Oct 2021 17:37:17 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91D0FF8016C
 for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2021 17:37:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91D0FF8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="CscNlMOp"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0280660F70;
 Thu, 14 Oct 2021 15:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1634225820;
 bh=xd2Z6vObY1T2yHw99Gt6lAexOvTNAR+VdurjW6SSb30=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CscNlMOppfUWGVMGjG8pPx/9FzogQ4u8ANpyWZwElqePOpLAukvJYpA668RTTaZr2
 LaN7cLQICW6SA4p2HtPGZF8A9jPReJ4cJDO18XCTyo0Hdx0chYhm14fnQS7F4/Q6pu
 2oMEj/LKcdUN2YulJ/QzIDC42bjiMKMVvETYuHkY=
Date: Thu, 14 Oct 2021 17:36:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 0/3] ALSA: usb-audio: Small improvements in mixer handling
Message-ID: <YWhOmu+msvC+suVv@kroah.com>
References: <20211014130636.17860-1-tiwai@suse.de> <YWhBxq5Sf/bAcGLk@kroah.com>
 <s5h35p3wsks.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h35p3wsks.wl-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
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

On Thu, Oct 14, 2021 at 05:10:11PM +0200, Takashi Iwai wrote:
> On Thu, 14 Oct 2021 16:42:14 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > On Thu, Oct 14, 2021 at 03:06:33PM +0200, Takashi Iwai wrote:
> > > Hi,
> > > 
> > > this is a patchset with small fixes for improving the USB-audio mixer
> > > behavior.  Instead of treating the error from a control message
> > > continuously, initialize all at the probe and keep the rest working.
> > > 
> > > The first two patches are rather fixes for error messages in
> > > get_ctl_value_v2() function, the last one implements the new
> > > behavior.
> > > 
> > > 
> > > Takashi
> > > 
> > > ===
> > > 
> > > Takashi Iwai (3):
> > >   ALSA: usb-audio: Downgrade error message in get_ctl_value_v2()
> > >   ALSA: usb-audio: Drop superfluous error message after disconnection
> > >   ALSA: usb-audio: Initialize every feature unit once at probe time
> > > 
> > >  sound/usb/mixer.c | 42 ++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 36 insertions(+), 6 deletions(-)
> > > 
> > > -- 
> > > 2.26.2
> > > 
> > 
> > These work great for me, combined with the quirk patch I sent:
> > 
> > Tested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Thanks for quick testing!
> 
> As those are no urgent fixes, I'm going to queue them for 5.16.

No rush from my side, thanks!

greg k-h
