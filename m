From: Timur Tabi <timur@freescale.com>
Subject: I don't understand snd_pcm_ops
Date: Fri, 18 May 2007 18:13:49 -0500
Message-ID: <464E332D.4010106@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id CD97524423
	for <alsa-devel@alsa-project.org>;
	Sat, 19 May 2007 01:13:52 +0200 (CEST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l4INDnLO020057
	for <alsa-devel@alsa-project.org>; Fri, 18 May 2007 16:13:50 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l4INDnXK010897
	for <alsa-devel@alsa-project.org>; Fri, 18 May 2007 18:13:49 -0500 (CDT)
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

I'm new to ALSA driver development, and I'm writing an SOC driver for new hardware.  Can 
someone explain to me what the snd_pcm_ops structure is for?  And it sounds like a stupid 
question, but after studying documentation and sample code, I'm still confused.

First off, I thought PCM stood for Pulse Code Modulation, but that just describes the 
format of the digital data.  I don't understand what a PCM operation could be.

I've seen documentation where PCM is considered an alternative to I2S or AC97.  But if you 
look at eti_b1_wm8731.c, you'll see this:

#include "at91-pcm.h"
#include "at91-i2s.h"

So is the AT91 a PCM device or an I2S device???

Some background: I'm writing driver for a new SOC that has an I2S interface, and it's 
talking to a CS4270 codec, but the CS4270 codec is wired up in "stand-alone" mode, so 
there's no software configuration.

--
Timur Tabi
Linux Kernel Developer @ Freescale
