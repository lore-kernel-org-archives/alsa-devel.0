From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: hda - Update the list of quirk models
Date: Mon, 22 May 2017 16:46:06 +0200
Message-ID: <20170522144606.30477-3-tiwai@suse.de>
References: <20170522144606.30477-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 18DAF266E84
 for <alsa-devel@alsa-project.org>; Mon, 22 May 2017 16:46:08 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id CAA77AC39
 for <alsa-devel@alsa-project.org>; Mon, 22 May 2017 14:46:07 +0000 (UTC)
In-Reply-To: <20170522144606.30477-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I've forgotten to sync the documentation with the actually available
options for some time.  Now all updated.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/hd-audio/models.rst | 114 ++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 49 deletions(-)

diff --git a/Documentation/sound/hd-audio/models.rst b/Documentation/sound/hd-audio/models.rst
index 5338673c88d9..773d2bfacc6c 100644
--- a/Documentation/sound/hd-audio/models.rst
+++ b/Documentation/sound/hd-audio/models.rst
@@ -16,6 +16,8 @@ ALC880
     6-jack in back, 2-jack in front
 6stack-digout
     6-jack with a SPDIF out
+6stack-automute
+    6-jack with headphone jack detection
 
 ALC260
 ======
@@ -62,6 +64,8 @@ lenovo-dock
     Enables docking station I/O for some Lenovos
 hp-gpio-led
     GPIO LED support on HP laptops
+hp-dock-gpio-mic1-led
+    HP dock with mic LED support
 dell-headset-multi
     Headset jack, which can also be used as mic-in
 dell-headset-dock
@@ -72,6 +76,12 @@ alc283-sense-combo
     Combo jack sensing on ALC283
 tpt440-dock
     Pin configs for Lenovo Thinkpad Dock support
+tpt440
+    Lenovo Thinkpad T440s setup
+tpt460
+    Lenovo Thinkpad T460/560 setup
+dual-codecs
+    Lenovo laptops with dual codecs
 
 ALC66x/67x/892
 ==============
@@ -97,6 +107,8 @@ inv-dmic
     Inverted internal mic workaround
 dell-headset-multi
     Headset jack, which can also be used as mic-in
+dual-codecs
+    Lenovo laptops with dual codecs
 
 ALC680
 ======
@@ -114,6 +126,8 @@ inv-dmic
     Inverted internal mic workaround
 no-primary-hp
     VAIO Z/VGC-LN51JGB workaround (for fixed speaker DAC)
+dual-codecs
+    ALC1220 dual codecs for Gaming mobos
 
 ALC861/660
 ==========
@@ -206,65 +220,47 @@ auto
 
 Conexant 5045
 =============
-laptop-hpsense
-    Laptop with HP sense (old model laptop)
-laptop-micsense
-    Laptop with Mic sense (old model fujitsu)
-laptop-hpmicsense
-    Laptop with HP and Mic senses
-benq
-    Benq R55E
-laptop-hp530
-    HP 530 laptop
-test
-    for testing/debugging purpose, almost all controls can be
-    adjusted.  Appearing only when compiled with $CONFIG_SND_DEBUG=y
+cap-mix-amp
+    Fix max input level on mixer widget
+toshiba-p105
+    Toshiba P105 quirk
+hp-530
+    HP 530 quirk
 
 Conexant 5047
 =============
-laptop
-    Basic Laptop config 
-laptop-hp
-    Laptop config for some HP models (subdevice 30A5)
-laptop-eapd
-    Laptop config with EAPD support
-test
-    for testing/debugging purpose, almost all controls can be
-    adjusted.  Appearing only when compiled with $CONFIG_SND_DEBUG=y
+cap-mix-amp
+    Fix max input level on mixer widget
 
 Conexant 5051
 =============
-laptop
-    Basic Laptop config (default)
-hp
-    HP Spartan laptop
-hp-dv6736
-    HP dv6736
-hp-f700
-    HP Compaq Presario F700
-ideapad
-    Lenovo IdeaPad laptop
-toshiba
-    Toshiba Satellite M300
+lenovo-x200
+    Lenovo X200 quirk
 
 Conexant 5066
 =============
-laptop
-    Basic Laptop config (default)
-hp-laptop
-    HP laptops, e g G60
-asus
-    Asus K52JU, Lenovo G560
-dell-laptop
-    Dell laptops
-dell-vostro
-    Dell Vostro
-olpc-xo-1_5
-    OLPC XO 1.5
-ideapad
-    Lenovo IdeaPad U150
+stereo-dmic
+    Workaround for inverted stereo digital mic
+gpio1
+    Enable GPIO1 pin
+headphone-mic-pin
+    Enable headphone mic NID 0x18 without detection
+tp410
+    Thinkpad T400 & co quirks
 thinkpad
-    Lenovo Thinkpad
+    Thinkpad mute/mic LED quirk
+lemote-a1004
+    Lemote A1004 quirk
+lemote-a1205
+    Lemote A1205 quirk
+olpc-xo
+    OLPC XO quirk
+mute-led-eapd
+    Mute LED control via EAPD
+hp-dock
+    HP dock support
+mute-led-gpio
+    Mute LED control via GPIO
 
 STAC9200
 ========
@@ -444,6 +440,8 @@ dell-eq
     Dell desktops/laptops
 alienware
     Alienware M17x
+asus-mobo
+    Pin configs for ASUS mobo with 5.1/SPDIF out
 auto
     BIOS setup (default)
 
@@ -477,6 +475,8 @@ hp-envy-ts-bass
     Pin fixup for HP Envy TS bass speaker (NID 0x10)
 hp-bnb13-eq
     Hardware equalizer setup for HP laptops
+hp-envy-ts-bass
+    HP Envy TS bass support
 auto
     BIOS setup (default)
 
@@ -496,10 +496,22 @@ auto
 
 Cirrus Logic CS4206/4207
 ========================
+mbp53
+    MacBook Pro 5,3
 mbp55
     MacBook Pro 5,5
 imac27
     IMac 27 Inch
+imac27_122
+    iMac 12,2
+apple
+    Generic Apple quirk
+mbp101
+    MacBookPro 10,1
+mbp81
+    MacBookPro 8,1
+mba42
+    MacBookAir 4,2
 auto
     BIOS setup (default)
 
@@ -509,6 +521,10 @@ mba6
     MacBook Air 6,1 and 6,2
 gpio0
     Enable GPIO 0 amp
+mbp11
+    MacBookPro 11,2
+macmini
+    MacMini 7,1
 auto
     BIOS setup (default)
 
-- 
2.13.0
