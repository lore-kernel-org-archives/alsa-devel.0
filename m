From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: core: Add flag to ignore
 pmdown_time at pcm_close
Date: Fri, 21 Oct 2011 22:31:40 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507C8CB95AD@bgsmsx502.gar.corp.intel.com>
References: <1318592614-13110-1-git-send-email-peter.ujfalusi@ti.com>
	<1318592614-13110-2-git-send-email-peter.ujfalusi@ti.com>
	<12D0C12AF19E15409D57F22566E88EF50A813690AD@bgsmsx501.gar.corp.intel.com>
	<20111021085303.GB3513@opensource.wolfsonmicro.com>
	<12D0C12AF19E15409D57F22566E88EF50A81369249@bgsmsx501.gar.corp.intel.com>
	<20111021091358.GG3513@opensource.wolfsonmicro.com>
	<12D0C12AF19E15409D57F22566E88EF50A813D504E@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 83FB6103813
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 19:01:47 +0200 (CEST)
In-Reply-To: <12D0C12AF19E15409D57F22566E88EF50A813D504E@bgsmsx501.gar.corp.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Babu, Ramesh" <ramesh.babu@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

I think the requirement is to delay the power down the link during the  music playback. There is a possibility that next song will start playing sooner. In this case, try to avoid power down and power up the DAI immediately. In case of voice call, it is not expected to have voice call immediately after a call. It can be closed. Phone stack can go ahead and close the modem path but codec path will still be open. This will cause glitches.

How will this scenario be glitch free?


-----Original Message-----
From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Babu, Ramesh
Sent: Friday, October 21, 2011 3:59 AM
To: Mark Brown
Cc: Peter Ujfalusi; alsa-devel@alsa-project.org; Liam Girdwood; Misael Lopez Cruz
Subject: Re: [alsa-devel] [PATCH v2 1/2] ASoC: core: Add flag to ignore pmdown_time at pcm_close

> This clearly isn't something that should be set in the CODEC driver, 
> it's a system integration issue - on a different board there might be 
> no such requirement.

Hmm... Ok. Thanks for clarification.

If it is a board specific requirement, then would it make sense to have it in dai_link as per Peter Ujfaulsi's RFC [1].

In general, how this kind of situation is handled?

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2011-October/045088.html

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
