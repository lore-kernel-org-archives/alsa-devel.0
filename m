From: Hannu Savolainen <hannu@opensound.com>
Subject: Re: Re: [OT] ALSA userspace API complexity
Date: Mon, 9 Jan 2006 00:47:22 +0200 (EET)
Message-ID: <Pine.LNX.4.61.0601090010090.31763__32547.6568578326$1136760638$gmane$org@zeus.compusonic.fi>
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
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from minor.compusonic.fi (host1.compusonic.fi [195.238.198.242])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C755DD4
	for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2006 23:49:59 +0100 (MET)
In-Reply-To: <Pine.LNX.4.61.0601081007550.9470@tm8103.perex-int.cz>
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
Cc: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 8 Jan 2006, Jaroslav Kysela wrote:

> I don't think so. The library can do such conversions (and alsa-lib does) 
> quite easy. If we have a possibility to remove the code from the kernel 
> space without any drawbacks, then it should be removed. I don't see any 
> advantage to have such conversions in the kernel.
The advantage is that you don't need any libraries. 
 
> Bad decision. Again, I feel you're hidding the flexibility against
> your feeling that the kernel API is the best enough for applications.
> Imagine that the API redirection is or can be also flexible for your 
> future development.
Past 13 years have proven that kernel only API has been very successfull.
There are 1000's of applications supporting it and being a kernel 
only API has not caused any problems. If something cannot be implemented 
in kernel (like effect plugins) then a library can be implemented on top 
of the OSS kernel API which has already been done by other developers.
 
Right. Emulating OSS API in userland is difficult in this way. I just 
couldn't imagine that somebody wants to do that. It can be considered as 
my fault.

> > Actually I have forgotten what was the reason why you wanted to get the 
> > OSS API emulated in userland rather than using the previous snd-oss 
> > module (which worked well other than the API version you emulated was too 
> > old)?
> 
> Stream mixing. We have user space solution while you insist to put this 
> code to kernel. Simply, we need to go through our library.
I wonder if foing mixing (summing) of streams in kernel really causes more 
problems than emulating a kernel API in user space.

> >From the end user perspective, don't you think that having an opportunity 
> to change the API entry point from one to multiple (user space library - 
> preferred, direct kernel space - last resort) is more flexible for 
> developers and users? Please, consider this question without any flames 
> line which API is better and what's better for audio subsystem architects 
> and what's better for your commercial work.
It's too late to discuss about this. This decision could have been made in 
1992-1993 before large number of applications were already written. 
Unfortunately the whole issue was raised just recently.

There has been definitions for routines like osslib_open(), etc in 
soundcard.h for years. Also the libOSSlib.so library contains such 
routines. If an OSS application is compiled without -DOSSLIB then they are 
defined as open, etc. Unfortunately this version of soundcard.h was not 
accepted by the kernel OSS maintainers so the stock Linux version doesn't 
have these definitions.

If you like to get OSS apps to go through this library API you can do the 
following:

- Get the latest soundcard.h from our OSS package to be included in the 
stock kernel.
- Do the same for libOSSlib (sources shipped with OSS).
- Tell all OSS developers to change all OSS system calls to use their 
osslib_ counterparts. And to recompile against the latest soundcard.h
with -DOSSLIB. Make sure all distributions have done the changes before 
that.

Then you can include a libOSSlib.o library in ALSA with all the OSS 
emulation stuf inside.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
