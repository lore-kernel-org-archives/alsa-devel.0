From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: sblive line capture woes
Date: Fri, 18 Oct 2002 20:31:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210182021520.626-100000@pnote.perex-int.cz>
References: <20021018200317.GA22229@depression.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021018200317.GA22229@depression.ath.cx>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bob Ham <node@users.sourceforge.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 18 Oct 2002, Bob Ham wrote:

> On Fri, Oct 18, 2002 at 07:22:08PM +0200, Jaroslav Kysela wrote:
> 
> > Please, send us output from 'amixer scontents' and 'amixer contents' to 
> > figure out the problem. Thanks.
> 
> Attached.

Thanks. I don't see the problem at first glance. Are you trying to capture 
signal from LiveDrive line #1?

Could you follow these steps?

Please, turn everything off (volumes and mute controls). And type 
this command:

amixer sset 'Line LiveDrive',0 capture 100 cap

It should be sufficient. If not, it might be that we have some different 
names for EMU10K1 inputs. Then could you try these commands 
(simultaneously, if input works, try determine the right one)?

amixer sset 'Line LiveDrive',1 capture 100 cap
amixer sset 'IEC958 TTL',0 capture 100 cap
amixer sset 'Zoom Video',0 capture 100 cap
amixer sset 'IEC958 Optical' capture 100 cap
amixer sset 'IEC958 Coaxial' capture 100 cap
amixer sset 'Line LiveDrive' capture 100 cap

AC'97 controls should be off. There's none connection between AC'97 
and these inputs. Good luck.

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
