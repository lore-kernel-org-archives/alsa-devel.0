Return-Path: <SRS0=pl6R=OU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7467BC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 15:12:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 606A3615E5
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 15:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 606A3615E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mrbrklyn.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F178616C2;
	Thu, 30 Sep 2021 17:11:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F178616C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633014759;
	bh=UszC3uVWm8neBD7sr19m9jVI9ymJweEKhoaQYEXla+k=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pvCQfZVBr5HTDSBFA00aXY0zArY8lxtiRsGuqJPphwfWxv6frLAXEqGpLI1NJFfYm
	 yf2aheIobMULe8IQa5U9s4g38J5F1k1TexFNdUbp1PiVQYL6q46nx+vVOvzGoGt6V9
	 mBgWmv22JoyjRcisxvX25nK3pqynEu3Q3lpE6Z0c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36061F804D2;
	Thu, 30 Sep 2021 17:11:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98603F80227; Wed, 29 Sep 2021 16:59:26 +0200 (CEST)
Received: from mrbrklyn.com (www2.mrbrklyn.com [96.57.23.82])
 by alsa1.perex.cz (Postfix) with ESMTP id 0F7CBF80105
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 16:59:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F7CBF80105
Received: by mrbrklyn.com (Postfix, from userid 1000)
 id EE421163F8F; Wed, 29 Sep 2021 10:59:13 -0400 (EDT)
Date: Wed, 29 Sep 2021 10:59:13 -0400
From: Ruben Safir <ruben@mrbrklyn.com>
To: jim.cromie@gmail.com
Subject: Re: ALSA kernel projects - for academic purposes
Message-ID: <20210929145913.GA15841@www2.mrbrklyn.com>
References: <CAHhAz+i=3NDuxK2rZZY6N18=OTbkna3VMVpx4nNgF0vyq3JmQA@mail.gmail.com>
 <324112.1632501120@turing-police>
 <CAHhAz+jNCd=cw-bohcoiAA2UhNZYSFLX07qEV-T2p+KAsVHhAQ@mail.gmail.com>
 <CAJfuBxxAEXnPxY-nx4JEe+fzH7J+nLYzD9zLCSzgjViBHsQbPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfuBxxAEXnPxY-nx4JEe+fzH7J+nLYzD9zLCSzgjViBHsQbPA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Mailman-Approved-At: Thu, 30 Sep 2021 17:11:01 +0200
Cc: Muni Sekhar <munisekharrms@gmail.com>,
 alsa-devel <alsa-devel@alsa-project.org>,
 Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
 linux-sound@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
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

On Fri, Sep 24, 2021 at 11:15:35AM -0600, jim.cromie@gmail.com wrote:
> On Fri, Sep 24, 2021 at 10:58 AM Muni Sekhar <munisekharrms@gmail.com> wrote:
> >
> > On Fri, Sep 24, 2021 at 10:02 PM Valdis Klētnieks
> > <valdis.kletnieks@vt.edu> wrote:
> > >
> > > On Fri, 24 Sep 2021 19:34:59 +0530, Muni Sekhar said:
> > > > What small projects would you suggest to a novice with the ALSA
> > > > kernel. The aim is to develop a familiarity with the ALSA kernel
> > > > source code, and also to submit it for academic purposes.
> > >
> > > A good place to start is getting a good handle on what the phrase "the ALSA
> > > kernel" even means.
> > Basically looking for kernel space audio subsystem projects rather
> > than its user-space library(alsa-lib) and utilities(alsa-utils).
> 
> why ?
> if your interest is better sound, then improving user-space is going
> to be more productive.


Because he wants to, that is why.  It is his agenda, not yours.

I am not sure if people percieve just how much of a jerk they sound when
they routely redirect a question to their favorite view of how the world
should work.

Either help or shut up

