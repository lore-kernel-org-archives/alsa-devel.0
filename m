From: Daniel Silverstone <dsilvers@digital-scurf.org>
Subject: Issue with hda_intel on i7+Z97 chipset
Date: Tue, 28 Oct 2014 20:57:25 +0000
Message-ID: <20141028205725.GA3839@somnambulist.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bagpuss.pepperfish.net (bagpuss.pepperfish.net [148.251.8.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A7CC265733
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 21:57:28 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

Firstly, I hope this is a suitable way to report this issue.  I am using
Debian/Wheezy on a reasonably recent i7 based system which has a Z97
motherboard chipset.

In Windows, sound is perfect, but in Linux it's very crackly (direct through
alsa) and if I bring pulseaudio into the mix then it reports buffer/interrupt
issues on the microphone along the lines of:

Oct 19 16:03:33 listless pulseaudio[3780]: [alsa-source] alsa-source.c: ALSA woke us up to read new data from the device, but there was actually nothing to read!
Oct 19 16:03:33 listless pulseaudio[3780]: [alsa-source] alsa-source.c: Most likely this is a bug in the ALSA driver 'snd_hda_intel'. Please report this issue to the ALSA developers.
Oct 19 16:03:33 listless pulseaudio[3780]: [alsa-source] alsa-source.c: We were woken up with POLLIN set -- however a subsequent snd_pcm_avail() returned 0 or another value < min_avail.

Similar messages are shown for issues with playback:

user.log.2.gz:Oct 18 21:50:25 listless pulseaudio[3780]: [alsa-sink] alsa-sink.c: ALSA woke us up to write new data to the device, but there was actually nothing to write!
user.log.2.gz:Oct 18 21:50:25 listless pulseaudio[3780]: [alsa-sink] alsa-sink.c: Most likely this is a bug in the ALSA driver 'snd_hda_intel'. Please report this issue to the ALSA developers.
user.log.2.gz:Oct 18 21:50:25 listless pulseaudio[3780]: [alsa-sink] alsa-sink.c: We were woken up with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or another value < min_avail.

In both cases, sound exhibts crackles, pops, crunches, stalls, repeats etc.

I can mitigate the issue by working one or more of the CPU cores hard with
bzip2 -c </dev/urandom > /dev/null

Of course, this makes my system fans run harder etc, which is a bit of a pain
for me, and it's only masking the issue, not solving it.

For reference, my motherboard's dmi shows:
        Manufacturer: Gigabyte Technology Co., Ltd.
        Product Name: Z97-D3H-CF
And the CPU reports as:
        Family: Core i7
        Manufacturer: Intel
        ID: C3 06 03 00 FF FB EB BF
        Signature: Type 0, Family 6, Model 60, Stepping 3
        Version: Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz

The relevant PCI devices are:

00:03.0 0403: 8086:0c0c (rev 06)
	Subsystem: 8086:2010
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 51
	Region 0: Memory at f7834000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: snd_hda_intel

and

00:1b.0 0403: 8086:8ca0
	Subsystem: 1458:a182
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 50
	Region 0: Memory at f7830000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: snd_hda_intel

and it's possible that this kernel message is relevant:

[   17.248493] hda-intel: IRQ timing workaround is activated for card #1. Suggest a bigger bdl_pos_adj.
[   17.251735] hda-intel: Invalid position buffer, using LPIB read method instead.

I have tried a number of bdl_pos_adj between 1 and 32 and I have tried
enable_msi=1

Neither seem to have helped significantly.

I am currently running 3.12-0.bpo.1-amd64 from Debian's wheezy-backports
repository.  Unfortunately anything newer seems to lock up during boot and I've
not managed to track down what or why as yet.

I was hoping that you may have some idea of what is going on and either some
suggestions for improving my situation on 3.12 or else some desire for further
debug data such that a newer kernel (once I can persuade one to boot) may
perform better for me.

Please let me know if you require further details from me in order to address
this.

Regards,

Daniel.

-- 
Daniel Silverstone                         http://www.digital-scurf.org/
PGP mail accepted and encouraged.            Key Id: 3CCE BABE 206C 3B69
