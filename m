From: Andy Lo-A-Foe <andy@alsaplayer.org>
Subject: Re: Kernel OOP with alsaplayer driver
Date: Tue, 20 Aug 2002 14:59:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020820125953.GA920@orbital.xs4all.nl>
References: <20020820110644.GA380@orbital.xs4all.nl> <s5hk7mlsok4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hk7mlsok4.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 20, 2002 at 02:27:23PM +0200, Takashi Iwai wrote:

> could you check via strace which ioctl triggers this?
> strangely i cannot reproduce this on my machine.

strace gives the following (parsed):

....
....
open("/dev/snd/pcmC0D0p", O_RDWR)       = 4
ioctl(4, AGPIOC_INFO, 0xbfffdf60)       = 0
....
ioctl(4, 0xc25c4110, 0xbfffe09c)        = 0
ioctl(4, 0xc25c4110, 0xbfffe09c)        = 0
ioctl(4, 0xc25c4110, 0xbfffe41c)        = 0
....
....
....lots of the above...
....
....then after we initiate shutdown of the program....
ioctl(4, 0x4143, 0x1807)                = 0
ioctl(4, 0x4112, 0x40031090)            = 0
close(4)                                = 0
open("/root/.alsaplayer/config", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 4
close(4)                                = 0

Not sure if this helps, I can't get symbol values for the ioctl
parameters. Let me know...

Thanks,
Andy


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
