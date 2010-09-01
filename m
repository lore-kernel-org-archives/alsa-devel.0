From: asim khan <khan.asim.2009@gmail.com>
Subject: alsa-2.6.24
Date: Wed, 1 Sep 2010 09:20:34 +0530
Message-ID: <AANLkTikHomanw0pg+n6t0cavL4NLkx7-5kbUk7BUBem7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B60E31037FB
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Sep 2010 05:50:35 +0200 (CEST)
Received: by gwj15 with SMTP id 15so1821279gwj.38
	for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2010 20:50:35 -0700 (PDT)
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

Hello

Iam using kernel 2.6.24 and trying run an ALSA capture application on arm11
board
this application when tries to open the device snd_pcm_open
(&capture_handle, "plughw:1,0",
SND_PCM_STREAM_CAPTURE, 0)) < 0)...it gives an error
ALSA lib pcm_hw.c:1399 _snd_pcm_hw_open) Invalid value for card
I have also tried using  device "hw:1,0" plughw:0,1...but it didnt help. I
get same error
then i checked /dev directory ,there it has not created /dev/snd directory
but I can see /dev/dsp0 dsp1,dsp2 ....which seems its not using ALSA as it
has not created /dev/snd .so I manually created the /dev/snd and the devices
like /dev/snd/pcmC0D0p and /dev/snd/controlC0. with major and minor number
as on x86 machine.same application is running well on x86

can anyone please help me in this that what could be the problem as soon as
possible..and what is solution for it....Thanks in advance

--Regards
Asim
