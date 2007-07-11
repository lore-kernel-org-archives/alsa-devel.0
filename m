From: Andreas Rumpler <andreas.rumpler@audivo.com>
Subject: Noise Problem with rate convert plugins
Date: Wed, 11 Jul 2007 17:41:21 +0200
Message-ID: <4694FA21.1020506@audivo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node1.mail8.netdiscounter.de (node1.mail8.netdiscounter.de
	[62.112.137.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 0828D103918
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 17:41:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail8.netdiscounter.de (Postfix) with ESMTP id 7FD3570000AA
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 17:41:32 +0200 (CEST)
Received: from node1.mail8.netdiscounter.de ([127.0.0.1])
	by localhost (mail8 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 24774-04 for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 17:41:31 +0200 (CEST)
Received: from [127.0.0.1] (p54921309.dip0.t-ipconnect.de [84.146.19.9])
	by mail8.netdiscounter.de (Postfix) with ESMTP id ADB7370000A5
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 17:41:30 +0200 (CEST)
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

Hello,

I'm new to this list.I hope someone could help me with a problem 
concerning the samplerate converter plugins of the alsa driver.

Firstly some facts about my application.

- Envy24 (VT1270) pci audio chip on a custom mainboard
- playback of sounds/music with different sample rates from 8kHz to 
48kHz (sample rate of the files)
- the hardware (Envy24 chip) must always run with 44.1kHz or 48kHz 
(selectable by user), because the audio is outputed by a DAC and SPDIF 
and the SPDIF clock must not be changed according to the sample rate of 
the files.
- Kernel is 2.6.22 and alsa is 1.0.14

So I'm using the samplerate (libsample rate based) plugin from the 
alsa-plugin package. Generaly it works very good.

My problem is:
Every time a playback is started a short plop noise is heard. The noise 
is on analog and SPDIF output. If I don't use the samplerate converter 
the noise is not heard at all. So it comes definitely from the rate 
converter plugin, I think. Changing  the quality level of the plugin 
don't solve the problem. I've also switched to the new Speex rate 
converter plugin. With this plugin there is no noise at the start of 
playback. But here I have trouble with awful noise at some rate 
conversions (6kHz(source) -> 48kHz(output); 11.025kHz -> 44.1kHz; 
22.05kHz -> 44.1kHz). So it's even worse than using the libsamplerate 
plugin. Finaly I've tried the libavcodec plugin, which is the worst 
according to noise.

Could any comment this problem, please?

This is my asound.conf:
##############################################
# Playback over Line-Out and SPDIF simultaniously as default

pcm.!default {
 type plug
 slave.pcm {
  type multi
  slaves.a.pcm "plughw:0,0"
  slaves.a.channels 2
  slaves.b.pcm "hw:0,1"
  slaves.b.channels 2
         bindings.0.slave a
         bindings.0.channel 0
         bindings.1.slave a
         bindings.1.channel 1
         bindings.2.slave b
         bindings.2.channel 0
         bindings.3.slave b
         bindings.3.channel 1
 }
 ttable.0.0 1
 ttable.1.1 1
 ttable.0.2 1
 ttable.1.3 1
}

pcm_slave.s1 {
 pcm default
 rate 44100
}

pcm_slave.s2 {
 pcm default
 rate 48000
}

pcm.rate_convert_44100 {
    type rate
    slave s1
    converter samplerate
}

pcm.rate_convert_48000 {
    type rate
    slave s2
    converter samplerate
}
#####################################################


Regards
Andreas Rumpler
