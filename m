From: Oliver Ford <ipaqlinux@oliford.co.uk>
Subject: Problem setting mixer switch with amixer/alsactl.
Date: Wed, 22 Oct 2008 19:47:20 +0100
Message-ID: <48FF7538.3090000@oliford.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0.thdo.woaf.net (dog.thdo.woaf.net [213.230.192.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 962B5246B9
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 20:47:39 +0200 (CEST)
Received: from i-83-67-105-182.freedom2surf.net ([83.67.105.182]
	helo=[192.168.0.10])
	by mx0.thdo.woaf.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63) (envelope-from <ipaqlinux@oliford.co.uk>)
	id 1Ksijp-00020y-4J
	for alsa-devel@alsa-project.org; Wed, 22 Oct 2008 18:47:21 +0000
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

I have a system with a wm9713 ac97 codec. It has a single speaker 
connected to SPKL and OUT4 in BTL config.

Currently I'm setting up the audio path with a small script using amixer:
amixer cset numid=90 2        # Out4 Mux = Inv2
amixer cset numid=95 3        # Left Speaker Out Mux = Speaker
amixer cset numid=88 2        # DAC Inv Mux 2  = Speaker
amixer cset numid=31 1        # Out4 Playback Switch = on
amixer cset numid=2  1,0      # Speaker Playback Switch = L:on, R:off

and also:
amixer cset numid=62 1        # Speaker Mixer PCM Playback Switch = on

If I do all of the above except for setting 'Speaker Mixer PCM Playback 
Switch' and then un-mute that in the full alsamixer program, the audio 
works through the speaker.  If I run the 'Speaker Mixer PCM Playback 
Switch' amixer command (either before or after setting it with 
alsamixer), the audio stops working. Once that's happened I can't get it 
back at all without a full reboot (even suspend/resume doesn't help).

Setting it with alsamixer so it works and then using alsactl to save and 
restore the config also breaks it.

I'm not sure how to go about debugging this one, can anyone help?

Also, is there a way to (and should I) set the DAC -> SPKMIX -> INV2 -> 
OUT4 etc in my platform definition in the kernel code, rather than doing 
it with amixer?

Oliver Ford
