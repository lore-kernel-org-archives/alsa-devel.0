From: Hsin-Yu Chao <hychao@chromium.org>
Subject: [PATCH 2/2] ALSA: hda/ca0132 - Fix recording from mode
	id 0x8
Date: Wed, 19 Feb 2014 14:30:35 +0800
Message-ID: <1392791435-17170-1-git-send-email-hychao@chromium.org>
References: <s5htxcbtc71.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f73.google.com (mail-pb0-f73.google.com
 [209.85.160.73])
 by alsa0.perex.cz (Postfix) with ESMTP id A01E72652C1
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 07:30:39 +0100 (CET)
Received: by mail-pb0-f73.google.com with SMTP id rq2so2253065pbb.0
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 22:30:38 -0800 (PST)
In-Reply-To: <s5htxcbtc71.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>, Takashi Iwai <tiwai@suse.de>, Chih-Chung Chang <chihchung@chromium.org>, linux-kernel@vger.kernel.org, Hsin-Yu Chao <hychao@chromium.org>, Dylan Reid <dgreid@chromium.org>, Xi Wang <xi.wang@gmail.com>
List-Id: alsa-devel@alsa-project.org

Incorrect ADC is picked in ca0132_capture_pcm_prepare(),
where it assumes multiple streams while there is one stream
per ADC. Note that ca0132_capture_pcm_cleanup() already does
the right thing.

The Chromebook Pixel has a microphone under the keyboard that
is attached to node id 0x8. Before this fix, recording would
always go to the main internal mic (node id 0x7).

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
Reviewed-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/patch_ca0132.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 0aa72ee..46ecdbb 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2768,9 +2768,7 @@ static int ca0132_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
 					unsigned int format,
 					struct snd_pcm_substream *substream)
 {
-	struct ca0132_spec *spec = codec->spec;
-
-	snd_hda_codec_setup_stream(codec, spec->adcs[substream->number],
+	snd_hda_codec_setup_stream(codec, hinfo->nid,
 				   stream_tag, 0, format);
 
 	return 0;
-- 
1.8.3.2
