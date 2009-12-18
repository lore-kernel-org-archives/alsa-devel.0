From: Michal Halva <hedik99@seznam.cz>
Subject: Re:
	=?utf-8?q?HD-Audio_device_unsuppored_=28Nvidia=09G2x?=
	=?utf-8?q?x-series=09GPU=09implemented=29?=
Date: Fri, 18 Dec 2009 00:09:33 +0000 (UTC)
Message-ID: <loom.20091218T005933-741@post.gmane.org>
References: <4B238733.2070706@arcor.de> <s5heimxlrjd.wl%tiwai@suse.de>
	<4B262682.60400@arcor.de> <s5h7hsplqlz.wl%tiwai@suse.de>
	<s5h7hspjvpv.wl%tiwai@suse.de>
	<loom.20091216T161000-446@post.gmane.org>
	<s5haaxiw04o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 862D5103810
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 01:09:57 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NLQPr-0001lz-Rk
	for alsa-devel@alsa-project.org; Fri, 18 Dec 2009 01:09:55 +0100
Received: from r5n194.net.upc.cz ([86.49.13.194])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 01:09:55 +0100
Received: from hedik99 by r5n194.net.upc.cz with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 01:09:55 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai <at> suse.de> writes:

> 
> It might be also the video driver side.
> For example, when a wrong EDID is set up in X config, the audio part also
> doesn't work.  There were similar bug reports with the older Nvidia cihpset.
> 

definitely - but changing driver versions does not help - tried
185.x,190.x,195.x with the same results
replugging HDMI cable from receiver directly to TV or using custom EDID in
xorg.conf does not help either

> Of course, it can be a driver bug.  How did you test exactly?
> A preferred way is to run like:
> 	% aplay -Dhdmi foo.wav
> It might be -Dhdmi:1, too, depending on the h/w.
> 
> Let's check firstly from the 2ch samples.

I was testing with speaker-test -c2 -Dhdmi ... interestingly enough alsa-driver
1.0.22 behaves differently than 1.0.21

1.0.21 - no warning message in kernel log, speaker test was switching amongst
channels (like it was really playing something)

1.0.22 - warning message in kernel log 
[   10.096043] ALSA hda_intel.c:694: azx_get_response timeout, switching to
polling mode: last cmd=0x100f0000
speaker-test/aplay just hangs forever until ^C

in both cases neither av receiver nor tv detects any audio on HDMI

> 
> Takashi
> 

Thanks,

Michal
