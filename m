From: "Iovescu, Magdalena" <m-iovescu1@ti.com>
Subject: Re: Noisy audio - ALSA Configuration
Date: Thu, 16 Aug 2007 12:36:53 -0500
Message-ID: <28FEEE653F330C4FA01F6C799E7BBA5E01CDDCF5@dlee10.ent.ti.com>
References: <1187247940.16551.1205659251@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id F0C8D10384F
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Aug 2007 19:37:00 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <1187247940.16551.1205659251@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens,

Thanks. I wanted to avoid short writes as I thought that they may be the
cause of the noise I have in my audio.

What may be other reasons I get bad quality audio?

Magdalena

-----Original Message-----
From: Clemens Ladisch [mailto:cladisch@fastmail.net] 
Sent: Thursday, August 16, 2007 2:06 AM
To: Iovescu, Magdalena; alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Noisy audio - ALSA Configuration

Iovescu, Magdalena wrote:
> Does anyone have examples or documentation on how to configure
periods,
> frames and buffers for various sample rates?

Frames don't need configuration; they are dependent on the sample format
only.  In your case (S16_LE, 2 channels), one frame = four bytes.

The buffer size determines latency.  Low latency is only important when
the audio data is generated from user input in real time; when you can
read (and decode) ahead, you should better use a rather large buffer to
reduce the possibility of underruns.

Periods aren't that important.  A period is the interval between two
interrupts, so it might be better to have more small periods than fewer
large ones (unless the interrupt overhead gets too high) so that your
application can get woken up more often, but there isn't much difference
in practice.

> [...] With a buffer this big, I do not get underruns, but all the
> writes are short writes. I have not been able to find the right
> configuration to avoid short writes,

Short writes happen where there is less free space in the buffer than
you are trying to write.  This is the normal case, there's nothing wrong
with that.  Is there a reason why you want to avoid them?


Regards,
Clemens
