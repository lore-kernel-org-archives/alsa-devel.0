Return-Path: <SRS0=pl6R=OU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD56C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 15:12:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1031B615E5
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Sep 2021 15:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1031B615E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mrbrklyn.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A21716DC;
	Thu, 30 Sep 2021 17:11:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A21716DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633014766;
	bh=1yeaZZs3L6FJtPdf39+DGAwi2G0Mz1fRXIyrEgXdn60=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vibNl+uHwPnfRtoEWEeoeRjtMESgl9nnASoILxxsBOgn/bD6YVSpoIGGmBu5bV20J
	 Op0ObQ5cT0ou/5bh2uP3hTC5KYT9DD4D7BMDfJhXxjLCek9+/UrEP7l56PoMdJXYoo
	 Wry/nxOwB8FnTinjqFASEBpo97Wfikv56NcvmPuo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C0D4F804DF;
	Thu, 30 Sep 2021 17:11:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A17C4F80105; Wed, 29 Sep 2021 17:00:59 +0200 (CEST)
Received: from mrbrklyn.com (www2.mrbrklyn.com [96.57.23.82])
 by alsa1.perex.cz (Postfix) with ESMTP id A87A9F80105
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 17:00:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A87A9F80105
Received: by mrbrklyn.com (Postfix, from userid 1000)
 id 3F0AF163F9E; Wed, 29 Sep 2021 11:00:52 -0400 (EDT)
Date: Wed, 29 Sep 2021 11:00:52 -0400
From: Ruben Safir <ruben@mrbrklyn.com>
To: jim.cromie@gmail.com
Subject: Re: ALSA kernel projects - for academic purposes
Message-ID: <20210929150052.GB15841@www2.mrbrklyn.com>
References: <CAHhAz+i=3NDuxK2rZZY6N18=OTbkna3VMVpx4nNgF0vyq3JmQA@mail.gmail.com>
 <324112.1632501120@turing-police>
 <CAHhAz+jNCd=cw-bohcoiAA2UhNZYSFLX07qEV-T2p+KAsVHhAQ@mail.gmail.com>
 <CAJfuBxxAEXnPxY-nx4JEe+fzH7J+nLYzD9zLCSzgjViBHsQbPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

> 
> also, theres now pipewire, which is new, and all the buzz.
> its apparently the future of linux audio
> 



BTW - we hear the BS every month, and yet, ALSA is still here and the
backbone of Linux sound... 


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

