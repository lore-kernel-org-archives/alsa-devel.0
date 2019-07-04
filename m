From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: hda/ca0132 - remove redundant assignment to variable 'changed'
Date: Thu,  4 Jul 2019 13:44:25 +0100
Message-ID: <20190704124425.2142-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Connor McAdams <conmanx360@gmail.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The variable 'changed' is being initialized with a value that is never
read and it is being updated later with a new value. The initialization
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index c0565437ffed..0d51823d7270 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -5980,7 +5980,7 @@ static int ca0132_alt_volume_put(struct snd_kcontrol *kcontrol,
 	int ch = get_amp_channels(kcontrol);
 	long *valp = ucontrol->value.integer.value;
 	hda_nid_t vnid = 0;
-	int changed = 1;
+	int changed;
 
 	switch (nid) {
 	case 0x02:
-- 
2.20.1
