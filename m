From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Using the timer
Date: Thu, 22 Sep 2011 13:57:58 +0200
Message-ID: <4E7B22C6.5030600@ladisch.de>
References: <CAPhDKbFdHV_7QXw=jZtmD3nmV8O0KoiREzDQ3gH=wtvf=C_L+A@mail.gmail.com>	<4E79ECAB.5030904@ladisch.de>
	<CAPhDKbFwuX_HRYYxbUiwDi=G5BU8P9j_8YVytH1bY+x03_cBuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 9BDEB24422
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 13:57:31 +0200 (CEST)
In-Reply-To: <CAPhDKbFwuX_HRYYxbUiwDi=G5BU8P9j_8YVytH1bY+x03_cBuA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ilya Dmitrichenko <errordeveloper@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ilya Dmitrichenko wrote:
> On 21 September 2011 13:54, Clemens Ladisch <clemens@ladisch.de> wrote:
> > What hardware timer?
> 
> I meant the clock of the soundcard.

The HDSP does have a sample clock, but it cannot be used independently
from a running PCM stream.

Using this PCM slave timer in the sequencer is possible, but the period
length is likely to be much larger than the desired sequencer timestamp
granularity.

What exactly do you want to do?


Regards,
Clemens
