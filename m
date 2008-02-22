From: Remy Bruno <remy.bruno@trinnov.com>
Subject: Strange (HW?) bug with RME9632 + AO4S + Mobo DG33BU
Date: Fri, 22 Feb 2008 17:23:40 +0100
Message-ID: <20080222162340.GA30803@trinnov.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.trinnov.com (mail.trinnov.com [82.228.38.100])
	by alsa0.perex.cz (Postfix) with SMTP id 009A724412
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 17:23:40 +0100 (CET)
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
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

Hi,

I came across a quite strange bug using the RME 9632 with an intel motherboard
DG33BU, whose symptom is random xruns.
Conditions:
- Sound card = RME 9632. I tried several ones (recent and older ones), so this
  is not due to a defective card
- AI4S/AO4S (daughter boards) pluged. The bug does not happen without these. I
  also tried several ones.
- Sample rate does not matter (48kHz or 96kHz for example)
- Last alsa driver/lib (from HG tree)
- Linux kernel 2.6.23.9
- DG33BU motherboard. For example, on an Asus M2NPV-VM with the same
  cards/alsa/kernel, the bug does not happen.
- And the most strange condition: send non-null samples to channels 1&3 or
  channels 2&4 of the daughter board (ie channels 13&15 or 14&16 at 48kHz). The
  bug does not happen if you send sound on channels 1&2 only, or 1 only, or 3
  only for example, but it happens if you send on both 1&3.

By analyzing what happens, I found the reason for the xrun. In the conditions
of the bug, from time to time (say about 1 time over 1000), the memory space of
the card (called "iobase" in the hdsp driver) is incorrectly read. The value
0xFFFFFFFF is read for any register instead of the correct values. I confirmed
this behavior with the following experiment:
- I wrote a programm permanently reading the memory space of the card, in an
  active loop, by mmap()ing /sys/bus/pci/devices/<my_card>/resource0, reading
  the first word, and reporting when 0xFFFFFFFF is read (BTW, this first
  register corresponds to the card status, and the value 0xFFFFFFFF is not a
  possible status value of the card from what I saw --- or at least this value
  is highly unlikely)
  This program effectively reports some 0xff-reads when the above conditions
  are met (ie when non-null samples are sent to channel 1&3 of AO4S). As I said
  before, not all reads give 0xFF, only some of them (but of course, this is
  enough to get problems!). As soon as the above conditions are not met (for
  example, outputing true silence on the AO4S), the program stops reporting
  problems.
- To make sure the bug is not due to an alsa driver/library or program bug, I
  wanted to write non-null samples directly to the shared memory region without
  using snd_pcm_writeX(). In order to do so, I modified the code displaying
  /proc/asound/card0/hdsp in order to get the physical address of the playback
  buffer in addition to the virtual address already given. And then, by
  mmap()ing /dev/mem at the right offset, I got the possibility to write
  non-null values while the card is running. The effect is the same: while the
  alsa driver writes zeros, if I "overload" the buffer with non-null values at
  offset corresponding to channels 1&3 of the AO4S, I get several bad reads
  with my watching program (of course, the bad reads stop quickly because the
  alsa drivers continue to write zeros thus overwriting my non-null values and
  thus the bug conditions are not met any longer)

I don't know exactly who is to be blamed here, because the card with the same
driver/kernel on another motherboard works perfectly, and, indeed, no
0xFFFFFFFF reads are detected in this case. Needless to say, I tried several
DG33BU mobos, several slots, several re-plugs of the PCI card, with the same
behaviour. Maybe this can be due to some kind of PCI conflict? Anyway, the RME
card is the only PCI/PCI-express card on the mobo.

For now, the fix is truly wonderful: in hdsp_read(), keep on reading while
0xFFFFFFFF is read... With a maximum of times of course (I set 10). If the
"true" value is not 0xFFFFFFFF, then the true value will be read at least once
and so returned (I never got 10 consecutive times 0xFFFFFFFF, even not 2), and
if the "true" value is 0xFFFFFFFF, then the only side effect of the patch is 
that the register will be read 10 times instead of 1. I don't think this can do
any harm in any case. Anyway, there should be a competition for the most awful
bugfix, I'm sure this one could win :-)

