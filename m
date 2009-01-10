From: Stefanie <21_halfthetruth@web.de>
Subject: hda_codec: Unknown model for ALC268
Date: Sat, 10 Jan 2009 22:39:05 +0100
Message-ID: <49691579.2070600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate03.web.de (fmmailgate03.web.de [217.72.192.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 349251037EB
	for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2009 22:37:05 +0100 (CET)
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id B6C12F66603B
	for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2009 22:37:04 +0100 (CET)
Received: from [80.142.227.1] (helo=Mescalin.local)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273) id 1LLlVw-0002cB-00
	for alsa-devel@alsa-project.org; Sat, 10 Jan 2009 22:37:04 +0100
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

I have problems with the sound chip of my notebook. It is a Medion akoya
WIM 2220. Actually, there is a driver for the chip, but somehow, I can't
get it to work. I'm desperate and don't know what to do.

My friend helped my to gather the following information:

This is from lspci:

00:1b.0 0403: 8086:284b (rev 04)

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio
Controller (rev 04)
        Subsystem: Wistron Corp. Device 4085
        Flags: fast devsel, IRQ 22
        Memory at fa200000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
Count=1/1 Enable-
        Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [100] Virtual Channel <?>
        Capabilities: [130] Root Complex Link <?>
        Kernel modules: snd-hda-intelk <?>
 
I have found this in my syslog while trying to load snd-hda-intel:

Jan 10 21:30:16 Mescalin HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22
(level, low) -> IRQ 22
Jan 10 21:30:16 Mescalin HDA Intel 0000:00:1b.0: setting latency timer to 64
Jan 10 21:30:16 Mescalin hda_codec: Unknown model for ALC268, trying
auto-probe from BIOS...
Jan 10 21:30:16 Mescalin hda_codec: Cannot set up configuration from
BIOS.  Using base mode...
Jan 10 21:30:16 Mescalin SPDIF already defined
Jan 10 21:30:16 Mescalin HDA Intel 0000:00:1b.0: PCI INT A disabled
Jan 10 21:30:16 Mescalin HDA Intel: probe of 0000:00:1b.0 failed with
error -16

Thanks in advance for your help.

Stefanie
