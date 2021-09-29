Return-Path: <SRS0=pl6R=OU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFD4C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 15:13:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5CB615E5
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 15:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD5CB615E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mrbrklyn.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 161F916E2;
	Thu, 30 Sep 2021 17:12:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 161F916E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633014792;
	bh=Ggzy0fejFqx+Zv0QZIj8S0uPVG837aHnMIrfQo9eQts=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=onPUDQkUEaBgQm4TptMPMvfqwte3rD5lR5WiP1osm/qxrOEpfmzMJlAy/nZzw3a+u
	 1llicZ/ao/U0Zxl4vwKEIRhSluIXGXLknUy49FTKEcsNjz4R30kKvKG58ZZnRHVYiW
	 RpkEOZfj+ZBusfWwKeklY4WVa1DRGJCoj1L37OAQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 741EFF804E5;
	Thu, 30 Sep 2021 17:11:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BEA34F80227; Wed, 29 Sep 2021 17:07:22 +0200 (CEST)
Received: from mrbrklyn.com (www2.mrbrklyn.com [96.57.23.82])
 by alsa1.perex.cz (Postfix) with ESMTP id D53F7F80113
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 17:07:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D53F7F80113
Received: by mrbrklyn.com (Postfix, from userid 1000)
 id 9AAE3163F8F; Wed, 29 Sep 2021 11:07:15 -0400 (EDT)
Date: Wed, 29 Sep 2021 11:07:15 -0400
From: Ruben Safir <ruben@mrbrklyn.com>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Subject: Re: ALSA kernel projects - for academic purposes
Message-ID: <20210929150715.GC15841@www2.mrbrklyn.com>
References: <CAHhAz+i=3NDuxK2rZZY6N18=OTbkna3VMVpx4nNgF0vyq3JmQA@mail.gmail.com>
 <324112.1632501120@turing-police>
 <CAHhAz+jNCd=cw-bohcoiAA2UhNZYSFLX07qEV-T2p+KAsVHhAQ@mail.gmail.com>
 <YU5QgPwYDB2XnaVP@geday>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YU5QgPwYDB2XnaVP@geday>
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

On Fri, Sep 24, 2021 at 07:26:08PM -0300, Geraldo Nascimento wrote:
> On Fri, Sep 24, 2021 at 10:28:01PM +0530, Muni Sekhar wrote:
> > On Fri, Sep 24, 2021 at 10:02 PM Valdis Klētnieks
> > <valdis.kletnieks@vt.edu> wrote:
> > >
> > > On Fri, 24 Sep 2021 19:34:59 +0530, Muni Sekhar said:
> > > > What small projects would you suggest to a novice with the ALSA
> > > > kernel. The aim is to develop a familiarity with the ALSA kernel
> > > > source code, and also to submit it for academic purposes.
> 
> I'm not an academicist by far but if you want your patches to be academic,
> I think it's more of a question of scientific rigour and scientific
> method, 


No - it is an issue of education.  They are trying to learn something
that they don't already know.  The contribution is they become educated.

> such that when the patch(set) is finally accepted by the Linux
> community and Linus Torvalds ultimately, you can write a paper about
> it.
>


They are not writing a paper for Linus.  They are writing it for their
dean or mentor.


> Obviously there are a lot of things an academicist could bring from his
> background to improve the Linux kernel, 

Yeah - but that is not what they are trying to do.  And if that was the
case, this would likely not be the list for it, since this is a newbies
list.


> My suggestion is to ask Takashi Iwai if he has in mind 

BOINK - the doesn't need a new student dragging on his tail and if he
did then he would chose an intern to help with his code.

You are failing to understand how higher education works.

> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies


-- 
So many immigrant groups have swept through our town
that Brooklyn, like Atlantis, reaches mythological
proportions in the mind of the world - RI Safir 1998
http://www.mrbrklyn.com 

DRM is THEFT - We are the STAKEHOLDERS - RI Safir 2002
http://www.nylxs.com - Leadership Development in Free Software
http://www2.mrbrklyn.com/resources - Unpublished Archive 
http://www.coinhangout.com - coins!
http://www.brooklyn-living.com 

Being so tracked is for FARM ANIMALS and extermination camps, 
but incompatible with living as a free human being. -RI Safir 2013

