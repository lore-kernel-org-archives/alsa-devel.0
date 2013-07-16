From: Tormen <my.nl.abos@gmail.com>
Subject: Re: No sound with Sony VAIO VPCZ1 (ALC889)
Date: Tue, 16 Jul 2013 20:38:41 +0200
Message-ID: <51E59331.5000200@gmail.com>
References: <51D464A5.6040507@gmail.com> <51D59D60.9020105@gmail.com>
 <51D5FCFC.8010506@gmail.com> <s5hip0pwp49.wl%tiwai@suse.de>
 <51D6B56D.8050909@gmail.com> <s5h1u7dchqh.wl%tiwai@suse.de>
 <020e0ad5107eb4c2bb333468be58d7d3@www.happyassassin.net>
 <51D9F543.2070605@gmail.com>
 <c2cbc2323ce3a8e0df5f52de3ecb276c@www.happyassassin.net>
 <s5hvc4luem4.wl%tiwai@suse.de>
 <46b0590bfa4ffc836dde180f8ffe3c97@www.happyassassin.net>
 <s5hwqoycu0y.wl%tiwai@suse.de> <51DDD53A.8040502@gmail.com>
 <s5hbo69vf4z.wl%tiwai@suse.de> <51DE7B63.7060708@gmail.com>
 <s5hfvvlcs4o.wl%tiwai@suse.de> <51DE9D18.6010304@gmail.com>
 <51E4FD95.2080500@gmail.com> <s5hsizflykp.wl%tiwai@suse.de>
 <51E4FF18.2050208@gmail.com> <s5hoba2n9ve.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050201090404050203000502"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
 [209.85.212.171])
 by alsa0.perex.cz (Postfix) with ESMTP id C14E3265094
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 20:38:43 +0200 (CEST)
Received: by mail-wi0-f171.google.com with SMTP id hj3so4504632wib.10
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 11:38:43 -0700 (PDT)
In-Reply-To: <s5hoba2n9ve.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Adam Williamson <awilliam@redhat.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050201090404050203000502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 16/07/13 11:15, Takashi Iwai wrote:
> It doesn't look like the driver patched properly.
> Try to put some printk() in the patched code path to confirm that
> you're really testing the patched driver.
>
>
> Takashi
I am not 100% sure if it was or not, because I had applied the patch not 
with "quilt"
... but now I am:
I put in some printk()'s and it still shows speaker_outs=0 :(

I was wondering if it's a problem that the speaker_outs=0 is printed way 
before all the "fill_and_eval_dacs" changes of yours are executed?

I attached you my patch so that you can see what output corresponds to 
what piece of code.

alsa-info.sh:
http://www.alsa-project.org/db/?f=c644b65a9e25fd1cef5b4b53d6d806d45526e5b2

And the complete output of my debug messages:

FIRST just loading the modules:
      modprobe snd debug=2
      modprobe snd_hda_intel

