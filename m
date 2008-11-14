From: "G.Bitzer" <gerd.bitzer@web.de>
Subject: problem with snd_hda_intel and ALC889a
Date: Fri, 14 Nov 2008 17:49:48 +0100
Message-ID: <491DAC2C.5050002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate03.web.de (fmmailgate03.web.de [217.72.192.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 35D772433A
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 17:49:49 +0100 (CET)
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id D5BFAF46E40A
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 17:49:48 +0100 (CET)
Received: from [85.216.104.173] (helo=[85.216.104.173])
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226) id 1L11rg-0003vq-00
	for alsa-devel@alsa-project.org; Fri, 14 Nov 2008 17:49:48 +0100
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

Hi All,

I have a problem I think caused by ALSA. But first the facts.


My box runs Gentoo Linux, kernel 2.6.25-gentoo-r7, amd64, on a Gigabyte 
board with the following sound hardware (excerpt from lspci -vv):

00:14.2 Audio device: ATI Technologies Inc SB600 Azalia
        Subsystem: Giga-byte Technology Device a002
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32, Cache Line Size: 4 bytes
        Interrupt: pin ? routed to IRQ 16
        Region 0: Memory at fe024000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)

There is a AMD 790X chipset on the board, and a ALC889a codec.

According to 'grep Code /proc/asound/card0/codec\#3'
a 'Codec: Realtek ALC885' is detected.

All software is self compiled, as usual with Gentoo.

I can play .ogg or .mp3 files with audacious, no problem so far, also 
viewing/listening to .wmv files or YouTube works.

But when pcm sounds are played from some games i constantly get dropouts 
and errors like

snd_pcm_writei failed: Broken pipe
preparing audio device for output
snd_pcm_writei failed: Broken pipe
preparing audio device for output
...

or

snd_pcm_writei failed: Resource temporarily unavailable
snd_pcm_writei failed: Resource temporarily unavailable
snd_pcm_writei failed: Resource temporarily unavailable
snd_pcm_writei failed: Resource temporarily unavailable
snd_pcm_writei short write: 987 out of 1024
snd_pcm_writei failed: Resource temporarily unavailable
snd_pcm_writei failed: Resource temporarily unavailable
idAudioHardwareALSA::Write: 1024 frames overflowed and dropped
snd_pcm_writei short write: 1242 out of 2048
snd_pcm_writei failed: Resource temporarily unavailable
idAudioHardwareALSA::Write: 1024 frames overflowed and dropped
snd_pcm_writei failed: Resource temporarily unavailable
snd_pcm_writei failed: Resource temporarily unavailable

After disabling 'Aggressive power-saving on HD-audio SND_HDA_POWER_SAVE' 
and 'AC97 Power-Saving Mode SND_AC97_POWER_SAVE' I got less dropouts, 
but they were still noticable.

Last but not least, my alsa is

media-libs/alsa-lib-1.0.16
media-sound/alsa-headers-1.0.16
media-sound/alsa-utils-1.0.16

This are the newest ones marked as stable in portage.

What can I do ? Are there any parameters for the kernel modules, to get 
good pcm sound ?

Thanks in advance


PS: I can send a report of alsa-info.sh, if this is helps
