From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] More aggressive PM for HD-audio
Date: Wed, 18 Mar 2015 09:50:54 +0100
Message-ID: <1426668658-15911-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 590F72604DE
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 09:51:01 +0100 (CET)
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi,

here is a patchset for supporting more aggressive PM for HD-audio.
This allows to change the power state of each widget more dynamically
with jack and stream states.  It's activated only when the codec
driver (or via sysfs or f/w patch) sets codec->power_mgmt flag.

In theory, this should work for the recent Realtek codecs, but
currently I have no machine for test.

David, could you or your team check whether this works for ALC282 or
such?  Just add like:

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5415,6 +5415,7 @@ static int patch_alc269(struct hda_codec *codec)
 
 	spec = codec->spec;
 	spec->gen.shared_mic_vref_pin = 0x18;
+	codec->power_mgmt = 1;
 
 	snd_hda_pick_fixup(codec, alc269_fixup_models,
 		       alc269_fixup_tbl, alc269_fixups);


The patchset is for for-next branch of sound git tree, but they might
be applicable to 4.0-rc (or even older), too.  The current patches are
found in topic/hda-power branch.


thanks,

Takashi

===

Takashi Iwai (4):
  ALSA: hda - Simplify PCM setup overrides
  ALSA: hda - Support advanced power state controls
  ALSA: hda - Use the new power control for VIA codecs
  ALSA: hda - Adjust power of beep widget and outputs

 sound/pci/hda/hda_beep.c       |  29 +-
 sound/pci/hda/hda_beep.h       |   1 +
 sound/pci/hda/hda_codec.c      |   4 +
 sound/pci/hda/hda_codec.h      |   2 +
 sound/pci/hda/hda_generic.c    | 480 ++++++++++++++++++++++++------
 sound/pci/hda/hda_generic.h    |   5 +-
 sound/pci/hda/patch_realtek.c  |  41 ---
 sound/pci/hda/patch_sigmatel.c |   5 +
 sound/pci/hda/patch_via.c      | 662 +----------------------------------------
 9 files changed, 427 insertions(+), 802 deletions(-)

-- 
2.3.3
