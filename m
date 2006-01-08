From: Hannu Savolainen <hannu@opensound.com>
Subject: Re: [OT] ALSA userspace API complexity
Date: Sun, 8 Jan 2006 03:30:14 +0200 (EET)
Message-ID: <Pine.LNX.4.61.0601080225500.17252__42833.0500064932$1136684040$gmane$org@zeus.compusonic.fi>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de>
 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
 <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi> <s5h7j9chzat.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from minor.compusonic.fi (host1.compusonic.fi [195.238.198.242])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D0BF710F
	for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2006 02:32:53 +0100 (MET)
In-Reply-To: <s5h7j9chzat.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 7 Jan 2006, Takashi Iwai wrote:

> > > Because OSS API doesn't cover many things.  For example, 
> > > 
> > > - PCM with non-interleaved formats
> > There is no need to handle non-interleaved data in kernel level drivers 
> > because all the devices use interleaved formats.
> 
> Many RME boards support only non-intereleave data.
In such cases it's better to do interleavin/deinterleaving in the kernel 
rather than forcing the apps to check which method they should use.

Using non-interleaved instead of interleaved as the format was an 
alternative that I considered very early. Non-interleaved is easier to 
understand for the programmers. However all devices (with exceptions 
you mentioned) use interleaved and in the early days (386/486) 
re-interleaving appeared to be too time consuming.

> > > - PCM with 3-bytes-packed 24bit formats
> > Applications have no reasons to use for this kind of stupid format so OSS 
> > translates it to the usual 32 bit format on fly. In fact OSS API does 
> > have support for this format.
> 
> Well, this is stupid but very popular nowadays, unforunately :)
In user land? (I see you are just joking). I know USB devices use this 
inpractical format due to USB bus bandwidth limitations. However I'm 100% 
sure no programmer feels happy with it.
 
> > > - Combination of multiple devices
> > > - Split of channels to concurrent accesses
> > Could you be more specific with the above isues?
> 
> I meant to split channels of a single device to different processes
> (e.g. front/rear/clfe for each).  (I know it's doable but the question
> is how to implement it.)
By having a device file for each channel (or stereo pair) with their 
private kernel buffers. The output interrupt handler then picks the 
samples from each buffer and interleaves them to the output. Right, this 
can be done in user land too but is it really easier in that way?
 
> > > Forcing OSS API means to force to process the all things above in
> > > the kernel.  I guess many people would disagree with it.
> > Wrong. This is not an API issue at all. It's an implementation one. 
> 
> Indeed.  But you know that almost all "OSS" applications access
> directly the device files.  There is no room to put a library to solve
> these things in user-space.
Why should there be any need to put library code between the kernel API 
and an application that is perfectly happy with it? It is only necessary 
if somebody wants to emulate the OSS kernel API in library level.

A wrapper library with routines like oss_open, oss_write, etc was once 
considered. However we didn't find any good reason to do that (in 
particular because that conflicted with routine names already used 
internally in some important OSS applications).
 

> 
> > An alternative for doing some operations in the kernel is looping the 
> > audio data through an user land daemon. The application itself is still 
> > using the usual OSS API without knowing anything about any daemons. We 
> > have tested this approach and it works. There just has not been any good 
> > reason to use this approach instead of using kernel space approach. 
> > Passing data through multiple applications makes the latency issues to 
> > accumulate. If you do the processing in the kernel you will hit by the 
> > task scheduling latencies at most once.
> 
> Yes, I thought of the similar thing...  But, is it really a preferred
> approach?
We found out that doing the things we wanted to do was actually much 
easier in kernel space. 

The perfect solution requires possibility to run privileged semi-userland 
tasks between the kernel and the device switch table. If such task can 
access limited set of kernel services (sleep/wake, mutexes, timers and few 
others) while still being able to do FP and access normal user land 
services then...
However I think this is just a day dream because more or less major 
changes would be required to the kernel. In addition using just two 
protection rings is one of the key foundations of the Linux kernel.

> 
> > The OSS approach is not to make everything in the kernel. Things that can 
> > be done easier in the applications (or in libraries) have been left 
> > out from the API.
> 
> Basically, it's not 100% fault of OSS, IMO.  But, looking at the
> reality, apps do access directly to the kernel.  It's worse in the
> case of binary-only apps like flash or skype.  To support these
> things, the only "realistic" (OSS-ish) solution so far is to implement
> the conversion routines in the kernel level.
What if there is some better way to handle OSS-ALSA interaction than 
library level hooks/emulation. In the short term this may be difficult 
because OSS is binary only and outside the kernel. But in long run OSS can 
hopefully be open sourced which could make it possible to use solutions 
like merging the kernel space drivers together.

Actually I have forgotten what was the reason why you wanted to get the 
OSS API emulated in userland rather than using the previous snd-oss 
module (which worked well other than the API version you emulated was too 
old)?

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
