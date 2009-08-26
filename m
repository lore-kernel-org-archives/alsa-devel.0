From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA default buffer sizes
Date: Wed, 26 Aug 2009 14:12:19 +0200
Message-ID: <4A9526A3.8030804@ladisch.de>
References: <21ed1c370908221347w3b62b0ado7429382fc01945c3@mail.gmail.com>	
	<4A926196.5000705@ladisch.de>
	<21ed1c370908241138n1fef462eoc636fe21ff444b35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 95EC32461B
	for <alsa-devel@alsa-project.org>;
	Wed, 26 Aug 2009 14:12:28 +0200 (CEST)
In-Reply-To: <21ed1c370908241138n1fef462eoc636fe21ff444b35@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Jander <manuel.jander@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Manuel Jander wrote:
> Can anyone tell me why choosing the smallest period size by default is
> a good idea ?

Because there a sound cards where there is no more precise information
about the current position than the period interrupt, so using smaller
periods gives better position information.

Using larger periods is useful only if you really want to save power.

Most PCI drivers have a minimum period size of 32 bytes (related to the
PCI burst size) and do not limit the number of periods, so this
algorithm tends to work just fine.

> Maybe it would be good to know inside the driver that the user program
> does not actually care about the period time?

When the program actually does not care, then it does not matter what
value gets used, so the minimum period time is correct by definition.

> The problem is, as far as I understand right now, I would have to
> increase the minimum period time of the au88x0 driver,

Just increase the maximum number of periods.

Increasing period_bytes_min to 32 or so wouldn't hurt either.

> As a work around, maybe I could set the minimum period bytes to 0,
> and if I encounter that value at snd_pcm_xxx_hw_params(), override
> that value with something useable and reasonable ?

You cannot use values that the ALSA framework does not know about.

> > au88x0_pcm.c has period_bytes_min = 0x1 and periods_max = 32.
> >
> > Is that periods_max an actual hardware limit?
> 
> No. I considered that anything beyond 32 is just plain stupid :)

Those fields are intended to enforce hardware limits.

Besides, using the sound card period interrupt as a 48 kHz timer is a
perfectly valid application.  (Well, as a stress test. :-)


Best regards,
Clemens
