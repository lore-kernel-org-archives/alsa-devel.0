From: Dmitry Baikov <dsbaikov@gmail.com>
Subject: Fwd: [LAD] kernel 2.6.29 rc6 no working rme multiface 1
Date: Mon, 2 Mar 2009 06:59:35 +0300
Message-ID: <70a871c80903011959s9e4c94ds62aa0e88b4f2c040@mail.gmail.com>
References: <20090302025929.64889223@rt-ente>
	<70a871c80903011849r586443e4h7188747ac01cbaf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id CE4B71037EC
	for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2009 04:59:36 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 6so1433570ywa.2
	for <alsa-devel@alsa-project.org>; Sun, 01 Mar 2009 19:59:35 -0800 (PST)
In-Reply-To: <70a871c80903011849r586443e4h7188747ac01cbaf3@mail.gmail.com>
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

---------- Forwarded message ----------
From: Dmitry Baikov <dsbaikov@gmail.com>
Date: Mon, Mar 2, 2009 at 5:49 AM
Subject: Re: [LAD] kernel 2.6.29 rc6 no working rme multiface 1
To: "m.wolkstein@gmx.de" <m.wolkstein@gmx.de>
Cc: The Linux Audio Developers' Mailing List
<linux-audio-dev@lists.linuxaudio.org>


On Mon, Mar 2, 2009 at 4:59 AM, m.wolkstein@gmx.de <m.wolkstein@gmx.de> wrote:
> hiho,
> my name is michael wolkstein and i wrote the first time to this list.
> sorry about my english. but i am no english native-speaker.
>
> after booting kernel 2.6.29 rc6 i get a problem with my rme multiface 1 connected true pcmcia cardbusinterface.
>
> i get this message after insert my card.
> RME Hammerfall DSP 0000:16:00.0: enabling device (0000 -> 0002)
> RME Hammerfall DSP 0000:16:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> Hammerfall-DSP: no Digiface or Multiface connected!
> RME Hammerfall DSP 0000:16:00.0: PCI INT A disabled
> RME Hammerfall DSP: probe of 0000:16:00.0 failed with error -5
>
> i have compile the kernel included alsa module.
> also i have installed the newest alsa-firmware 1.0.19 and newest alsa-tools 1.0.19.
>
> my old kernel 2.6.24 load both firmwares correct.
>
> the old one 1.0.16 (debian unstable)
> and the new 1.0.19 download from the alsa-project page
>
> the new kernel produce errors. kernel module snd_hdsp is already loaded with the new kernel.


Have the same problem here.
2.6.24 works, 2.6.28 doesn't (tried 2.6.8-ARCH and 2.6.28.7-1-ARCH).
I reported the problem to alsa-devel list, but they said I have hw
problems (I think I do not).

The latest arch kernel gives oops, if the card is inserted before booting.
It crashes during udev event processing (i.e. something from userspace
triggers the problem)
If anybody is really interested, I can try to provide kernel backtrace
(either type it in, or try to use serial console).


Dmitry.
