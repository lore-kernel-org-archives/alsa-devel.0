From: Bas Vermeulen <Bas.Vermeulen@novero.com>
Subject: ASoC/DAPM: How to make the DAPM routing complete?
Date: Fri, 16 Sep 2011 16:07:13 +0200
Message-ID: <4E735811.2060002@novero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.novero.com (mx.novero.com [212.23.138.198])
	by alsa0.perex.cz (Postfix) with ESMTP id F1DFD24559
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 16:12:56 +0200 (CEST)
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

I am using a slightly modified version of the 88pm860x-codec.c driver 
from 3.x in an android modified 2.6.35 kernel.

I have had to make some changes to allow both capture and playback work 
on the same (I2S) interface, but so far things are working.

I am however having some problems getting the DAPM framework to set the 
correct switches needed to get the complete route to actually start.

What would be needed to get this working as it should? I can post or 
send the driver on request, but basically the same question rises for 
the current driver in the 3.x kernel.

I want/need to go from HS1/HS2 to DIN for playback, and from MIC1 to 
DOUT for capture. In order to do that, I have to set the following switches:

amixer -q sset 'DAC HS1 Mux' 'Right'
amixer -q sset 'DAC HS2 Mux' 'Left'
amixer -q sset 'I2S Mic Mux' 'ADC'
amixer -q sset 'ADC Left Mux' 'ADCL'

I would like to make this automatic, but I am unsure how to express this 
in my dapm routing table.

Note that in order to be able to use playback and capture independently 
on the I2S interface (within reason, it is not possible to use a 
different rate for instance), I had to add a SUPPLY control to the dapm 
widgets that turns on the I2S clock when needed.

Any help, hints or pointers to the right manual to read would be 
appreciated.

Bas Vermeulen
