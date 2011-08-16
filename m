From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: USB Audio questions
Date: Tue, 16 Aug 2011 10:44:44 -0500
Message-ID: <11988.2521023557$1313509503@news.gmane.org>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>
	<1313432124-22591-2-git-send-email-lars@metafoo.de>
	<000001cc5b8a$4a6577c0$df306740$@bossart@linux.intel.com>
	<4E4A100D.9020302@ladisch.de> <20110816145353.GB5233@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id A6EFA244A7
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 17:44:46 +0200 (CEST)
In-Reply-To: <20110816145353.GB5233@xanatos>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Sarah Sharp' <sarah.a.sharp@linux.intel.com>, 'Clemens Ladisch' <clemens@ladisch.de>
Cc: 'ALSA Development Mailing List' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> For USB 3.0 host controllers, the HCD doesn't get the information about
> which frame exactly the transfer went out in.  This is because all the
> scheduling is done in hardware, not software.  The xHCI driver can only
> record the frame that was current when the interrupt for the URB
> happened.
> 
> Pierre, I'm not sure you can get the precise measurements you want out
> of a USB 3.0 host controller to do the audio/video sync.  You're
> welcome
> to suggest something to Steve McGowan to add to the xHCI spec, and you
> should probably double check with him that what I'm saying is correct.

Thanks Sarah for the heads-up. I was only looking at existing USB Audio
solutions for now, looks like there's some work to be done for USB3 as well.
We do need precise timing information for all audio drivers. Probably a good
topic for LPC discussions...
-Pierre
