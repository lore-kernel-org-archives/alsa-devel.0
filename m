From: Hans Schou <linux@schou.dk>
Subject: Re: PROBLEM: SIS7019 stops recording after 42 min
Date: Mon, 21 Jun 2010 20:49:37 +0200
Message-ID: <AANLkTikCGzUKe9Fy1d0xhberqGFe71lvrQbg5gkQzgf1@mail.gmail.com>
References: <AANLkTimO5PXmJiIPDw82MTA53mLSl-OC0e1SOEh7v8pH@mail.gmail.com>
	<1276972298.22889.16.camel@obelisk.thedillows.org>
	<AANLkTimwZFNLBNJWODyzKXwx9CbIorg3OCA53XZchkeN@mail.gmail.com>
	<1277043970.22889.45.camel@obelisk.thedillows.org>
	<AANLkTikBTMq3d-Ov65wYLJ_Vw-7Jde4AOwfXcEPB0wLr@mail.gmail.com>
	<1277129180.22889.64.camel@obelisk.thedillows.org>
	<AANLkTikW71h7ABVXY21pLL9AeOlmRTfVaSTjJ_6Ma0_R@mail.gmail.com>
Reply-To: linux@schou.dk
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FD34243F6
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jun 2010 20:50:00 +0200 (CEST)
Received: by wwb13 with SMTP id 13so449903wwb.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2010 11:49:58 -0700 (PDT)
In-Reply-To: <AANLkTikW71h7ABVXY21pLL9AeOlmRTfVaSTjJ_6Ma0_R@mail.gmail.com>
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

2010/6/21 Hans Schou <linux@schou.dk>:
> 2010/6/21 David Dillow <dave@thedillows.org>:
>
>>> Only 35 minutes of recording but I was running in 50min.

>>
>> Ok, cool, we see the problem with arecord as well, though you were
>> getting overrun messages as well?
>
> Yes, a lot of overrun. At least one per second.
>
>>> How do I enable SND_PCM_XRUN_DEBUG with sox?
>>
>> Sorry, that should be CONFIG_SND_PCM_XRUN_DEBUG in the kernel
>> configuration, but if we can demonstrate this with arecord, there's no
>> real reason to recompile your kernel at this point.
>
> OK, I'll skip that. It takes rather long time to compile.
>
>>> Right now uptime says
>>> =A0 =A0load average: 0.19, 0.21, 0.18
>>> but strace and top is the bad guys, not arecord.
>>
>> An overrun means that arecord didn't run for 500ms, and the load average
>> won't really tell you much about that -- latency can happen with low
>
> Well, I did not see that with sox. It was running fine for 42 min.
>
>> loads. That said, I'm suspecting that you've found a problem in the
>> driver, and I'd lay odds it is in the handling of multiple periods per
>> buffer.
>
>> I don't know the options available on sox, but if you can use arecord to
>> reproduce, then that is probably the best tool for the job. Can you set
>> it up to use two periods per buffer and see if you still can reproduce?
>> Options would look like -B 250000 -F 125000. A second test with -B
>> 1000000 -F 500000 would be interesting, if the hw can handle buffers of
>> that size -- I don't recall offhand.
>
> I have just started it with =A0-B 250000 -F 125000 and get a lot of overr=
un.
> I skipped using strace to make less stress.
>
> cmdline is now:
> arecord -B 250000 -F 125000 -c 1 -r 44100 -f S16 -M -D hw:0,0 -v arec.wav

This gave a 191069598 bytes long file. What does this test actually
show regarding the original problem with stopping after 42 min?

I have just started:
 arecord -B 1000000 -F 500000 -c 1 -r 44100 -f S16 -M -D hw:0,0 -v arec.wav
and I only got one overrun. What I did was that logged in on another
ssh console and executed "ls".

Here is a complete screen dump after running 2 minutes:
+ arecord -B 1000000 -F 500000 -c 1 -r 44100 -f S16 -M -D hw:0,0 -v arec.wav
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
  buffer_size  : 32768
  period_size  : 22050
  period_time  : 500000
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 22050
  xfer_align   : 22050
  start_threshold  : 1
  stop_threshold   : 32768
  silence_threshold: 0
  silence_size : 0
  boundary     : 1445068800
overrun!!! (at least 826.140 ms long)
Status:
  state       : XRUN
  trigger_time: 1277144902.603264297
  tstamp      : 1277144903.428975238
  delay       : 0
  avail       : 44108
  avail_max   : 44108
overrun!!! (at least 0.077 ms long)
Status:
  state       : XRUN
  trigger_time: 1277144938.378978657
  tstamp      : 1277144938.379038604
  delay       : 0
  avail       : 42344
  avail_max   : 42344

/hans
/hans
