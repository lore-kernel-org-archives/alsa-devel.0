From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: SYSFS,
 was Re:  [PATCH] RFC - add prealloc_max proc file
Date: Fri, 6 Oct 2006 19:30:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610061925440.8573@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0610061026300.8573@tm8103.perex-int.cz>
	<1160126104.8856.272696626@webmail.messagingengine.com>
	<s5hbqopu1ip.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0610061332560.8573@tm8103.perex-int.cz>
	<s5h64extxxd.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0610061517520.8573@tm8103.perex-int.cz>
	<s5hzmc9shg9.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0610061531410.8573@tm8103.perex-int.cz>
	<s5hwt7dsgnx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 62B8719C
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Oct 2006 19:30:34 +0200 (MEST)
In-Reply-To: <s5hwt7dsgnx.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 6 Oct 2006, Takashi Iwai wrote:

> At Fri, 6 Oct 2006 15:34:30 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > On Fri, 6 Oct 2006, Takashi Iwai wrote:
> > 
> > > At Fri, 6 Oct 2006 15:19:58 +0200 (CEST),
> > > Jaroslav Kysela wrote:
> > > > 
> > > > On Fri, 6 Oct 2006, Takashi Iwai wrote:
> > > > 
> > > > > > > > BTW: Shouldn't all(?) these proc files eventually go to sysfs?
> > > > > > > 
> > > > > > > There is already a function to add a sysfs file
> > > > > > > (snd_add_device_sysfs_file()), so it must be pretty easy.
> > > > > > 
> > > > > > Yes and no. An layer for concrete device/substream should be added.
> > > > > 
> > > > > Right, it's missing.
> > > > > 
> > > > > > Anyway, actually we can move most of values from proc to sysfs for 2.6.
> > > > > > Any problems with it?
> > > > > 
> > > > > Proc files for showing information are OK, but controlling the driver
> > > > > over proc file isn't a recommended way on 2.6 kernel.  That's what
> > > > > sysfs is for.
> > > > > 
> > > > > Anyway it's no big deal but just TODO.
> > > > 
> > > > I'd like to create similar layer as in proc, but it seems that we must 
> > > > place cards root somewhere. Do you think that /sys/class/soundcard is good 
> > > > place and name for this root?
> > > 
> > > I don't think so.  /sys/class are referred by HAL to probe the device
> > > files.  Adding a root would simply confuse the system.
> > 
> > Hmm. Any suggestion? /sys/bus or /sys/devices does not seem also as a 
> > right place.
> 
> We can create another class for the sound-root.  But, better to ask
> sysfs guys before starting working on it.
> 
> Alternatively, we can put the tree under controlC* entry since control
> is corresponding to each card in ALSA.  Actually, snd_card instance is
> _the_ container of control elements.

Looking to the udev code, creating /sys/class/soundcard might make sense.
It seems that they're handling /sys/class/net also differently than other 
standard /dev devices.

The main purpose of this class should be renaming card id.

Anyway, let's wait if someone replies on lkml.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
