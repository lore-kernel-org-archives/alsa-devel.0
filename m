From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Timing Info
Date: Thu, 17 Jun 2010 17:36:59 +0200
Message-ID: <4C1A411B.2060301@ladisch.de>
References: <AANLkTil1tGrkCdRt1s9AZ8eWYG55hYrPOCq6TRaEhpRK@mail.gmail.com>	<AANLkTik3ycq3POxHRG_bc0jO-KByZVvirVJ-X9-bySY_@mail.gmail.com>	<4C14E6CB.2030909@ladisch.de>
	<AANLkTinrDq0Mx-5uf00vOqHt5YAXZ7N3BNQz5NlJB7UB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9C24F2449A
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jun 2010 17:37:11 +0200 (CEST)
In-Reply-To: <AANLkTinrDq0Mx-5uf00vOqHt5YAXZ7N3BNQz5NlJB7UB@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Dugas <paul@dugasenterprises.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Dugas wrote:
> On Sun, Jun 13, 2010 at 10:10 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> > Set SND_PCM_TSTAMP_ENABLE to generate a timestamp whenever the hardware
> > position is updated.  Call snd_pcm_status to read the position and the
> > corresponding timestamp.
> 
> I've re-read this a number of times and have been fiddling with code
> that dumps the status at various points but I'm still not grasping the
> concept here.  Can comeone point me to an explanation of the delay,
> avail, and avail_max values?

The avail value tells you how many frames are available, i.e., can be
written, in the output buffer.  The largest value that this had since
the last snd_pcm_status call is avail_max.

The delay value is the time that will elapse before the next frame that
you write into the buffer will actually be output by the hardware.  This
is not only the time until the hardware reads this frame out of the
buffer (which could be computed from avail) but also any processing
after that.


HTH
Clemens
