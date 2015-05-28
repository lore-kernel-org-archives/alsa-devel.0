From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Disable Headphone Mic boost for
	ALC662
Date: Thu, 28 May 2015 09:40:23 +0200
Message-ID: <1432798823-2858-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id BB1FE26043E
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 09:40:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: 1454235@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

When headphone mic boost is above zero, some 10 - 20 second delay
might occur before the headphone mic is operational.
Therefore disable the headphone mic boost control (recording gain is
sufficient even without it).

(Note: this patch is not about the headset mic, it's about the less
common mic-in only mode.)

BugLink: https://bugs.launchpad.net/bugs/1454235
Suggested-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d0fa455..da2d371 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4240,6 +4240,11 @@ static void alc_fixup_headset_mode_alc662(struct hda_codec *codec,
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
 		spec->gen.hp_mic = 1; /* Mic-in is same pin as headphone */
+
+		/* Disable boost for mic-in permanently. (This code is only called
+		   from quirks that guarantee that the headphone is at NID 0x1b.) */
+		snd_hda_codec_write(codec, 0x1b, 0, AC_VERB_SET_AMP_GAIN_MUTE, 0x7000);
+		snd_hda_override_wcaps(codec, 0x1b, get_wcaps(codec, 0x1b) & ~AC_WCAP_IN_AMP);
 	} else
 		alc_fixup_headset_mode(codec, fix, action);
 }
-- 
1.9.1
