From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [patch] ac97_codec(modem): Fix "MC'97 converters and GPIO not ready"
 problem.
Date: Tue, 05 Apr 2005 03:46:23 +0300
Message-ID: <E1DJBR3-00025v-4a@sc8-sf-mx1.sourceforge.net>
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Resent-To: alsa-devel@lists.sourceforge.net
Resent-message-id: <20050406142224.GA29933@sashak.softier.local>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de, alsa-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Hi,

It is nice, that "key" point here is 12000 -> 8000 sample rate, looks
like many modem codecs don't like 12000 sample rate.

Sasha.

Summary: Fix MC97 codec initialization.

This (especially 12000 -> 8000 sample rate replace) fix popular
"MC97 converters.. not ready" error with modem codecs initializations.

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-kernel/pci/ac97/ac97_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
retrieving revision 1.180
diff -u -b -B -r1.180 ac97_codec.c
--- alsa-kernel/pci/ac97/ac97_codec.c	29 Mar 2005 15:33:28 -0000	1.180
+++ alsa-kernel/pci/ac97/ac97_codec.c	2 Apr 2005 23:14:40 -0000
@@ -1964,21 +1964,21 @@
 		/* note: it's important to set the rate at first */
 		tmp = AC97_MEA_GPIO;
 		if (ac97->ext_mid & AC97_MEI_LINE1) {
-			snd_ac97_write_cache(ac97, AC97_LINE1_RATE, 12000);
+			snd_ac97_write_cache(ac97, AC97_LINE1_RATE, 8000);
 			tmp |= AC97_MEA_ADC1 | AC97_MEA_DAC1;
 		}
 		if (ac97->ext_mid & AC97_MEI_LINE2) {
-			snd_ac97_write_cache(ac97, AC97_LINE2_RATE, 12000);
+			snd_ac97_write_cache(ac97, AC97_LINE2_RATE, 8000);
 			tmp |= AC97_MEA_ADC2 | AC97_MEA_DAC2;
 		}
 		if (ac97->ext_mid & AC97_MEI_HANDSET) {
-			snd_ac97_write_cache(ac97, AC97_HANDSET_RATE, 12000);
+			snd_ac97_write_cache(ac97, AC97_HANDSET_RATE, 8000);
 			tmp |= AC97_MEA_HADC | AC97_MEA_HDAC;
 		}
-		snd_ac97_write_cache(ac97, AC97_EXTENDED_MSTATUS, 0xff00 & ~(tmp << 8));
+		snd_ac97_write_cache(ac97, AC97_EXTENDED_MSTATUS, 0);
 		udelay(100);
 		/* nothing should be in powerdown mode */
-		snd_ac97_write_cache(ac97, AC97_EXTENDED_MSTATUS, 0xff00 & ~(tmp << 8));
+		snd_ac97_write_cache(ac97, AC97_EXTENDED_MSTATUS, 0);
 		end_time = jiffies + (HZ / 10);
 		do {
 			if ((snd_ac97_read(ac97, AC97_EXTENDED_MSTATUS) & tmp) == tmp)



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
