From: ikke <ikke@iki.fi>
Subject: maestro3 & es1988: mic range too low
Date: Sun, 17 Aug 2008 22:07:19 +0300
Message-ID: <e3156df0808171207p71c685e4r40ce079fdad77f89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FDFC2437A
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Aug 2008 21:07:21 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m28so1279415wag.8
	for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2008 12:07:20 -0700 (PDT)
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

I'm having mic problems with snd_maestro3 and es1988 allegro hw. The
laptop is HP OmniBook Xe3. The mic is way too silent (unusable) even
with 20db boost option on. I found this seems to have been really
common problem, but only one came with a fix [1] to the problem,
enabling one more bit to volume control. Could someone please help me
apply that fix to current alsa?

I tried compiling 2.6.26.2 kernel and made the first change of the
patch from mail [1] attachement [2]. No change. The second part of
patch I did not find anymore from the code. There are similar parts in
ac97_patch.c. Any hint what should be added there?

The original patched code is somewhat outdated compared to modern
one... But the reasoning for the original patch sounds reasonable. The
mic volume is tunable, only at the very low range. I recall the laptop
came with Win98, and there was no problem then with the sound -> not a
HW problem. I have never got this laptop mic working with linux, so
this is not anything that broke recently. I see there is
check_volume_resolution function which tries to guess some of the
register ranges, but maybe it get's it wrong with this HW.

I tried with external headset, the behavior is just the same. The
headset is working fine with IBM T41, so not due the mic itself.

Any help would be preciated, thanks,

  ikke


[1] http://thread.gmane.org/gmane.linux.alsa.devel/2025
[2] http://cache.gmane.org//gmane/linux/alsa/devel/2025-001.bin

Other posts related, with no solutions:

http://article.gmane.org/gmane.linux.alsa.user/9802
http://article.gmane.org/gmane.linux.alsa.user/15260
http://article.gmane.org/gmane.linux.alsa.user/9663
http://article.gmane.org/gmane.linux.alsa.devel/27195


HW is HP Omnibook Xe3,
00:08.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
Ubuntu up to date hardy, with manually compiled linux-2.6.26.2.

the patch:
-----------------------------------
--- ac97_codec.c	Fri Jun 21 16:09:15 2002
+++ /usr/src/linux/sound/pci/ac97/ac97_codec.c	Sun Jun 16 21:56:00 2002
@@ -579,7 +579,7 @@

 static const snd_kcontrol_new_t snd_ac97_controls_mic[3] = {
 AC97_SINGLE("Mic Playback Switch", AC97_MIC, 15, 1, 1),
-AC97_SINGLE("Mic Playback Volume", AC97_MIC, 0, 15, 1),
+AC97_SINGLE("Mic Playback Volume", AC97_MIC, 0, 31, 1),
 AC97_SINGLE("Mic Boost (+20dB)", AC97_MIC, 6, 1, 0)
 };

@@ -1137,7 +1137,7 @@
 	for (idx = 0; idx < 3; idx++)
 		if ((err = snd_ctl_add(card,
snd_ac97_cnew(&snd_ac97_controls_mic[idx], ac97))) < 0)
 			return err;
-	snd_ac97_write_cache(ac97, AC97_MIC, 0x801f);
+	snd_ac97_write_cache(ac97, AC97_MIC, 0x805f);

 	/* build Line controls */
 	for (idx = 0; idx < 2; idx++)
-----------------------------------

amixer settings:
-----------------------------------
$ amixer
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 21 [68%] [-15.00dB] [on]
  Front Right: Playback 21 [68%] [-15.00dB] [on]
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [0.00dB] [on]
Simple mixer control '3D Control - Center',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 15 [100%]
Simple mixer control '3D Control - Depth',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 15 [100%]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [12.00dB] [on]
  Front Right: Playback 31 [100%] [12.00dB] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [12.00dB] [on] Capture [off]
  Front Right: Playback 31 [100%] [12.00dB] [on] Capture [off]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [12.00dB] [on] Capture [off]
  Front Right: Playback 31 [100%] [12.00dB] [on] Capture [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [12.00dB] [on]
  Front Left: Capture [on]
  Front Right: Capture [on]
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Mic Select',0
  Capabilities: enum
  Items: 'Mic1' 'Mic2'
  Item0: 'Mic1'
Simple mixer control 'Video',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [12.00dB] [on]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 15 [100%] [0.00dB] [on]
Simple mixer control 'Aux',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mono Output Select',0
  Capabilities: enum
  Items: 'Mix' 'Mic'
  Item0: 'Mix'
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 15 [100%] [22.50dB] [on]
  Front Right: Capture 15 [100%] [22.50dB] [on]
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
-----------------------------------

 ---> looking at the mic range it seems to be 0-31 already, capture is
only 0-15, I wonder if that's right...
