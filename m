From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/realtek - Add shutup hint
Date: Tue, 12 Jun 2018 17:21:18 +0200
Message-ID: <20180612152118.17720-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F268B266E8B
 for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2018 17:21:30 +0200 (CEST)
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
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Berg <bberg@redhat.com>
List-Id: alsa-devel@alsa-project.org

The pin shutup callback seems working well on some devices while it
does harm on some other devices; e.g. Lenovo laptops show often the
noises at (runtime) PM with the pin shutup enabled.

Currently, the only way to disable the pin shutup is to hard-code
  spec->shutup = alc_no_shutup;
in the fixup, and this makes the debugging harder for normal users.
For allowing users to test the similar effect without recompiling the
kernel, this patch adds a new hint string "shutup".  It's a boolean
value, and by passing false to this, user can turn off the pin shutup
call.

For example, to turn off the shutup on Lenovo P50, create a "firmware
patch" file (e.g. /lib/firmware/alsa/lenovo-p50) containing the
following lines:

  [codec]
  0x10ec0298 0x17aa222e 0

  [hint]
  shutup = no

and pass the file via patch option of snd-hda-intel module
(e.g. patch=alsa/lenovo-p50).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b1eb6bd4fbd8..e5a002900292 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -793,6 +793,9 @@ static inline void alc_shutup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 
+	if (!snd_hda_get_bool_hint(codec, "shutup"))
+		return; /* disabled explicitly by hints */
+
 	if (spec && spec->shutup)
 		spec->shutup(codec);
 	else
-- 
2.17.1
