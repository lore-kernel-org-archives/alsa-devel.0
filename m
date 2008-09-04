From: Kevin Gilbert <kevin952@tpg.com.au>
Subject: Problems with pulseaudio / asla on PS3
Date: Fri, 5 Sep 2008 08:42:08 +1000
Message-ID: <200809050842.08596.kevin952@tpg.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail8.tpgi.com.au (mail8.tpgi.com.au [203.12.160.165])
	by alsa0.perex.cz (Postfix) with ESMTP id 18D9A244F5
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 00:42:36 +0200 (CEST)
Received: from giles.localnet (203-30-105-25.rucc.net.au [203.30.105.25])
	(authenticated bits=0)
	by mail8.tpgi.com.au (envelope-from kevin952@tpg.com.au)
	(8.14.3/8.14.3) with ESMTP id m84MgWVh029817
	for <alsa-devel@alsa-project.org>; Fri, 5 Sep 2008 08:42:34 +1000
Content-Disposition: inline
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

Hi,

I'm trying to get an jukebox application going on a Sony PlayStation3 using 
Qt-Embedded, Phonon and PulseAudio. The application is working well on my KDE-
based laptop where it appears that the application is using Phonon -> ALSA -> 
PulseAudio. But there is no sound from the application when run on the PS3.

I initially reported this problem to the PulseAudio mailing list. The first 
post on this topic is at https://tango.0pointer.de/pipermail/pulseaudio-
discuss/2008-August/002249.html . In pacticular, see these posts:

1) https://tango.0pointer.de/pipermail/pulseaudio-discuss/2008-
September/002346.html where I detail the results of a final test using the 
latest development version of PulseAudio; and

2) https://tango.0pointer.de/pipermail/pulseaudio-discuss/2008-
September/002347.html where a PulseAudio developer diagnoses the problem as 
being within ALSA.

For convenience, the following is from the latter post:

"So, what happens here is this: your device can only do non-interleaved audio 
and is hence configured for it (as we can see from that "slave setup" listing 
above). Because your hardware lacks a hardware volume control ALSA puts 
"softvol" on top of the hw device: the "Soft Volume PCM" you can see in the 
first part. That device is initialized for interleaved audio as you can see. 
Which is what PA supports and PA asked for.

Now, if softval takes non-interleaved from below and gives interleaved to the 
layer above than it would need to rearrange those samples -- which it however 
doesn't actually. PA hence checks with those asserts if the audio data is 
properly arranged -- which it is not as we can see.

This is a bug in ALSA's softvol module. Please report this on alsa-devel. 
softvol falsely claims to be able to rearrange non-interleaved audio to 
interleaved."

Not sure what other information I should post here so I'll wait for any 
feedback.

Thanks in advance,
Kevin
