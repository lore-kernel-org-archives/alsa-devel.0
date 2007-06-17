From: Ctirad Fertr <c.fertr@volny.cz>
Subject: Alsa mixer interface limitations?
Date: Sun, 17 Jun 2007 21:50:51 +0200
Message-ID: <200706172150.52355.c.fertr@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.vol.cz (smtp1.vol.cz [195.250.128.78])
	by alsa0.perex.cz (Postfix) with ESMTP id CDA1110389F
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Jun 2007 21:50:55 +0200 (CEST)
Received: from [10.16.3.4] (dsl-tn-6-43.static.adsl.vol.cz [83.148.7.43])
	by smtp1.vol.cz (Postfix) with ESMTP id 51D7B40698
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Jun 2007 21:50:53 +0200 (CEST)
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

Hello!

I'm currently in phase of adding support for higher sample rates into e-mu 
1212m/1820m driver. These cards have a lot of physical inputs and outputs and 
also a bunch of internal buses used for capture, playback and internal 
routing between physical inputs and outputs. Both physical I/O and internal 
buses are shown in alsamixer, so one can set routing easily. It's a lot of 
switches, anyway.

The card has three modes. The standard (or "single speed") mode is the only 
mode currently supported in emu10k driver. It is capable of 44.1/48kHz sample 
rate only. If we need higher sample rates, we have to switch the card into 
either "double speed" (for 88.2/96kHz) or  "quadruple speed" (for 
176.4/192kHz) mode. 

The problem is that the number of inputs, outputs and especially internal 
buses significantly changes at higher speed modes. The reason is that 
internal buses are 44.1/48kHz only and thus we must use two (or four) of them 
per channel. Also some physical I/O ports disappear at double and quadruple 
speeds (e.g. ADAT has 4 channles at 96k and 2 at 192k, S/PDIF is completely 
disabled at 192k).

The question is how to deal with that in alsamixer? IMHO the best way would be 
to change the number of switches in alsamixer on the fly. Unfortunatelly, I'm 
afraid it's impossible. Another way would be to make a particular swiches 
inactive, though I don't know if it is a good idea and it wold require a lot 
of code anyway.  Any ideas? Please help!

Ctirad
