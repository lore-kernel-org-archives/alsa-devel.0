From: Hermann Lauer <hermann.lauer@iwr.uni-heidelberg.de>
Subject: cs4236 (no B) and alsa 0.9.0rc7 and isapnp
Date: Sat, 15 Feb 2003 00:47:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030215004752.B2487@lemon.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear developers,

I tried to get my cs4236 (not B) card running under 2.2.23.
One of the problems after "configure --with-isapnp" was the setting of

CONFIG_ISAPNP_KERNEL    =

in Makefile.conf, which wouldn't compile the snd-isapnp module. After setting it to "n"
the module was build and works.

Second Problem is the "half supported card" cs4236 - the website states that
the driver should be snd-cs4236, but it didn't recognize the card as
it lacks "MODE 3" mixer support - I found an old discussion that the
cs4236 driver won't work. Appended is a patch which:

- adds the signature of my PNP to cs4232 driver
- adds the String representation to the 4236 hardware id
- adds a kernel message to the cs4236 driver which prints out that
the cs4236 has not MODE3 and extended register support instead of ignoring a
cs4236 card silently.

Is that still right that the cs4232 driver is the more appropriate driver
for the cs4236 or should the cs4236 driver support also the cs4236 itself ?

Thanks for any help and your work,

Greetings
  Hermann 

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-driver-0.9.0rc-cs4236.patchl"

--- alsa-driver-0.9.0rc7/alsa-kernel/isa/cs423x/cs4231_lib.c.orig	Wed Jan  8 11:08:25 2003
+++ alsa-driver-0.9.0rc7/alsa-kernel/isa/cs423x/cs4231_lib.c	Fri Feb 14 09:17:40 2003
@@ -1455,6 +1455,7 @@
 	case CS4231_HW_CS4232:	return "CS4232";
 	case CS4231_HW_CS4232A:	return "CS4232A";
 	case CS4231_HW_CS4235:	return "CS4235";
+	case CS4231_HW_CS4236:  return "CS4236";
 	case CS4231_HW_CS4236B: return "CS4236B";
 	case CS4231_HW_CS4237B: return "CS4237B";
 	case CS4231_HW_CS4238B: return "CS4238B";
--- alsa-driver-0.9.0rc7/alsa-kernel/isa/cs423x/cs4236.c.orig	Wed Dec 11 19:21:38 2002
+++ alsa-driver-0.9.0rc7/alsa-kernel/isa/cs423x/cs4236.c	Fri Feb 14 09:17:40 2003
@@ -188,6 +188,8 @@
 	ISAPNP_CS4232('C','S','C',0x1a32,0x0000,0x0010,0x0003),
 	/* HP Omnibook 5500 onboard */
 	ISAPNP_CS4232('C','S','C',0x4232,0x0000,0x0002,0x0003),
+	/* Unnamed CS4236 card (Made in Taiwan) */
+	ISAPNP_CS4232('C','S','C',0x4236,0x0000,0x0010,0x0003),
 	/* Turtle Beach TBS-2000 (CS4232) */
 	ISAPNP_CS4232('C','S','C',0x7532,0x0000,0x0010,0xb006),
 	/* Turtle Beach Tropez Plus (CS4232) */
--- alsa-driver-0.9.0rc7/alsa-kernel/isa/cs423x/cs4236_lib.c.orig	Thu Aug 15 14:13:06 2002
+++ alsa-driver-0.9.0rc7/alsa-kernel/isa/cs423x/cs4236_lib.c	Fri Feb 14 09:19:10 2003
@@ -281,7 +281,9 @@
 	}
 	if ((err = snd_cs4231_create(card, port, cport, irq, dma1, dma2, hardware, hwshare, &chip)) < 0)
 		return err;
+
 	if (!(chip->hardware & CS4231_HW_CS4236B_MASK)) {
+	        snd_printk("CS4236+: MODE3 and extended registers not available, hardware=0x%lx\n",chip->hardware);
 		snd_device_free(card, chip);
 		return -ENODEV;
 	}

--NzB8fVQJ5HfG6fxh--


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
