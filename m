From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: How do I tell ALSA that my driver supports every
 possible sample rate?
Date: Tue, 24 Jul 2007 09:14:24 +0200
Message-ID: <1185261264.6647.1201715813@webmail.messagingengine.com>
References: <46A4CF38.3050107@freescale.com>
	<1185210867.7590.1201603759@webmail.messagingengine.com>
	<46A4E503.50207@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id B370B103852
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 09:14:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46A4E503.50207@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> Clemens Ladisch wrote:
> > To indicate that the PCM device supports all sample rates between the
> > minimum and the maximum, set SNDRV_PCM_RATE_CONTINUOUS in addition to
> > the other supported bits.
> 
> So I should do this:
> 
> 	SNDRV_PCM_RATES_5512 | SNDRV_PCM_RATE_8000_192000 | SNDRV_PCM_RATE_CONTINUOUS

Yes.

> That's not really elegant.

How could this be made more elegant?

It would be possible for ALSA to automatically set the single rate bits
that fall into the minimum/maximum range when the CONTINUOUS bit is set,
but this wouldn't help in your case because you'd still need to set
these bits in case one of the I2S/codec drivers has to remove the
CONTINUOUS bit.


Regards,
Clemens