[10263.731133] snd_hda_intel 0000:00:1b.0: irq 45 for MSI/MSI-X
[10263.747274] Tormen: alc882_fixup_no_primary_hp: AAA
[10263.750059] Tormen: alc882_fixup_no_primary_hp: BBB ==> set 
spec->no_multi_io = 1
[10263.752896] hda_codec: ALC889: SKU not ready 0x411111f0
[10263.755938] ALSA hda_auto_parser.c:335 autoconfig: line_outs=1 
(0x14/0x0/0x0/0x0/0x0) type:speaker
[10263.758707] ALSA hda_auto_parser.c:339    speaker_outs=0 
(0x0/0x0/0x0/0x0/0x0)
[10263.761476] ALSA hda_auto_parser.c:343    hp_outs=1 
(0x15/0x0/0x0/0x0/0x0)
[10263.764246] ALSA hda_auto_parser.c:344    mono: mono_out=0x0
[10263.767028] ALSA hda_auto_parser.c:348    inputs:
[10263.769908] ALSA hda_auto_parser.c:352      Mic=0x18
[10263.772632] ALSA hda_auto_parser.c:352      Mic=0x19
[10263.775354] ALSA hda_auto_parser.c:352      Internal Mic=0x12
[10263.778038] ALSA patch_realtek.c:466 realtek: No valid SSID, checking 
pincfg 0x411111f0 for NID 0x1d
[10263.780832] ALSA patch_realtek.c:549 realtek: Enable default setup 
for auto mode as fallback
[10263.783693] Tormen: parse_user_hints: val (from 'multi_io') == '-2'
[10263.786078] Tormen: fill_and_eval_dacs: 111 spec->no_multi_io == '0'
[10263.787634] Tormen: fill_and_eval_dacs: 222 spec->no_multi_io == '0'
[10263.789531] Tormen: fill_and_eval_dacs: DDD
[10263.790957] Tormen: fill_and_eval_dacs: 111 spec->no_multi_io == '0'
[10263.792364] Tormen: fill_and_eval_dacs: 222 spec->no_multi_io == '0'
[10263.793749] Tormen: fill_and_eval_dacs: DDD
[10263.795150] Tormen: fill_and_eval_dacs: 222 spec->no_multi_io == '0'
[10263.796546] Tormen: fill_and_eval_dacs: DDD
[10263.797932] Tormen: fill_and_eval_dacs: 222 spec->no_multi_io == '0'
[10263.799363] Tormen: fill_and_eval_dacs: DDD
[10263.800759] Tormen: fill_and_eval_dacs: 111 spec->no_multi_io == '0'
[10263.802161] Tormen: fill_and_eval_dacs: AAA
[10263.804110] Tormen: fill_and_eval_dacs: 222 spec->no_multi_io == '0'
[10263.805609] Tormen: fill_and_eval_dacs: BBB
[10263.807265] Tormen: fill_and_eval_dacs: CCC
[10263.810445] input: HDA Digital PCBeep as 
/devices/pci0000:00/0000:00:1b.0/input/input25
[10263.812063] Tormen: alc882_fixup_no_primary_hp: AAA
[10263.818856] Tormen: alc882_fixup_no_primary_hp: AAA
[10263.820812] Tormen: alc882_fixup_no_primary_hp: AAA
[10263.822315] input: HDA Intel MID Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input26
[10263.823905] input: HDA Intel MID Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input27
[10263.825607] input: HDA Intel MID Headphone as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input28

THEN with manual set multi_io = yes:

echo "multi_io = yes" 
 >/sys/devices/pci0000:00/0000:00:1b.0/sound/card0/hwC0D0/hints
echo "1" >/sys/devices/pci0000:00/0000:00:1b.0/sound/card0/hwC0D0/reconfig

