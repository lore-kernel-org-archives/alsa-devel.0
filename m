From: Marcus Andersson <054185595@telia.com>
Subject: Re: ALSA Hammerfall DSP driver
Date: Sun, 16 Jun 2002 21:02:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D0CE0D9.EF6B78A3@telia.com>
References: <200205261203.g4QC32328992@mailf.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from maila.telia.com (maila.telia.com [194.22.194.231])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA01195
	for <alsa-devel@alsa-project.org>; Sun, 16 Jun 2002 20:57:03 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

my Multiface now works. I am not quite sure exactly what I did right,
but I suspect it is that I now load snd_hammerfall_mem at boot time. I
suspect some kind of faulty state is introduced if snd_hammerfall_mem
isn't loaded in the correct way. This is impossible to correct later by
unloading all the alsa modules and start over. Maybe it can be made a
little more fault tolerant.

By the way, thanks for the driver!

Marcus

Paul Davis wrote:
> 
> >> i know its mundane, but are you sure you have the cables hooked up
> >> correctly?
> >
> >I booted windows to check the setup, and it works.
> >
> > you can set the passthru control
> >>
> >>            amixer cset name=Passthru 1
> >>
> >> and check that passthru is working OK.
> >
> >This doesn't work either.
> 
> OK, thats useful information. I wish I knew what it meant :) My best
> guess right now is that its something to do with the channel mapping;
> since the i/o configuration on the multiface is different, it may be
> that i need to change something about how we address certain channels.
> 
> ># alsactl store 1
> >alsactl: get_control:359: Unknown control type: 6
> 
> have you updated your alsa-utils and alsa-lib? there was a new control
> type (64 bit integer) introduced for the H-DSP.
> 
> >At some point the 'MIDI STATE out' is lit and stays lit. I don't use
> >MIDI. (I think, if not aplay tries to play a wav as midi.)
> 
> Do you have any idea at what point this happens?
> 
> --p

_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
