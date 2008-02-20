From: Ctirad Fertr <c.fertr@gmail.com>
Subject: emu10k1, how to setup DMA for 24bit playback?
Date: Thu, 21 Feb 2008 00:09:33 +0100
Message-ID: <200802210009.33259.c.fertr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.vol.cz (smtp2.vol.cz [195.250.128.75])
	by alsa0.perex.cz (Postfix) with ESMTP id A111B24568
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 00:10:46 +0100 (CET)
Received: from [10.16.3.4] (dsl-tn-6-43.static.adsl.vol.cz [83.148.7.43])
	by smtp2.vol.cz (Postfix) with ESMTP id 43AF629956
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 00:10:46 +0100 (CET)
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

Hello, 

I'm trying to add 24bit playback for E-mu cards into emu10k driver. These 
cards use an FPGA, which is 32bit internally and it is feeded via 10k2 EMU32 
BUSes.  Unfortunatelly, the emu10k DMA cannot handle more than 16bit samples, 
so kind of tricky stuff is needed. The already working 24bit multichannel 
capture uses an DSP code, which splits an 32 bit sample into two halfs, sent 
it over two DMA channels and then alsa lib (???) joins it back into S32_LE 
sample. 

I'm trying to use same technique in reverse way using a pair of A_FXBUSes for 
one playback chanel, but I'm not able to set the DMA the way I need. Can 
someone with emu10k knowledge help me?   

----
Ctirad    
