From: Tim Goetze <tim@quitte.de>
Subject: Re: usb-audio: variable periodsize / nframes per callback
 can shorten latency times
Date: Tue, 20 Aug 2002 13:34:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0208201320350.682-100000@summer.quitte>
References: <s5hlm71sst7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA08867
	for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2002 14:33:20 +0200
In-Reply-To: <s5hlm71sst7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Alsa-Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>> With the current setup and cycle code for mmap'd IO (like Jack for
>> example does it), is it possible to use these devices at all?
>
>on 48kHz my usb speaker worked fine with 1ms or 2ms period size (not
>under high loads, though), since the frames per urb becomes integer in
>this case.  on 44.1kHz xrun could happen.

Yeah, a differing number of frames/cycle makes things hairy. But if
one sets a period size of 45/90 frames/cycle and accepts 44/88/89 as
well, things should work OK, shouldn't they?

>> What kind of hw/sw params, especially period size, should one set?
>
>the frequency aligned to 1000Hz.

You mean divided by 1000, rounded up to the nearest integer, right?

>> Can one choose larger period sizes (45 frames/cycle is too tough for
>> a userspace process, at least on this box)?
>
>of course, depending on the kernel :)
>in theory, 1ms latency is enough possible.

Thanks!

tim



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
