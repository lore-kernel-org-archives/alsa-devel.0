From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: about sound/core/pcm_lib.c:1997: capture read
 error (DMA or IRQ trouble?)
Date: Tue, 02 Oct 2007 13:23:50 +0200
Message-ID: <1191324230.918.1213682039@webmail.messagingengine.com>
References: <loom.20070926T031709-238@post.gmane.org>
	<1190787860.12924.1212641403@webmail.messagingengine.com>
	<loom.20070927T042730-792@post.gmane.org>
	<1190877245.11159.1212855119@webmail.messagingengine.com>
	<loom.20070928T151557-644@post.gmane.org>
	<1191221393.9447.1213434499@webmail.messagingengine.com>
	<loom.20071002T105039-455@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 46344243EC
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Oct 2007 13:23:53 +0200 (CEST)
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id D48AB3009B
	for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2007 07:23:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <loom.20071002T105039-455@post.gmane.org>
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

Akio wrote:
> > >   in my case, the sampling rate is 16k,
> > 
> > At 16 kHz, a 32-bit counter overflows after about 74.5 hours.
> 
> so the unit is samples not frames. does snd_pcm_prepare will reset
> the counter or not?

You said that snd_pcm_prepare() returns -EIO, so I guess the driver
does not.

> so I have to check out where is overflow occurred. which function
> should I dive into?

Some function in the driver.

> > Which driver are you using?
> 
> my platform is Freescale i.mx27 TO1, the audio driver is come from Freescale.

Then I'd suggest you'd ask Freescale.

In any case I cannot help you if you don't tell me where to find the
source code of the driver.


Regards,
Clemens
