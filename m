From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 15/15] ALSA: hda - Disable FLOAT format support
Date: Mon, 14 May 2012 17:32:06 +0200
Message-ID: <1337009526-26256-16-git-send-email-tiwai@suse.de>
References: <1337009526-26256-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A8F624A2C
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 0852890F2E
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
In-Reply-To: <1337009526-26256-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

It turned out that the FLOAT format on CS4206 results in simple
noises, which implies that this is no right format as is.
Since CS4206 is the only codec supporting the float, let's disable it
until we find the correct format.

Reported-and-tested-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 7a621f5..c556fe1 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3842,11 +3842,13 @@ int snd_hda_query_supported_pcm(struct hda_codec *codec, hda_nid_t nid,
 					bps = 20;
 			}
 		}
+#if 0 /* FIXME: CS4206 doesn't work, which is the only codec supporting float */
 		if (streams & AC_SUPFMT_FLOAT32) {
 			formats |= SNDRV_PCM_FMTBIT_FLOAT_LE;
 			if (!bps)
 				bps = 32;
 		}
+#endif
 		if (streams == AC_SUPFMT_AC3) {
 			/* should be exclusive */
 			/* temporary hack: we have still no proper support
-- 
1.7.9.2
