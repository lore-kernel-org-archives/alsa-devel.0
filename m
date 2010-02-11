From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: safe support for rewind in ALSA
Date: Thu, 11 Feb 2010 08:20:53 +0100
Message-ID: <4B73AFD5.4080205@ladisch.de>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>	<20100201180139.GC15509@sirena.org.uk>	<alpine.LNX.2.00.1002011903330.25340@eeebox2.perex-int.cz>	<alpine.DEB.1.10.1002012239220.3125@ecabase.localdomain>	<alpine.DEB.1.10.1002012328440.3125@ecabase.localdomain>	<4f3252891002081459q29f02414hf168a596ab641995@mail.gmail.com>	<alpine.DEB.1.10.1002092242540.3125@ecabase.localdomain>	<4f3252891002100519h132fddb8t1f2bc56e97bf5c40@mail.gmail.com>	<4B72B665.3060903@ladisch.de>
	<4f3252891002102252vb6d7a94l76fb78e33da37775@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 333CD243BA
	for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2010 08:20:55 +0100 (CET)
Received: from compute1.internal (compute1 [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 95DB5E0F39
	for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2010 02:20:54 -0500 (EST)
Received: from [10.1.2.38] (srv004.schk01.int.dmc-one.com [85.232.8.141])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 19A4A4AD40F
	for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2010 02:20:53 -0500 (EST)
In-Reply-To: <4f3252891002102252vb6d7a94l76fb78e33da37775@mail.gmail.com>
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
> Are the one period per buffer designed for specific purpose such as
> playing/looping the pre-loaded soundfont ?

No, it's just a consequence of how the card's DMA controller is designed.

> Other than pulseaudio , are there any application use this mode  properly
> without glitch ?

The number of periods has nothing to do with glitching.

> Do you mean that PA only wake up once when configure sound card to use two
> periods per buffer ?

When using two periods per buffer, ALSA tries to wake up PA two times.
However, PA ignores the sound card's interrupts and is woken up by its
own timer.


Regards,
Clemens
