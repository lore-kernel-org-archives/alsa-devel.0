From: Frank Mandarino <fmandarino@endrelia.com>
Subject: Re: AT91 SoC PCM Capture
Date: Fri, 22 Jun 2007 13:19:26 -0400
Message-ID: <467C049E.8060807@endrelia.com>
References: <61c0054e0706220935y22b58671l72b11cf9c77c4b35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tomts24-srv.bellnexxia.net (tomts24.bellnexxia.net
	[209.226.175.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AC4C2452B
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2007 19:19:36 +0200 (CEST)
Received: from toip38-bus.srvr.bell.ca ([67.69.240.39])
	by tomts24-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070622171927.HFLS26892.tomts24-srv.bellnexxia.net@toip38-bus.srvr.bell.ca>
	for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2007 13:19:27 -0400
In-Reply-To: <61c0054e0706220935y22b58671l72b11cf9c77c4b35@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Kavan <pkavan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Kavan wrote:
> I am wondering what piece of code contains the capture functionality for
> the at91 soc. I am hoping to see how and when the pcm activates the ssc
> at read time. I just cannot figure out why TD0 would behave at such with
> this set of code and yet behave correctly with my polling code. Not a
> criticism....just wanting to figure this out.

There is very little distinction between Playback and Capture in the
ASoC AT91 implementation.  Each SSC has 2 DMA structures, one for each
direction.  The Playback DMA structure points at the SSC PDC transmit
registers and SSC transmit register masks, and the Capture DMA structure
points at the SSC PDC receive registers and SSC receive masks.  The DMA
structure to use is selected in at91_ssc_hw_params().

By doing this, at91-pcm.c DMA code can simply run the DMA transfers
without having to know which direction the data is being transferred.

Both receive and transmit SSC registers are initialized in
at91_ssc_hw_params(), regardless of the direction.

../fam
-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada
