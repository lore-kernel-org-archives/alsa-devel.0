From: Antonin ENFRUN <ae.tech@noos.fr>
Subject: PATCH] SPDIF out clock sync for via8235 / ALC650
Date: 26 Nov 2002 12:42:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1038310932.5903.34.camel@petulant>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-DGCIuidIx/nrOvajLtR7"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-DGCIuidIx/nrOvajLtR7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


I'm using alsa-driver 0.9.0rc6 on an Asus A7V8X (via8235 southbridge and
ALC650 -ac97 compatible- codec).

PCM output is fine on the main analog channel, but SPDIF out is not
working for any FS != 48khz. Looking at the source, the SPDIF out is
initialised at 48Khz on startup, and there is no way to change it. But
the ALC650 disable SPDIF out if SPDIF clock is not the same as the clock
used on the corresponding ac-link channel (I don't know if it's a
standard AC97 behaviour ?)

The patch included tracks clock change on the main DAC channel, and
updates the SPDIF clock accordingly : it allows SPDIF out to output the
main PCM channel, when the sample rate is 32K, 44.1K or 48K.

If there is a better solution, let me know !

TODO:
* Test for the codec used (if other codecs don't need this ?)
* Check the channel/slot on AC97-SPSA to track the corresponding clock.

On a side note, how can I send PCM to the other channels (rear,
lfe/front and spdif) ? And is there already an API to get/set the SPDIF
clock ?

Thanks for any feedback / suggestions !

-- 
Antonin ENFRUN <ae.tech@noos.fr>

--=-DGCIuidIx/nrOvajLtR7
Content-Disposition: attachment; filename=patch.txt
Content-Type: text/plain; name=patch.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- alsa-driver-0.9.0rc6/alsa-kernel/pci/ac97/ac97_codec.c	2002-10-30 15:20:08.000000000 +0100
+++ alsa-driver-0.9.0rc6-ae/alsa-kernel/pci/ac97/ac97_codec.c	2002-11-26 10:21:13.000000000 +0100
@@ -1946,6 +1946,51 @@
  *  PCM support
  */
 
+
+// AE: Updating SPDIF Clock
+static void ae_set_spdif(ac97_t *ac97, unsigned short rate)
+{  
+	unsigned short old, new;
+	
+	// Get new SPDIF Rate
+	switch(rate) {
+	case 48000:
+		rate = AC97_SC_SPSR_48K;
+		break;
+		
+	case 44100:
+		rate = AC97_SC_SPSR_44K;
+		break;
+		
+	case 32000:
+		rate = AC97_SC_SPSR_32K;
+		break;
+		
+	default:
+		rate = AC97_SC_SPSR_48K;
+		break;
+	}
+	
+	
+	// Do we need to change SR ?
+	old = ac97->regs[AC97_SPDIF];
+	new = (old & ~  AC97_SC_SPSR_MASK) | rate;
+	if (old != new) {
+		
+		// Disable SPDIF
+		snd_ac97_update_bits(ac97, AC97_EXTENDED_STATUS, AC97_EA_SPDIF, 0);
+		
+		
+		// Set SPDIF out RATE
+		snd_ac97_update_bits(ac97, AC97_SPDIF, AC97_SC_SPSR_MASK, rate);
+		
+		
+		// Re-Enable SPDIF
+		snd_ac97_update_bits(ac97, AC97_EXTENDED_STATUS, AC97_EA_SPDIF, AC97_EA_SPDIF);
+  }
+}
+
+
 int snd_ac97_set_rate(ac97_t *ac97, int reg, unsigned short rate)
 {
 	unsigned short mask;
@@ -1978,7 +2023,13 @@
 	if (tmp > 65535)
 		return -EINVAL;
 	snd_ac97_update(ac97, reg, tmp & 0xffff);
-	snd_ac97_read(ac97, reg);
+	rate = snd_ac97_read(ac97, reg);
+	
+	// AE: Set SPDIF out RATE  
+	if (reg == AC97_PCM_FRONT_DAC_RATE) {
+	  ae_set_spdif(ac97, rate);
+	}
+
 	return 0;
 }
 

--=-DGCIuidIx/nrOvajLtR7--



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
