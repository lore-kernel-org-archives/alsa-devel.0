From: Fernando Lopez-Lezcano <nando-Q5CBQdYaXkCY9Qp+Rujo2eW1CriLhL8O@public.gmane.org>
Subject: Re: [LAD] [alsa-devel] 2.6.31.x vs. rme vs. alsa 1.0.22?
Date: Tue, 23 Feb 2010 20:48:53 +0000
Message-ID: <1266958133.2507.234.camel@localhost.localdomain>
References: <1266371882.3361.40.camel@localhost.localdomain>
	<1266882689.3704.178.camel@localhost.localdomain>
	<1266884215.3704.208.camel@localhost.localdomain>
	<1266884449.3704.214.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-oL1NfGLD6Pb0B0WPG9lo"
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
In-Reply-To: <1266884449.3704.214.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: The Linux Audio Developers' Mailing List <linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--=-oL1NfGLD6Pb0B0WPG9lo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2010-02-23 at 00:20 +0000, Fernando Lopez-Lezcano wrote:
> On Tue, 2010-02-23 at 00:16 +0000, Fernando Lopez-Lezcano wrote:
> > On Mon, 2010-02-22 at 23:51 +0000, Fernando Lopez-Lezcano wrote:
> > > On Tue, 2010-02-16 at 17:58 -0800, Fernando Lopez-Lezcano wrote:
> > > > Hey, has anyone been seeing strange behavior from this combination?
> > > > 
> > > >   kernel 2.6.31.x rt20 + alsa 1.0.22 userland
> > > >   RME card (pcmcia card + multiface)
> > > > 
> > > > hdspmixer is not doing the right thing (does not initialize the card in
> > > > a way in which playback works), it does not see the hwdep interface (or
> > > > something like that) and disables metering,
> > [MUNCH]
> > > I have been trying to see if I can figure _anything_ out of this...
> > > 
> > > A diff of 2.6.29 (last known working) against 2.6.31.12 reveals
> > > something that might have an influence on the problem:
> > > 
> > > in snd_hdsp_create_hwdep there are two lines added:
> > > 
> > > + hw->ops.open = snd_hdsp_hwdep_dummy_op;
> > 
> > Hmmm, looks like snd_hdsp_hwdep_dummy_op is not passing back the
> > hdsp->hwdep structure to the open call at all (returning 0 is not enough
> > from the description of the alsa api). That would explain what is
> > happening, most probably no ioctls are found...
> > 
> > Am I on the right track?
> 
> Argh. I was looking at the diff backwards (DOH!). The ops.open and
> ops.release ioctl calls are _missing_ in the 2.6.31.12 tree. 

The attached patch starts to make a difference (it restores the two
missing ops in hw->ops. Once the card is recognized and the firmware is
downloaded the pcmcia card + Multiface appears to be functional. Cool.

...

Now, recognizing the card is not working fully (Fedora 11 + rt kernel).
>From a cold start the card is recognized but it is not fully functional,
a rmmod snd_hdsp followed by a modprobe snd_hdsp fixes that. 

Here are the relevant dmesg entries:

Insert pcmcia card, multiface power cycled before that so firmware is
not loaded:

----
pcmcia_socket pcmcia_socket0: pccard: CardBus card inserted into slot 0
pci 0000:16:00.0: reg 10 32bit mmio: [0x000000-0x00ffff]
RME Hammerfall DSP 0000:16:00.0: enabling device (0000 -> 0002)
RME Hammerfall DSP 0000:16:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ
16
ALSA sound/pci/rme9652/hdsp.c:679: Hammerfall-DSP: iobox found after
2260ms!
ALSA sound/pci/rme9652/hdsp.c:831: Hammerfall-DSP: wait for FIFO status
<= 0 failed after 30 iterations
RME Hammerfall DSP 0000:16:00.0: firmware: requesting
multiface_firmware_rev11.bin
ALSA sound/pci/rme9652/hdsp.c:696: Hammerfall-DSP: loading firmware
ALSA sound/pci/rme9652/hdsp.c:729: Hammerfall-DSP: finished firmware
loading
ALSA sound/pci/rme9652/hdsp.c:659: Hammerfall-DSP: no Digiface or
Multiface connected!
ALSA sound/pci/rme9652/hdsp.c:659: Hammerfall-DSP: no Digiface or
Multiface connected!
ALSA sound/pci/rme9652/hdsp.c:659: Hammerfall-DSP: no Digiface or
Multiface connected!
ALSA sound/pci/rme9652/hdsp.c:659: Hammerfall-DSP: no Digiface or
Multiface connected!
----

So, the firmware is loaded (apparently) but hdsp_check_for_iobox does
not see the Multiface.  But the devices appear to be there (card #1):

----
$ cat /proc/asound/devices
  2:        : timer
  3:        : sequencer
  4: [ 0- 1]: digital audio playback
  5: [ 0- 0]: digital audio playback
  6: [ 0- 0]: digital audio capture
  7: [ 0- 0]: hardware dependent
  8: [ 0]   : control
  9: [ 1- 0]: raw midi
 10: [ 1- 0]: digital audio playback
 11: [ 1- 0]: digital audio capture
 12: [ 1- 0]: hardware dependent
 13: [ 1]   : control
----

Starting hdspmixer prints:

----
$ hdspmixer 

HDSPMixer 1.6 - Copyright (C) 2003 Thomas Charbonnel <thomas-pgofvZdtUFgdnm+yROfE0A@public.gmane.org>
This program comes with ABSOLUTELY NO WARRANTY
HDSPMixer is free software, see the file COPYING for details

Looking for HDSP cards :
Card 0 : HDA Intel at 0xfe020000 irq 17
Card 1 : RME Hammerfall DSP + Multiface at 0xc0000000, irq 16
Multiface found !
1 Hammerfall DSP card found.
Initializing default presets
----

Everything seems to be there but if I start jackd it starts fine but I
get no sound from the outputs. 

Something has not been initialized properly. I get this at some point:

----
ALSA sound/pci/rme9652/hdsp.c:4589: Hammerfall-DSP: firmware needs to be
uploaded to the card.
----

Now close jack, hdspmixer. 
/sbin/rmmod snd_hdsp
/sbin/modprobe snd_hdsp

----
RME Hammerfall DSP 0000:16:00.0: PCI INT A disabled
RME Hammerfall DSP 0000:16:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ
16
ALSA sound/pci/rme9652/hdsp.c:679: Hammerfall-DSP: iobox found after
0ms!
ALSA sound/pci/rme9652/hdsp.c:5106: Hammerfall-DSP: Firmware already
present, initializing card.
----

After that jackd is happy and the card works...
Any help appreciated!!
-- Fernando


--=-oL1NfGLD6Pb0B0WPG9lo
Content-Disposition: attachment; filename="linux-2.6.31-hdsp-hwdep.patch"
Content-Type: text/x-patch; name="linux-2.6.31-hdsp-hwdep.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

--- linux-2.6.31.x86_64/sound/pci/rme9652/hdsp.c~	2009-09-09 15:13:59.000000000 -0700
+++ linux-2.6.31.x86_64/sound/pci/rme9652/hdsp.c	2010-02-22 16:25:34.000000000 -0800
@@ -4436,6 +4436,13 @@
 	return 0;
 }
 
+static int snd_hdsp_hwdep_dummy_op(struct snd_hwdep *hw, struct file *file)
+{
+	/* we have nothing to initialize but the call is required */
+	return 0;
+}
+
+
 /* helper functions for copying meter values */
 static inline int copy_u32_le(void __user *dest, void __iomem *src)
 {
@@ -4754,7 +4761,9 @@
 	hw->private_data = hdsp;
 	strcpy(hw->name, "HDSP hwdep interface");
 
+	hw->ops.open = snd_hdsp_hwdep_dummy_op;
 	hw->ops.ioctl = snd_hdsp_hwdep_ioctl;
+	hw->ops.release = snd_hdsp_hwdep_dummy_op;
 
 	return 0;
 }
--- linux-2.6.31.x86_64/sound/pci/rme9652/hdspm.c~	2009-09-09 15:13:59.000000000 -0700
+++ linux-2.6.31.x86_64/sound/pci/rme9652/hdspm.c	2010-02-22 16:30:01.000000000 -0800
@@ -4100,6 +4100,13 @@
 	return 0;
 }
 
+static int snd_hdspm_hwdep_dummy_op(struct snd_hwdep *hw, struct file *file)
+{
+	/* we have nothing to initialize but the call is required */
+	return 0;
+}
+
+
 static int snd_hdspm_hwdep_ioctl(struct snd_hwdep * hw, struct file *file,
 				 unsigned int cmd, unsigned long arg)
 {
@@ -4206,7 +4213,9 @@
 	hw->private_data = hdspm;
 	strcpy(hw->name, "HDSPM hwdep interface");
 
+	hw->ops.open = snd_hdspm_hwdep_dummy_op;
 	hw->ops.ioctl = snd_hdspm_hwdep_ioctl;
+	hw->ops.release = snd_hdspm_hwdep_dummy_op;
 
 	return 0;
 }

--=-oL1NfGLD6Pb0B0WPG9lo
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-audio-dev mailing list
Linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
http://lists.linuxaudio.org/listinfo/linux-audio-dev

--=-oL1NfGLD6Pb0B0WPG9lo--
