From: Toby <dryfter@gmail.com>
Subject: Re: State of the XFi driver on x86_64
Date: Mon, 3 Nov 2008 10:42:55 +1100
Message-ID: <8fe68c970811021542j172985a5hd0a8d554f6cffb26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by alsa0.perex.cz (Postfix) with ESMTP id EE5F21037EE
	for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2008 00:42:56 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 24so2323165wfg.23
	for <alsa-devel@alsa-project.org>; Sun, 02 Nov 2008 15:42:55 -0800 (PST)
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

2008/11/2 WILMES Andreas <administrator@webspace.ms>:
> Hello everbody,
>
> Can someone give the current state of the driver? What are his features,
> what is working?

I've been watching this thread for a while, and occasionally trying
out new builds, as I have an original PCI X-Fi emu20k1.
Everyone else seems to be reporting decent successes, but I have never
managed it myself.

Playing back sound files at any sample-rate results in a repeating
burst of static. Adjusting the period/buffer parameters to aplay will
cause the pitch/tone of the static burst to change, but never turn
into anything remotely like the desired sound.

I'm running this on a 64-bit system (Ubuntu 8.04 with a custom
compiled kernel). Is anyone else having success on this platform?

Thanks,
Toby

-- 
Turning and turning in the widening gyre
The falcon cannot hear the falconer
Things fall apart; the center cannot hold
Mere anarchy is loosed upon the world
