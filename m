From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Kernel OOP with alsaplayer driver
Date: Tue, 20 Aug 2002 15:15:49 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208201515200.12251-100000@pnote.perex-int.cz>
References: <20020820125953.GA920@orbital.xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020820125953.GA920@orbital.xs4all.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Andy Lo-A-Foe <andy@alsaplayer.org>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Aug 2002, Andy Lo-A-Foe wrote:

> On Tue, Aug 20, 2002 at 02:27:23PM +0200, Takashi Iwai wrote:
> 
> > could you check via strace which ioctl triggers this?
> > strangely i cannot reproduce this on my machine.
> 
> strace gives the following (parsed):
> 
> ....
> ....
> open("/dev/snd/pcmC0D0p", O_RDWR)       = 4
> ioctl(4, AGPIOC_INFO, 0xbfffdf60)       = 0
> ....
> ioctl(4, 0xc25c4110, 0xbfffe09c)        = 0
> ioctl(4, 0xc25c4110, 0xbfffe09c)        = 0
> ioctl(4, 0xc25c4110, 0xbfffe41c)        = 0
> ....
> ....
> ....lots of the above...
> ....
> ....then after we initiate shutdown of the program....
> ioctl(4, 0x4143, 0x1807)                = 0
> ioctl(4, 0x4112, 0x40031090)            = 0
> close(4)                                = 0
> open("/root/.alsaplayer/config", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 4
> close(4)                                = 0

Where it crashes? I've fixed one problem in CVS, but it shouldn't be 
triggered with Trident hardware.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
