From: "Giovanni Maruzzelli" <gmaruzz.lists@gmail.com>
Subject: dsnoop do not works on snd-hda-intel
Date: Mon, 17 Sep 2007 07:21:03 +0200
Message-ID: <7c5010d60709162221v13d9d4e8w9b481f36cdfe7851@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.185])
	by alsa0.perex.cz (Postfix) with ESMTP id D9A42103802
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 07:21:03 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so1513176fka
	for <alsa-devel@alsa-project.org>; Sun, 16 Sep 2007 22:21:03 -0700 (PDT)
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

Hi all,

I hope someone can give me an hint on this problem, that is stopping me.

On my new laptop (asus f5v) dsnoop do not works, neither I can record
at the same moment with more than one application. The second
application that want to use the dsnoop, fail to open it.

I'm using Ubuntu 7.04 fully updated.

lspci gives:
00:0f.0 Audio device: Silicon Integrated Systems [SiS] Azalia Audio Controller

cat /proc/asound/card0/codec#* | grep Codec gives:
Codec: Realtek ALC660-VD
Codec: Motorola Si3054

I've upgraded driver, lib, and utils to 1.0.14 but it do not helped.

I've put at the end of /etc/modprobe.d/alsa-base
options snd-hda-intel model=3stack-660

I can always reproduce the behavior, for eg:

root@ubuntu-lap:~# arecord -Ddefault ciao.wav &
[1] 6923
root@ubuntu-lap:~# Recording WAVE 'ciao.wav' : Unsigned 8 bit, Rate
8000 Hz, Mono

root@ubuntu-lap:~# arecord -Ddefault ciao2.wav &
[2] 6926
root@ubuntu-lap:~# ALSA lib pcm_dsnoop.c:606:(snd_pcm_dsnoop_open)
unable to open slave
arecord: main:545: audio open error: Invalid argument

[2]+  Exit 1                  arecord -Ddefault ciao2.wav

I can give any additional info is needed.

Thank you all in advance,

Giovanni Maruzzelli
