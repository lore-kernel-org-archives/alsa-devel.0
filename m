From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Fix for front speaker output on Audigy2
Date: Thu, 27 Mar 2003 20:51:18 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303272051.18647.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
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


Hi, this patch enables output from the front speakers on Audigy2 cards. I've removed the 
rubbish I had for disabling the AC97 codec mixer.

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
<               unsigned int reg = inl(emu->port + HCFG);
<               outl(reg | HCFG_GPOUT0, emu->port + HCFG);
---
>               if (!emu->audigy) {
>                       unsigned int reg = inl(emu->port + HCFG);
>                       outl(reg | HCFG_GPOUT0, emu->port + HCFG);
>               } else {
>                       unsigned int reg = inl(emu->port + A_IOCFG);
>                       outl(reg | A_IOCFG_GPOUT0, emu->port + A_IOCFG);
>               }
Index: pci/emu10k1/emufx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emufx.c,v
retrieving revision 1.30
diff -r1.30 emufx.c
1505,1506c1505,1509
<       //A_PUT_STEREO_OUTPUT(A_EXTOUT_AFRONT_L, A_EXTOUT_AFRONT_R, playback + SND_EMU10K1_PLAYBACK_CHANNELS);
<       A_PUT_STEREO_OUTPUT(A_EXTOUT_AC97_L, A_EXTOUT_AC97_R, playback + SND_EMU10K1_PLAYBACK_CHANNELS);
---
>       if (emu->audigy && emu->revision == 4) { /* audigy2 */
>               A_PUT_STEREO_OUTPUT(A_EXTOUT_AFRONT_L, A_EXTOUT_AFRONT_R, playback + SND_EMU10K1_PLAYBACK_CHANNELS);
>       } else {
>               A_PUT_STEREO_OUTPUT(A_EXTOUT_AC97_L, A_EXTOUT_AC97_R, playback + SND_EMU10K1_PLAYBACK_CHANNELS);
>       }
--- CUT HERE ---

-- 
adq


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