[10462.452100] ALSA hda_hwdep.c:221 hda-codec: reconfiguring
[10462.614742] Tormen: alc882_fixup_no_primary_hp: AAA
[10462.618508] Tormen: alc882_fixup_no_primary_hp: AAA
[10462.620912] Tormen: alc882_fixup_no_primary_hp: BBB ==> set 
spec->no_multi_io = 1
[10462.623365] hda_codec: ALC889: SKU not ready 0x411111f0
[10462.626209] ALSA hda_auto_parser.c:335 autoconfig: line_outs=1 
(0x14/0x0/0x0/0x0/0x0) type:speaker
[10462.628736] ALSA hda_auto_parser.c:339    speaker_outs=0 
(0x0/0x0/0x0/0x0/0x0)
[10462.631345] ALSA hda_auto_parser.c:343    hp_outs=1 
(0x15/0x0/0x0/0x0/0x0)
[10462.633911] ALSA hda_auto_parser.c:344    mono: mono_out=0x0
[10462.636543] ALSA hda_auto_parser.c:348    inputs:
[10462.639122] ALSA hda_auto_parser.c:352      Mic=0x18
[10462.640323] ALSA hda_auto_parser.c:352      Mic=0x19
[10462.641419] ALSA hda_auto_parser.c:352      Internal Mic=0x12
[10462.642554] ALSA patch_realtek.c:466 realtek: No valid SSID, checking 
pincfg 0x411111f0 for NID 0x1d
[10462.643700] ALSA patch_realtek.c:549 realtek: Enable default setup 
for auto mode as fallback
[10462.644841] Tormen: parse_user_hints: val (from 'multi_io') == '1'
[10462.645988] Tormen: parse_user_hints: spec->no_multi_io == '1'
[10462.647186] Tormen: fill_and_eval_dacs: 111 spec->no_multi_io == '0'
[10462.648520] Tormen: fill_and_eval_dacs: 222 spec->no_multi_io == '0'
[10462.649847] Tormen: fill_and_eval_dacs: DDD
[10462.651038] Tormen: fill_and_eval_dacs: 111 spec->no_multi_io == '0'
[10462.652201] Tormen: fill_and_eval_dacs: 222 spec->no_multi_io == '0'
[10462.653352] Tormen: fill_and_eval_dacs: DDD
[10462.654522] Tormen: fill_and_eval_dacs: 222 spec->no_multi_io == '0'
[10462.655673] Tormen: fill_and_eval_dacs: DDD
[10462.656804] Tormen: fill_and_eval_dacs: 222 spec->no_multi_io == '0'
[10462.657944] Tormen: fill_and_eval_dacs: DDD
[10462.659122] Tormen: fill_and_eval_dacs: 111 spec->no_multi_io == '0'
[10462.660266] Tormen: fill_and_eval_dacs: AAA
[10462.661392] Tormen: fill_and_eval_dacs: 222 spec->no_multi_io == '0'
[10462.662576] Tormen: fill_and_eval_dacs: BBB
[10462.664050] Tormen: fill_and_eval_dacs: CCC
[10462.665700] input: HDA Digital PCBeep as 
/devices/pci0000:00/0000:00:1b.0/input/input29
[10462.667026] Tormen: alc882_fixup_no_primary_hp: AAA
[10462.673168] Tormen: alc882_fixup_no_primary_hp: AAA
[10462.674864] Tormen: alc882_fixup_no_primary_hp: AAA
[10462.675957] input: HDA Intel MID Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input30
[10462.677133] input: HDA Intel MID Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input31
[10462.678328] input: HDA Intel MID Headphone as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input32


Tormen

--------------050201090404050203000502
Content-Type: text/x-patch;
 name="0001-ALSA-hda-Add-no_multi_io-hda_gen_spec-flag.patch.mine.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-Add-no_multi_io-hda_gen_spec-flag.patch.mine.p";
 filename*1="atch"

Index: sound/pci/hda/hda_generic.c
===================================================================
--- sound/pci/hda/hda_generic.c.orig	2013-06-13 19:52:08.000000000 +0200
+++ sound/pci/hda/hda_generic.c	2013-07-16 18:29:49.162269696 +0200
@@ -138,6 +138,13 @@
 	val = snd_hda_get_bool_hint(codec, "primary_hp");
 	if (val >= 0)
 		spec->no_primary_hp = !val;
+	val = snd_hda_get_bool_hint(codec, "multi_io");
+	printk(KERN_ALERT "Tormen: parse_user_hints: val (from 'multi_io') == '%i'\n",
+	       val);
+	if (val >= 0)
+		printk(KERN_ALERT "Tormen: parse_user_hints: spec->no_multi_io == '%i'\n",
+		       spec->no_multi_io);
+		spec->no_multi_io = !val;
 	val = snd_hda_get_bool_hint(codec, "multi_cap_vol");
 	if (val >= 0)
 		spec->multi_cap_vol = !!val;
@@ -1498,8 +1505,12 @@
 					      cfg->speaker_pins,
 					      spec->multiout.extra_out_nid,
 					      spec->speaker_paths);
