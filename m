From: James Stafford <jstafford@ampltd.com>
Subject: Re: [PATCH] Envy24HT
Date: Wed, 04 Dec 2002 17:29:57 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m18JdlZ-003yVDC@mail.corpex.com>
References: <Pine.LNX.4.33.0212041402420.521-100000@pnote.perex-int.cz>
 <m18JZ72-003yUIC@mail.corpex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m18JajL-003yUYC@mail.corpex.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Here are some more patches for Envy24HT support in the ICE1712 driver.
For now, I have left some of the debug code I accidentally left in the last
patch, since it is only added to the /proc output.

The name of the PCM streams for the ICE1724 is changed to "ICE1724 multi"
from "ICE1712 multi"
The ICE1724.conf file is added to alsa-lib/src/conf/cards to fix the
channel routing 

Index: alsa-kernel/pci/ice1712/amp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ice1712/amp.c,v
retrieving revision 1.1
diff -u -r1.1 amp.c
--- alsa-kernel/pci/ice1712/amp.c	3 Dec 2002 17:53:43 -0000	1.1
+++ alsa-kernel/pci/ice1712/amp.c	4 Dec 2002 15:04:05 -0000
@@ -42,6 +42,12 @@
 	return 0;
 }
 
+static int __devinit snd_vt1724_amp_add_controls(ice1712_t *ice)
+{
+	/* we use pins 39 and 41 of the VT1616 for left and right read outputs */
+	snd_ac97_write_cache(ice->ac97, 0x5a, snd_ac97_read(ice->ac97, 0x5a) &
~0x8000);
+}
+
 
 /* entry point */
 struct snd_ice1712_card_info snd_vt1724_amp_cards[] __devinitdata = {
@@ -49,6 +55,7 @@
 		VT1724_SUBDEVICE_AUDIO2000,
 		"AMP Ltd AUDIO2000",
 		snd_vt1724_amp_init,
+		snd_vt1724_amp_add_controls,
 	},
 	{ } /* terminator */
 };
Index: alsa-kernel/pci/ice1712/ice1712.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ice1712/ice1712.c,v
retrieving revision 1.14
diff -u -r1.14 ice1712.c
--- alsa-kernel/pci/ice1712/ice1712.c	3 Dec 2002 21:15:29 -0000	1.14
+++ alsa-kernel/pci/ice1712/ice1712.c	4 Dec 2002 15:04:17 -0000
@@ -1405,7 +1405,11 @@
 
 	if (rpcm)
 		*rpcm = NULL;
-	err = snd_pcm_new(ice->card, "ICE1712 multi", device, 1, 1, &pcm);
+	if (ice->vt1724)
+		err = snd_pcm_new(ice->card, "ICE1724 multi", device, 1, 1, &pcm);
+	else
+		err = snd_pcm_new(ice->card, "ICE1712 multi", device, 1, 1, &pcm);
+
 	if (err < 0)
 		return err;
 
@@ -1415,7 +1419,10 @@
 	pcm->private_data = ice;
 	pcm->private_free = snd_ice1712_pcm_profi_free;
 	pcm->info_flags = 0;

-	strcpy(pcm->name, "ICE1712 multi");
+	if (ice->vt1724)
+		strcpy(pcm->name, "ICE1724 multi");
+	else
+		strcpy(pcm->name, "ICE1712 multi");
 
 	snd_pcm_lib_preallocate_pci_pages_for_all(ice->pci, pcm, 256*1024,
256*1024);
 
Index: alsa-lib/src/conf/cards/Makefile.am
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/conf/cards/Makefile.am,v
retrieving revision 1.9
diff -u -r1.9 Makefile.am
--- alsa-lib/src/conf/cards/Makefile.am	29 Nov 2002 14:50:03 -0000	1.9
+++ alsa-lib/src/conf/cards/Makefile.am	4 Dec 2002 15:04:19 -0000
@@ -10,6 +10,7 @@
 	FM801.conf \
 	GUS.conf \
 	ICE1712.conf \
+	ICE1724.conf \
 	ICH.conf \
 	RME9636.conf \
 	RME9652.conf \


diff -u -N -r cvs2/alsa-lib/src/conf/cards/ICE1724.conf
cvs-envy24ht/alsa-lib/src/conf/cards/ICE1724.conf
--- cvs2/alsa-lib/src/conf/cards/ICE1724.conf	Thu Jan  1 01:00:00 1970
+++ cvs-envy24ht/alsa-lib/src/conf/cards/ICE1724.conf	Wed Dec  4 15:34:26 2002
@@ -0,0 +1,100 @@
+#
+# Configuration for the ICE1724 (Envy24HT) chip
+#
+
+<confdir:pcm/front.conf>
+
+ICE1724.pcm.front.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type route
+	ttable.0.0 1
+	ttable.1.1 1
+	slave.pcm {
+		type hw
+		card $CARD
+	}
+}	
+
+<confdir:pcm/surround40.conf>
+
+ICE1724.pcm.surround40.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type route
+	ttable.0.0 1
+	ttable.1.1 1
+	ttable.2.4 1
+	ttable.3.5 1
+	slave.pcm {
+		type hw
+		card $CARD
+	}
+}	
+
+<confdir:pcm/surround51.conf>
+
+ICE1724.pcm.surround51.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type route
+	ttable.0.0 1
+	ttable.1.1 1
+	ttable.2.4 1
+	ttable.3.5 1
+	ttable.4.2 1
+	ttable.5.3 1
+	slave.pcm {
+		type hw
+		card $CARD
+	}
+}
+
+<confdir:pcm/iec958.conf>
+
+ICE1724.pcm.iec958.0 {
+	@args [ CARD AES0 AES1 AES2 AES3 ]
+	@args.CARD {
+		type string
+	}
+	@args.AES0 {
+		type integer
+	}
+	@args.AES1 {
+		type integer
+	}
+	@args.AES2 {
+		type integer
+	}
+	@args.AES3 {
+		type integer
+	}
+	type hooks
+	slave.pcm {
+		type route
+		ttable.0.6 1
+		ttable.1.7 1
+		slave.pcm {
+			type hw
+			card $CARD
+		}
+	}
+	hooks.0 {
+		type ctl_elems
+		hook_args [
+			{
+				interface PCM
+				name "IEC958 Playback PCM Stream"
+				lock true
+				preserve true
+				value [ $AES0 $AES1 $AES2 $AES3 ]
+			}
+		]
+	}
+}

--
James Stafford


mailto:jstafford@ampltd.com

Advanced Micro Peripherals Ltd 
Unit 17
Sedgeway Business Park
Witchford
Cambridge
CB6 2HY

Tel: +44 1353 659 500 
Fax:+44 1353 659 600 



-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
