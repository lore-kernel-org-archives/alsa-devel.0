From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: safe support for rewind in ALSA
Date: Wed, 10 Feb 2010 14:36:37 +0100
Message-ID: <4B72B665.3060903@ladisch.de>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>	<20100201180139.GC15509@sirena.org.uk>	<alpine.LNX.2.00.1002011903330.25340@eeebox2.perex-int.cz>	<alpine.DEB.1.10.1002012239220.3125@ecabase.localdomain>	<alpine.DEB.1.10.1002012328440.3125@ecabase.localdomain>	<4f3252891002081459q29f02414hf168a596ab641995@mail.gmail.com>	<alpine.DEB.1.10.1002092242540.3125@ecabase.localdomain>
	<4f3252891002100519h132fddb8t1f2bc56e97bf5c40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 0296E244DE
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 14:36:39 +0100 (CET)
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 05BC3E0B4D
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 08:36:39 -0500 (EST)
Received: from [10.1.2.38] (srv004.schk01.int.dmc-one.com [85.232.8.141])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8304A4C2A02
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 08:36:38 -0500 (EST)
In-Reply-To: <4f3252891002100519h132fddb8t1f2bc56e97bf5c40@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> ...
> The rest of those sound cards which have period_mins = 1 are regarded as
> broken by PA developer  (e.g. intel8x0 ,emu10k1 , ens1371 , ... ) and aplay
> did not work with one period per buffer too.
> 
> what is the hardware requirement for the driver to support one period per
> buffer ?

That the hardware can be programmed to generate only one interrupt per
buffer.

> if none of the those driver can be fixed
>  why don't we change the period_min of all those broken drivers from 1 to 2
> ?

Because period_min has nothing to do with the brokenness.  PA wants to
use as few periods as possible because it does not use period interrupts
but the DMA pointer, and it's the latter that is broken.


Regards,
Clemens
