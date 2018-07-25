From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/12] ALSA: hda - Fix a sparse warning about
	snd_ctl_elem_iface_t
Date: Wed, 25 Jul 2018 23:00:51 +0200
Message-ID: <20180725210057.18017-7-tiwai@suse.de>
References: <20180725210057.18017-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A91DD26774B
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:01:05 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A1253B082
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:01:03 +0000 (UTC)
In-Reply-To: <20180725210057.18017-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

The knew->iface field is in snd_ctl_elem_iface_t, which is with
__bitwise, hence it can't be converted implicitly from integer.
Give an explicit cast for the invalid type.

Spotted by sparse:
  sound/pci/hda/hda_codec.c:3280:25: warning: restricted snd_ctl_elem_iface_t degrades to integer

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 6d0c0b143270..0a5085537034 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3277,8 +3277,8 @@ int snd_hda_add_new_ctls(struct hda_codec *codec,
 	for (; knew->name; knew++) {
 		struct snd_kcontrol *kctl;
 		int addr = 0, idx = 0;
-		if (knew->iface == -1)	/* skip this codec private value */
-			continue;
+		if (knew->iface == (__force snd_ctl_elem_iface_t)-1)
+			continue; /* skip this codec private value */
 		for (;;) {
 			kctl = snd_ctl_new1(knew, codec);
 			if (!kctl)
-- 
2.18.0
