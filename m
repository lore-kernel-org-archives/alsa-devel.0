From: Vishal Thanki <vishalthanki@gmail.com>
Subject: Audible Pop noise with CS4271 codec
Date: Mon, 8 Aug 2016 10:20:30 +0200
Message-ID: <CAC3a_SBC1vgKouDcqUSqEVwnDybT6wRdP9Yv9DfCzSzCxjV8vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id D06DE266606
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 10:20:51 +0200 (CEST)
Received: by mail-wm0-f53.google.com with SMTP id o80so121797748wme.1
 for <alsa-devel@alsa-project.org>; Mon, 08 Aug 2016 01:20:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

On a custom built am335x based board with CS4271 codec, I am observing
the audible pop/click sound during playback start and playback stop
(using aplay). The pop sound is observed with kernel 4.0 as well as on
kernel 4.4. I have not tried the recent kernels but since there is no
change in the CS4271 codec driver, I am assuming the problem can be
reproduced in the latest kernel as well.

I have experimented a bit with conditional "soft reset"
(enable_soft_reset flag) which is added in driver and which seems to
have little influence in pop sound. My experiment is like following:

1) Start the board with "soft reset" enabled in CS4271 driver
2) Play sine wave tone for 5 seconds using aplay --> The pop sound is
present during starting and stopping of the playback
3) Play the silence file (no audio data - filled with zero) using
aplay --> The pop sound is present only during starting of the
playback
4) Play the silence file again using aplay --> The pop sound is
present only during starting of the playback

Now disable the "soft reset" in driver and

1) Play sine wave tone for 5 seconds using aplay --> The pop sound is
present during starting and stopping of the playback
2) Play the silence file using aplay --> The pop sound is present only
during starting of the playback
3) Play the silence file again using aplay --> The pop sound is gone
4) Play the silence file successively multiple times --> The pop sound
not observed
5) Now play the sine wave tone again --> The pop sound is present
during startup and stop.
6) Now play the silent file again --> The pop sound is present during
startup, and no pop sound during stop.

The driver handles the muting and unmuting of DAC in mute_stream DAI
callback which looks okay to me. So I have added delays in mute_stream
callback after "unmute" of DACs and noticed that unmuting of DAC is
not causing the pop noise, but it is heard as soon as the audio data
starts flowing (after .trigger() ?).

I could also not figure out what problem the "soft reset" is
addressing and how it is influencing the pop noise in successive
silence file playback.

Any help in further debugging would be greatly appreciated.

Thanks,
Vishal
