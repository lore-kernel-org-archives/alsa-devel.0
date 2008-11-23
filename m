From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: floating point exception triggered by speaker-test on
	pc-speaker
Date: Sun, 23 Nov 2008 14:30:24 +0500
Message-ID: <ggb7td$f1a$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 367A224539
	for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2008 10:31:40 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L4BJX-00062k-Sr
	for alsa-devel@alsa-project.org; Sun, 23 Nov 2008 09:31:36 +0000
Received: from 90.151.19.103 ([90.151.19.103])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2008 09:31:35 +0000
Received: from patrakov by 90.151.19.103 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2008 09:31:35 +0000
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

I have hit a strange bug. To reproduce:

1. Build snd-pcsp.ko.

2. alsamixer -c pcsp, set the base frequency to 37286 Hz

3. $ speaker-test -r 22050 -P 4 -D plughw:pcsp

speaker-test 1.0.18

Playback device is plughw:pcsp
Stream parameters are 22050Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Rate set to 22050Hz (requested 22050Hz)
Buffer size range from 37 to 38756
Period size range from 18 to 19379
Using max buffer size 38756
Periods = 4
was set period_size = 0
was set buffer_size = 38756
  0 - Front Left
Floating point exception

I.e., as you see, period size somehow became 0. While debugging this with printfs, I 
noticed that the interval for periods in snd_pcm_hw_param_set_near() starts with 4, 
but doesn't include it (i.e., is open).

Also, I found that snd_interval_refine_first() and snd_interval_refine_last(), when 
given an open interval, refine it to something like (n n+1). This is obviously 
wrong, as there are no integer points in this interval. Changing i->max++ and 
i->min-- there to adjust the value by 2 did eliminate the floating point exception, 
but replaced it with "Unable to set nperiods 4 for playback: Invalid argument". So 
there must be something else also wrong, but I can't pinpoint it and give you a 
ready-made patch :(

-- 
Alexander E. Patrakov
