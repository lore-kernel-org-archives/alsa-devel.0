From: Enrik Berkhan <Enrik.Berkhan@planb.de>
Subject: Re: oops while unloading snd-intel8x0
Date: Fri, 10 Jan 2003 13:37:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030110123732.GE986@electra.intern.planb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi,

At Tue, 10 Dec 2002 08:39:35 -0800, Takashi Iwai wrote:
> At Tue, 10 Dec 2002 13:50:31 +0100, Christian Guggenberger wrote:
> > I get following oops while unloading snd-intel8x0 on a Dell Optiplex 260
> hmm, it's a new type of oops, which i've never seen.

I had the same problem using a Gericom Frontman (SiS 7012). It turned out
that unregistering the joystick_driver while no joystick had been found
on init caused the oops. Proposed patch:

--- intel8x0.c.orig	Mon Oct 28 12:56:35 2002
+++ intel8x0.c	Thu Jan  9 13:13:21 2003
@@ -1783,6 +1783,9 @@
 	} while (time_after_eq(end_time, jiffies));
 
       __ok3:      
+	if (chip->device_type == DEVICE_SIS) {
+		iputword(chip, 0x4c, igetword(chip, 0x4c) | 1);
+	}
       	return 0;
 }
 
@@ -2451,6 +2454,8 @@
 		return -ENOENT;
 	}
 
+	printk("joystick_probe called\n");
+
 	if (joystick_port[dev] > 0 || mpu_port[dev] > 0) {
 		u16 val;
 		pci_read_config_word(pci, 0xe6, &val);
@@ -2490,6 +2495,8 @@
 	.id_table = snd_intel8x0_joystick_ids,
 	.probe = snd_intel8x0_joystick_probe,
 };
+
+static int have_joystick = 0;
 #endif
 
 static int __init alsa_card_intel8x0_init(void)
@@ -2503,7 +2510,13 @@
                 return err;
         }
 #if defined(SUPPORT_JOYSTICK) || defined(SUPPORT_MIDI)
-	pci_module_init(&joystick_driver);
+	if (pci_module_init(&joystick_driver) < 0) {
+	        printk("no joystick found\n");
+                have_joystick = 0;
+	} else {
+	        printk("joystick(s) found\n");
+	        have_joystick = 1;
+	}
 #endif
         return 0;
 
@@ -2513,7 +2526,8 @@
 {
 	pci_unregister_driver(&driver);
 #if defined(SUPPORT_JOYSTICK) || defined(SUPPORT_MIDI)
-	pci_unregister_driver(&joystick_driver);
+        if (have_joystick)
+	        pci_unregister_driver(&joystick_driver);
 #endif
 }
 

Cheers,
Enrik



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
