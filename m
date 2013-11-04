From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Fix possible zero-division
Date: Mon,  4 Nov 2013 17:08:29 +0100
Message-ID: <1383581310-9947-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (unknown [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F0B1262629
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 17:08:50 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4E2C1A6122
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 17:08:30 +0100 (CET)
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

Check the TLV db scale result before actually dividing in vmaster
slave init code.  Also mask TLV_DB_SCALE_MUTE bit so that the right
value is obtained even if this bit is set by the codec driver.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index de1a7670ba0d..33c01d551aa4 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2676,8 +2676,13 @@ static int get_kctl_0dB_offset(struct snd_kcontrol *kctl)
 		set_fs(fs);
 	} else if (kctl->vd[0].access & SNDRV_CTL_ELEM_ACCESS_TLV_READ)
 		tlv = kctl->tlv.p;
-	if (tlv && tlv[0] == SNDRV_CTL_TLVT_DB_SCALE)
-		val = -tlv[2] / tlv[3];
+	if (tlv && tlv[0] == SNDRV_CTL_TLVT_DB_SCALE) {
+		int step = tlv[3];
+		step &= ~TLV_DB_SCALE_MUTE;
+		if (!step)
+			return -1;
+		val = -tlv[2] / step;
+	}
 	return val;
 }
 
-- 
1.8.4.2
