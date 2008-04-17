From: Ctirad Fertr <c.fertr@gmail.com>
Subject: Re: Patchmix-style application for EMU cards
Date: Thu, 17 Apr 2008 18:07:21 +0200
Message-ID: <200804171807.21325.c.fertr@gmail.com>
References: <c812bae60804150126j5258843em44849b3c5f367f8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.vol.cz (smtp1.vol.cz [195.250.128.78])
	by alsa0.perex.cz (Postfix) with ESMTP id 3366B103852
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Apr 2008 18:08:07 +0200 (CEST)
Received: from [10.16.3.4] (dsl-tn-6-43.static.adsl.vol.cz [83.148.7.43])
	by smtp1.vol.cz (Postfix) with ESMTP id EFE1A89AE8
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Apr 2008 18:08:06 +0200 (CEST)
In-Reply-To: <c812bae60804150126j5258843em44849b3c5f367f8f@mail.gmail.com>
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

Dne Tuesday 15 of April 2008 10:26:06 Camilo Polymeris napsal(a):

Hello

> I am working on a graphical mixing/routing application for the Emu10k
> series of semi-pro soundcards, 

That is great!  I planned to try to write one, but never have enough time to 
do that. 

> but I am having trouble figuring out the 
> routing mechanism of the driver, specially the "Multichannel PCM" part. Is
> there any technical documentation on this card I could read (I haven't
> found any),

I'm afraid there is no documentation at all. The emu10k1.h and  emumixer.c are 
quite self explanatory, though. Especially the first one.

The basic idea is that we have two chips. One is custom FPGA, where all the  
physical inputs and outpusts are connected. The second chip is the emu10k 
which is conected to FPGA by a bunch of 32bit  buses. There are 32 buses from 
emu10k to FPGA called DSP0 to DSP31 used for playback and 21 buses in other 
direction called DSP0 to DSP15 (hexa numbering!) used for capture. 1 bus = 
one audio channel except for higher sample rates (e.g. 96kHz and 192kHz), 
where multiple buses are used to transfer one channel. The FPGA can assign 
any physical input (or playback DSP channel) to any capture DSP channel and 
same for outputs (see alsamixer). The multichannel capture on hw:0,2 captures 
the first 16 channels (DSP0 to DSPD). The multichannel playback on hw:0,3 is 
routed to DSP0 to DSP15.  
I hope it helps.

>  or maybe the driver developer can help me out?

Well, I'm not quite a driver developer, but I think I know E-mu cards well to 
answer any questions important for mixer appliacation ;)  So please ask. I'd 
like to help you to imporve alsa suport for these excellent cards.

Best Regards,

Ctirad
