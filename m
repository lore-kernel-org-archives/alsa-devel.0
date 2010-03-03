From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: [RFC 3/4] OMAP3: McBSP: Add interface for transmit
 FIFO state query
Date: Wed, 03 Mar 2010 08:07:52 +0200
Message-ID: <1267596472.24345.16.camel@eenurkka-desktop>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267537191-25254-4-git-send-email-peter.ujfalusi@nokia.com>
	<1267537920.24345.7.camel@eenurkka-desktop>
	<20100302160615.51cfbd64.jhnikula@gmail.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id C7FA5103807
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 07:08:32 +0100 (CET)
In-Reply-To: <20100302160615.51cfbd64.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-03-02 at 15:06 +0100, ext Jarkko Nikula wrote:
> On Tue, 02 Mar 2010 15:52:00 +0200
> Eero Nurkkala <ext-eero.nurkkala@nokia.com> wrote:
> 
> > Reading the XBUFFSTAT register is by no means accurate.
> > IIRC, it reports the buffer status incorrectly about 1/50 times
> > on average (@ 48000khz); with simple math, it may be read during the DMA
> > burst. Or is it guaranteed not being read during DMA transfer / have
> > you otherwise verified the behavior?
> > 
> Do you remember how big was this variation? Was it near the burst size
> or some arbitrary difference?
> 
> 

Mostly the samples were good (49/50, @48khz, 2 channels, value polled
from userpace), but the remaining 1/50 were garbage - and actually
matched the probability of a simultaneous DMA burst. So the problem is -
if you read at time t0, and the DMA burst is taking place at the same
time - you get a value that looks rather random, as when (if) you poll
the position @ t0 + n uS, the value is (after some usecs) a lot
different. Or maybe the XBUFFSTAT just isn't reliable at all (regardless
of DMA bursts etc).

It's easy to check - at DMA IRQ, read out the XBUFFSTAT... if the range
is not valid, print a message...(to rule out the DMA bursts).

- Eero
