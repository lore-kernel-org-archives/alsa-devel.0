From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Fw: writing audiowerk driver (philips saa7146a), some questions
Date: Fri, 31 May 2002 11:38:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <001801c2088f$71693120$0400a8c0@martijn>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hirogen.kabelfoon.nl (hirogen.kabelfoon.nl [62.45.45.69])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA30789
	for <alsa-devel@alsa-project.org>; Fri, 31 May 2002 11:39:55 +0200
Received: from martijn (kf-nawij-tg01-0748.dial.kabelfoon.nl [62.45.66.237])
	by hirogen.kabelfoon.nl (Postfix) with SMTP id 503CB7DB0
	for <alsa-devel@alsa-project.org>; Fri, 31 May 2002 11:39:10 +0200 (CEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

below is a message i sent earlier, but with the wrong email address:

----

writing audiowerk driver (philips saa7146a), some questions


 hi,

 i have finally been able to get the information i need to be able
 to write a driver for the emagic audiowerk8 audio interface.
 now since i am not an experienced kernel programmer and have
 not even done audio programming (apart from midi), i have
 some questions.

 - should i use the normal double buffered aproach or does having
 more than 2 buffers have advantages?

 - what is normally called the latency of an audio interface for output?
 is this the total size of the buffers or (in the case of double buffered
io)
 only one buffer? i'm thinking it is the total buffer size and this would
 make using more than 2 buffers have a better latency/interrupt response
 time ratio, right?

 - should setting the buffer size and number be done on modules loading
 or should it be possible to change it after that? the saa7146 doesn't need
 contiguous memory since it has a mmu.

 - where can i find documentation on writing alsa drivers? what would be
 the best driver source to use for documentation?

 - does alsa allow varipitch? i think the new rme cards are supposed to
 have this feature and the audiowerk8 has it, i.e. it can change its
sampling
 rate from about 37700 to 58200 hz while running in 1hz increments.
 this allows for sync to video/tape/midi or whatever. or it allows for the
 sample rate to be adjusted when receiving audio using rtp.

 - the audiowerk8 uses three dma channels: one for input and two for output.
 should i just wake a process that is blocking on a read() from the input
dma
 interrupt or should i wait until all three dma channels are ready and then
 unblock all read()/write() processes? should unblocking the processes be
 done
 from bottom half?

 --martijn





_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
