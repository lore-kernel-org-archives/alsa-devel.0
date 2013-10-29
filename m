From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/10] ALSA: ad1889: Fix right attenuation proc
	output
Date: Tue, 29 Oct 2013 17:00:28 +0100
Message-ID: <1383062433-9388-6-git-send-email-tiwai@suse.de>
References: <1383062433-9388-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D21162610CE
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:48 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9FB6AA5FE2
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:48 +0100 (CET)
In-Reply-To: <1383062433-9388-1-git-send-email-tiwai@suse.de>
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

The right attenuation bits aren't needed to be shifted.

Spotted by coverity CID 11427.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ad1889.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index d2b9d617aee5..b680d03e2419 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -739,7 +739,7 @@ snd_ad1889_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffe
 	reg = ad1889_readw(chip, AD_DS_WADA);
 	snd_iprintf(buffer, "Right: %s, -%d dB\n",
 			(reg & AD_DS_WADA_RWAM) ? "mute" : "unmute",
-			((reg & AD_DS_WADA_RWAA) >> 8) * 3);
+			(reg & AD_DS_WADA_RWAA) * 3);
 	
 	reg = ad1889_readw(chip, AD_DS_WAS);
 	snd_iprintf(buffer, "Wave samplerate: %u Hz\n", reg);
-- 
1.8.4.1
