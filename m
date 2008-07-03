From: "Kan-I Jyo" <cecilhsujp@gmail.com>
Subject: Re: [Fwd: [Alsa-user] Intel Poulsbo(SCH) chipset does
	not recognize Adi 1986 codec under linux]]
Date: Thu, 3 Jul 2008 14:42:16 +0900
Message-ID: <1e8a3dd0807022242sd33c315xa4613da95d039f38@mail.gmail.com>
References: <1e8a3dd0806241840m76069ad8sa35058ad8ddb843b@mail.gmail.com>
	<s5hprq5onxz.wl%tiwai@suse.de>
	<1e8a3dd0806250500p6f7a343u89b11d42f556347@mail.gmail.com>
	<s5hhcbhogef.wl%tiwai@suse.de>
	<1e8a3dd0806300620i2be727afibc932c1df6744f7f@mail.gmail.com>
	<s5hy74lewe7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 70E32246F9
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 07:42:17 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id b27so505944fka.0
	for <alsa-devel@alsa-project.org>; Wed, 02 Jul 2008 22:42:16 -0700 (PDT)
In-Reply-To: <s5hy74lewe7.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Takashi,

Thank you for your reply.

2008/7/1 Takashi Iwai <tiwai@suse.de>:

> If you know the slot number of the codec beforehand, you can modify to
> force to set chip->codec_mask in azx_reset().  Then the driver will
> continue to probe the codec.

By changing the "chip->codec_mask", amazingly the codec chip is now recognized.

<hda_intel.c.diff>
--- hda_intel.c.orig	2008-07-02 13:27:14.699908463 +0900
+++ hda_intel.c	2008-07-02 13:27:48.303899618 +0900
@@ -750,7 +750,8 @@ static int azx_reset(struct azx *chip)

 	/* detect codecs */
 	if (!chip->codec_mask) {
-		chip->codec_mask = azx_readw(chip, STATESTS);
+		/* chip->codec_mask = azx_readw(chip, STATESTS); */
+		chip->codec_mask = 1;
 		snd_printdd("codec_mask = 0x%x\n", chip->codec_mask);
 	}

<ends here>

I do not consider this as a good way to solve this issue, this is
quite a progress to me. Thank you for your advise, Takashi.

Regardless of being recognized and been configurable by alsamixer,
there is no sound output from the speaker. I have tried all the model
option listed in Documentation/sound/alsa/ALSA-Configuration.txt for
AD1986A and none provides a sound output.

By switching to different models, it results some similar log output
in both dmesg and /var/log/messages have some info like this:

<dmesg>

--snip--
ALSA /root/alsa-driver-1.0.17rc3/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:601:
hda_intel: azx_get_response timeout, switching to polling mode: last
cmd=0x000f0000
ALSA /root/alsa-driver-1.0.17rc3/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:608:
hda_intel: azx_get_response timeout, switching to single_cmd mode:
last cmd=0x000f0000
ALSA /root/alsa-driver-1.0.17rc3/pci/hda/hda_codec.c:2334: hda_codec:
model '6stack' is selected
ALSA /root/alsa-driver-1.0.17rc3/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1196:
snd_hda_codec_new() results is 0

<ends here>

When trying to apply the "position_fix" module option to values other
than the default "0", I got following ouput from dmesg.

<dmesg>

--snip--
ALSA /root/alsa-driver-1.0.17rc3/acore/../alsa-kernel/core/pcm_lib.c:1540:
playback write error (DMA or IRQ trouble?)

<ends here>

And in /var/log/messages, I have following messages complaining that
the position buffer is invalid.

</var/log/messages>

--snip--
Jan  2 18:34:03 localhost kernel: hda-intel: Invalid position buffer,
using LPIB read method instead.
Jan  2 18:34:03 localhost kernel: hda-intel: IRQ timing workaround is
activated for card #0. Suggest a bigger bdl_pos_adj.

<ends here>

As you have metioned in your previous update, there is high
possibility that this is not a software(driver) issue but a hardware
misconfiguration. Though I think there might some kind of workaround
to solve this issue, I will try contacting the hardware vendor about
this situation.

And still, any commet would be greatly appreciated.

-- 
Sincerely,

Jyo
