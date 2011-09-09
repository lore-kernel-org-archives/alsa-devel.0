From: Ilya Dmitrichenko <errordeveloper@gmail.com>
Subject: hdsp: 2.6.39 IRQ set-up error
Date: Fri, 9 Sep 2011 20:41:11 +0100
Message-ID: <CAPhDKbEL_VCycmsKhZJ1PvDzS+vmOr54FOCZLmo7kqk9DKBN8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id A12962454E
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 21:41:12 +0200 (CEST)
Received: by vws20 with SMTP id 20so1377774vws.24
	for <alsa-devel@alsa-project.org>; Fri, 09 Sep 2011 12:41:11 -0700 (PDT)
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

It's rather strange that IRQ number is 0,
I'm not too sure but I though 0 is a special
IRQ number, isn't it ?

% modprobe snd_hdsp
% dmesg | tail -3
[115297.031548] ALSA sound/usb/pcm.c:227: setting usb interface 1:1
[115344.320693] ALSA sound/pci/rme9652/hdsp.c:5486: Hammerfall-DSP:
unable to use IRQ 0
[115344.320712] RME Hammerfall DSP: probe of 0000:05:02.0 failed with error -16
% uname -r
2.6.39-gentoo-r3

I cannot see any options that the module could take.
Could this be due to some option in kernel config?

Cheers,
-- 
Ilya
