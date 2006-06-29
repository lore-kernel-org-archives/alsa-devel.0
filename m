From: Andi Kleen <ak@suse.de>
Subject: Re: Alsa update in mainline broke ATI-IXP sound driver
	II
Date: Thu, 29 Jun 2006 12:03:22 +0200
Message-ID: <200606291203.22773.ak__41485.8306445696$1151575455$gmane$org@suse.de>
References: <200606252139.36002.ak@suse.de> <200606262028.31807.ak@suse.de>
	<s5hmzbz92i6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CA0B7236
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 12:03:31 +0200 (MEST)
In-Reply-To: <s5hmzbz92i6.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Monday 26 June 2006 20:48, Takashi Iwai wrote:
> At Mon, 26 Jun 2006 20:28:31 +0200,
> Andi Kleen wrote:
> > 
> > 
> > > OK, and still you get the same error like:
> > > 
> > > 	ALSA lib confmisc.c:672:(snd_func_card_driver) cannot find card '0'
> > > 	...
> > > ??
> > 
> > Yes.
> > 
> > > Any change if you set CONFIG_SND_DYNAMIC_MINORS=y ?
> > 
> > With that it finally works. Thanks.
> > 
> > Still can it be fixed?
> 
> Well, the bug shall be fixed :)
> 
> Unfortunately I cannot reproduce this on my systems that are all based
> on SUSE 10.1, and the latest 2.6.17-git works fine even
> CONFIG_SND_DYNAMIC_MINORS=n as far as I've tested.
> 
> Could you check the strace and what open error occurs?
> I suppose it's /dev/snd/controlC0, but don't figure out exactly.

Sorry for the delay

(as root) I get

5184  open("/dev/snd/controlC0", O_RDONLY) = -1 EACCES (Permission denied)
5184  open("/dev/snd/controlC1", O_RDONLY) = -1 EACCES (Permission denied)
... (upto 31) ...
5184  open("/dev/sound/dsp", O_WRONLY|O_NONBLOCK) = -1 ENOENT (No such file or d
5184  open("/dev/dsp", O_WRONLY|O_NONBLOCK) = -1 EACCES (Permission denied)

ccontrol0 is
crw-------  1 andi audio 116, 6 2006-06-29 11:49 /dev/snd/controlC0

It also doesn't work as andi

I stuck printks to the EACCES in sound/* and they don't trigger so it must
be somewhere else.


-Andi

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
