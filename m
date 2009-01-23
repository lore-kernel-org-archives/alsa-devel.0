From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Misusing snd_pcm_avail_update()
Date: Fri, 23 Jan 2009 18:56:38 +0100
Message-ID: <497A04D6.4000603@ladisch.de>
References: <20090120025727.GA30499@tango.0pointer.de>	<49758B71.8090605@ladisch.de>	<20090120142614.GA27494@tango.0pointer.de>	<49761C79.8060605@ladisch.de>	<20090120202933.GA17626@tango.0pointer.de>	<s5hwscpqypo.wl%tiwai@suse.de>	<20090122222015.GB9379@tango.0pointer.de>
	<s5htz7q54k3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 843061038D7
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 18:56:43 +0100 (CET)
In-Reply-To: <s5htz7q54k3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> [...]
> My main concern is what kernel <-> user API is needed in addition or
> needed to be changed.
> 
> If it's a question how to pass the granularity to user-space, usually
> it's a constant value, and thus it can be put somewhere in the
> existing struct, or add a single ioctl. 

Most PCI devices have 32 bytes; wavetable chips have a constant time
(5.33 ms, i.e., resampled to 256 framesat 48 kHz).  But the interesting
cases are where the granularity is dependent on the period size, or
where the application could choose some arbitrary value (USB).  For
these cases, it would be very useful to have the granularity as an
interval in the PCM hardware parameters  (or probably three: bytes/
frames/time).

In the case of granularity==period, this allows PulseAudio to detect
that it has to work with small periods after it has set a small upper
bound for the granularity.  (This is exactly what the hw_param
dependencies were designed for.)

> OTOH, if it has to be implemented as a form of snd_pcm_busy_for(),
> the kernel needs the compuation like the above.  That's my concern.

Instead of writing a callback in the USB driver to compute the time
until the next underrun, I'd rather rip out that fast start code.
So, no kernel computation is needed.  :-)


Anyway, regardless of how the API looks, I see two compatibility
concerns:
* For many devices (legacy ISA, etc.), we just don't know the correct
  value.
* What should alsa-lib do when it runs on an old kernel?  It could
  return a worst-case estimate (period size), but this would cause PA
  to use small periods.  Perhaps it would be better to return some error
  ("don't know").


Best regards,
Clemens
