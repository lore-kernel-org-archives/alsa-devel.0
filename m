From: Matt <matt@embeddedalley.com>
Subject: [PATCH][1/2] hda: fix vref cap and ctl values
Date: Wed, 13 Apr 2005 00:38:05 -0700
Message-ID: <20050413003805.E24624@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Fix some vref defines so they are valid for the different bits in
the pin cap and pin control registers. Please apply.

Signed-off-by: Matt <matt@embeddedalley.com>

Index: alsa-kernel/pci/hda/hda_codec.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_codec.h,v
retrieving revision 1.4
diff -u -r1.4 hda_codec.h
--- alsa-kernel/pci/hda/hda_codec.h	22 Feb 2005 17:17:58 -0000	1.4
+++ alsa-kernel/pci/hda/hda_codec.h	13 Apr 2005 07:11:14 -0000
@@ -176,15 +176,21 @@
 #define AC_PINCAP_OUT			(1<<4)	/* output capable */
 #define AC_PINCAP_IN			(1<<5)	/* input capable */
 #define AC_PINCAP_BALANCE		(1<<6)	/* balanced I/O capable */
-#define AC_PINCAP_VREF			(7<<8)
+#define AC_PINCAP_VREF			(0x37<<8)
 #define AC_PINCAP_VREF_SHIFT		8
 #define AC_PINCAP_EAPD			(1<<16)	/* EAPD capable */
-/* Vref status (used in pin cap and pin ctl) */
-#define AC_PIN_VREF_HIZ			(1<<0)	/* Hi-Z */
-#define AC_PIN_VREF_50			(1<<1)	/* 50% */
-#define AC_PIN_VREF_GRD			(1<<2)	/* ground */
-#define AC_PIN_VREF_80			(1<<4)	/* 80% */
-#define AC_PIN_VREF_100			(1<<5)	/* 100% */
+/* Vref status (used in pin cap) */
+#define AC_PINCAP_VREF_HIZ		(1<<0)	/* Hi-Z */
+#define AC_PINCAP_VREF_50		(1<<1)	/* 50% */
+#define AC_PINCAP_VREF_GRD		(1<<2)	/* ground */
+#define AC_PINCAP_VREF_80		(1<<4)	/* 80% */
+#define AC_PINCAP_VREF_100		(1<<5)	/* 100% */
+/* Vref setting (used in pin ctl) */
+#define AC_PINCTL_VREF_HIZ		(0)	/* Hi-Z */
+#define AC_PINCTL_VREF_50		(1)	/* 50% */
+#define AC_PINCTL_VREF_GRD		(2)	/* ground */
+#define AC_PINCTL_VREF_80		(4)	/* 80% */
+#define AC_PINCTL_VREF_100		(5)	/* 100% */
 
 
 /* Amplifier capabilities */
Index: alsa-kernel/pci/hda/hda_generic.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_generic.c,v
retrieving revision 1.3
diff -u -r1.3 hda_generic.c
--- alsa-kernel/pci/hda/hda_generic.c	22 Mar 2005 15:34:38 -0000	1.3
+++ alsa-kernel/pci/hda/hda_generic.c	13 Apr 2005 07:11:34 -0000
@@ -426,7 +426,7 @@
 		return "Line";
 	case AC_JACK_CD:
 		if (pinctl)
-			*pinctl |= AC_PIN_VREF_GRD;
+			*pinctl |= AC_PINCTL_VREF_GRD;
 		return "CD";
 	case AC_JACK_AUX:
 		if ((location & 0x0f) == AC_JACK_LOC_FRONT)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
