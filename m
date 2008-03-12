From: "Jin-Young Park" <parkjy@mtekvision.com>
Subject: I changed cross-compiler to eabi. But alsa
	applications don't working.
Date: Wed, 12 Mar 2008 17:24:51 +0900
Message-ID: <280b69ac0803120124i6688eb19k4053947b04c57577@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 3224A1038CE
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 09:24:54 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 25so3834489wfa.23
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 01:24:52 -0700 (PDT)
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

Hello.

Yesterday, I was changed cross-compiler to eabi.
All components(Kernel, libraries and applications) was re-compiled, no
problem.
Almost all components are well working, but alsa application do not working.

Any clue?

Thanks.

------ error messages ------
# madplay-alsa --no-tty-control I.O.U.mp3
MPEG Audio Decoder 0.15.2 (beta) - Copyright (C) 2000-2004 Robert Leslie et
al.
          Title: I.O.U
         Artist: Carry&Ron
ALSA lib pcm_params.c:2135:(snd1_pcm_hw_refine_slave) Slave PCM not usable
Access type not available for playback: Invalid argument
output: Invalid argument

------ error messages ------
# aplay -M -D hw:0,0 Torn.wav
Playing WAVE 'Torn.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
aplay: set_params:896: Broken configuration for this PCM: no configurations
available
