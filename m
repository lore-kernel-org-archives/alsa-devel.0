From: David Flater <vger@flaterco.com>
Subject: [bug] sbawe: the PnP won't stop
Date: Sat, 23 Mar 2013 22:25:18 -0400
Message-ID: <514E640E.4060502@flaterco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay03.pair.com (relay03.pair.com [209.68.5.17])
 by alsa0.perex.cz (Postfix) with SMTP id 00EA626161A
 for <alsa-devel@alsa-project.org>; Sun, 24 Mar 2013 03:25:22 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

I've got an ISA PnP SB AWE type card in a system with a non-working DMA 5.
Without intervention, the Sound Blaster always gets the broken DMA.  I have
no BIOS options to control the allocation of DMAs, and the PnP configuration
done within ALSA ignores /etc/isapnp.conf [*].  DMA 6 works fine if I can get
sbawe to stop re-initializing the PnP and just use it.

# Use setup from isapnp with dma16 moved to 6.
modprobe snd-sbawe isapnp=0 port=0x220 mpu_port=0x330 fm_port=0x388 awe_port=0x620 irq=5 dma8=1 dma16=6
modprobe snd-emu8000-synth

Problem is, regardless whether isapnp is 0 or 1, sbawe always PnPs the card
and puts it back on broken DMA 5.  If I have already got the card correctly
configured with /sbin/isapnp beforehand, sbawe leaves the original resources
tied up as a ghost card and allocates again (/proc/dma):

 1: SoundBlaster - 8bit
 2: floppy
 3: SoundBlaster - 8bit
 4: cascade
 5: SoundBlaster - 16bit
 6: SoundBlaster - 16bit

To get it working I ripped the following lines of code out of kernel 3.8.4,
blocking PnP completely.  As for a proper nondestructive fix, I'm not sure
whether the intent was (A) you were only supposed to get one of the two
registrations, or (B) the PnP registration was not supposed to reinit
everything if it was already set up.

--- sound/isa/sb/sb16.c~	2013-03-14 14:27:14.000000000 -0400
+++ sound/isa/sb/sb16.c	2013-03-23 20:18:50.137987332 -0400
@@ -674,13 +674,6 @@
 #ifdef CONFIG_PNP
 	if (!err)
 		isa_registered = 1;
-
-	err = pnp_register_card_driver(&sb16_pnpc_driver);
-	if (!err)
-		pnp_registered = 1;
-
-	if (isa_registered)
-		err = 0;
 #endif
 	return err;
 }


[*] So is there a different config file for PnP within ALSA?

-- DWF
