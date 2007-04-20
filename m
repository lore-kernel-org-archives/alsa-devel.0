From: Dmitry Ursegov <dursegov@jet.su>
Subject: ad1986a snd_hda_intel patch
Date: Fri, 20 Apr 2007 23:55:41 +0400
Message-ID: <1177098941.7389.16.camel@dmitry-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.jet.msk.su (mx.jet.msk.su [62.117.74.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F4C224692
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Apr 2007 21:55:54 +0200 (CEST)
Received: from [62.117.85.97] (helo=[192.168.1.2])
	by mx.jet.msk.su with asmtp (SSLv3:RC4-MD5:128) (Exim 4.34)
	id 1HezCx-0000h8-Hg
	for alsa-devel@alsa-project.org; Fri, 20 Apr 2007 23:55:51 +0400
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

Hello!

I have an asus a8jn laptop and a integrated audio with Analog Devices
AD1986A chip.

$ lspci -vnn
0:1b.0 Audio device [0403]: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller [8086:27d8] (rev 02)
        Subsystem: ASUSTeK Computer Inc. Unknown device [1043:1447]
        Flags: bus master, fast devsel, latency 0, IRQ 21
        Memory at febfc000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: <access denied>

The audio seems to work properly on the right channel, but not on the
left. All I get on the left channel is a loud screeching noise followed
by a pop when the audio turns off. The microphon jack don't work also.

I make a patch from the solution described in this
http://mailman.alsa-project.org/pipermail/alsa-devel/2007-March/000093.html message:

diff -Nur alsa-driver-1.0.14rc3/alsa-kernel/pci/hda/patch_analog.c
alsa-driver-1.0.14rc3_ad1986a/alsa-kernel/pci/hda/patch_analog.c
--- alsa-driver-1.0.14rc3/alsa-kernel/pci/hda/patch_analog.c
2007-03-06 15:26:32.000000000 +0300
+++ alsa-driver-1.0.14rc3_ad1986a/alsa-kernel/pci/hda/patch_analog.c
2007-04-20 23:32:19.000000000 +0400
@@ -873,7 +873,7 @@
        board_config = snd_hda_check_board_config(codec, AD1986A_MODELS,
                                                  ad1986a_models,
                                                  ad1986a_cfg_tbl);
-       switch (board_config) {
+/*     switch (board_config) {
        case AD1986A_3STACK:
                spec->num_mixers = 2;
                spec->mixers[1] = ad1986a_3st_mixers;
@@ -912,6 +912,18 @@
                spec->multiout.dig_out_nid = 0;
                break;
        }
+*/
+
+                spec->num_mixers = 2;
+                spec->mixers[1] = ad1986a_3st_mixers;
+                spec->num_init_verbs = 3;
+                spec->init_verbs[1] = ad1986a_3st_init_verbs;
+                spec->init_verbs[2] = ad1986a_ch2_init;
+                spec->channel_mode = ad1986a_modes;
+                spec->num_channel_mode = ARRAY_SIZE(ad1986a_modes);
+                spec->need_dac_fix = 1;
+                spec->multiout.max_channels = 2;
+                spec->multiout.num_dacs = 1;

        return 0;
 }

I don't know, why snd_hda_check_board_config() return wrong value, but
that workaround works.

Thanks!
Dmitry Ursegov
