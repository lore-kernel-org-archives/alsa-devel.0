From: Manuel Schneider <manuel.schneider@kanal-ratte.de>
Subject: Re: Swissonic TS22PCI / Teratec Phase 22 / driver
 problems with ice1724
Date: Thu, 14 Aug 2008 16:03:20 +0200
Message-ID: <48A43B28.5000308@kanal-ratte.de>
References: <48A4332E.4070704@kanal-ratte.de> <s5habff1zft.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mastersmail.com (mx1.mastersmail.com [195.114.98.122])
	by alsa0.perex.cz (Postfix) with ESMTP id 194C32471C
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Aug 2008 16:03:30 +0200 (CEST)
In-Reply-To: <s5habff1zft.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai schrieb, Am 14.08.2008 15:47:

> Pass model=phase22 module option to snd-ice1724 driver.  Then it
> handles the card as if it's phase22.



Thanks for this hin. Unfortunately it changes nothing - still kernel
error message, still no usable sound device.

I also tried the following kernel patch, which gives me an accessible
sound device and usable mixer (and no kernel error), but recording does
not work (just noise).
The patch is quite simple - it just adds the subvendor ID of the
Swissonic card and adds all phase22 functionality to it.

Manuel

---
-:[/usr/src/linux/sound/pci/ice1712]#> diff -uN phase.h.bak phase.h
--- phase.h.bak 2008-08-12 10:13:49.000000000 +0200
+++ phase.h     2008-08-12 09:49:23.000000000 +0200
@@ -25,9 +25,11 @@
    */

   #define PHASE_DEVICE_DESC "{Terratec,Phase 22},"\
+                          "{Swissonic,TS22PCI},"\
                             "{Terratec,Phase 28},"

   #define VT1724_SUBDEVICE_PHASE22       0x3b155011
+#define VT1724_SUBDEVICE_TS22PCI       0x3b157b11
   #define VT1724_SUBDEVICE_PHASE28       0x3b154911

   /* entry point */
---

---
-:[/usr/src/linux/sound/pci/ice1712]#> diff -uN phase.c.bak phase.c
--- phase.c.bak 2008-08-12 09:51:28.000000000 +0200
+++ phase.c     2008-08-12 09:51:28.000000000 +0200
@@ -124,6 +124,11 @@
                  ice->num_total_adcs = 2;
                  ice->vt1720 = 1; // Envy24HT-S have 16 bit wide GPIO
                  break;
+       case VT1724_SUBDEVICE_TS22PCI:
+               ice->num_total_dacs = 2;
+               ice->num_total_adcs = 2;
+               ice->vt1720 = 1; // Envy24HT-S have 16 bit wide GPIO
+               break;
          default:
                  snd_BUG();
                  return -EINVAL;
@@ -139,6 +144,10 @@
                  if ((err = snd_ice1712_akm4xxx_init(ak, &akm_phase22,
&akm_phase22_priv, ice)) < 0)
                          return err;
                  break;
+       case VT1724_SUBDEVICE_TS22PCI:
+               if ((err = snd_ice1712_akm4xxx_init(ak, &akm_phase22,
&akm_phase22_priv, ice)) < 0)
+                       return err;
+               break;
          }

          return 0;
@@ -153,6 +162,10 @@
                  err = snd_ice1712_akm4xxx_build_controls(ice);
                  if (err < 0)
                          return err;
+       case VT1724_SUBDEVICE_TS22PCI:
+               err = snd_ice1712_akm4xxx_build_controls(ice);
+               if (err < 0)
+                       return err;
          }
          return 0;
   }
@@ -896,6 +909,15 @@
                  .eeprom_data = phase22_eeprom,
          },
          {
+               .subvendor = VT1724_SUBDEVICE_TS22PCI,
+               .name = "Swissonic TS22PCI",
+               .model = "phase22",
+               .chip_init = phase22_init,
+               .build_controls = phase22_add_controls,
+               .eeprom_size = sizeof(phase22_eeprom),
+               .eeprom_data = phase22_eeprom,
+       },
+       {
                  .subvendor = VT1724_SUBDEVICE_PHASE28,
                  .name = "Terratec PHASE 28",
                  .model = "phase28",
---



-- 
Kanal Ratte 104,5 MHz
...das Freie Radio im Wiesental

Hauptstrasse 82
79650 Schopfheim

Tel: +49 7622 6692-53
Fax: +49 7622 6692-54
