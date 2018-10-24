From: frederik@ofb.net
Subject: alsaloop problems; ALSA streaming tutorial (resend)
Date: Wed, 24 Oct 2018 01:01:20 -0700
Message-ID: <20181024080118.hwlaato642zpagfc@ofb.net>
Reply-To: frederik@ofb.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ICGRIDDB04.SEAS.upenn.edu (icgriddb04.seas.upenn.edu
 [158.130.57.72])
 by alsa0.perex.cz (Postfix) with ESMTP id AD65E26752C
 for <alsa-devel@alsa-project.org>; Wed, 24 Oct 2018 10:01:29 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mark@xwax.org
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Mark (cc'ing ALSA-user, ALSA-devel)

Thank you for your tutorial

http://www.pogo.org.uk/~mark/trx/streaming-desktop-audio.html

I found it helpful and clearly-written (although missing a "}" brace
and I think it should be "-P" instead of "-p"...).

I got as far as trying the 'alsaloop' example. It seems very finicky,
sometimes I am able to play a test.wav cleanly through the loopback
device, and sometimes there are a lot of crackles and I get errors
like

    playback hw:0: change avail_min=2968
    playback hw:0: change avail_min=2972
    playback hw:0: change avail_min=2976
    underrun for playback hw:0
      last write before 9.8370ms, queued 10.0000ms/0.0000ms -> missing -0.1630ms
      expected 10.0000ms, processing 0.1910ms, max missing 0.0443ms
      last wake 0.0350ms, last check 0.0350ms, avail_min 32.0000ms
      max buf 40.0000ms, pfilled 0.0000ms, cfilled 10.0000ms
      job started before 0.0110ms

For 'aplay' invocations where there are errors, it generally never
recovers; the whole (10 second) wav file is played with crackles and
errors being printed. I tried to figure out if this is due to some
different rate settings being chosen at random with each 'aplay'
invocation, but all the alsaloop debugging output looks the same
between working and non-working runs of aplay (except for the above
underrun errors). I also tried various settings for -A and -S in
'alsaloop', but nothing would alleviate this problem. The only thing
that fixes it is to change the latency '-t' setting to a higher value
than the default 10ms. However this seems like a bad solution, given
that it is able (50% of the time) to play a whole sound file at the
lower latency with no errors; I would rather have it recover from the
underruns when they happen, than increase the latency for every
invocation. Enabling realtime via the Arch Wiki info (a bit tricky as
I had to edit some of the files by hand) didn't change this behavior.

I also encountered a problem when trying to make alsaloop output to a
dmix device. I wanted to have it output to dmix so that I could use my
audio normally while experimenting with alsaloop. I got a "Poll FD
initialization failed." error:

    playback plug:hw0mix/capture hubcap sync type: CAPTRATESHIFT
    New pitch for playback plug:hw0mix/capture hubcap: 1.00000000 (min/max samples = 0/0)
    underrun for playback plug:hw0mix
      last write before 19.7440ms, queued -1.0000ms/-1.0000ms -> missing -1.0000ms
      expected 10.0000ms, processing 0.0290ms, max missing 0.0000ms
      last wake 1539883911239.1819ms, last check 19.6460ms, avail_min 2.5000ms
      max buf 250.0000ms, pfilled 0.0000ms, cfilled 0.0000ms
      job started before 0.0310ms
    Poll FD initialization failed.

Is this error understood? I would have thought that enough others
would also have been wanting to use alsaloop in such a simple
configuration, to warrant a better error message.

I'm somewhat confused by the alsaloop manual page, my version says it
is from "5 Aug 2010" but it has glaring errors, it says "-B" is a
synonym for "--buffer" but alsaloop tells me "alsaloop: invalid option
-- 'B'". Also it says that I can use "-c" to set both channels and
rate. Are these typos really unfixed for eight years?

Here are the commands I used:

$ alsaloop -C hubcap -P hw:0 -v -v -U |& tee alsaloloop.out
...
$ aplay -v test.wav |& tee aplay.out
...
$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version k4.14.71-1-lts.

The earlier version of this email had output files attached, but they
caused the message to be held for "moderator approval". Here are some
HTTP versions of the same files:

alsaloop.out: http://ix.io/1pUj
aplay.out: http://ix.io/1pUk
asound-remote (the config): http://ix.io/1pUl

I think I'll investigate network audio with JACK next but I wanted to
share my experiences in case there is something I'm doing wrong here,
or in case there are bugs that can be fixed in ALSA.

Thank you,

Frederick
