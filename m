From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: Re: snd-hda-intel+dmix: Disabling power save doesn't
	work
Date: Tue, 08 May 2012 20:19:56 +1000
Message-ID: <joas0d$i6b$1@dough.gmane.org>
References: <jo7bfq$oeu$1@dough.gmane.org> <s5hfwbbutb8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
	by alsa0.perex.cz (Postfix) with ESMTP id A959E2414C
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 12:20:16 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1SRhWd-0006uR-3h
	for alsa-devel@alsa-project.org; Tue, 08 May 2012 12:20:11 +0200
Received: from 124-170-95-13.dyn.iinet.net.au ([124.170.95.13])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 12:20:11 +0200
Received: from a.nielsen by 124-170-95-13.dyn.iinet.net.au with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 12:20:11 +0200
In-Reply-To: <s5hfwbbutb8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> This works as expected when stopping playback, but if I only *pause* playback
>> then the signal drops almost exactly one second later, no matter what
>> "powersave" is set to.  So of course then resuming playback means I lose a
>> couple of seconds of audio while the amplifier re-syncs to the SPDIF signal.
>
> Check the powersave option value when this happens.  The system such as
> power-utils script may change the parameter by itself.

Thanks for the quick reply!  I checked this and there was no change.  Before, 
during and after playback, the module options haven't changed.

>> It doesn't happen if I use hw:0,1 as the output device (the SPDIF signal keeps
>> going, even when paused) but as soon as I change the output device to dmix
>> then the signal drops whenever the audio is paused.
>
> It's weird becauase the pause function isn't implemented in dmix at
> all.  Thus it's application's own behavior how to pause the stream.
> Usually the application stops the stream like a normal stop then
> restarts from the position manually.

Upon more experimentation I have noticed that the SPDIF signal also drops out 
during silent sections of audio.  If there's a 100% quiet part of a film or 
movie I'm watching with mplayer or another program, during the silent sections 
the signal drops out and I again miss a few seconds when they start speaking 
again.

I now realise this has been happening for a long time, as I created a .wav 
file containing 60 seconds of very quiet white noise a few years ago.  I play 
this in a loop in the background whenever I want to prevent the powersave from 
kicking in in the silent parts when I'm watching a movie.

It seems that this happens regardless of the output device - hw:0,1 or dmix 
both drop out during silent sections.  I have double-checked during pausing 
though, and as before hw:0,1 keeps going during a pause while dmix drops out.

Is dmix closing its output PCM stream when all input streams are paused or 
silent?  I'm not sure what else would cause this behaviour.

Thanks again,
Adam.
