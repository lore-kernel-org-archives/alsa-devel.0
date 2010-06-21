From: Hans Schou <linux@schou.dk>
Subject: Re: PROBLEM: SIS7019 stops recording after 42 min
Date: Mon, 21 Jun 2010 07:56:05 +0200
Message-ID: <AANLkTikBTMq3d-Ov65wYLJ_Vw-7Jde4AOwfXcEPB0wLr@mail.gmail.com>
References: <AANLkTimO5PXmJiIPDw82MTA53mLSl-OC0e1SOEh7v8pH@mail.gmail.com>
	<1276972298.22889.16.camel@obelisk.thedillows.org>
	<AANLkTimwZFNLBNJWODyzKXwx9CbIorg3OCA53XZchkeN@mail.gmail.com>
	<1277043970.22889.45.camel@obelisk.thedillows.org>
Reply-To: linux@schou.dk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 90A44244AB
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jun 2010 07:56:25 +0200 (CEST)
Received: by wwb31 with SMTP id 31so237647wwb.38
	for <alsa-devel@alsa-project.org>; Sun, 20 Jun 2010 22:56:25 -0700 (PDT)
In-Reply-To: <1277043970.22889.45.camel@obelisk.thedillows.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Dillow <dave@thedillows.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

2010/6/20 David Dillow <dave@thedillows.org>:

> You caught the correct files, yes. Did that command produce 10 second
> pauses? If not, then I need to see the same information from the rec
> command you were using to reproduce the issue before. It may be easier
> to just run the rec command for a moment to collect the data rather than
> wait the 40+ minutes to see if arecord also demonstrates the issue.

Over night I have been running arecord several times. Alle wav-files
are much below the expected size 264600000 bytes (44100*2*60s*50min).
The file size recorded

184928116
184939142
185170688
186030716
186989978
187166394
187221524
188555670
188654904
188798242
189503906
189900842

189900842/(44100*2*60) = 35.88

Only 35 minutes of recording but I was running in 50min.

It seems that arecord loses more sample than I have seen with sox-rec.

> I'm guessing that rec (sox) is using the mmap interface, and
> I've not done much with that -- though perhaps there is a bug in sox's
> overrun handling. You could enable SND_PCM_XRUN_DEBUG to see if overruns
> are happening when sox starts taking 10 seconds.

How do I enable SND_PCM_XRUN_DEBUG with sox?

> Getting overruns on SiS 550 based devices isn't entirely surprising, as
> it doesn't have a huge amount of horsepower or memory.

Well, I usually don't have problem with that. I have samba running but
I don't access the recorded files while recording, so it is not a
problem.

Right now uptime says
   load average: 0.19, 0.21, 0.18
but strace and top is the bad guys, not arecord.

>> The error does occur with rate 8000 8bit (the default).
>
> Do you mean 'does not occur'? That may be more expected -- 8khz/8bit has
> approximately 9% of the data as 44.1khz/16bit.

Sorry, yes you are right.

>> > Can you try using arecord? You can use options to tell it how to
>> > configure the PCM. Especially interesting will be to configure 2 periods
>> > per buffer vs whatever rec uses. 2 periods per buffer uses the hardware
>> > interrupts to clock out periods, where as 3+ uses a more complex
>> > mechanism. You can also use -M to use mmap vs not.
>>
>> Options like this?
>> strace -tt -o arec.log arecord -c 1 -r 44100 -f S16 -M arec.wav

I tried this one:
  arecord -c 1 -r 44100 -f S16 -M -D hw:0,0 -v arec.wav
but it did not change anything. Still the files are much too small.

Recording WAVE 'arec.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
Hardware PCM card 0 'SiS7019' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 22050
  period_size  : 5513
  period_time  : 125011
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 5513
  xfer_align   : 5513
  start_threshold  : 1
  stop_threshold   : 22050
  silence_threshold: 0
  silence_size : 0
  boundary     : 1944986400
overrun!!! (at least 4.368 ms long)
Status:
  state       : XRUN
  trigger_time: 1277092780.321430383
  tstamp      : 1277092780.323362792
  delay       : 0
  avail       : 27562
  avail_max   : 27562

# grep avail arec-stdout2.log | sort | uniq -c
      6   avail       : 22053
     13   avail       : 22055
      2   avail       : 22058
      1   avail       : 22059
     10   avail       : 22060
      4   avail       : 22062
      1   avail       : 22063
      2   avail       : 22064
  10975   avail       : 27562
      5   avail       : 33075
      2   avail       : 38588
      6   avail_max   : 22053
     13   avail_max   : 22055
      2   avail_max   : 22058
      1   avail_max   : 22059
     10   avail_max   : 22060
      4   avail_max   : 22062
      1   avail_max   : 22063
      2   avail_max   : 22064
  10975   avail_max   : 27562
      5   avail_max   : 33075
      2   avail_max   : 38588
      2   avail_min    : 5513

So most often 'avail' is 27562 after an overrun when  running arecord.

I think it would be better to test with sox-rec but which options
should be used?

/hans
