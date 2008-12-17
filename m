From: "Klaus Schulz" <kls.schlz@googlemail.com>
Subject: Sigmatel patch for missing
Date: Wed, 17 Dec 2008 09:23:24 +0100
Message-ID: <d9690f190812170023k4744b391ua4a3dcf4ea5641a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 287FD24422
	for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2008 09:23:25 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so1447332yxh.2
	for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2008 00:23:25 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi folks.

Below patch seems to be missing in 1.0.18a! Note that also MCP51 seemed to
work afterwards.
It needs to be ported to 1.0.18.a though.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3036

Can anybody let me know how the patch would look like in latest driver rev.

THX
Klaus




--- patch_sigmatel.c.orig    2007-09-15 17:57:07.000000000 -0700
+++ patch_sigmatel.c    2007-09-15 17:50:26.000000000 -0700
@@ -2304,6 +2304,15 @@
         stac92xx_auto_set_pinctl(codec, cfg->dig_in_pin,
                      AC_PINCTL_IN_EN);

+    switch (codec->subsystem_id) {
+    case 0x107b0317: // Gateway MX3412, MT3423
+    case 0x107b0318: // Gateway MT3707, ML3109 (ATI SB450)
+    case 0x10de026c: // Gateway MX3410
+        snd_hda_codec_write(codec, 0x08, 0, AC_VERB_SET_POWER_STATE, 0x00);
+        snd_hda_codec_write(codec, 0x08, 0, AC_VERB_SET_EAPD_BTLENABLE,
0x02);
+        break;
+    }
+
     if (spec->gpio_mute) {
         stac922x_gpio_mute(codec, 0, 0);
         stac922x_gpio_mute(codec, 1, 0);
