From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] RFC - add prealloc_max proc file
Date: Fri, 6 Oct 2006 13:36:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610061332560.8573@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0610061026300.8573@tm8103.perex-int.cz>
	<1160126104.8856.272696626@webmail.messagingengine.com>
	<s5hbqopu1ip.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4A5DD19A
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Oct 2006 13:36:52 +0200 (MEST)
In-Reply-To: <s5hbqopu1ip.wl%tiwai@suse.de>
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

> At Fri, 06 Oct 2006 11:15:04 +0200,
> Clemens Ladisch wrote:
> > 
> > Jaroslav Kysela wrote:
> > > I would like to propose to add prealloc_max proc file to give a 
> > > hint, what's the maximum allowed DMA buffer size in bytes:
> > 
> > You mean, users are not supposed to do a binary search with
> > the prealloc file?  ;-)
> > 
> > > ...
> > 
> > Looks good.
> > 
> > 
> > BTW: Shouldn't all(?) these proc files eventually go to sysfs?
> 
> There is already a function to add a sysfs file
> (snd_add_device_sysfs_file()), so it must be pretty easy.

Yes and no. An layer for concrete device/substream should be added.
Anyway, actually we can move most of values from proc to sysfs for 2.6.
Any problems with it?

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
