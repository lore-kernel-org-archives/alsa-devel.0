From: Johannes Stezenbach <js@sig21.net>
Subject: [PATCH] hda-intel: Enable Analog CD Input from
	internal ATAPI	connector on Asus M2N-SLI.
Date: Tue, 11 Dec 2007 18:46:08 +0100
Message-ID: <20071211174608.GA10279@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from allen.werkleitz.de (allen.werkleitz.de [80.190.251.108])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E3E9244F9
	for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2007 18:46:18 +0100 (CET)
Received: from p57a24fc3.dip.t-dialin.net ([87.162.79.195] helo=abc.local)
	by allen.werkleitz.de with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63) (envelope-from <js@sig21.net>) id 1J29BP-00075k-5E
	for alsa-devel@alsa-project.org; Tue, 11 Dec 2007 18:46:17 +0100
Received: from js by abc.local with local (Exim 4.68)
	(envelope-from <js@sig21.net>) id 1J29BI-0002hU-Vn
	for alsa-devel@alsa-project.org; Tue, 11 Dec 2007 18:46:08 +0100
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

the internal CD connector on my Asus M2N-SLI Deluxe board doesn't
work without the patch below, /proc/asound/card0/codec#0
shows that the pin is disabled (Pin-ctls: 0x00).

I used kernel linux-2.6.24-rc4-190-g94545ba from Linus' git tree.

During my experiments I found that loading the snd-hda-intel
driver with model=auto also enables the CD connector. It seems
that for my board (BIOS version 1102) the BIOS configuration
is correct and the "Asus M2N-SLI" quirk shouldn't be necessary?
I get the following debug output:

ALSA sound/pci/hda/hda_intel.c:727: codec_mask = 0x1
ALSA sound/pci/hda/hda_codec.c:2140: hda_codec: model 'auto' is selected
ALSA sound/pci/hda/hda_codec.c:2760: autoconfig: line_outs=4 (0x12/0x16/0x24/0x25/0x0)
ALSA sound/pci/hda/hda_codec.c:2764:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:2768:    hp_outs=1 (0x11/0x0/0x0/0x0/0x0)
ALSA sound/pci/hda/hda_codec.c:2776:    inputs: mic=0x17, fmic=0x14, line=0x15, fline=0x0, cd=0x18, aux=0x0

(which matches the board's actual connections)

Anyway, if you think the patch below is correct the please apply. It
works fine for me.

There is one thing that I don't get however: If I run aplay it creates
an additional "PCM" mixer control, which however doesn't have any
effect. I guess this is intended for softvol, but I don't need
it. How do I stop aplay from creating this control?
(If it matters, I use Debian unstable, alsa-lib 1.0.15.)


Thanks,
Johannes


---
Enable Analog CD Input from internal ATAPI connector on Asus M2N-SLI.

Signed-off-by: Johannes Stezenbach <js@sig21.net>

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 196ad3c..8c2aff4 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -2079,6 +2079,8 @@ static struct hda_verb ad1988_6stack_init_verbs[] = {
 	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
 	{0x3c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 	{0x34, AC_VERB_SET_CONNECT_SEL, 0x0},
+	/* Analog CD Input */
+	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
 
 	{ }
 };
