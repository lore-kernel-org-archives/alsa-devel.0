From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: sblive line capture woes
Date: Fri, 18 Oct 2002 21:36:39 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210182125030.626-100000@pnote.perex-int.cz>
References: <20021018211649.GA22671@depression.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021018211649.GA22671@depression.ath.cx>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bob Ham <node@users.sourceforge.net>
Cc: "alsa-devel @ lists. sourceforge. net" <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 18 Oct 2002, Bob Ham wrote:

> On Fri, Oct 18, 2002 at 08:31:10PM +0200, Jaroslav Kysela wrote:
> 
> > Thanks. I don't see the problem at first glance. Are you trying to capture 
> > signal from LiveDrive line #1?
> 
> No, from 'Line LineDrive',0
> 
> > Could you follow these steps?
> > 
> > Please, turn everything off (volumes and mute controls).
> 
> I ran the attached script, which appears to do the job.  The amixer output
> is also attached.
> 
> > And type 
> > this command:
> > 
> > amixer sset 'Line LiveDrive',0 capture 100 cap
> 
> Didn't work :(
> 
> > It should be sufficient. If not, it might be that we have some different 
> > names for EMU10K1 inputs. Then could you try these commands 
> > (simultaneously, if input works, try determine the right one)?
> > 
> > amixer sset 'Line LiveDrive',1 capture 100 cap
> > amixer sset 'IEC958 TTL',0 capture 100 cap
> > amixer sset 'Zoom Video',0 capture 100 cap
> > amixer sset 'IEC958 Optical' capture 100 cap
> > amixer sset 'IEC958 Coaxial' capture 100 cap
> > amixer sset 'Line LiveDrive' capture 100 cap
> 
> Didn't work either :(
> 
> > AC'97 controls should be off. There's none connection between AC'97 
> > and these inputs. Good luck.
> 
> I'll bear that in mind.
> 
> By the way, and I've no idea if it has any bearing but my snd-emu10k1
> options include snd_extin=0x3fc3 snd_extout=0x1fff.

You may try: snd_extin=0x3fff and try set Zoom Video and IEC958 TTL 
controls again to verify, if signal is not there.

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
