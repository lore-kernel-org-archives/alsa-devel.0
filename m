From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Patch to fix LIN_OUT1 on Audigy2 cards (+ others)
Date: Tue, 11 Mar 2003 23:23:58 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303112323.58656.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi, this patch is in three parts.

1) The changes to emufx.c make LIN_OUT1 work on the Audigy2. It seems to be the AC97 thing again... in fact there 
was even a line in there helpfully commented out ready to be used :)

2) The changes to emu10k1_main.c. This is setting the card to use Analogue out instead of Digital. This is the 
HCFG/A_IOCFG thing on Audigy cards again... I've checked the rest of the emu10k1 code however, and it is fine.

3) Finally, the changes to emumixer.c cause the code NOT to create an AC97 mixer device on Audigy2 cards, since 
it seems to be kinda worthless and confusing.



--- CUT HERE ---
Index: pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.23
diff -r1.23 emu10k1_main.c
241c241
< 	
---
> 
243,244c243,249
< 		unsigned int reg = inl(emu->port + HCFG);
< 		outl(reg | HCFG_GPOUT0, emu->port + HCFG);
---
> 		if (!emu->audigy) {
> 			unsigned int reg = inl(emu->port + HCFG);
> 			outl(reg | HCFG_GPOUT0, emu->port + HCFG);
> 		} else {
> 			unsigned int reg = inl(emu->port + A_IOCFG);
> 			outl(reg | A_IOCFG_GPOUT0, emu->port + A_IOCFG);
> 		}
Index: pci/emu10k1/emufx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emufx.c,v
retrieving revision 1.30
diff -r1.30 emufx.c
1505,1506c1505,1509
< 	//A_PUT_STEREO_OUTPUT(A_EXTOUT_AFRONT_L, A_EXTOUT_AFRONT_R, playback + SND_EMU10K1_PLAYBACK_CHANNELS);
< 	A_PUT_STEREO_OUTPUT(A_EXTOUT_AC97_L, A_EXTOUT_AC97_R, playback + SND_EMU10K1_PLAYBACK_CHANNELS);
---
> 	if (emu->audigy && emu->revision == 4) { /* audigy2 */
> 		A_PUT_STEREO_OUTPUT(A_EXTOUT_AFRONT_L, A_EXTOUT_AFRONT_R, playback + SND_EMU10K1_PLAYBACK_CHANNELS);
> 	} else {
> 		A_PUT_STEREO_OUTPUT(A_EXTOUT_AC97_L, A_EXTOUT_AC97_R, playback + SND_EMU10K1_PLAYBACK_CHANNELS);
> 	}
Index: pci/emu10k1/emumixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emumixer.c,v
retrieving revision 1.14
diff -r1.14 emumixer.c
427c427
< 	if (!emu->APS) {
---
> 	if ((!emu->APS) && (!(emu->audigy && emu->revision == 4))) {	
435c435
< 	} else {
---
> 	} else if (emu->APS) {
436a437,438
> 	} else if (emu->audigy && emu->revision == 4) {
> 		strcpy(emu->card->mixername, "Audigy 2");
--- CUT HERE ---



-- 
adq


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
