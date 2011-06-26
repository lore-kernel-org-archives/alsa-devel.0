From: crow <crow@linux.org.ba>
Subject: Realtek ALC662 rev1 no sound over HDMI
Date: Sun, 26 Jun 2011 18:45:30 +0200
Message-ID: <BANLkTim2NwanrTtgsYGwHjkyW34fiHuuBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1889024849
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Jun 2011 18:45:33 +0200 (CEST)
Received: by iwl42 with SMTP id 42so4303185iwl.38
	for <alsa-devel@alsa-project.org>; Sun, 26 Jun 2011 09:45:32 -0700 (PDT)
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

I am trying to get sound working on kernel 2.6.39 (under archlinux
x86_64 bit distribution) over HDMI to my digital receiver but without
luck. Before this post i asked in #alsa for help, and everything we
tried over there didnt get the sound over HDMI.
I connected headphones to the green jack and ran speaker-test and
there is sound over jack, analog sound plays fine. But runing
alsamixer un-muting spdif/iec958/spdif (1) and trying to re run
speaker-test doesn't output sound over HDMI to my digital receiver.

I tried to use /etc/asound.conf for global settings (tooked from
2.6.35 archlinux i686 installation) but does not work with 2.6.39
installation, even I am not able to play analog sound:
speaker-test -c2 -twav -l1
This above works without asound.conf, and it plays analog sound on headphones.

This is how i tried to play sound over HDMI:
speaker-test -c2 -D plughw:0,3 -twav -l1

The above command does output sound on 2.6.35 (but just over Fron Right)

I run alsa-info.sh script on both installation and it can be found on
(2) kernel 2.6.39 and (3) kernel 2.6.35.

I was hoping to get sound working with 2.6.39 (current official
archlinux kernel) over HDMI by just un-muting spdif with alsamixer,
but it seems not to be that easy.

(1) http://www.abload.de/img/alsa01ji6j.png
(2) http://www.alsa-project.org/db/?f=7bf61ad34a4bb51b615773aab69ae904693a07d7
(3) http://www.alsa-project.org/db/?f=3694c9052c2b8f5d78f8a9e2a465a7c94885449b
