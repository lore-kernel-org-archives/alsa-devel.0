Return-Path: <SRS0=pl6R=OU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A8EC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 15:14:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D15D6159A
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 15:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D15D6159A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mrbrklyn.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B6D8F16CC;
	Thu, 30 Sep 2021 17:13:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B6D8F16CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633014867;
	bh=WDr82usZnpVyAIhdQa/WBYEwY6iv94hZDJJl+FXQpAw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F/cyKsPXGtBz7eUJUYA/3MEq82OcLBEoFKJpsxbGzlRBENASisxMtERBa9+1ks19H
	 ZsDs541nO659FVQy0TeBgErWooQqsnILkxu8EeoWQqU2e8yL2IURg1MnqUxijkqP+0
	 X/j8HIG/N7s7np9kNHnkJZetbaLSU1xs/9NVFxSk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A26D1F804FE;
	Thu, 30 Sep 2021 17:11:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22F1EF804AD; Thu, 30 Sep 2021 05:01:43 +0200 (CEST)
Received: from mrbrklyn.com (www2.mrbrklyn.com [96.57.23.82])
 by alsa1.perex.cz (Postfix) with ESMTP id 01C16F800F3
 for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2021 05:01:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01C16F800F3
Received: by mrbrklyn.com (Postfix, from userid 1000)
 id 26EAB163F9E; Wed, 29 Sep 2021 23:01:33 -0400 (EDT)
Date: Wed, 29 Sep 2021 23:01:33 -0400
From: Ruben Safir <ruben@mrbrklyn.com>
To: Aruna Hewapathirane <aruna.hewapathirane@gmail.com>
Subject: Re: ALSA kernel projects - for academic purposes
Message-ID: <20210930030132.GA24271@www2.mrbrklyn.com>
References: <CAHhAz+i=3NDuxK2rZZY6N18=OTbkna3VMVpx4nNgF0vyq3JmQA@mail.gmail.com>
 <CAFSeFg8UJtt1mUSE+ue8kjh5y=yR68g4SuwAcDrRGNXHHMsi=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFSeFg8UJtt1mUSE+ue8kjh5y=yR68g4SuwAcDrRGNXHHMsi=Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Mailman-Approved-At: Thu, 30 Sep 2021 17:11:01 +0200
Cc: Muni Sekhar <munisekharrms@gmail.com>,
 alsa-devel <alsa-devel@alsa-project.org>, linux-sound@vger.kernel.org,
 kernelnewbies <kernelnewbies@kernelnewbies.org>
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

Bingo 


Correct Answer


On Wed, Sep 29, 2021 at 10:11:33PM -0400, Aruna Hewapathirane wrote:
> On Fri, Sep 24, 2021 at 10:05 AM Muni Sekhar <munisekharrms@gmail.com>
> wrote:
> 
> > Hi all,
> >
> >
> > What small projects would you suggest to a novice with the ALSA
> > kernel. The aim is to develop a familiarity with the ALSA kernel
> > source code, and also to submit it for academic purposes.
> >
> >
> > --
> > Thanks,
> > Sekhar
> >
> 
> 
> 1. Read the documentation for the Linux Sound Subsystem :
> https://www.kernel.org/doc/html/latest/sound/index.html
> 2. Then try to understand the the ALSA Driver API
> 3. In your kernel source tree under the sound folder/directory you will
> find lot's of useful source code.
> 
> If you open the /sound/x86/intel_hdmi_audio.h file at the very top you will
> see what is below:
> 
> // SPDX-License-Identifier: GPL-2.0-only
> /*
>  *   intel_hdmi_audio.c - Intel HDMI audio driver
>  *
>  *  Copyright (C) 2016 Intel Corp
>  *  Authors: Sailaja Bandarupalli <sailaja.bandarupalli@intel.com>
>  * Ramesh Babu K V <ramesh.babu@intel.com>
>  * Vaibhav Agarwal <vaibhav.agarwal@intel.com>
>  * Jerome Anand <jerome.anand@intel.com>
>  *
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  *
>  *
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  * ALSA driver for Intel HDMI audio
>  */
> 
> All the authors you will notice are from intel and seem to be all south
> asian :-))) pure coincidence ? I somehow
> do not think so.
> 
> Muni in my experience what I have learnt  over the years is there will be
> times when you ask a question and
> you will get very negative or straight-up demoralising and demotivating
> toxic remarks and comments. My advice
> to you is this:
> 
> Have a deaf ear to the obstacles and negative comments, rather use them as
> motivation to achieve your goals.
> 
> *Lesson to take away:*
> 
>    1. Alas! We can’t have a deaf ear to the negative comments that we
>    receive so abundantly from people all around us.
>    I mean even those who don’t usually give advice, would try to stop you
>    from doing something you so eagerly wanted to do,
>    even when they themselves don’t know anything about it. But we can,
>    however, avoid them or use them as a motivation
>    to prove them wrong. Yep, use their words to prove them wrong!
> 
> Good luck - Aruna

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

