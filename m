From: Tim Goetze <tim@quitte.de>
Subject: Re: usb-audio: variable periodsize / nframes per callback
 can shorten latency times
Date: Tue, 20 Aug 2002 22:27:12 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0208202223390.682-100000@summer.quitte>
References: <s5hznvhtprx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA15449
	for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2002 22:28:49 +0200
In-Reply-To: <s5hznvhtprx.wl@alsa2.suse.de>
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

>At Tue, 20 Aug 2002 13:34:03 +0200 (CEST),
>Tim Goetze wrote:
>> 
>> Takashi Iwai wrote:
>> 
>> >> With the current setup and cycle code for mmap'd IO (like Jack for
>> >> example does it), is it possible to use these devices at all?
>> >
>> >on 48kHz my usb speaker worked fine with 1ms or 2ms period size (not
>> >under high loads, though), since the frames per urb becomes integer in
>> >this case.  on 44.1kHz xrun could happen.
>> 
>> Yeah, a differing number of frames/cycle makes things hairy. But if
>> one sets a period size of 45/90 frames/cycle and accepts 44/88/89 as
>> well, things should work OK, shouldn't they?
>
>well... for that, you have to know how much data to be written
>_before_ actually you writing it.  i.e. you need an extra step, query
>the (rest) period size -> then write/read, instead of always writing
>the same amount of data.

Sorry, I don't get it.

You mean update_avail will return a higher number of frames than
snd_pcm_mmap_begin, so one has to mmap_begin a second time? That
would be proceeding as usual.

tim



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
