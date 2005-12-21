From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.15-rc6: boot failure in saa7134-alsa.c
Date: Wed, 21 Dec 2005 23:40:25 +0100
Message-ID: <20051221224025.GC3917__8739.67403681508$1135204951$gmane$org@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local> <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de> <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <20051220202325.GA3850@stusta.de> <s5hr786zfzm.wl%tiwai@suse.de> <20051221182214.GB3888@stusta.de> <s5hzmmuxplc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 8AED4199
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2005 23:40:26 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <s5hzmmuxplc.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 21, 2005 at 07:38:39PM +0100, Takashi Iwai wrote:
> At Wed, 21 Dec 2005 19:22:14 +0100,
> Adrian Bunk wrote:
> > 
> > On Wed, Dec 21, 2005 at 03:23:09PM +0100, Takashi Iwai wrote:
> > > At Tue, 20 Dec 2005 21:23:25 +0100,
> > > Adrian Bunk wrote:
> > > > 
> > > > On Tue, Dec 20, 2005 at 11:59:20AM -0800, Linus Torvalds wrote:
> > > > > 
> > > > > 
> > > > > On Tue, 20 Dec 2005, Adrian Bunk wrote:
> > > > > >
> > > > > > > Adrian, does it work if you change the "module_init()" in 
> > > > > > > sound/sound_core.c into a "fs_initcall()"?
> > > > > > 
> > > > > > No, this didn't work.
> > > > > > 
> > > > > > What did work was to leave sound/sound_core.c alone
> > > > > 
> > > > > Can you do try the other way again, with sound/core/sound.c fixed too?
> > > > >...
> > > > 
> > > > This works in the sense that the kernel boots and my saa7134 TV card is 
> > > > giving both audio and video output.
> > > > 
> > > > But the non-saa7134 access to my soundcard (e.g. rexima or xmms) is no 
> > > > longer working.
> > > 
> > > What is missing there?  No sound card entry in /proc/asound/cards?
> > >...
> > 
> > <--  snip  -->
> > 
> > 0 [SAA7134        ]: SAA7134 - SAA7134
> >                      saa7134[0] at 0xed800000 irq 18
> > 1 [V8237          ]: VIA8237 - VIA 8237
> >                      VIA 8237 with AD1888 at 0xe000, irq 21
> > 
> > <--  snip  -->
> > 
> > What changed compared to the working setup (if the bug is really here) 
> > is the order of the two.
> 
> Well, that's not anyway guaranteed unless you pass the proper index
> options.

I'm not sure whether this is really related to my problem:

No matter how they are ordered, shouldn't my soundcard still be 
accessible from xmms or rexima?

> In the case above, snd_via82xx.index=0 saa7134.index=1 should work.

This results in my soundcard being no longer available:

<--  snip  -->

...
Unknown boot option `saa7134.index=1': ignoring
...
cannot find the slot for index 0 (range 0-0)
VIA 82xx Audio: probe of 0000:00:11.5 failed with error -12
ALSA device list:
  #0: saa7134[0] at 0xed800000 irq 18
NET: Registered protocol family 2
...

<--  snip  -->

But as said above, I don't suspect the order of the devices being the 
problem.

> Or you may tune with udev, too.

-ENOUDEV

> Takashi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
