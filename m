From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to pair Wine with ALSA? part1: intro &
 underruns (long)
Date: Tue, 16 Aug 2011 09:16:08 +0200
Message-ID: <4E4A1938.5080209@ladisch.de>
References: <8E4C156DA5797D418DBFADFD8CE655A4138FB471F5@HE113481.emea1.cds.t-internal.com>	<4E47BE17.1000205@ladisch.de>
	<8E4C156DA5797D418DBFADFD8CE655A41392BAD314@HE113481.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id E0FE6245E3
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 09:16:11 +0200 (CEST)
In-Reply-To: <8E4C156DA5797D418DBFADFD8CE655A41392BAD314@HE113481.emea1.cds.t-internal.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joerg-Cyril.Hoehle@t-systems.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Joerg-Cyril.Hoehle@t-systems.com wrote:
> Clemens Ladisch wrote:
> > > [...]  GetPosition returns "the stream position of the sample that
> > > is currently playing through the speakers".
> >However, does that documentation actually make a distinction between the
> >last sample that has been read from the buffer and the sample being played?
> 
> Er, what do you mean?

Er, that I didn't read the documentation.  After Googling, I see that
your interpretation is correct.

> BTW, I thought dmix could be used with any card, but I found no
> one-liner syntax to open card 1 with dmix.  It seemed hard-wired (by
> configuration) to card0 (not that I'm familiar with ALSA conf syntax).

Device names can have parameters; you can use "dmix:x" or "dmix:CARD=x"
or "dmix:{ CARD=x; }" or whatever other syntax is allowed by ALSA's
configuration system.  And yes, it's mostly undocumented.

> >Configuring the device to stop on xruns seems to be a better fit for
> >your requirements.
> 
> That's what Wine used to do in the former driver.
> 
> But it's precisely because dmix does(did?) not support xrun detection
> that I started looking into the free-running mode.

Any device _must_ stop on xrun, if so configured.  Not doing so would
be a bug.  Could you still reproduce it now?

> >The meaning of ALSA's periods is as follows:
> >2) When ALSA is blocked (in snd_pcm_write* or in poll), it checks
> >    whether to wake up the application only when an interrupt arrives.
> 
> What about non-blocking mode?  Do you mean to imply that in
> non-blocking mode, never using poll() causes period_size to become
> irrelevant from the app POV?

Yes.  Recently, the possibility to disable interrupts (period_wakeup)
was added to a few drivers; PulseAudio uses this.
http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.html#gfbacdcf2339d2d6ad984815f6b720888

> The new driver doesn't use poll at all.  It uses a fixed rate timer
> signal.  Is that against any recommendations?  What's bad about it?

Well, that duplicates PulseAudio's code.  ;-)


Regards,
Clemens
