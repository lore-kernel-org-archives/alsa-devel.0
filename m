From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [OT] ALSA userspace API complexity
Date: Sun, 8 Jan 2006 10:24:46 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0601081007550.9470@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de>
 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
 <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi> <s5h7j9chzat.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0601080225500.17252@zeus.compusonic.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E993312C
	for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2006 10:24:47 +0100 (MET)
In-Reply-To: <Pine.LNX.4.61.0601080225500.17252@zeus.compusonic.fi>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hannu Savolainen <hannu@opensound.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org, ALSA development <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 8 Jan 2006, Hannu Savolainen wrote:

> On Sat, 7 Jan 2006, Takashi Iwai wrote:
> 
> > > > Because OSS API doesn't cover many things.  For example, 
> > > > 
> > > > - PCM with non-interleaved formats
> > > There is no need to handle non-interleaved data in kernel level drivers 
> > > because all the devices use interleaved formats.
> > 
> > Many RME boards support only non-intereleave data.
> In such cases it's better to do interleavin/deinterleaving in the kernel 
> rather than forcing the apps to check which method they should use.

I don't think so. The library can do such conversions (and alsa-lib does) 
quite easy. If we have a possibility to remove the code from the kernel 
space without any drawbacks, then it should be removed. I don't see any 
advantage to have such conversions in the kernel.

> > Indeed.  But you know that almost all "OSS" applications access
> > directly the device files.  There is no room to put a library to solve
> > these things in user-space.
> Why should there be any need to put library code between the kernel API 
> and an application that is perfectly happy with it? It is only necessary 
> if somebody wants to emulate the OSS kernel API in library level.
> 
> A wrapper library with routines like oss_open, oss_write, etc was once 
> considered. However we didn't find any good reason to do that (in 
> particular because that conflicted with routine names already used 
> internally in some important OSS applications).

Bad decision. Again, I feel you're hidding the flexibility against
your feeling that the kernel API is the best enough for applications.
Imagine that the API redirection is or can be also flexible for your 
future development.

> What if there is some better way to handle OSS-ALSA interaction than 
> library level hooks/emulation. In the short term this may be difficult 
> because OSS is binary only and outside the kernel. But in long run OSS can 
> hopefully be open sourced which could make it possible to use solutions 
> like merging the kernel space drivers together.
> 
> Actually I have forgotten what was the reason why you wanted to get the 
> OSS API emulated in userland rather than using the previous snd-oss 
> module (which worked well other than the API version you emulated was too 
> old)?

Stream mixing. We have user space solution while you insist to put this 
code to kernel. Simply, we need to go through our library.

>From the end user perspective, don't you think that having an opportunity 
to change the API entry point from one to multiple (user space library - 
preferred, direct kernel space - last resort) is more flexible for 
developers and users? Please, consider this question without any flames 
line which API is better and what's better for audio subsystem architects 
and what's better for your commercial work.

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
