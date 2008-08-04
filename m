From: "george pee" <georgepee@gmail.com>
Subject: [PATCH] ac97 mono-out w/internal speaker
Date: Mon, 4 Aug 2008 11:46:28 -0500
Message-ID: <d75a31820808040946y15700f82p78a6cb17f54e49d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 4349F2417B
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Aug 2008 18:46:30 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so350936and.80
	for <alsa-devel@alsa-project.org>; Mon, 04 Aug 2008 09:46:29 -0700 (PDT)
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
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have a wireless tablet (webdt310)
http://dtresearch.com/product/wt310/index.htm

It has cs5536 audio and a realtek alc203 codec.

The headphone jack works perfectly, but the internal speaker was not.

After a bit a twiddling and reading the ALC203 data sheet, I finally figured
out that the function of Pin 37 had to be changed to MONO-OUT to get sound
out of the
internal speaker.

I'm not sure that this is the best approach (maybe there could be some pin
sensing?)
but I added this as an ac97 quirk.  Here's the patch.

diff -rub linux-2.6.26.orig/sound/pci/ac97/ac97_codec.c
linux-2.6.26.new/sound/pci/ac97/ac97_codec.c
--- linux-2.6.26.orig/sound/pci/ac97/ac97_codec.c       2008-07-29
15:30:57.000000000 -0500
+++ linux-2.6.26.new/sound/pci/ac97/ac97_codec.c        2008-08-04
10:58:12.000000000 -0500
@@ -2709,6 +2710,12 @@
        return snd_ctl_add(ac97->bus->card,
snd_ac97_cnew(&snd_ac97_alc_jack_detect, ac97));
 }

+/* ac97 tune: turn on mono-out */
+static int tune_mono_out(struct snd_ac97 *ac97)
+{
+       snd_ac97_update_bits(ac97, 0x7a, 0x400, 0x400);
+       return 1;
+}
+
 /* ac97 tune: inversed EAPD bit */
 static int tune_inv_eapd(struct snd_ac97 *ac97)
 {
@@ -2801,6 +2808,7 @@
        { "inv_eapd", tune_inv_eapd },
        { "mute_led", tune_mute_led },
        { "hp_mute_led", tune_hp_mute_led },
+      { "mono_out", tune_mono_out },
 };
