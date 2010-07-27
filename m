From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Time to give up on PA
Date: Tue, 27 Jul 2010 14:44:39 +0800
Message-ID: <AANLkTimgA23-aJFpL6C=BV1UEFgp9Gei8SZxvC+-JKbg@mail.gmail.com>
References: <1280201582.10543.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8194B243A7
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 08:44:43 +0200 (CEST)
Received: by vws20 with SMTP id 20so3734228vws.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 23:44:40 -0700 (PDT)
In-Reply-To: <1280201582.10543.6.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/7/27 Chris <cpollock@embarqmail.com>

> Raymond, please look at the attached file that was gleamed from a 552k
> hourly syslog snippet. From what I can see PA is not working correctly
> and it's sucking up all my memory not to mention causing my HD to thrash
> for minutes at a time. For instance, the drive was being accessed from
> 10pm to around 10:20 continously, I was finally able to log out and shut
> down PA through MCC. Also look at the one entry where clamav would not
> run.
>
> http://ez-files.net/646514
>
>
> Jul 26 20:44:40 localhost spamd[17669]: rules: failed to run CLAMAV
> test, skipping:
> Jul 26 20:44:40 localhost spamd[17669]:  (__alarm__ignore__(172)
> Jul 26 20:44:40 localhost spamd[17669]: )
> Jul 26 20:44:42 localhost spamd[17669]: check: exceeded time limit in
> Mail::SpamAssassin::Plugin::Check::_eval_tests_type13_prineg100_set3,
> skipping further tests
> Jul 26 20:44:44 localhost spamd[17669]: plugin: eval failed:
> __alarm__ignore__(131)
>
> I've currently got PA disabled in MCC I'm afraid to restart because of
> all the problems, any advice?? I don't see a fix in sight.
>
> Thanks for all your help
>
> Chris
>


It is quite clear that the sound card ens1371 is underrun as appl_ptr is
behind hw_ptr


It is strange that PA server use 1 period per buffer (16384) which is
different from your daemon.conf and also different from your two bug report
at mandriva bugzilla

http://thread.gmane.org/gmane.linux.alsa.devel/75101/focus=75105

Do this mean that some parameters in daemon.conf is obsolete ?

https://qa.mandriva.com/show_bug.cgi?id=56473#c15

https://qa.mandriva.com/show_bug.cgi?id=60169#c0


Although 16384 is multiple of 8 but one period per buffer is unlikely to
work on those non HDA sound cards

http://thread.gmane.org/gmane.linux.alsa.devel/66376/focus=66484



Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.590|   0.062)
alsa-util.c: snd_pcm_delay() returned a value that is exceptionally large:
-424360 bytes (-2405 ms).
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.590|   0.062)
alsa-util.c: Most likely this is a bug in the ALSA driver 'snd_ens1371'.
Please report this issue to the ALSA developers.
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c: snd_pcm_dump():
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c: Hardware PCM card 0 'Ensoniq AudioPCI' device 0 subdevice 0
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c: Its setup is:
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   stream       : PLAYBACK
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   access       : MMAP_INTERLEAVED
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   format       : S16_LE
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   subformat    : STD
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   channels     : 2
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   rate         : 44100
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   exact rate   : 44101 (1445100000/32768)
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   msbits       : 16
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   buffer_size  : 16384
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   period_size  : 16384
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   period_time  : 371510
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   tstamp_mode  : ENABLE
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   period_step  : 1
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   avail_min    : 16384
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   period_event : 0
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   start_threshold  : -1
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   stop_threshold   : 1073741824
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   silence_threshold: 0
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   silence_size : 0
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   boundary     : 1073741824
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   appl_ptr     : 389015462
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.634|   0.043)
alsa-util.c:   hw_ptr       : 389121552
Jul 26 20:41:13 localhost pulseaudio[26721]: (89776.669|   0.035)
alsa-sink.c: Increasing wakeup watermark to 120.11 ms
