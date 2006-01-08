From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [OT] ALSA userspace API complexity
Date: Sun, 8 Jan 2006 14:23:43 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0601081408020.10981__41345.5006121241$1136755574$gmane$org@tm8103.perex-int.cz>
References: <20060104030034.6b780485.zaitcev@redhat.com>
 <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de>
 <Pine.BSO.4.63.0601052022560.15077@rudy.mif.pg.gda.pl> <s5h8xtshzwk.wl%tiwai@suse.de>
 <20060108020335.GA26114@dspnet.fr.eu.org> <Pine.LNX.4.61.0601081039520.9470@tm8103.perex-int.cz>
 <20060108130447.GA96834@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 33583135
	for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2006 14:23:44 +0100 (MET)
In-Reply-To: <20060108130447.GA96834@dspnet.fr.eu.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Olivier Galibert <galibert@pobox.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 8 Jan 2006, Olivier Galibert wrote:

> On Sun, Jan 08, 2006 at 10:42:02AM +0100, Jaroslav Kysela wrote:
> > On Sun, 8 Jan 2006, Olivier Galibert wrote:
> > 
> > > On Sat, Jan 07, 2006 at 03:32:27PM +0100, Takashi Iwai wrote:
> > > > Yes, it's a known problem to be fixed.  But, it's no excuse to do
> > > > _everything_ in the kernel (which OSS requires).
> > > 
> > > OSS does not require to do anything in the kernel except an entry
> > > point.
> > > 
> > > 
> > > > And if the application doesn't support, who and where converts it?
> > > > With OSS API, it's a job of the kernel.
> > > 
> > > Once again no.  Nothing prevents the kernel to forward the data to
> > > userland daemons depending on a userspace-uploaded configuration.
> > 
> > But it's quite ineffecient. The kernel must switch tasks at least twice
> > or more. It's the major problem with the current OSS API.
> 
> Once.  U->K or K->U is not task switching and accordingly has a very
> low cost.  It's changing of userspace task that is costly.  And dmix
> _is_ a task switch, there is no performance difference between talking
> with it through shared memory and semaphores and who knows what else
> and talking with it through a kernel interface.
> 
> You should count how many U-U switches and U-K syscalls communicating
> with dmix represents.  Hard to do for a simple user, since the
> protocol is not documented.

You're in a mistake. For x86, there are no U-K syscalls for dmix and no 
extra U-U task switches, even the latency is same as for the direct 
hardware access, because we're using a lockless technique. Also, in case 
of use of using mutexes for other architectures, there is only task switch 
when mutex is locked when the real mixing is in progress (the mixing is 
really small time windows, so it's rare to have mutex locked).

In case of a mixing daemon, you need to regulary woke up a task in a time 
period (probably with a highter time interval than application are feeding 
new samples). So you have at least one U-U task switch in the perfect 
conditions (all sound applications delivered data "in time").

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
