From: Martin Drab <drab@kepler.fjfi.cvut.cz>
Subject: Re: [OT] ALSA userspace API complexity
Date: Sun, 8 Jan 2006 03:26:18 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0601080317040.22583@kepler.fjfi.cvut.cz>
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
Received: from kepler.fjfi.cvut.cz (kepler.fjfi.cvut.cz [147.32.6.11])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9A127132
	for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2006 03:26:19 +0100 (MET)
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

> > And if the application doesn't support, who and where converts it?
> > With OSS API, it's a job of the kernel.
> 
> Once again no.  Nothing prevents the kernel to forward the data to
> userland daemons depending on a userspace-uploaded configuration.

I think that the point was, that switching from userspace to kernelspace 
then to userspace again and back to kernelspace in order to do something, 
that could have been done directly in the userspace, and though could save 
those two unnecessary switches, is an unnecessary overhead, which may not 
necessarily be that insignificant if it's done so often (which for 
streaming audio is the case). Why doing things complicated when there is 
no evident gain from it, or is there?

Martin


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