So this hack fixes the software-visible part of the problem, but the
punctual disparition of the IO space of the card is still there. For example, I
don't know what happens as far as writing is concerned! Maybe some writes to
registers of the card are ignored? I did not really investigate this, but I
checked that there are no glitches in the sound (by checking that a sine is
never distorted during a whole night), contrary to what happened without the
fix.

I join the patch corresponding to this hack, I'm not sure if it should be
included in the main tree!... However, it may be usefull (it is for me anyway),
because you can't use the AO4S card without it. I would be interested to know
if other people had the same problem with this motherboard, or another one. Of
course, I would also be interested if someone has got an idea about the reason
for this strange behaviour. I will send an email to RME about this problem.

Best regards,
Remy Bruno

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename=patch_hdsp_pci_bug

diff -r bf8d84bb62bc pci/rme9652/hdsp.c
--- a/pci/rme9652/hdsp.c	Tue Feb 19 16:13:03 2008 +0100
+++ b/pci/rme9652/hdsp.c	Wed Feb 20 19:33:57 2008 +0100
@@ -643,6 +643,35 @@ static void hdsp_write(struct hdsp *hdsp
 
 static unsigned int hdsp_read(struct hdsp *hdsp, int reg)
 {
+	/* Big dirty hack.
+	 * On some archs (Intel DG33BU), when 9632 has got AI4S and(?) AO4S and
+	 * some non-null signal is sent to channels 1&3 or channels 2&4 of AO4S
+	 * (yes, strange conditions!), for some mysterious reason, the whole
+	 * card io space is from time to time read as 0xffffffff. This bad read
+	 * happens only once (from my experience), and next bad reading is
+	 * "several" reads after. Allowing 10 bad reads is more than enough. By
+	 * chance, 0xffffffff is not possible as a status and status2 read (the
+	 * most sensitive registers for PCM) and RME 9632.
+	 * This behavior has been checked by writing samples directly to mmaped
+	 * memory (at playback buffer address) and reading io space the same
+	 * way, so bypassing all alsa stuff.
+	 * Anyay, in all cases, we can wait reading something else than
+	 * 0xffffffff, and if we read 10 consecutive times 0xffffffff, we
+	 * consider this is the true value
+	 */
+	if (hdsp->io_type == H9632)
+	{
+		unsigned int val;
+		int count = 10;
+		
+		while (count-- > 0)
+		{
+			val = readl(hdsp->iobase + reg);
+			if (val != 0xffffffff)
+				break;
+		}
+		return val;
+	}
 	return readl (hdsp->iobase + reg);
 }
 
@@ -3298,8 +3327,10 @@ snd_hdsp_proc_read(struct snd_info_entry
 	status2 = hdsp_read(hdsp, HDSP_status2Register);
 
 	snd_iprintf(buffer, "%s (Card #%d)\n", hdsp->card_name, hdsp->card->number + 1);
-	snd_iprintf(buffer, "Buffers: capture %p playback %p\n",
-		    hdsp->capture_buffer, hdsp->playback_buffer);
+	snd_iprintf(buffer, "Buffers: capture %p playback %p (physical %p %p)\n",
+		    hdsp->capture_buffer, hdsp->playback_buffer,
+		ALIGN(hdsp->capture_dma_buf.addr, 0x10000ul),
+		ALIGN(hdsp->playback_dma_buf.addr, 0x10000ul));
 	snd_iprintf(buffer, "IRQ: %d Registers bus: 0x%lx VM: 0x%lx\n",
 		    hdsp->irq, hdsp->port, (unsigned long)hdsp->iobase);
 	snd_iprintf(buffer, "Control register: 0x%x\n", hdsp->control_register);

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--W/nzBZO5zC0uMSeA--