-			if (fill_mio_first && cfg->line_outs == 1 &&
+			printk(KERN_ALERT "Tormen: fill_and_eval_dacs: 111 spec->no_multi_io == '%i'\n",
+		       spec->no_multi_io);
+			if (!spec->no_multi_io &&
+			    fill_mio_first && cfg->line_outs == 1 &&
 			    cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
+				printk(KERN_ALERT "Tormen: fill_and_eval_dacs: AAA\n");
 				err = fill_multi_ios(codec, cfg->line_out_pins[0], true);
 				if (!err)
 					mapped = true;
@@ -1511,8 +1522,12 @@
 				   spec->private_dac_nids, spec->out_paths,
 				   &main_out_badness);
 
-	if (fill_mio_first &&
+	printk(KERN_ALERT "Tormen: fill_and_eval_dacs: 222 spec->no_multi_io == '%i'\n",
+       spec->no_multi_io);
+
+	if (!spec->no_multi_io && fill_mio_first &&
 	    cfg->line_outs == 1 && cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
+		printk(KERN_ALERT "Tormen: fill_and_eval_dacs: BBB\n");
 		/* try to fill multi-io first */
 		err = fill_multi_ios(codec, cfg->line_out_pins[0], false);
 		if (err < 0)
@@ -1539,8 +1554,10 @@
 			return err;
 		badness += err;
 	}
-	if (cfg->line_outs == 1 && cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
+	if (!spec->no_multi_io &&
+	    cfg->line_outs == 1 && cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
 		err = fill_multi_ios(codec, cfg->line_out_pins[0], false);
+		printk(KERN_ALERT "Tormen: fill_and_eval_dacs: CCC\n");
 		if (err < 0)
 			return err;
 		badness += err;
@@ -1557,9 +1574,12 @@
 				check_aamix_out_path(codec, spec->speaker_paths[0]);
 	}
 
-	if (cfg->hp_outs && cfg->line_out_type == AUTO_PIN_SPEAKER_OUT)
+	if (!spec->no_multi_io &&
+	    cfg->hp_outs && cfg->line_out_type == AUTO_PIN_SPEAKER_OUT) {
+		printk(KERN_ALERT "Tormen: fill_and_eval_dacs: DDD\n");
 		if (count_multiio_pins(codec, cfg->hp_pins[0]) >= 2)
 			spec->multi_ios = 1; /* give badness */
+	}
 
 	/* re-count num_dacs and squash invalid entries */
 	spec->multiout.num_dacs = 0;
Index: sound/pci/hda/hda_generic.h
===================================================================
--- sound/pci/hda/hda_generic.h.orig	2013-06-13 19:52:08.000000000 +0200
+++ sound/pci/hda/hda_generic.h	2013-07-16 18:29:49.162269696 +0200
@@ -202,6 +202,7 @@
 	unsigned int need_dac_fix:1; /* need to limit DACs for multi channels */
 	unsigned int shared_mic_hp:1; /* HP/Mic-in sharing */
 	unsigned int no_primary_hp:1; /* Don't prefer HP pins to speaker pins */
+	unsigned int no_multi_io:1; /* Don't try multi I/O config */
 	unsigned int multi_cap_vol:1; /* allow multiple capture xxx volumes */
 	unsigned int inv_dmic_split:1; /* inverted dmic w/a for conexant */
 	unsigned int own_eapd_ctl:1; /* set EAPD by own function */
Index: sound/pci/hda/patch_realtek.c
===================================================================
--- sound/pci/hda/patch_realtek.c.orig	2013-06-13 19:52:08.000000000 +0200
+++ sound/pci/hda/patch_realtek.c	2013-07-16 18:29:49.166269730 +0200
@@ -1816,8 +1816,12 @@
 				       const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
-	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+	printk(KERN_ALERT "Tormen: alc882_fixup_no_primary_hp: AAA\n");
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		printk(KERN_ALERT "Tormen: alc882_fixup_no_primary_hp: BBB ==> set spec->no_multi_io = 1\n");
 		spec->gen.no_primary_hp = 1;
+		spec->gen.no_multi_io = 1;
+	}
 }
 
 static const struct hda_fixup alc882_fixups[] = {
Index: Documentation/sound/alsa/HD-Audio.txt
===================================================================
--- Documentation/sound/alsa/HD-Audio.txt.orig	2013-06-13 19:52:08.000000000 +0200
+++ Documentation/sound/alsa/HD-Audio.txt	2013-07-16 18:33:24.504192737 +0200
@@ -454,6 +454,8 @@
 - need_dac_fix (bool): limits the DACs depending on the channel count
 - primary_hp (bool): probe headphone jacks as the primary outputs;
   default true
+- multi_io (bool): try probing multi-I/O config (e.g. shared
+  line-in/surround, mic/clfe jacks)
 - multi_cap_vol (bool): provide multiple capture volumes
 - inv_dmic_split (bool): provide split internal mic volume/switch for
   phase-inverted digital mics


--------------050201090404050203000502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050201090404050203000502--
