From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: M-Audio Revolution and MythTV
Date: Mon, 1 Mar 2004 09:17:56 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403010917310.1870@pnote.perex-int.cz>
References: <1078107493.5239.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078107493.5239.19.camel@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ann Patterson <annp322@sbcglobal.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 29 Feb 2004, Ann Patterson wrote:

> I installed a M-Audio Revolution 7.1 (snd-ice1724) in my mythtv box. I
> had mythtv working fine with the machine's onboard sound (snd-trident)
> using OSS emulation. The revo works correctly for things like xine,
> mplayer, aplay (of course), play, etc. In mythtv, however, I get no
> sound. 
> 
> I dug into the mythtv code, and found that it is doing a call to
> ioctl(audiofd, SNDCTL_DSP_GETOSPACE, &info) and using the info.bytes
> value that is returned to determine whether or not to write to the card.
> The first call to SNDCTL_DSP_GETOSPACE appears to return a reasonable
> number, but from that point, the numbers returned are all over the
> place, and are often negative. So, mythtv, of course, won't write to the
> card. I find that if I comment out the code that checks the values
> returned from GETOSPACE, I get sound, but it is out of sync with the
> video (sound slightly behind video).
> 
> I'm using the dmix plugin, if that matters, but I got the same results
> without the plugin.
> 
> I'm willing to debug this further, but I've not done anything with alsa
> or soundcards before, so I need a bit of help in determining where to
> look.

Can you write a nice small test code which shows this problem? You may 
modify code in alsa-oss/test/osstest.c .

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
