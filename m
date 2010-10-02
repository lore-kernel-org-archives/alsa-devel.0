From: Alexandre <alxgomz@gmail.com>
Subject: unsupported variant of snd_hda_intel
Date: Fri, 1 Oct 2010 19:01:33 -1000
Message-ID: <AANLkTinDxaesb-=AZi8sALtw6MkERjMr3WK7Nixkv06P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id 19A5224577
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Oct 2010 07:01:33 +0200 (CEST)
Received: by qwj9 with SMTP id 9so1981539qwj.38
	for <alsa-devel@alsa-project.org>; Fri, 01 Oct 2010 22:01:33 -0700 (PDT)
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

I have an Acer Aspire 4736G laptop.
The soundcard that is shipped in this laptop is intel-hda based as
shown (actually it's a realtek):

cat /proc/asound/cards
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0x9b300000 irq 46

Basic sound output is correct but few feature are missing:
- internal mic seems to be found but do not works.
- sound output stop working when trying to send it using HDMI output
- heads do not work when plugged neither when forcing pulseaudio to use it.

I have an ubuntu 10.10 which is shipped with alsa 1.0.23.
I have googled around and tried loading the snd-hda-intel with several
parameters () as found in HD-Audio-Models.txt to no avail.

cat /proc/asound/pcm
00-00: ALC888 Analog : ALC888 Analog : playback 1 : capture 1
00-01: ALC888 Digital : ALC888 Digital : playback 1
00-03: NVIDIA HDMI : NVIDIA HDMI : playback 1

Where can I begin to help implement the support for this sound card? I
have very skills in developement in general but am ready to try if it
is not to hard (I supose I can use previous code for similar models)..
I just need a shepherd.

Thanks
