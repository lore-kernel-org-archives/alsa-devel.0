From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: spdif-trough and snd_ctl_elem_*
Date: Sat, 20 Jul 2002 09:11:08 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0207200909370.809-100000@pnote.perex-int.cz>
References: <s5h8z47r3xj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8z47r3xj.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: joy <joy@pingfm.org>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 19 Jul 2002, Takashi Iwai wrote:

> At Thu, 18 Jul 2002 00:31:16 +0200,
> joy wrote:
> > 
> > > well, it seems that ens1371 has still no configuration for iec958.
> > > so, the right way is to add this stuff...
> > ?
> > should i add it? will you add it? on which device is the iec958
> > running on the ens1371? i guess its hw:0,0
> 
> yes.  there is a switch "IEC958 Playback Switch", and we need to turn
> it on in pcm hook.  but i don't see any raw playback switch nor iec958
> status configuration, so i have no idea how to turn to the pass-thru
> mode.
> 
> Jaroslav, do you have any clue?

I have no information, if the ES1371 chip can configure bits in the IEC958 
stream. Maybe, all bits are hardcoded.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
