From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Fixes AC3 output on Audigy2 sound cards.
Date: Mon, 21 Mar 2005 21:26:29 +0000
Message-ID: <423F3C05.3010100@superbug.co.uk>
References: <423C312E.7010503@superbug.co.uk> <s5hacow4w4b.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040009010201070407070009"
In-Reply-To: <s5hacow4w4b.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040009010201070407070009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Sat, 19 Mar 2005 14:03:26 +0000,
> James Courtier-Dutton wrote:
> 
>>Hi,
>>
>>This patch adds a DSP patch to fix an spdif_bug on some Audigy2 cards.
>>It also does detailed identification of the capabilities of the sound 
>>card so that the patch is only applied to the sound cards that really 
>>need it.
>>
>>Signed off: James Courtier-Dutton
> 
> 
> The patch seems to have both this change and the addition of
> capabilities selection.  Could you split into two patches?
> 
> 
> thanks,
> 
> Takashi
> 
> 
Patch must be applied after the "[PATCH] Add framework for better audigy 
sound card capabilities selection." one.


Signoff: James Courtier-Dutton

This patch adds a DSP patch to fix an spdif_bug on some Audigy2 cards.


--------------040009010201070407070009
Content-Type: text/plain;
 name="ac3-fix.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac3-fix.diff.txt"

Index: alsa-driver/alsa-kernel/pci/emu10k1/emufx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emufx.c,v
retrieving revision 1.69
diff -u -r1.69 emufx.c
--- alsa-driver/alsa-kernel/pci/emu10k1/emufx.c	17 Feb 2005 14:51:52 -0000	1.69
+++ alsa-driver/alsa-kernel/pci/emu10k1/emufx.c	21 Mar 2005 21:23:37 -0000
@@ -1339,6 +1339,7 @@
 	/* A_PUT_STEREO_OUTPUT(A_EXTOUT_FRONT_L, A_EXTOUT_FRONT_R, playback + SND_EMU10K1_PLAYBACK_CHANNELS); */
 
 	/* IEC958 Optical Raw Playback Switch */ 
+	gpr_map[gpr++] = 0;
 	gpr_map[gpr++] = 0x1008;
 	gpr_map[gpr++] = 0xffff0000;
 	for (z = 0; z < 2; z++) {
@@ -1349,7 +1350,14 @@
 		A_SWITCH(icode, &ptr, tmp + 0, tmp + 2, gpr + z);
 		A_SWITCH_NEG(icode, &ptr, tmp + 1, gpr + z);
 		A_SWITCH(icode, &ptr, tmp + 1, playback + SND_EMU10K1_PLAYBACK_CHANNELS + z, tmp + 1);
-		A_OP(icode, &ptr, iACC3, A_EXTOUT(A_EXTOUT_FRONT_L + z), A_GPR(tmp + 0), A_GPR(tmp + 1), A_C_00000000);
+		if ((z==1) && (emu->card_capabilities->spdif_bug)) {
+			/* Due to a SPDIF output bug on some Audigy cards, this code delays the Right channel by 1 sample */
+			snd_printk("Installing spdif_bug patch: %s\n", emu->card_capabilities->name);
+			A_OP(icode, &ptr, iACC3, A_EXTOUT(A_EXTOUT_FRONT_L + z), A_GPR(gpr - 3), A_C_00000000, A_C_00000000);
+			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 3), A_GPR(tmp + 0), A_GPR(tmp + 1), A_C_00000000);
+		} else {
+			A_OP(icode, &ptr, iACC3, A_EXTOUT(A_EXTOUT_FRONT_L + z), A_GPR(tmp + 0), A_GPR(tmp + 1), A_C_00000000);
+		}
 	}
 	snd_emu10k1_init_stereo_onoff_control(controls + nctl++, "IEC958 Optical Raw Playback Switch", gpr, 0);
 	gpr += 2;

--------------040009010201070407070009--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
