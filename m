From: Hans Schou <linux@schou.dk>
Subject: Re: PROBLEM: SIS7019 stops recording after 42 min
Date: Mon, 21 Jun 2010 19:42:38 +0200
Message-ID: <AANLkTikW71h7ABVXY21pLL9AeOlmRTfVaSTjJ_6Ma0_R@mail.gmail.com>
References: <AANLkTimO5PXmJiIPDw82MTA53mLSl-OC0e1SOEh7v8pH@mail.gmail.com>
	<1276972298.22889.16.camel@obelisk.thedillows.org>
	<AANLkTimwZFNLBNJWODyzKXwx9CbIorg3OCA53XZchkeN@mail.gmail.com>
	<1277043970.22889.45.camel@obelisk.thedillows.org>
	<AANLkTikBTMq3d-Ov65wYLJ_Vw-7Jde4AOwfXcEPB0wLr@mail.gmail.com>
	<1277129180.22889.64.camel@obelisk.thedillows.org>
Reply-To: linux@schou.dk
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DDF68243C3
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jun 2010 19:43:00 +0200 (CEST)
Received: by wwb13 with SMTP id 13so397149wwb.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2010 10:42:59 -0700 (PDT)
In-Reply-To: <1277129180.22889.64.camel@obelisk.thedillows.org>
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

2010/6/21 David Dillow <dave@thedillows.org>:

>> Only 35 minutes of recording but I was running in 50min.
>
> Ok, cool, we see the problem with arecord as well, though you were
> getting overrun messages as well?

Yes, a lot of overrun. At least one per second.

>> How do I enable SND_PCM_XRUN_DEBUG with sox?
>
> Sorry, that should be CONFIG_SND_PCM_XRUN_DEBUG in the kernel
> configuration, but if we can demonstrate this with arecord, there's no
> real reason to recompile your kernel at this point.

OK, I'll skip that. It takes rather long time to compile.

>> Right now uptime says
>> =A0 =A0load average: 0.19, 0.21, 0.18
>> but strace and top is the bad guys, not arecord.
>
> An overrun means that arecord didn't run for 500ms, and the load average
> won't really tell you much about that -- latency can happen with low

Well, I did not see that with sox. It was running fine for 42 min.

> loads. That said, I'm suspecting that you've found a problem in the
> driver, and I'd lay odds it is in the handling of multiple periods per
> buffer.

> I don't know the options available on sox, but if you can use arecord to
> reproduce, then that is probably the best tool for the job. Can you set
> it up to use two periods per buffer and see if you still can reproduce?
> Options would look like -B 250000 -F 125000. A second test with -B
> 1000000 -F 500000 would be interesting, if the hw can handle buffers of
> that size -- I don't recall offhand.

I have just started it with  -B 250000 -F 125000 and get a lot of overrun.
I skipped using strace to make less stress.

cmdline is now:
arecord -B 250000 -F 125000 -c 1 -r 44100 -f S16 -M -D hw:0,0 -v arec.wav

overrun!!! (at least 0.201 ms long)
Status:
  state       : XRUN
  trigger_time: 1277140527.1826705
  tstamp      : 1277140527.2005279
  delay       : 0
  avail       : 16537
  avail_max   : 16537
overrun!!! (at least 0.207 ms long)
Status:
  state       : XRUN
  trigger_time: 1277140527.128608572
  tstamp      : 1277140527.128793445
  delay       : 0
  avail       : 16537
  avail_max   : 16537
overrun!!! (at least 0.167 ms long)
Status:
  state       : XRUN
  trigger_time: 1277140527.256925501
  tstamp      : 1277140527.257071819
  delay       : 0
  avail       : 16537
  avail_max   : 16537

> I will hopefully have my hardware back up and running tonight; BTW, what
> distro are you using? I'm trying Fedora 13, but I'm expecting to run
> into trouble with the lack of cmov support on the processor.

Debian stable.

/hans
