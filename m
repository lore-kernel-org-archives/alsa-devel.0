From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [OT] ALSA userspace API complexity
Date: Tue, 10 Jan 2006 11:51:33 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0601101144130.10330__8199.87233630872$1136890339$gmane$org@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de>
 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
 <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi> <s5h7j9chzat.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0601080225500.17252@zeus.compusonic.fi>
 <Pine.LNX.4.61.0601081007550.9470@tm8103.perex-int.cz>
 <Pine.LNX.4.61.0601090010090.31763@zeus.compusonic.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DF216135
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2006 11:51:33 +0100 (MET)
In-Reply-To: <Pine.LNX.4.61.0601090010090.31763@zeus.compusonic.fi>
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

On Mon, 9 Jan 2006, Hannu Savolainen wrote:

> > >From the end user perspective, don't you think that having an opportunity 
> > to change the API entry point from one to multiple (user space library - 
> > preferred, direct kernel space - last resort) is more flexible for 
> > developers and users? Please, consider this question without any flames 
> > line which API is better and what's better for audio subsystem architects 
> > and what's better for your commercial work.
> It's too late to discuss about this. This decision could have been made in 
> 1992-1993 before large number of applications were already written. 
> Unfortunately the whole issue was raised just recently.
> 
> There has been definitions for routines like osslib_open(), etc in 
> soundcard.h for years. Also the libOSSlib.so library contains such 
> routines. If an OSS application is compiled without -DOSSLIB then they are 
> defined as open, etc. Unfortunately this version of soundcard.h was not 
> accepted by the kernel OSS maintainers so the stock Linux version doesn't 
> have these definitions.
> 
> If you like to get OSS apps to go through this library API you can do the 
> following:
> 
> - Get the latest soundcard.h from our OSS package to be included in the 
> stock kernel.
> - Do the same for libOSSlib (sources shipped with OSS).
> - Tell all OSS developers to change all OSS system calls to use their 
> osslib_ counterparts. And to recompile against the latest soundcard.h
> with -DOSSLIB. Make sure all distributions have done the changes before 
> that.
> 
> Then you can include a libOSSlib.o library in ALSA with all the OSS 
> emulation stuf inside.

You should do the clear statement that the direct using of syscalls is not 
recommented for application developers. Unfortunately at this time, I 
admit, it would be very difficult to change the existing applications.

I can only suggest to OSS including the commercial version:

1) create a osslib package under GPL and probably also under BSD licence
2) notify developers in your documentation that every syscall has own
   function in osslib and that using syscalls directly is not recommended

In this way, your library will go to all Linux distributions and OSS app 
developers will have quite confirmed the right direction from you.

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
