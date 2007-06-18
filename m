From: ChernYue Kwok <chernyue@gdc-tech.com>
Subject: Output levels on SBLive! 5.1 on ALSA vs WIndows
Date: Mon, 18 Jun 2007 17:37:46 +0800
Message-ID: <200706181737.47296.chernyue@gdc-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from helium.gdc-tech.com (www.gdc-tech.com [203.132.205.66])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BCD724349
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2007 11:37:51 +0200 (CEST)
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
Cc: Pranay Kumar <pranay@gdc-tech.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I am using an SBLive! 5.1 sound card (emu10k1 chipset) with 6 channel output. 
Due to the nature of my work, I need to be able to play sound through all 6 
channels at the same output level to an amplifier.

Using Linux and the emu10k1 ALSA driver, I measured output voltage levels on 
an oscilloscope while playing a sine wave on all 6 channels, and I got three 
different output voltage amplitudes for the front, rear and center/subwoofer 
channels.
Repeating the same test with the same card on WIndows using the Creative 
SBLive drivers from their website, I am able to get the same output voltage 
amplitude on all 6 channels.
For both tests, all output levels in the relevant mixers were set to their 
maximum levels.

I would like to know if this output normalizing 'feature' of the SBLive 
Windows driver can be found in the emu10k1 ALSA driver, or in any other ALSA 
driver. Failing that, is there any other solution to set output levels in the 
driver, or am I doomed to twiddle in alsamixer to get the output levels that 
I want?

Thanks in advance.
