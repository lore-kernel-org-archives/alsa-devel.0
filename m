From: Dirk.Kalis@t-online.de
Subject: RE: ice1712 Card ID problem the second
Date: Thu,  9 Sep 2004 19:36:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1C5SqE-0ZRNom0@cmpmail00.bbul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello Ross,

the 2 files are not attached. Below you can find the patches for
testing.

regards
dirk

****************************************************************************
--- delta.h.ori Thu Sep  9 10:04:54 2004
+++ delta.h     Thu Sep  9 09:49:21 2004
@@ -31,6 +31,7 @@
                "{MidiMan M Audio,Delta DiO 2496},"\
                "{MidiMan M Audio,Delta 66},"\
                "{MidiMan M Audio,Delta 44},"\
+               "{MidiMan M Audio,Delta 44-2},"\
                "{MidiMan M Audio,Audiophile 24/96},"\
                "{Digigram,VX442},"

@@ -38,6 +39,7 @@
 #define ICE1712_SUBDEVICE_DELTADIO2496 0x121431d6
 #define ICE1712_SUBDEVICE_DELTA66      0x121432d6
 #define ICE1712_SUBDEVICE_DELTA44      0x121433d6
+#define ICE1712_SUBDEVICE_DELTA44_2    0x121433a0
 #define ICE1712_SUBDEVICE_AUDIOPHILE   0x121434d6
 #define ICE1712_SUBDEVICE_DELTA410     0x121438d6
 #define ICE1712_SUBDEVICE_DELTA1010LT  0x12143bd6
--- delta.c.ori Thu Sep  9 10:03:56 2004
+++ delta.c     Thu Sep  9 09:48:58 2004
@@ -520,6 +520,7 @@
                ice->num_total_adcs = 2;
                break;
        case ICE1712_SUBDEVICE_DELTA44:
+       case ICE1712_SUBDEVICE_DELTA44_2:
        case ICE1712_SUBDEVICE_DELTA66:
                ice->num_total_dacs = ice->omni ? 8 : 4;
                ice->num_total_adcs = ice->omni ? 8 : 4;
@@ -593,6 +594,7 @@
                break;
        case ICE1712_SUBDEVICE_DELTA66:
        case ICE1712_SUBDEVICE_DELTA44:
+       case ICE1712_SUBDEVICE_DELTA44_2:
                err = snd_ice1712_akm4xxx_init(ak, &akm_delta44,
&akm_delta44_priv, ice);
                break;
        case ICE1712_SUBDEVICE_VX442:
@@ -677,6 +679,7 @@
        case ICE1712_SUBDEVICE_AUDIOPHILE:
        case ICE1712_SUBDEVICE_DELTA410:
        case ICE1712_SUBDEVICE_DELTA44:
+       case ICE1712_SUBDEVICE_DELTA44_2:
        case ICE1712_SUBDEVICE_DELTA66:
        case ICE1712_SUBDEVICE_VX442:
                err = snd_ice1712_akm4xxx_build_controls(ice);
@@ -717,6 +720,14 @@
        {
                .subvendor = ICE1712_SUBDEVICE_DELTA44,
                .name = "M Audio Delta 44",
+               .model = "delta44",
+               .chip_init = snd_ice1712_delta_init,
+               .build_controls = snd_ice1712_delta_add_controls,
+               .no_mpu401 = 1,
+       },
+       {
+               .subvendor = ICE1712_SUBDEVICE_DELTA44_2,
+               .name = "M Audio Delta 44-2",
                .model = "delta44",
                .chip_init = snd_ice1712_delta_init,
                .build_controls = snd_ice1712_delta_add_controls,
--- envy24control.h.ori Thu Sep  9 10:02:50 2004
+++ envy24control.h     Thu Sep  9 09:50:42 2004
@@ -31,6 +31,7 @@
 #define ICE1712_SUBDEVICE_DELTADIO2496 0x121431d6
 #define ICE1712_SUBDEVICE_DELTA66      0x121432d6
 #define ICE1712_SUBDEVICE_DELTA44      0x121433d6
+#define ICE1712_SUBDEVICE_DELTA44-2    0x121433a0
 #define ICE1712_SUBDEVICE_AUDIOPHILE    0x121434d6
 #define ICE1712_SUBDEVICE_DELTA410      0x121438d6
 #define ICE1712_SUBDEVICE_DELTA1010LT   0x12143bd6
*************************************************************************




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
