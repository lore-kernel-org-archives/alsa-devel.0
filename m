From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: dmix and dsnoop
Date: Sun, 14 Feb 2010 15:26:08 +0800
Message-ID: <4f3252891002132326n3aa31c0aoa6742c49c0117039@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f171.google.com (mail-pz0-f171.google.com
	[209.85.222.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A91D243A1
	for <alsa-devel@alsa-project.org>; Sun, 14 Feb 2010 08:26:12 +0100 (CET)
Received: by pzk1 with SMTP id 1so2747341pzk.16
	for <alsa-devel@alsa-project.org>; Sat, 13 Feb 2010 23:26:09 -0800 (PST)
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

why do dmix and dsnoop 's slave alway open subdevice 0 ?

for those hardware mixing sound cards which has two or more playback
subdevices or hda-intel which may have 3 recording subdevices

when subdevice 0 is opened by another application ,

dmix / dsnoop always fail even when there are available subdevices

aplay -v -Dplug:dmix test.wav
ALSA lib pcm_dmix.c:1010:(snd_pcm_dmix_open) unable to open slave
aplay: main:654: audio open error: Device or resource busy



arecord -v -Dplug:dsnoop:1 -f cd -d20 tt.wav
ALSA lib pcm_dsnoop.c:593:(snd_pcm_dsnoop_open) unable to open slave
arecord: main:654: audio open error: Device or resource busy
