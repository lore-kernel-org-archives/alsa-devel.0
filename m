From: Markus Osterhoff <linux-kernel@k-raum.org>
Subject: [PATCH RESEND V2] ALSA: hda: fix possible NULL
	dereference
Date: Mon, 24 Aug 2015 14:11:39 +0200
Message-ID: <20150824121139.GB13757@mo-online.de>
References: <20150823183705.GT31650@mo-online.de>
 <s5hsi79ryfg.wl-tiwai@suse.de>
 <20150824101740.GA13757@mo-online.de>
 <s5h1tetdlva.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo-online.de (mo-online.de [89.238.66.174])
 by alsa0.perex.cz (Postfix) with ESMTP id E75962606F5
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 14:11:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h1tetdlva.wl-tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

After a for-loop was replaced by list_for_each_entry, see
Commit bbbc7e8502c9 ("ALSA: hda - Allocate hda_pcm objects dynamically"),
Commit 751e2216899c ("ALSA: hda: fix possible null dereference"),
a possible NULL pointer dereference has been introduced; this patch adds
the NULL check on pcm->pcm, while leaving a potentially superfluous
check on pcm itself untouched.

Signed-off-by: Markus Osterhoff <linux-kernel@k-raum.org>
---
 sound/pci/hda/hda_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 5de3c5d..d1a2cb6 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3172,7 +3172,7 @@ static int add_std_chmaps(struct hda_codec *codec)
                        struct snd_pcm_chmap *chmap;
                        const struct snd_pcm_chmap_elem *elem;
 
-                       if (!pcm || pcm->own_chmap ||
+                       if (!pcm || !pcm->pcm || pcm->own_chmap ||
                            !hinfo->substreams)
                                continue;
                        elem = hinfo->chmap ? hinfo->chmap : snd_pcm_std_chmaps;
