From: Alexey Bazhin <baz@irc.msk.ru>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Sun, 12 Oct 2008 16:53:53 +0400
Message-ID: <20081012165353.a084d158.baz@irc.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mosuzedu.ru (mail.mosuzedu.ru [62.117.117.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 6201B24581
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Oct 2008 14:57:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.mosuzedu.ru (Postfix) with ESMTP id 51553BD7E
	for <alsa-devel@alsa-project.org>; Sun, 12 Oct 2008 16:57:34 +0400 (MSD)
Received: from mail.mosuzedu.ru ([127.0.0.1])
	by localhost (sakura.mosuzedu.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EpQwm4AZa5x0 for <alsa-devel@alsa-project.org>;
	Sun, 12 Oct 2008 16:57:33 +0400 (MSD)
Received: from firefly.flat.yume.ru (cicada.yume.ru [217.172.19.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: baz@yume.ru)
	by mail.mosuzedu.ru (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>; Sun, 12 Oct 2008 16:57:33 +0400 (MSD)
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

I have just compiled driver from git and try to run it. My card is pci:
1102:0005 Multimedia audio controller: Creative Labs SB X-Fi

I got following:

root@mayonaka:~# modprobe snd-sbxfi
root@mayonaka:~# speaker-test -c 2 -r 96000 -t sine

speaker-test 1.0.15

Playback device is default
Stream parameters are 96000Hz, S16_LE, 2 channels
Sine wave rate is 440.0000Hz
Rate set to 96000Hz (requested 96000Hz)
[  262.522739] XFi DAC reset timeout

Period size ran[  262.564029] XFi DAC reset timeout
ge from 32 to 16[  262.620275] XFi DAC reset timeout
384
Using max b[  262.676529] XFi DAC reset timeout
uffer size 16384[  262.732784] XFi DAC reset timeout

Periods = 4
w[  262.789038] XFi DAC reset timeout
as set period_size = 4096
was set buffer_size = 16384
 0 - Front Left
[  327.491997] BUG: soft lockup - CPU#0 stuck for 61s! [swapper:0]
[  327.492001] Kernel panic - not syncing: softlockup: hung tasks

and i did hear the sine on the left channel. Hope it helps...

-- 
 Alexey Bazhin
  mailto:baz@irc.msk.ru
  ICQ 125125882
