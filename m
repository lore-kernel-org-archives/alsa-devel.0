From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Specific question about ICE1724 + AK4114
Date: Thu, 24 Jan 2008 00:09:35 +0100
Message-ID: <4797C92F.2050106@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 4250110386F
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 00:09:44 +0100 (CET)
Received: from [192.168.105.213] (ap-dustin.bobrnet.cz [10.109.8.38])
	by mailserver.bobrnet.net (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	m0NNE8rc011049
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 00:14:12 +0100
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

I would like to add support for automatic detection of incoming SPDIF
sample rate for ICE cards with AK4114 DIR, specifically ESI Juli and
Prodigy192 with MI/IODI/O card.

Juli windows drivers support the detection, Prodigy drivers don't 
(broken in some other way too), but the hardware is basically identical.

AK4114 support detection by comparing the recovered clock from SPDIF 
with another clock of 11, 12 or 24MHz, supplied by a crystal, or externally.

In both cards this functionality seems to be provided by Xilinx XC9536 
CPLD, together with PLL frequency multiplier MK73-1. It all fits 
together, the CPLD provides the freqency division for PLL feedback of 
the multiplier. External reference clock input of AK4114 is connected to 
CPLD, as well as setup pins XTL0/1. Output frequency of MK73-1 specified 
in datasheet is in the range of 10-50MHz

Here is my question: For the PLL multiplier to work, its datasheet says 
it must be fed with input pulses of 20-50kHz. This frequency could be 
easily provided by ICE1724, BUT in master mode only. When in slave mode 
(which is the case for active SPDIF input - clock provided by AK4114), 
all the clocks are derived from the external clock. This signal 
obviously cannot be used as reference for the sample rate detection in 
AK4114 - i.e. basically of itself.

According to the ICE1724 datasheet, only I2C and MIDI clocks are derived 
from the 48kHz mode crystal in slave mode. The datasheed says I2C clock 
is output only during I2C read/write activity, MIDI clock is not 
directly output at all.

The cards have no other visible crystals/clock modules apart of those 
two connected directly to ICE1724. I could not trace any connections 
from the actual crystals to CPLD.

Now here I am, absolutely wondering where the CPLD gets its low 
frequency stable signal for the PLL multiplier, to provide reference 
clock for SPDIF rate detection. I am afraid without this knowledge I 
cannot make the detection work in the alsa driver.

Hopefully someone experienced in this area will throw a ray of light 
upon this mystery.

Thanks in advance for any ideas, information, suggestions.

Best regards,

Pavel Hofman.
