From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Channel swapping problem on Atmel SSC audio
Date: Thu, 11 Nov 2010 11:49:34 +1300
Message-ID: <4CDB217E.2030906@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 39BFF1037FC
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 23:48:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm working on a custom board using the AT91SAM9G45 processor and a
TLV320AIC26 SPI attached audio codec using I2S format audio. When doing
audio playback on the board the left and right channels are occasionally
flipped.

I have verified this by generating a custom wav file which has constant
data on one channel and an incrementing counter on the other channel.
The digitial out from the CPU shows that no data is being lost, but
around 1/5 times the audio channels will be flipped. The problem appears
to be that the DMA is starting on the wrong edge of the LRCLK.

I have using both SND_SOC_DAIFMT_CBM_CFM (Codec provides clocks) and
SND_SOC_DAIFMT_CBS_CFS (CPU provides clocks) but the problem occurs in
both situations. I have also tried changing TCMR:CKO to SSC_CKO_TRANSFER
and TCMR:START to SSC_START_LOW_RF, but the problem still occurs. I have
looked through the PCM/SSC DMA code and cannot find any obvious bugs.

I have checked the errata for the At91SAM9G45 processor (our chip
marking is CU-1004-A), but can't find anything which relates directly to
the problem we are seeing.

Has anybody else had this problem, or does anybody have any AT91/Atmel
hardware that they could test to see if it occurs on other hardware also?

Thanks,
~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751 
Fax:   +64 3 3779135			  USA 1800 261 2934
