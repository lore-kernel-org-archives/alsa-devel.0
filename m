From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: [PATCH] vt1720 mobo
Date: Tue, 18 Jan 2005 12:31:21 +0100
Message-ID: <m2wtubj7na.fsf@vador.mandrakesoft.com>
References: <auto-000075553485@mailfe05.swip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <auto-000075553485@mailfe05.swip.net> (maxdelm@tele2.fr's
 message of "Sun, 16 Jan 2005 9:35:32 +0100")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: maxdelm@tele2.fr
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--=-=-=

<maxdelm@tele2.fr> writes:

>     I have Chaintech 9CJS Mainboard with VT1720 sound-chip.
> 
> Delmaire Maxime.

that is:

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=vt1720.diff

--- /home/tv/cvs/alsa/alsa-kernel/pci/ice1712/vt1720_mobo.c	2004-07-31 06:20:14.000000000 +0200
+++ /tmp/vt1720_mobo.c	2005-01-17 12:15:26.000000000 +0100
@@ -101,6 +101,15 @@
 		.eeprom_size = sizeof(k8x800_eeprom),
 		.eeprom_data = k8x800_eeprom,
 	},
+	{
+		.subvendor = VT1720_SUBDEVICE_9CJS,
+		.name = "Chaintech 9CJS",
+		/* identical with k8x800 */
+		.chip_init = k8x800_init,
+		.build_controls = k8x800_add_controls,
+		.eeprom_size = sizeof(k8x800_eeprom),
+		.eeprom_data = k8x800_eeprom,
+	},
 	{ } /* terminator */
 };
 
--- /home/tv/cvs/alsa/alsa-kernel/pci/ice1712/vt1720_mobo.h	2004-07-31 06:20:14.000000000 +0200
+++ /tmp/vt1720_mobo.h	2005-01-18 12:30:29.971147072 +0100
@@ -26,11 +26,13 @@
 
 #define VT1720_MOBO_DEVICE_DESC        "{Albatron,K8X800 Pro II},"\
 				       "{Chaintech,ZNF3-150},"\
-				       "{Chaintech,ZNF3-250},"
+				       "{Chaintech,ZNF3-250},"\
+				       "{Chaintech,9CJS},"
 
 #define VT1720_SUBDEVICE_K8X800		0xf217052c
 #define VT1720_SUBDEVICE_ZNF3_150	0x0f2741f6
 #define VT1720_SUBDEVICE_ZNF3_250	0x0f2745f6
+#define VT1720_SUBDEVICE_9CJS		0x0f272327
 
 extern struct snd_ice1712_card_info  snd_vt1720_mobo_cards[];
 

--=-=-=--



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
