From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.15-rc6: known regressions in the kernel Bugzilla
Date: Fri, 30 Dec 2005 14:31:58 -0500
Message-ID: <1135971119.31111.21.camel__47738.2464604036$1135971234$gmane$org@mindpipe>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	 <20051222011320.GL3917@stusta.de> <20051222071557.GA17346@suse.de>
	 <s5hpsnpxrqw.wl%tiwai@suse.de>  <20051229132355.GA3811@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 6A78D18F
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 20:32:01 +0100 (MET)
In-Reply-To: <20051229132355.GA3811@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-12-29 at 14:23 +0100, Adrian Bunk wrote:
> On Thu, Dec 22, 2005 at 01:04:23PM +0100, Takashi Iwai wrote:
> > At Wed, 21 Dec 2005 23:15:57 -0800,
> > Greg KH wrote:
> > > 
> > > On Thu, Dec 22, 2005 at 02:13:20AM +0100, Adrian Bunk wrote:
> > > > The following bug in the kernel Bugzilla contains a regressions in 
> > > > 2.6.15-rc without a patch:
> > > > - #5760 No sound with snd_intel8x0 & ALi M5455 chipset
> > > >         (kobject_register failed)
> > > 
> > > We put code in the kobjet to report when callers fail, due to problems
> > > in them, and the kobject code is blamed...
> > > 
> > > Looks like a sound driver issue, nothing has changed in the kobject
> > > code.
> > 
> > But there is no relevant change in sound stuff between 2.6.15-rc4 and
> > rc6 (except for minor fix of OSS drivers).  If it really worked with
> > 2.6.15-rc4, something else got broken.
> 
> I don't know whether this is related to the problem, but the code giving 
> the "AC'97 1 does not respond - RESET" warning that is present in both 
> the working and the non-working cases for the submitter looks a bit 
> fragile.
> 
> > Takashi

Two more post 2.6.14 ALSA regressions that IMHO need to be fixed for
2.6.15:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1585
http://music.columbia.edu/pipermail/linux-audio-dev/2005-December/014269.html

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
