From: =?ISO-8859-1?Q?Jean-Pierre_Andr=E9?= <jean-pierre.andre@wanadoo.fr>
Subject: Re: [Fwd: HP DV4 1155 SE - No Sound through
	speakers...]
Date: Sat, 31 Jan 2009 08:52:19 +0100
Message-ID: <49840333.2080303@wanadoo.fr>
References: <4983FE7A.1040201@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2f.orange.fr (smtp2f.orange.fr [80.12.242.151])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A17C1037E3
	for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2009 08:52:21 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f13.orange.fr (SMTP Server) with ESMTP id A796C7000098
	for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2009 08:52:20 +0100 (CET)
Received: from [10.0.0.10] (ASt-Lambert-153-1-148-127.w90-35.abo.wanadoo.fr
	[90.35.123.127])
	by mwinf2f13.orange.fr (SMTP Server) with ESMTP id 680287000085
	for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2009 08:52:20 +0100 (CET)
In-Reply-To: <4983FE7A.1040201@wanadoo.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi,

> Hi all, I have an HP DV4 1155-SE, I've been unable to get sound working
> through the speakers, although it does work through the headhpones. I ran
> alsa-.upgrade which downloaded compiled, and installed 1.0.19 - still no
> luck.
>   

I have the same IDT codec 92HD71B7X on another
HP DV4 model, and I have tracked the problem to be
the kernel configuring IRQ 22 through the APIC, but
interrupts triggerring IRQ 20 (on kernel 2.6.27 and
alsa 1.0.19). It would be interesting if you could
confirm this by analyzing /proc/interrupts.

The workarounds I know of are :
- adding irqpoll to the boot options,
- or adding noapic to the boot options,
- using mplayer to play music.

There are with option "snd-hda-intel model=hp-m4"
(this option is for HP DV5/DV7, but HP DV4
is probably different)

I have not enough knowledge to tell where the problem
lies : kernel, apic, alsa.

Regards

Jean-Pierre


> I ran alsa-info, output here:
> http://www.alsa-project.org/db/?f=844b7ee6468067460e17b7fc694e49052072a26f
>
> I filed a bug, here:
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4374
>
> Any ideas?
>   
