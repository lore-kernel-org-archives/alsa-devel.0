From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: [PATCH] emu10k1: fix misc oopses
Date: Thu, 17 Mar 2005 15:11:19 +0100
Message-ID: <m2u0naqs54.fsf@vador.mandrakesoft.com>
References: <1110950511.19984.9.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
In-Reply-To: <1110950511.19984.9.camel@mindpipe> (Lee Revell's message of
 "Wed, 16 Mar 2005 00:21:51 -0500")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--=-=-=

Lee Revell <rlrevell@joe-job.com> writes:

> The P16V patch unconditionally checks the IPR2 register in the
> interrupt handler resulting in infinite loop and system lockup on
> any non Audigy2 cards.  I really hate checking emu->is_audigy and
> emu->revision in a fast path like the IRQ handler but I don't see
> another way.
> 
> Also, don't bother allocating/freeing the DMA buffer for P16V unless
> it's really present.
> 
> This is a critical fix and should trigger an immediate rc2 release
> IMO.  Currently any emu10k1 users other than Audigy 2 will lock up
> hard as soon as they play any sound.
> 
> Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

fix more oopses:

Signed-Off-By: Arnaud Patard <apatard@mandrakesoft.com>

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=alsa2.diff

Index: emumixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emumixer.c,v
retrieving revision 1.32
diff -u -r1.32 emumixer.c
--- emumixer.c	13 Mar 2005 12:17:09 -0000	1.32
+++ emumixer.c	16 Mar 2005 17:10:10 -0000
@@ -482,9 +482,13 @@
 			change = 1;
 		}
 	}	
-	if (change && mix->epcm->voices[ch])
-		update_emu10k1_fxrt(emu, mix->epcm->voices[ch]->number,
-				    &mix->send_routing[0][0]);
+
+	if (change && mix->epcm) {
+		if (mix->epcm->voices[ch]) {
+			update_emu10k1_fxrt(emu, mix->epcm->voices[ch]->number,
+					&mix->send_routing[0][0]);
+		}
+	}
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
 	return change;
 }
@@ -544,9 +548,12 @@
 			change = 1;
 		}
 	}
-	if (change && mix->epcm->voices[ch])
-		update_emu10k1_send_volume(emu, mix->epcm->voices[ch]->number,
-					   &mix->send_volume[0][0]);
+	if (change && mix->epcm) {
+		if (mix->epcm->voices[ch]) {
+			update_emu10k1_send_volume(emu, mix->epcm->voices[ch]->number,
+						   &mix->send_volume[0][0]);
+		}
+	}
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
 	return change;
 }
@@ -600,8 +607,11 @@
 		mix->attn[0] = val;
 		change = 1;
 	}
-	if (change && mix->epcm->voices[ch])
-		snd_emu10k1_ptr_write(emu, VTFT_VOLUMETARGET, mix->epcm->voices[ch]->number, mix->attn[0]);
+	if (change && mix->epcm) {
+		if (mix->epcm->voices[ch]) {
+			snd_emu10k1_ptr_write(emu, VTFT_VOLUMETARGET, mix->epcm->voices[ch]->number, mix->attn[0]);
+		}
+	}
 	spin_unlock_irqrestore(&emu->reg_lock, flags);
 	return change;
 }

--=-=-=--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
