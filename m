From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dmix plugin
Date: Wed, 12 Feb 2003 14:55:45 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302121451180.17076-100000@pnote.perex-int.cz>
References: <s5hlm0ln13y.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA06028
	for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2003 14:56:00 +0100
In-Reply-To: <s5hlm0ln13y.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Feb 2003, Takashi Iwai wrote:

> At Wed, 12 Feb 2003 10:45:41 +0100 (CET),
> Jaroslav wrote:
> > 
> > Here is an .asoundrc example configuration (plugin defaults are 48kHz, 
> > stereo, signed 16-bit little endian):
> > 
> > pcm.dmix {
> > 	type dmix
> > 	ipc_key 1234	# must be unique for all dmix plugins!!!!
> > 	slave {
> > 		pcm "hw:0,0"
> > 	}
> > }
> > 
> > 	Then try: 'aplay -Dplug:dmix <filename>' on multiple consoles.
> 
> confirmed to work fine on my machine.  great!
> 
> one thing noticed is that even the different sample rate is accepted
> without plug and ersults in too fast/slow playback.  just a minor
> problem, though.

Note that aplay uses snd_pcm_hw_params_set_rate_near() function, so it's
not guaranteed that rate is same as requested. I've added a check to aplay
- if rate doesn't fall into 5% limit, then warning is reported now.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
