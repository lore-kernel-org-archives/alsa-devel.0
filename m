From: Guilherme Raymo Longo <grlongo.ireland@gmail.com>
Subject: sound device is buzy to run pcm.c
Date: Mon, 15 Jun 2009 00:11:15 -0300
Message-ID: <fa40cc720906142011s5c2547e9r33a484a554a89fae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f218.google.com (mail-fx0-f218.google.com
	[209.85.220.218])
	by alsa0.perex.cz (Postfix) with ESMTP id 6410024344
	for <Alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 05:11:15 +0200 (CEST)
Received: by fxm18 with SMTP id 18so3256930fxm.32
	for <Alsa-devel@alsa-project.org>; Sun, 14 Jun 2009 20:11:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am getting this problem when running the pcm.c demo program at
http://alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html


This is the execution of the program:

guilherme@lap:/home/guilherme/Experimentos# ./PCM
Playback device is plughw:0,0
Stream parameters are 44100Hz, S16_LE, 1 channels
sine wave rate is 0 0.0000Hz
Using transfer method: write
Playback open error: Device or resource busy


I tried to check if the device is really buzy:

root@lap:/home/guilherme/Experimentos# lsof |grep snd
lsof: WARNING: can't stat() fuse.gvfs-fuse-daemon file system */
home/guilherme/*.gvfs
     Output information may be incomplete.
esd       5433  guilherme  mem       CHR     116,16                6947
/dev/snd/pcmC0D0p
esd       5433  guilherme    5r          CHR     116,33                6787
/dev/snd/timer
esd       5433  guilherme    6w        CHR     116,16                6947
/dev/snd/pcmC0D0p
esd       5433  guilherme    7r         CHR      116,0                  6987
/dev/snd/controlC0

and it seems to be ok.

That's my card

root@lap:/home/guilherme/Experimentos# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: ALC883 Analog [ALC883 Analog]
 Subdevices: 0/1
 Subdevice #0: subdevice #0

Is there a way to free the device or smth is wrong with my code??
I am using slackware 12.2 kernel 2.6


Great Regads;
