From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Audacity-devel reports bug in Alsa OSS emulation
Date: Wed, 18 Feb 2004 19:50:38 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402181949480.10724@pnote.perex-int.cz>
References: <4033A8EE.1030701@starhub.net.sg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4033A8EE.1030701@starhub.net.sg>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Richard Chan <rspchan@starhub.net.sg>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 19 Feb 2004, Richard Chan wrote:

> Hi,
> 
> I'm using Audacity with Alsa OSS emulation - I have observed an infamous 
> Audacity cursor bug
> with Alsa OSS emulation. Another user has tracked it down as follows:
> 
> Quote:
> 
> " I made some investigations about this problem and discovered that the ALSA
> OSS emulation is broken: ioctl(fd, SNDCTL_DSP_GETOPTR, &info) sometimes
> returns wrong results.
> I do not know ALSA enough to fix it, but I have patched an audacity source
> file as a workaround."
> 
> Known bug? Worth fixing?

No. I'm actually writting our own test tool. Anyway, what's your hardware? 
Is resampling on the way (see /proc/asound/card0/pcm0p/sub0/* files for 
more details)?

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
