From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio questions
Date: Tue, 16 Aug 2011 18:09:40 +0200
Message-ID: <4E4A9644.3020507@ladisch.de>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>	<1313432124-22591-2-git-send-email-lars@metafoo.de>	<000001cc5b8a$4a6577c0$df306740$@bossart@linux.intel.com>
	<4E4A100D.9020302@ladisch.de>
	<000601cc5c2a$87a26350$96e729f0$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id AC5712450B
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 18:09:42 +0200 (CEST)
In-Reply-To: <000601cc5c2a$87a26350$96e729f0$@bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: 'Sarah Sharp' <sarah.a.sharp@linux.intel.com>, 'ALSA Development Mailing List' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote:
> What is this USB frame counter and what would to enable its use, at
> least for playback where there is scope for lots of power
> optimizations.

USB timing is defined by frames, of which there are about 1000 per
second.  The audio driver schedules one packet to be sent/received for
each frame.  Multiple packets are grouped in a URB (USB request buffer);
the controller raises an interrupt when the last packet of the URB has
been completed.

By reading the current frame number, the driver could deduce how many
packets (and therefore, how many samples) have been processed by the
controller.

> > Why more efficient?  You cannot avoid double-buffering when a USB packet
> > wraps around the end of the ALSA ring buffer.
> 
> What I had in mind is a case where the ring buffer is divided in separate
> periods, which would each correspond to an integer number of URBs/packets.

This works only when the driver has control over how many samples
actually are transmitted in each USB frame.  The playback streams of
many USB audio devices work this way, but quite a few others, and
capture streams, don't.

> It's probably less generic than the current driver but a whole lot
> simpler/efficient.

The code wouldn't be simpler because we'd still need the other
algorithm.  This would be just an optimization.


Regards,
Clemens
