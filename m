From: Andrei Popa <andrei.popa@i-neo.ro>
Subject: [ALSA][hda-codec] fix-connexant-headphone-mute
Date: Sun, 29 Apr 2007 04:43:37 +0300
Message-ID: <1177811017.23940.7.camel@localhost>
Reply-To: andrei.popa@i-neo.ro
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from megainternet.ro (unknown [85.204.20.254])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CE58244CB
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Apr 2007 03:43:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

The sound works ok with the built-in speakers on my Fujitsu laptop(amilo
pro v3205). But if I plug in headphones in the audio out jack there is
no sound in the headphones. With kernel 2.6.20 it worked ok. With 2.6.21
it doesn't.
This BUG is reported in ALSA bugtracking system with ID 0003039.

Patch that fixes this bug:

diff --git a/sound/pci/hda/patch_conexant.c
b/sound/pci/hda/patch_conexant.c
index 46e93c6..5edd330 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -636,7 +636,7 @@ static void cxt5045_hp_automute(struct hda_codec
*codec)

        bits = (spec->hp_present || !spec->cur_eapd) ? 0x80 : 0;
        snd_hda_codec_amp_update(codec, 0x10, 0, HDA_OUTPUT, 0, 0x80,
bits);
-       snd_hda_codec_amp_update(codec, 0x10, 1, HDA_OUTPUT, 0, 0x80,
bits);
+       snd_hda_codec_amp_update(codec, 0x10, 1, HDA_OUTPUT, 0, 0,
bits);
 }

 /* unsolicited event for HP jack sensing */
@@ -988,10 +988,10 @@ static void cxt5047_hp_automute(struct hda_codec
*codec)

        bits = (spec->hp_present || !spec->cur_eapd) ? 0x80 : 0;
        snd_hda_codec_amp_update(codec, 0x1d, 0, HDA_OUTPUT, 0, 0x80,
bits);
-       snd_hda_codec_amp_update(codec, 0x1d, 1, HDA_OUTPUT, 0, 0x80,
bits);
+       snd_hda_codec_amp_update(codec, 0x1d, 1, HDA_OUTPUT, 0, 0,
bits);
        /* Mute/Unmute PCM 2 for good measure - some systems need this
*/
        snd_hda_codec_amp_update(codec, 0x1c, 0, HDA_OUTPUT, 0, 0x80,
bits);
-       snd_hda_codec_amp_update(codec, 0x1c, 1, HDA_OUTPUT, 0, 0x80,
bits);
+       snd_hda_codec_amp_update(codec, 0x1c, 1, HDA_OUTPUT, 0, 0,
bits);
 }

 /* toggle input of built-in and mic jack appropriately */
