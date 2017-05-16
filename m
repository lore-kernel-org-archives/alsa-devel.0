From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - No loopback on ALC299 codec
Date: Tue, 16 May 2017 09:15:01 +0200
Message-ID: <20170516071501.20787-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DCE14266847
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 09:15:03 +0200 (CEST)
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
Cc: Kailang Yang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org

ALC299 has no loopback mixer, but the driver still tries to add a beep
control over the mixer NID which leads to the error at accessing it.
This patch fixes it by properly declaring mixer_nid=0 for this codec.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195775
Fixes: 28f1f9b26cee ("ALSA: hda/realtek - Add new codec ID ALC299")
Cc: stable@vger.kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 58df440013c5..9c22ad694534 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6465,8 +6465,11 @@ static int patch_alc269(struct hda_codec *codec)
 		break;
 	case 0x10ec0225:
 	case 0x10ec0295:
+		spec->codec_variant = ALC269_TYPE_ALC225;
+		break;
 	case 0x10ec0299:
 		spec->codec_variant = ALC269_TYPE_ALC225;
+		spec->gen.mixer_nid = 0; /* no loopback on ALC299 */
 		break;
 	case 0x10ec0234:
 	case 0x10ec0274:
-- 
2.12.2
