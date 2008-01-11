From: "Alexandre BOUIN" <a.bouin@kerlink.fr>
Subject: ALSA : Can't open capture device
Date: Fri, 11 Jan 2008 11:56:02 +0100
Message-ID: <13257.4637573727$1200049016@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from scanner-relay-corvus2.pulsation.fr
	(scanner-relay-corvus2.pulsation.fr [80.74.64.70])
	by alsa0.perex.cz (Postfix) with SMTP id B06B7243DD
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 11:56:05 +0100 (CET)
Content-Language: fr
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

Hi list, 

I'm working on an intern project, using an AT91SAM9260EK-based board,
embedded system.
Our kernel contains a full ALSA 1.14 with ASoC layer.
Our ASoC driver works well in capture and playback, if we are using OSS
layer or directly /dev/dsp.
So I need some tips on ALSA layer side :

here you can see that my device is created : 
ll /dev/snd/
crwxrwxrwx    1 root     root     116,   0 Dec 26  2007 controlC0
crwxrwxrwx    1 root     root     116,   4 Dec 26  2007 hwC0D0
crwxrwxrwx    1 root     root     116,  14 Dec 26  2007 pcmC0D0c
crwxrwxrwx    1 root     root     116,  16 Dec 26  2007 pcmC0D0p
ll /dev/dsp
crwxrwxrwx    1 root     root      14,   3 Dec 26  2007 /dev/dsp

A cat on playback device works (I added some traces in kernel) : 
cat < /dev/snd/pcmC0D0p
snd_pcm_open : enter
snd_pcm_open_file : before snd_pcm_open_substream
snd_pcm_open_file : after snd_pcm_open_substream
cat: read error: Invalid argument

But a cat on capture device does not work : 
cat < /dev/snd/pcmC0D0c
-sh: cannot open /dev/snd/pcmC0D0c: No such device

Any suggestion will be greatfull !!

Regards, 

Alex.
