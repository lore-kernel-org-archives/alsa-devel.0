Return-Path: <SRS0=pl6R=OU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABAEC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 15:13:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23416159A
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 15:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D23416159A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mrbrklyn.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 850E816C1;
	Thu, 30 Sep 2021 17:12:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 850E816C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633014827;
	bh=E49/YDydmu7YC8tHzY4jcu3na/sy3MEa7bzQ0eHan1o=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rFAi5p2b1IXBiC5Y4WNJu9AOdWvLJ6Vi8Q7wsjJyDz3Q9cI/QlWMDIbmOVtoiyrei
	 wvfU32MBFsQbZh7mB4TL0dbDEwW84yEXP20bfNqjvheIZk/P8P5KBsjOwFD0JSBE3b
	 8UCmlC8DvmBqzdgowyP13cryd61CUoKG4QMa9+5Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 623C0F804F3;
	Thu, 30 Sep 2021 17:11:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33910F80227; Thu, 30 Sep 2021 03:46:07 +0200 (CEST)
Received: from mrbrklyn.com (www2.mrbrklyn.com [96.57.23.82])
 by alsa1.perex.cz (Postfix) with ESMTP id ACCA9F80161
 for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2021 03:46:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ACCA9F80161
Received: by mrbrklyn.com (Postfix, from userid 1000)
 id 23F86163FB8; Wed, 29 Sep 2021 21:46:00 -0400 (EDT)
Date: Wed, 29 Sep 2021 21:46:00 -0400
From: Ruben Safir <ruben@mrbrklyn.com>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Subject: Re: ALSA kernel projects - for academic purposes
Message-ID: <20210930014559.GA23321@www2.mrbrklyn.com>
References: <CAHhAz+i=3NDuxK2rZZY6N18=OTbkna3VMVpx4nNgF0vyq3JmQA@mail.gmail.com>
 <324112.1632501120@turing-police>
 <CAHhAz+jNCd=cw-bohcoiAA2UhNZYSFLX07qEV-T2p+KAsVHhAQ@mail.gmail.com>
 <YU5QgPwYDB2XnaVP@geday> <20210929150715.GC15841@www2.mrbrklyn.com>
 <YVSzqfgqWEoju4Xw@geday>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVSzqfgqWEoju4Xw@geday>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Mailman-Approved-At: Thu, 30 Sep 2021 17:11:01 +0200
Cc: Muni Sekhar <munisekharrms@gmail.com>,
 alsa-devel <alsa-devel@alsa-project.org>, Ruben Safir <ruben@mrbrklyn.com>,
 kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-sound@vger.kernel.org,
 Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
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

> I don't see your point here. 


I know that.  So read what I wrote again and think about the original
poster sitting in a CLASSROOM and working on a thesis due in 2 months


Just try to place yourslef in another persons shoes for 15 minutes.


This guy gets assigned this task and is trying to figure out an
approach.  He is not trying to satisfy YOUR needs,  but the requirments
of is grade so he can graduate.


