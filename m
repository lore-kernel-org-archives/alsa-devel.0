From: Mark Hills <mark@pogo.org.uk>
Subject: Layla 3G does not recover from ACPI Suspend
Date: Sun, 6 Sep 2009 15:16:57 +0100 (BST)
Message-ID: <alpine.BSO.2.00.0909061445140.28864@zrgural.vwaro.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 48D5D244B2
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Sep 2009 16:16:58 +0200 (CEST)
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

I have an Echo Layla 3G in my workstation. It works for audio, but does 
not recover from ACPI suspend to RAM.

On recovery the system is fine, and the Layla exists in 
/proc/asound/cards. But when the Layla is used it prints this message to 
dmesg, multiple times:

   wait_handshake(): Timeout waiting for DSP

Here are the relevant dmesg lines after awakening:

   Echoaudio Echo3G 0000:03:03.0: restoring config space at offset 0xf (was 0x100, writing 0x104)
   Echoaudio Echo3G 0000:03:03.0: restoring config space at offset 0x4 (was 0x0, writing 0xe7d00000)
   Echoaudio Echo3G 0000:03:03.0: restoring config space at offset 0x3 (was 0x0, writing 0xc010)
   Echoaudio Echo3G 0000:03:03.0: restoring config space at offset 0x1 (was 0x2800000, writing 0x2800112)
   Echoaudio Echo3G 0000:03:03.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19

I couldn't see anything loading the firmware. I thought unloading and 
loading snd-echo3g after recovery would help. This shows the firmware 
being loaded, but then no ALSA device is shown in /proc/asound/cards. On 
loading snd-echo3g:

   Echoaudio Echo3G 0000:03:03.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
   Echoaudio Echo3G 0000:03:03.0: firmware: requesting ea/echo3g_dsp.fw
   Echoaudio Echo3G 0000:03:03.0: firmware: requesting ea/loader_dsp.fw
   Echoaudio Echo3G 0000:03:03.0: PCI INT A disabled
   Echoaudio Echo3G: probe of 0000:03:03.0 failed with error -5

Is the firmware not being loaded when it should be? Or is there some extra 
initialisation not being done (eg. init_hw() in echo3g_dsp.c)?

All other devices in the system recover fine, but as far as I'm aware no 
other PCI devices require firmware. It's a Dell x86 system, kernel 
2.6.31-rc7.

Thanks for any help,

-- 
Mark
