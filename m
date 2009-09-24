From: Rick Bronson <rick@efn.org>
Subject: Re: WM8731 using I2S on omap3 McBSP2 issues
Date: Thu, 24 Sep 2009 15:37:28 -0700
Message-ID: <E1MqwwK-0004BR-Kz@amazonia.comcast.net>
References: <E1Mqrlf-0002YF-9O@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from samwise.efn.org (efn.org [206.192.230.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F84D24427
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Sep 2009 00:37:32 +0200 (CEST)
Received: from amazonia.comcast.net (c-98-232-231-2.hsd1.or.comcast.net
	[98.232.231.2])
	by samwise.efn.org (Postfix) with ESMTP id 487E8170043
	for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2009 15:37:31 -0700 (PDT)
Received: from rick by amazonia.comcast.net with local (Exim 4.69)
	(envelope-from <rick@efn.org>) id 1MqwwK-0004BR-Kz
	for alsa-devel@alsa-project.org; Thu, 24 Sep 2009 15:37:28 -0700
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


> You shouldn't need to touch the DMA code itself, it's normally an issue
> with the clocks and/or the pinmux code not managing to get the signals
> required to clock the data transfer.

  I noticed the dma code has been changed from what I have.

  Also noticed that the beagleboard is getting DMA interrupts when I
"aplay":

cat /proc/interrupts | grep DMA

 12:       4646        INTC  DMA   

  but I'm not.  As I mentioned, I'm at "2.6.29-rc3-omap1", anyone
think there is a problem with pcm DMA's in that version?

  Thanks

  Rick
