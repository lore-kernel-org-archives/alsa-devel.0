From: Tim Goetze <tim@quitte.de>
Subject: Re: usb-audio: variable periodsize / nframes per callback
 can shorten latency times
Date: Tue, 20 Aug 2002 12:30:11 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0208201214450.682-100000@summer.quitte>
References: <s5h65y6uadk.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA07295
	for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2002 12:31:49 +0200
In-Reply-To: <s5h65y6uadk.wl@alsa2.suse.de>
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

>> How can we implement the latency-optimal behaviour with alsa-driver
>> framework?
>> Can we implement something like a snd_1ms_elapsed() routine (called from
>> USB-interrupt), which in turn triggers a waiting app with the available
>> period size (which would be 44 or 45 frames for 44100Hz)?
>> I would like to see this in ALSA / JACK.
>> What do you think?
>
>hmm, it's not so easy, since this will break also the assumption of
>constant period "frames" by applications.  if we introduce the
>time-based period size, it won't work as compatible as older one,
>e.g. jack wouldn't run properly if the period size changes
>dynamically.
>hence, this should be handled in a special case.

With the current setup and cycle code for mmap'd IO (like Jack for
example does it), is it possible to use these devices at all? What
kind of hw/sw params, especially period size, should one set? Can
one choose larger period sizes (45 frames/cycle is too tough for a
userspace process, at least on this box)?

tim



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
