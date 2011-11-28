From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: how to handle buffer underrun in a softsynth
Date: Mon, 28 Nov 2011 21:16:28 +0100
Message-ID: <4ED3EC1C.70100@ladisch.de>
References: <alpine.DEB.2.00.1111281636560.13399@anubis.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id CC79A103949
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 21:16:43 +0100 (CET)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A5B3B203FC
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 15:16:41 -0500 (EST)
In-Reply-To: <alpine.DEB.2.00.1111281636560.13399@anubis.informatik.uni-halle.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Henning Thielemann <alsa@henning-thielemann.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Henning Thielemann wrote:
> I have written a software synthesizer in Haskell that fetches MIDI events
> from ALSA sequencer and plays the rendered signal via ALSA pcm. However it
> cannot cope correctly with buffer underruns.
> ...
>   Now when I detect a buffer underrun on writing a block to an ALSA pcm
> sink, I like to know the time gap in order to adjust the timestamps of the
> incoming MIDI events.

The sample clock is usually not synchronized with any other clock, so
you won't be able to get a very exact measurement.

However, there is a different way to approach this problem: just disable
underruns.  :)  Set the stop_threshold to the same value as the boundary,
and ALSA will no longer stop the device when an underrun happens.=B9  This
means that you'll have to write some data more quickly than normally to
catch up=B2, but the overall timing of the samples will not be affected.

=B9 The device will still stop on fatal errors such as an unplugged USB
  device.
=B2 Or, if you detect this case, just use snd_pcm_forward(); the samples
  that are 'too late' won't be played anyway.


Regards,
Clemens
