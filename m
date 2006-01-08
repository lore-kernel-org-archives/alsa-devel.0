From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [OT] ALSA userspace API complexity
Date: Sun, 8 Jan 2006 10:42:02 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0601081039520.9470__15468.5105117553$1136755089$gmane$org@tm8103.perex-int.cz>
References: <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
 <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de>
 <Pine.BSO.4.63.0601052022560.15077@rudy.mif.pg.gda.pl> <s5h8xtshzwk.wl%tiwai@suse.de>
 <20060108020335.GA26114@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6EFAE12E
	for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2006 10:42:03 +0100 (MET)
In-Reply-To: <20060108020335.GA26114@dspnet.fr.eu.org>
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

> On Sat, Jan 07, 2006 at 03:32:27PM +0100, Takashi Iwai wrote:
> > Yes, it's a known problem to be fixed.  But, it's no excuse to do
> > _everything_ in the kernel (which OSS requires).
> 
> OSS does not require to do anything in the kernel except an entry
> point.
> 
> 
> > And if the application doesn't support, who and where converts it?
> > With OSS API, it's a job of the kernel.
> 
> Once again no.  Nothing prevents the kernel to forward the data to
> userland daemons depending on a userspace-uploaded configuration.

But it's quite ineffecient. The kernel must switch tasks at least twice
or more. It's the major problem with the current OSS API.

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
