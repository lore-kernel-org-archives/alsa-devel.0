From: Jan Engelhardt <jengelh@medozas.de>
Subject: No mixers on ATI RS780 Azalia
Date: Wed, 26 May 2010 14:04:27 +0200 (CEST)
Message-ID: <alpine.LSU.2.01.1005261303170.19406@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from borg.medozas.de (borg.medozas.de [188.40.89.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F75D10381A
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 14:04:30 +0200 (CEST)
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
Cc: tiwai@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,


I have here a Samsung 320MXn2 monitor/mainboard (typical x86_64 
environment) where I cannot get sound output to the internal speakers 
working.

To start, there seem to be two sound cards:

lspci/lspci -n:
00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)
01:05.1 Audio device: ATI Technologies Inc RS780 Azalia controller
00:14.2 0403: 1002:4383
01:05.1 0403: 1002:960f

/proc/asound/cards:
 0 [SB  ]: HDA-Intel - HDA ATI SB
           HDA ATI SB at 0xf0500000 irq 16
 1 [HDMI]: HDA-Intel - HDA ATI HDMI
           HDA ATI HDMI at 0xf0110000 irq 19

The soundcard responsible for the internal speaker is the 01:05.1/"HDMI" 
one.

Under Windows XP, I see the following mixer elements for it:

 * Master Volume
 * Wave
 * SW Synth
 * CD Player

Subsequently, there is sound (once I bump the volumes on these).

However, in Linux up to including 2.6.34, I only see a single mixer 
element:

 * IEC958/S/PDIF

mplayer etc. all successfully write to the device, but since there are 
not any further mixer controls, I can't unmute the essential channels.

alsa-utils is version 1.0.21, from openSUSE 11.2 x86_64.


Any help is appreciated.

Thanks,
Jan
