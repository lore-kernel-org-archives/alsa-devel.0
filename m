From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 latency / capture period
Date: Wed, 07 Jul 2004 20:40:03 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1089247202.9740.16.camel@mindpipe>
References: <1087416890.25102.21.camel@debian>
	 <1087704381.805.20.camel@debian>  <s5h3c4oncuh.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-bh/z2b5kBd0QeMzVoN5T"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3c4oncuh.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-bh/z2b5kBd0QeMzVoN5T
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-06-21 at 11:35, Takashi Iwai wrote:
> At Sun, 20 Jun 2004 00:06:23 -0400,
> Lee Revell wrote:
> > 
> > Now, there is one more issue.  For some reason, in the emu10k1 driver, 
> > different numbered devices are used for FXBus capture and playback -
> > capture is hw:0,2 and playback is hw:0,3.  I don't think JACK supports 
> > full duplex mode if the playback and capture devices are different.  
> > It seems like these should be part of the same device anyway, they refer
> > to the exact same registers.
> 
> Yes, it would make more sense.  I'll fix this, too.
> 
> Meanwhile, you can use asym plugin for this purpose, e.g. adding the
> following to ~/.asoundrc:
> 
> 	pcm.fx {
> 		type asym
> 		playback.pcm "hw:0,3"
> 		capture.pcm "hw:0,2"
> 	}
> 
> and use the PCM "fx" for jack.
> 

Now that I understand the driver more completely, I think that merging
these devices does not make sense.

The FXBus playback device is used for AC3 passthrough (referred to as
'Raw SPDIF PCM' in the driver source), and uses TRAM and DSP code.  The
capture device uses the FXWC register and the normal DMA buffer, and can
capture any of the 64 FXBus outputs (with Peter Zubaj's patch).  These
devices actually have almost nothing to do with each other.

I think this change should be backed out.  I am working on a new device
for multichannel, low latency capture and playback but I think it will 
merged with the current FXBus capture device, hw:x,2.  The AC3
passthrough device should be moved back to hw:x,3.  Once the driver can
support capture of raw AC3 stream, then a corresponding hw:x,3 capture
device can be added.

Also, I have attached a patch to fix a few magic numbers in emupcm.c.

Lee





--=-bh/z2b5kBd0QeMzVoN5T
Content-Description: 
Content-Disposition: attachment; filename=emupcm_magicnumber.patch
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit

Index: alsa-kernel/pci/emu10k1/emupcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emupcm.c,v
retrieving revision 1.29
diff -u -r1.29 emupcm.c
--- alsa-kernel/pci/emu10k1/emupcm.c	1 Jul 2004 09:22:16 -0000	1.29
+++ alsa-kernel/pci/emu10k1/emupcm.c	8 Jul 2004 00:36:58 -0000
@@ -669,7 +669,7 @@
 
 	if (!epcm->running)
 		return 0;
-	ptr = snd_emu10k1_ptr_read(emu, CCCA, epcm->voices[0]->number) & 0x00ffffff;
+	ptr = snd_emu10k1_ptr_read(emu, CCCA, epcm->voices[0]->number) & CCCA_CURRADDR_MASK;
 #if 0	/* Perex's code */
 	ptr += runtime->buffer_size;
 	ptr -= epcm->ccca_start_addr;
@@ -700,7 +700,7 @@
 		udelay(50);	// hack, it takes awhile until capture is started
 		epcm->first_ptr = 0;
 	}
-	ptr = snd_emu10k1_ptr_read(emu, epcm->capture_idx_reg, 0) & 0x0000ffff;
+	ptr = snd_emu10k1_ptr_read(emu, epcm->capture_idx_reg, 0) & ADCIDX_MASK;
 	return bytes_to_frames(runtime, ptr);
 }
 

--=-bh/z2b5kBd0QeMzVoN5T--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
