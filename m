From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: hda - Skip card registration when no
	codec is found
Date: Wed, 28 Jun 2017 14:58:52 +0200
Message-ID: <20170628125854.13022-3-tiwai@suse.de>
References: <20170628125854.13022-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EF7CC266BC2
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 14:58:55 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 905F4AEE8
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 12:58:55 +0000 (UTC)
In-Reply-To: <20170628125854.13022-1-tiwai@suse.de>
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

It's nonsense to register a card object when no codec is bound on it,
as we don't support the deferred codec binding.  Instead of
registering an empty card object, just skip the registration by
returning an error from azx_codec_configure().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 1c60beb5b70a..d1eb14842340 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1345,6 +1345,9 @@ int azx_codec_configure(struct azx *chip)
 	list_for_each_codec_safe(codec, next, &chip->bus) {
 		snd_hda_codec_configure(codec);
 	}
+
+	if (!azx_bus(chip)->num_codecs)
+		return -ENODEV;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(azx_codec_configure);
-- 
2.13.2
