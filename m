From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 05/26] ALSA: hda - Fix a typo in comment
Date: Thu, 11 May 2017 23:09:04 +0200
Message-ID: <20170511210925.18208-6-tiwai@suse.de>
References: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BFD22266FDE
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:31 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6FA74AEBA
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 21:09:30 +0000 (UTC)
In-Reply-To: <20170511210925.18208-1-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index ff9c7968b562..0593d674de95 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1502,7 +1502,7 @@ static void get_ctl_amp_tlv(struct snd_kcontrol *kcontrol, unsigned int *tlv)
 }
 
 /**
- * snd_hda_mixer_amp_volume_put - TLV callback for a standard AMP mixer volume
+ * snd_hda_mixer_amp_tlv - TLV callback for a standard AMP mixer volume
  * @kcontrol: ctl element
  * @op_flag: operation flag
  * @size: byte size of input TLV
-- 
2.12.2
