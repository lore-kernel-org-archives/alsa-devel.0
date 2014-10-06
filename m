From: Greg Farrell <greg@gregfarrell.org>
Subject: Patch to enable audio on alc888 vendor id 0x10ec0888
 revision id 0x100202
Date: Mon, 06 Oct 2014 15:16:25 +0100
Message-ID: <5432A439.1050909@gregfarrell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gregfarrell.org (mail.gregfarrell.org [64.62.190.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F5512604A1
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 16:16:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I am dealing with some Atom based boards that have a Realtek ALC888 
providing HDA-Intel codec support. Vendor_id of 0x10ec0888.

These boards worked for us when they came with an earlier revision of 
the chip but did not work for us with a revision_id of 0x100202 .

Symptoms on kernel 3.11 (FC18) and 3.17rc7 were identical - sound was 
present but was almost completely inaudible even when mixers were raised 
to the max.

Investigations showed that forcing OFF EAPD resulted in normal amplified 
sound while turning it on resulted in the almost inaudible sound. This 
is - to my limited understanding - counter to how other chipsets work 
and makes me wonder if this particular chip version has an inverted EAPD 
bit. It was also necessary to skip the normal ALC888 coef fixup code 
(alc888_coef_init) in order for sound to work correctly.

I'm providing a patch that performs this behaviour only for alc888's 
with a vendor_id of 0x10ec0888 and a revision_id of 0x100202. It applies 
cleanly against 3.11 and 3.17rc7 but as I do not have a suitable build 
host for a 3.17 kernel it has only been tested with the 3.11 kernel.

I hope this is useful to anyone else running into this problem with this 
particular hardware.

Greg

greg@gregfarrell.org
greg.farrell@lincor.com


--- a/sound/pci/hda/patch_realtek.c    2014-10-03 16:41:50.374730157 +0100
+++ b/sound/pci/hda/patch_realtek.c    2014-10-03 16:52:57.539099277 +0100
@@ -289,7 +289,11 @@
  {
      unsigned int tmp;

-    alc_auto_setup_eapd(codec, true);
+    if ( !(codec->vendor_id == 0x10ec0888 && codec->revision_id == 
0x100202) )
+        alc_auto_setup_eapd(codec, true);
+    else
+        printk(KERN_INFO "hda_codec: %s: alc_auto_init_amp skipping 
alc_auto_setup_eapd due to chip revision test", codec->chip_name);
+
      switch (type) {
      case ALC_INIT_GPIO1:
          snd_hda_sequence_write(codec, alc_gpio1_init_verbs);
@@ -323,7 +327,10 @@
              alc889_coef_init(codec);
              break;
          case 0x10ec0888:
-            alc888_coef_init(codec);
+            if ( codec->revision_id != 0x100202 )
+                alc888_coef_init(codec);
+            else
+                printk(KERN_INFO "hda_codec: %s: alc_auto_init_amp 
0x10ec0888 type skipping alc888_coef_init due to revision_id test", 
codec->chip_name);
              break;
  #if 0 /* XXX: This may cause the silent output on speaker on some 
machines */
          case 0x10ec0267:
