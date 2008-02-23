From: Ctirad Fertr <c.fertr@gmail.com>
Subject: Re: emu10k1, how to setup DMA for 24bit playback?
Date: Sat, 23 Feb 2008 14:46:38 +0100
Message-ID: <200802231446.39988.c.fertr@gmail.com>
References: <200802210009.33259.c.fertr@gmail.com>
	<75b66ecd0802221705i77c753fdh7c30d7f7f30e7e05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.vol.cz (smtp1.vol.cz [195.250.128.78])
	by alsa0.perex.cz (Postfix) with ESMTP id 81C53103843
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 14:48:14 +0100 (CET)
Received: from [10.16.3.4] (dsl-tn-6-43.static.adsl.vol.cz [83.148.7.43])
	by smtp1.vol.cz (Postfix) with ESMTP id 452038478D
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 14:48:12 +0100 (CET)
In-Reply-To: <75b66ecd0802221705i77c753fdh7c30d7f7f30e7e05@mail.gmail.com>
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

Saturday 23 of February 2008 02:05:34 Lee Revell napsal(a):

Hello Lee,

thanks for your reply.

> I did quite a bit of work on this driver a few years back, among other
> things I implemented the multichannel playback support (the hw:0,3
> device).

Yes, I know. This code works well with e-mu cards as well, although it is 
limited to 16bit/48kHz. I'd like to improve this as well, but first I have to 
finish basic stereo 24bit playback via hw:0,0. 

> Do you have a web page with details on your work, or can you explain
> exactly what you've done so far and how it fails?  Preferably in patch
> form...

Well, if you look at emufx.c around line 1566, you will see how the 24 bit 
capture works. The data path (for newer e-mu cards as 1616(M) or 1212M V2) is 
following:

physical inputs (24bit) -> FPGA (internal routing) -> emu10k via A3_EMU32IN() 
(still 24bit padded to 32bit ) -> DSP code converts 32bit sample to 2 16bit 
via snd_emu10k1_audigy_dsp_convert_32_to_2x16() and feeds A_FXBUS2(x) and 
A_FXBUS(x+1) with the resulting halfs -> DMA -> PC side joins these two 16bit 
halfs into one S32_LE sample and voila, we have 24bit capture.

The driver, however, still lacks 24bit playback, and I'm trying to change 
that.  I have working DSP routine which converts two 16bit values from 
A_FXBUS(x) and A_FXBUS(x+1) into 32bit value for  A3_EMU32OUT(), where the 
FPGA and physical output are connected. 

So all I need is to send 32bit sample divided to two 16bit halfs via two 
A_FXBUS() into emu10k DSP. Unfortunatelly, simple changing the sample format 
to S32_LE did not the trick :( Any ideas? 

> How are you getting your hardware info? 

Just from the alsa emu10k source code and some hit and miss experiments. 
Unfortunatelly, there are no emu10k datasheets available :(

Ctirad
