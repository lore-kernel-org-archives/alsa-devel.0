From: Torsten Mohr <tmohr@s.netic.de>
Subject: playing samples in parallel
Date: Sun, 24 Feb 2002 23:54:12 +0100
Message-ID: <200202242254.g1OMsD906772@schleim.qwe.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Received: from mail.netic.de (mail.s.netic.de [212.9.160.11])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA13424
	for <alsa-devel@alsa-project.org>; Sun, 24 Feb 2002 22:53:07 +0100
Received: from there (localhost [127.0.0.1])
	by schleim.qwe.de (8.11.6/8.11.6/SuSE Linux 0.5) with SMTP id g1OMsD906772
	for <alsa-devel@alsa-project.org>; Sun, 24 Feb 2002 23:54:13 +0100
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

Hi everybody,

i'm new to this list, so i hope this question is
not off-topic.

I'm trying to play several samples in parallel or at certain
undetermined points, e.g. when an event happens.

To test this i load two different WAV files, that i can play
independently, start the first one, do a "sleep(1)" and then
start the second one.

The samples play only for a very short time, this seems to
be related to the "buffer_time".

What value should i use for buffer_time?  I've got the
length of the sample, its rate, its number of channels
and its bits per samplevalue.

I tried length*1000000/rate/channels/bits_per_sample.

This really seems to be the time in micro seconds, but
one is played far too short.


In detail, how i try to play a sample:
I open one handle for each time i want to play a sample
using "plughw:0,0" in NON_BLOCK mode, set format, channel,
rate.
Then i set the buffer_time according to the formula above,
i also tried a "500000".  I chose the period_time to be
100000.
Then i get buffer_size and period_size.
After that i set start_threshold to buffer_size and avail_min
to period_size.  Could this be the problem?

xfer_align is set to 1 and then i start playing it by using
"writei".


This way i start to play one sample, do a "sleep(1)", start
to play another sample, do a "sleep(1)", then i play the first
sample again, using another handle.


Has anybody got any hints for me?

Has anybody got a working example where two sounds are played
in parallel?  This should be used in games somewhere.

Do i need to use a handle for each sample i try to play?

Do i need to chose another device name instead of "plughw:0,0"
for each sample?


I'd also like to use an async_handler to inform my program when
a started sample is played completely.  How can i do this?  It seems
that the handler is called (buffer_time/period_time) times during
each sample, is that correct?


Best regards,
Torsten.


http://www.s.netic.de/tmohr/linux.html

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
