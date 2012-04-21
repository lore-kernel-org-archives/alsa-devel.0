From: "Paul D. DeRocco" <pderocco@ix.netcom.com>
Subject: Playback underrun recovery
Date: Sat, 21 Apr 2012 14:12:20 -0700
Message-ID: <FB1A4815959E42EF9F7B4F3A48E8E129@PAULD>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-scoter.atl.sa.earthlink.net
	(elasmtp-scoter.atl.sa.earthlink.net [209.86.89.67])
	by alsa0.perex.cz (Postfix) with ESMTP id E924724378
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Apr 2012 23:12:30 +0200 (CEST)
Received: from [76.89.179.141] (helo=PAULD)
	by elasmtp-scoter.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <pderocco@ix.netcom.com>) id 1SLhbZ-0001ZZ-Gs
	for alsa-devel@alsa-project.org; Sat, 21 Apr 2012 17:12:29 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I've got a synth program outputting directly to the main hw PCM device, with
no intervening plugins. It uses about 75-80% of the time on one core, so it
normally doesn't underrun. Once in a while, other burdens on the system
trigger an underrun, and my program never recovers. My buffer contains two
periods of 256 stereo frames (with 32-bit samples), which at 96KHz comes out
to a little over 5.3ms total. When it fails, its CPU usage goes up to 100%
on that core, and it spits out bursts of 5.3ms of audio (two full periods,
not one), with about 4ms of silence between them. My top level code consists
of a loop that generates one period at a time:

    int buf[512];

    while (true) {
        generate_samples(buf, 256); // generate 256 stereo frames
        if (snd_pcm_writei(h, buf, 256) < 0)
            snd_pcm_prepare(h);
    }

The funny thing is that if I break to the debugger and then restart, I get
exactly one underrun as you would expect, and then it recovers. What could
cause it to get into a state where it fails every other time around the
loop, and then sucks up milliseconds of CPU time before it gets going again,
thus guaranteeing another underrun?

-- 

Ciao,               Paul D. DeRocco
Paul                mailto:pderocco@ix.netcom.com 
