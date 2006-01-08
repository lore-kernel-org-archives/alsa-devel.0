From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [OT] ALSA userspace API complexity
Date: Sun, 8 Jan 2006 14:04:47 +0100
Message-ID: <20060108130447.GA96834__17589.199022814$1136755069$gmane$org@dspnet.fr.eu.org>
References: <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl> <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de> <Pine.BSO.4.63.0601052022560.15077@rudy.mif.pg.gda.pl> <s5h8xtshzwk.wl%tiwai@suse.de> <20060108020335.GA26114@dspnet.fr.eu.org> <Pine.LNX.4.61.0601081039520.9470@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from dspnet.fr.eu.org (dspnet.fr.eu.org [213.186.44.138])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B963A135
	for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2006 14:04:48 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601081039520.9470@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 08, 2006 at 10:42:02AM +0100, Jaroslav Kysela wrote:
> On Sun, 8 Jan 2006, Olivier Galibert wrote:
> 
> > On Sat, Jan 07, 2006 at 03:32:27PM +0100, Takashi Iwai wrote:
> > > Yes, it's a known problem to be fixed.  But, it's no excuse to do
> > > _everything_ in the kernel (which OSS requires).
> > 
> > OSS does not require to do anything in the kernel except an entry
> > point.
> > 
> > 
> > > And if the application doesn't support, who and where converts it?
> > > With OSS API, it's a job of the kernel.
> > 
> > Once again no.  Nothing prevents the kernel to forward the data to
> > userland daemons depending on a userspace-uploaded configuration.
> 
> But it's quite ineffecient. The kernel must switch tasks at least twice
> or more. It's the major problem with the current OSS API.

Once.  U->K or K->U is not task switching and accordingly has a very
low cost.  It's changing of userspace task that is costly.  And dmix
_is_ a task switch, there is no performance difference between talking
with it through shared memory and semaphores and who knows what else
and talking with it through a kernel interface.

You should count how many U-U switches and U-K syscalls communicating
with dmix represents.  Hard to do for a simple user, since the
protocol is not documented.

  OG.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
