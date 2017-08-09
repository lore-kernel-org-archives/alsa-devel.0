From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/4] ALSA: emux: Improve a size determination
	in two functions
Date: Wed, 9 Aug 2017 10:02:57 +0200
Message-ID: <3354241b-cb2e-3d91-5dca-5e3ea427ee03@users.sourceforge.net>
References: <412aa3a5-c8b6-c1fe-febb-0d62927dacc2@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E3E02673DD
 for <alsa-devel@alsa-project.org>; Wed,  9 Aug 2017 10:03:04 +0200 (CEST)
In-Reply-To: <412aa3a5-c8b6-c1fe-febb-0d62927dacc2@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 9 Aug 2017 09:11:26 +0200

Replace the specification of data types by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/synth/emux/emux_seq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/synth/emux/emux_seq.c b/sound/synth/emux/emux_seq.c
index 53820f75ba3e..12acf18c5be4 100644
--- a/sound/synth/emux/emux_seq.c
+++ b/sound/synth/emux/emux_seq.c
@@ -149,7 +149,8 @@ snd_emux_create_port(struct snd_emux *emu, char *name,
 		snd_printk(KERN_ERR "no memory\n");
 		return NULL;
 	}
-	p->chset.channels = kcalloc(max_channels, sizeof(struct snd_midi_channel), GFP_KERNEL);
+	p->chset.channels = kcalloc(max_channels, sizeof(*p->chset.channels),
+				    GFP_KERNEL);
 	if (p->chset.channels == NULL) {
 		snd_printk(KERN_ERR "no memory\n");
 		kfree(p);
@@ -371,7 +372,7 @@ int snd_emux_init_virmidi(struct snd_emux *emu, struct snd_card *card)
 	if (emu->midi_ports <= 0)
 		return 0;
 
-	emu->vmidi = kcalloc(emu->midi_ports, sizeof(struct snd_rawmidi *), GFP_KERNEL);
+	emu->vmidi = kcalloc(emu->midi_ports, sizeof(*emu->vmidi), GFP_KERNEL);
 	if (emu->vmidi == NULL)
 		return -ENOMEM;
 
-- 
2.13.4
