From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: snd-hda-intel+dmix: Disabling power save doesn't work
Date: Mon, 07 May 2012 12:19:37 +1000
Message-ID: <jo7bfq$oeu$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 96504104174
	for <alsa-devel@alsa-project.org>;
	Mon,  7 May 2012 04:30:04 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1SRDi7-0006jw-RI
	for alsa-devel@alsa-project.org; Mon, 07 May 2012 04:30:03 +0200
Received: from 124-170-95-13.dyn.iinet.net.au ([124.170.95.13])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 07 May 2012 04:30:03 +0200
Received: from a.nielsen by 124-170-95-13.dyn.iinet.net.au with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 07 May 2012 04:30:03 +0200
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

Hi all,

I'm trying to hunt down a bug in either dmix or the snd-hda-intel module and 
I'm hoping someone can give me some pointers.

When I am playing audio and I pause playback, the codec goes into power save 
and stops generating a SPDIF signal.  My amplifier then displays a 'signal 
lost' message.  This is quite annoying as it takes a few seconds to sync when 
the signal returns (during which time I can't hear the audio being played), so 
I set "powersave=0" to disable this behaviour.

This works as expected when stopping playback, but if I only *pause* playback 
then the signal drops almost exactly one second later, no matter what 
"powersave" is set to.  So of course then resuming playback means I lose a 
couple of seconds of audio while the amplifier re-syncs to the SPDIF signal.

Setting powersave to other values only affects the time before going into 
powersave mode after playback has stopped.  It has no effect on whether power 
saving is activated while paused.

The problem happens with any audio program (e.g. mplayer and xmms2.)  Setting 
"powersave=0" means the SPDIF signal keeps going when stopping playback, but 
it still drops after one second when pausing playback.

It doesn't happen if I use hw:0,1 as the output device (the SPDIF signal keeps 
going, even when paused) but as soon as I change the output device to dmix 
then the signal drops whenever the audio is paused.

Is there any way to stop this behaviour and make dmix honour the module setting?

Thanks,
Adam.
